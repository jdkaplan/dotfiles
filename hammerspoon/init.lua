hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

local mod = {"alt", "shift"}
hs.hotkey.bind(mod, "Return", function()
    -- -n: Always open a new instance.  I want it to open in my home directory.
    hs.execute("open -n /Applications/Alacritty.app")
end)
