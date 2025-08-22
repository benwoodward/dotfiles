-- ############################################################### --
-- HAMMERSPOON YABAI CONFIGURATION
-- Converted from skhd configuration for window management
-- ############################################################### --

-- Efficient yabai helper function (faster than hs.execute)
-- Based on recommendation from hammerspoon-yabai community
function yabai(args)
	hs.task
		.new("/usr/local/bin/yabai", nil, function(ud, ...)
			-- Optional: uncomment next line for debugging
			-- print("yabai:", hs.inspect(table.pack(...)))
			return true
		end, args)
		:start()
end

-- ############################################################### --
-- WINDOW POSITIONING AND SIZING
-- ############################################################### --

-- Make floating window fill left-half of screen
-- Original: ralt - left : yabai -m window --grid 1:2:0:0:1:1
-- hs.hotkey.bind({ "alt" }, "left", function()
-- 	yabai({ "-m", "window", "--grid", "1:2:0:0:1:1" })
-- end)

-- Make floating window fill right-half of screen
-- Original: ralt - right : yabai -m window --grid 1:2:1:0:1:1
-- hs.hotkey.bind({ "alt" }, "right", function()
-- 	yabai({ "-m", "window", "--grid", "1:2:1:0:1:1" })
-- end)

-- Make window full-screen
-- Original: cmd + shift - m : yabai -m window --grid 1:1:0:0:1:1
hs.hotkey.bind({ "cmd", "shift" }, "m", function()
	yabai({ "-m", "window", "--grid", "1:1:0:0:1:1" })
end)

-- ############################################################### --
-- MOVE FLOATING WINDOW (vim-style hjkl navigation)
-- ############################################################### --

-- Move floating window left
-- Original: shift + alt - h : yabai -m window --move rel:-50:0
hs.hotkey.bind({ "shift", "alt" }, "h", function()
	yabai({ "-m", "window", "--move", "rel:-50:0" })
end)

-- Move floating window right
-- Original: shift + alt - l : yabai -m window --move rel:50:0
hs.hotkey.bind({ "shift", "alt" }, "l", function()
	yabai({ "-m", "window", "--move", "rel:50:0" })
end)

-- Move floating window up
-- Original: shift + alt - k : yabai -m window --move rel:0:-50
hs.hotkey.bind({ "shift", "alt" }, "k", function()
	yabai({ "-m", "window", "--move", "rel:0:-50" })
end)

-- Move floating window down
-- Original: shift + alt - j : yabai -m window --move rel:0:50
hs.hotkey.bind({ "shift", "alt" }, "j", function()
	yabai({ "-m", "window", "--move", "rel:0:50" })
end)

-- ############################################################### --
-- INCREASE WINDOW SIZE (expand outward)
-- ############################################################### --

-- Increase window size left (expand left edge)
-- Original: shift + alt + cmd - h : yabai -m window --resize left:-50:0
hs.hotkey.bind({ "shift", "alt", "cmd" }, "h", function()
	yabai({ "-m", "window", "--resize", "left:-50:0" })
end)

-- Increase window size right (expand right edge)
-- Original: shift + alt + cmd - l : yabai -m window --resize right:50:50
hs.hotkey.bind({ "shift", "alt", "cmd" }, "l", function()
	yabai({ "-m", "window", "--resize", "right:50:50" })
end)

-- Increase window size up (expand top edge)
-- Original: shift + alt + cmd - k : yabai -m window --resize top:0:-50
hs.hotkey.bind({ "shift", "alt", "cmd" }, "k", function()
	yabai({ "-m", "window", "--resize", "top:0:-50" })
end)

-- Increase window size down (expand bottom edge)
-- Original: shift + alt + cmd - j : yabai -m window --resize bottom:0:50
hs.hotkey.bind({ "shift", "alt", "cmd" }, "j", function()
	yabai({ "-m", "window", "--resize", "bottom:0:50" })
end)

-- ############################################################### --
-- DECREASE WINDOW SIZE (shrink inward)
-- ############################################################### --

-- Decrease window size from right (shrink right edge)
-- Original: alt + cmd - l : yabai -m window --resize right:-50:0
hs.hotkey.bind({ "alt", "cmd" }, "l", function()
	yabai({ "-m", "window", "--resize", "right:-50:0" })
end)

-- Decrease window size from left (shrink left edge)
-- Original: alt + cmd - h : yabai -m window --resize left:50:50
hs.hotkey.bind({ "alt", "cmd" }, "h", function()
	yabai({ "-m", "window", "--resize", "left:50:50" })
end)

-- Decrease window size from bottom (shrink bottom edge)
-- Original: alt + cmd - k : yabai -m window --resize bottom:0:-50
hs.hotkey.bind({ "alt", "cmd" }, "k", function()
	yabai({ "-m", "window", "--resize", "bottom:0:-50" })
end)

-- Decrease window size from top (shrink top edge)
-- Original: alt + cmd - j : yabai -m window --resize top:0:50
hs.hotkey.bind({ "alt", "cmd" }, "j", function()
	yabai({ "-m", "window", "--resize", "top:0:50" })
end)

-- ############################################################### --
-- ADDITIONAL HELPER FUNCTIONS (uncomment to enable)
-- ############################################################### --

-- Optional: Add notification when config reloads
hs.alert.show("Hammerspoon Yabai config loaded")

-- Optional: Reload Hammerspoon config with Cmd+Alt+R
-- hs.hotkey.bind({"cmd", "alt"}, "r", function()
--     hs.reload()
-- end)

-- ############################################################### --
-- COMMENTED SHORTCUTS FROM ORIGINAL CONFIG
-- Uncomment and modify as needed:
-- ############################################################### --

--[[ 
FOCUS WINDOW:
hs.hotkey.bind({"alt"}, "h", function()
    yabai({"-m", "window", "--focus", "west"})
end)

SWAP WINDOWS:
hs.hotkey.bind({"shift", "alt"}, "h", function()
    yabai({"-m", "window", "--swap", "north"})
end)

MOVE/WARP WINDOWS:
hs.hotkey.bind({"shift", "cmd"}, "h", function()
    yabai({"-m", "window", "--warp", "east"})
end)

BALANCE WINDOWS:
hs.hotkey.bind({"shift", "alt"}, "0", function()
    yabai({"-m", "space", "--balance"})
end)

FOCUS SPACES:
hs.hotkey.bind({"cmd", "alt"}, "x", function()
    yabai({"-m", "space", "--focus", "recent"})
end)

TOGGLE ZOOM:
hs.hotkey.bind({"alt"}, "f", function()
    yabai({"-m", "window", "--toggle", "zoom-fullscreen"})
end)

TOGGLE FLOAT:
hs.hotkey.bind({"alt"}, "t", function()
    yabai({"-m", "window", "--toggle", "float"})
    yabai({"-m", "window", "--grid", "4:4:1:1:2:2"})
end)
--]]
