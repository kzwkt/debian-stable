mp.observe_property("sub-text", "string", function(name, value)
    local f = io.open("/tmp/mpv_lyrics", "w")
    if f then
        f:write(value or "", "\n")
        f:close()
    end
end)
