local paused = mp.get_property_native("pause")
local path = mp.get_property("path")
local sub_text = ""

local function update_display()
    local f = io.open("/tmp/mpv_lyrics", "w")
    if not f then return end

    local text = ""
    if path then
        if not paused and sub_text ~= "" then
            text = "🎶 " .. sub_text
        else
            local icon = paused and "⏸️ " or "▶️ "
            local filename = path:match("([^/]+)$") or path
            text = icon .. filename
        end
    end

    f:write(text, "\n")
    f:close()
    os.execute("pkill -RTMIN+10 i3blocks")
end

mp.observe_property("sub-text", "string", function(_, val)
    sub_text = val or ""
    update_display()
end)

mp.observe_property("pause", "bool", function(_, val)
    paused = val
    update_display()
end)

mp.observe_property("path", "string", function(_, val)
    path = val
    update_display()
end)

mp.register_event("shutdown", function()
    local f = io.open("/tmp/mpv_lyrics", "w")
    if f then f:write("") f:close() end
end)
