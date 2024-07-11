# curl --location https://apic-desktop.musixmatch.com/ws/1.1/token.get?app_id=web-desktop-app-v1.0
# src https://github.com/guidocella/mpv-lrc

local options = {
    musixmatch_token = '220215b052d6aeaa3e9a410986f6c3ae7ea9f5238731cb918d05ea',
}
local utils = require 'mp.utils'
require 'mp.options'.read_options(options)

local function show_message(message, is_error)
    if is_error then
        mp.msg.error(message)
    end
    if mp.get_property_native('vo-configured') then
        mp.osd_message(message, 5)
    end
end

local function curl(args)
    local result = mp.command_native({name = 'subprocess', capture_stdout = true, args = args})
    if result.killed_by_us or result.status ~= 0 then
        show_message('curl failed with code ' .. result.status, true)
        return
    end
    local response, err = utils.parse_json(result.stdout)
    if err then
        show_message('Unable to parse JSON response', true)
        return
    end
    return response
end

local function get_metadata()
    local metadata = mp.get_property_native('metadata')
    if not metadata then
        show_message('Metadata not yet loaded', true)
        return
    end
    local title = metadata.title or metadata.TITLE or metadata.Title
    local artist = metadata.artist or metadata.ARTIST or metadata.Artist
    if not title or not artist then
        show_message('Missing title or artist metadata', true)
        return
    end
    return title, artist
end

local function save_lyrics(lyrics, lrc_path)
    if lyrics == '' then
        show_message('Lyrics not found', true)
        return
    end
    local file, err = io.open(lrc_path, 'w')
    if not file then
        show_message('Failed to open file: ' .. err, true)
        return
    end
    file:write(lyrics)
    file:close()
    mp.osd_message(lyrics:find('^%[') and 'LRC downloaded' or 'Lyrics without timestamps downloaded')
    if lyrics:find('^%[') then
        mp.command('rescan-external-files')
    end
end

local function download_lyrics()
    local path = mp.get_property('path')
    if not path:match('%.mp3$') then return end

    local lrc_path = path:match('(.*)%.[^/]*$') .. '.lrc'
    if io.open(lrc_path, 'r') then
        mp.osd_message('LRC file already exists')
        return
    end

    local title, artist = get_metadata()
    if not title then return end

    mp.osd_message('Downloading lyrics')
    local response = curl({
        'curl', '--silent', '--get', '--cookie', 'x-mxm-token-guid=' .. options.musixmatch_token,
        'https://apic-desktop.musixmatch.com/ws/1.1/macro.subtitles.get',
        '--data', 'app_id=web-desktop-app-v1.0',
        '--data', 'usertoken=' .. options.musixmatch_token,
        '--data-urlencode', 'q_track=' .. title,
        '--data-urlencode', 'q_artist=' .. artist,
    })

    if not response then return end
    if response.message.header.status_code == 401 and response.message.header.hint == 'renew' then
        show_message('Musixmatch token rate limited. See script-opts/lrc.conf for new token generation.', true)
        return
    end
    if response.message.header.status_code ~= 200 then
        show_message('Request failed with status code ' .. response.message.header.status_code, true)
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
            show_message('This is an instrumental track', true)
            return
        end
    end

    save_lyrics(lyrics, lrc_path)
end

mp.register_event('file-loaded', download_lyrics)
