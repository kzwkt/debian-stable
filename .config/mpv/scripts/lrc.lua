local options = {
    musixmatch_token = '220215b052d6aeaa3e9a410986f6c3ae7ea9f5238731cb918d05ea',
}
local utils = require 'mp.utils'

require 'mp.options'.read_options(options)

local function show_error(message)
    mp.msg.error(message)
    if mp.get_property_native('vo-configured') then
        mp.osd_message(message, 5)
    end
end

local function curl(args)
    local r = mp.command_native({name = 'subprocess', capture_stdout = true, args = args})

    if r.killed_by_us then
        return
    end

    if r.status < 0 then
        show_error('subprocess error: ' .. r.error_string)
        return
    end

    if r.status > 0 then
        show_error('curl failed with code ' .. r.status)
        return
    end

    local response, error = utils.parse_json(r.stdout)

    if error then
        show_error('Unable to parse the JSON response')
        return
    end

    return response
end

local function get_metadata()
    local metadata = mp.get_property_native('metadata')

    if metadata == nil then
        show_error('Metadata not yet loaded')
        return
    end

    local title = metadata.title or metadata.TITLE or metadata.Title
    local artist = metadata.artist or metadata.ARTIST or metadata.Artist
    local album = metadata.album or metadata.ALBUM or metadata.Album

    if not title then
        show_error('This song has no title metadata')
        return
    end

    if not artist then
        show_error('This song has no artist metadata')
        return
    end

    return title, artist, album
end

local function save_lyrics(lyrics, lrc_path)
    if lyrics == '' then
        show_error('Lyrics not found')
        return
    end

    local lrc, error = io.open(lrc_path, 'w')
    if lrc == nil then
        show_error(error)
        return
    end
    lrc:write(lyrics)
    lrc:close()

    if lyrics:find('^%[') then
        mp.command('rescan-external-files')
        mp.osd_message('LRC downloaded')
    else
        mp.osd_message('Lyrics without timestamps downloaded')
    end
end

local function download_lyrics()
    local path = mp.get_property('path')
    local extension = path:match("^.+(%..+)$")
    
    if extension ~= ".mp3" then
        return
    end

    local lrc_path = (path:match('(.*)%.[^/]*$') or path) .. '.lrc'

    local lrc_file = io.open(lrc_path, 'r')
    if lrc_file then
        lrc_file:close()
        mp.osd_message('LRC file already exists')
        return
    end

    mp.osd_message('Downloading lyrics')

    local title, artist = get_metadata()

    if not title then
        return
    end

    local response = curl({
        'curl',
        '--silent',
        '--get',
        '--cookie', 'x-mxm-token-guid=' .. options.musixmatch_token,
        'https://apic-desktop.musixmatch.com/ws/1.1/macro.subtitles.get',
        '--data', 'app_id=web-desktop-app-v1.0',
        '--data', 'usertoken=' .. options.musixmatch_token,
        '--data-urlencode', 'q_track=' .. title,
        '--data-urlencode', 'q_artist=' .. artist,
    })

    if not response then
        return
    end

    if response.message.header.status_code == 401 and response.message.header.hint == 'renew' then
        show_error('The Musixmatch token has been rate limited. script-opts/lrc.conf explains how to generate a new one.')
        return
    end

    if response.message.header.status_code ~= 200 then
        show_error('Request failed with status code ' .. response.message.header.status_code .. '. Hint: ' .. response.message.header.hint)
        return
    end

    local body = response.message.body.macro_calls

    local lyrics = ''
    if body['matcher.track.get'].message.header.status_code == 200 then
        if body['matcher.track.get'].message.body.track.has_subtitles == 1 then
            lyrics = body['track.subtitles.get'].message.body.subtitle_list[1].subtitle.subtitle_body
        elseif body['matcher.track.get'].message.body.track.has_lyrics == 1 then
            lyrics = body['track.lyrics.get'].message.body.lyrics.lyrics_body
        elseif body['matcher.track.get'].message.body.track.instrumental == 1 then
            show_error('This is an instrumental track')
            return
        end
    end

    save_lyrics(lyrics, lrc_path)
end

mp.register_event('file-loaded', download_lyrics)
