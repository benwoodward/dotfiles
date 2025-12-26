-- ############################################################### --
-- HAMMERSPOON YABAI CONFIGURATION
-- Converted from skhd configuration for window management
-- ############################################################### --

-- Efficient yabai helper function (faster than hs.execute)
-- Based on recommendation from hammerspoon-yabai community
function yabai(args)
  hs.task
    .new("/opt/homebrew/bin/yabai", nil, function() return true end, args)
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
-- WINDOW RESIZING
-- cmd+alt+key: move the edge in that direction
-- cmd+alt+shift+key: move the opposite edge in that direction
-- ############################################################### --

-- H: move left edge left / shift: move right edge left
hs.hotkey.bind({ "alt", "cmd" }, "h", function()
	yabai({ "-m", "window", "--resize", "left:-50:0" })
end)
hs.hotkey.bind({ "shift", "alt", "cmd" }, "h", function()
	yabai({ "-m", "window", "--resize", "right:-50:0" })
end)

-- L: move right edge right / shift: move left edge right
hs.hotkey.bind({ "alt", "cmd" }, "l", function()
	yabai({ "-m", "window", "--resize", "right:50:0" })
end)
hs.hotkey.bind({ "shift", "alt", "cmd" }, "l", function()
	yabai({ "-m", "window", "--resize", "left:50:0" })
end)

-- K: move top edge up / shift: move bottom edge up
hs.hotkey.bind({ "alt", "cmd" }, "k", function()
	yabai({ "-m", "window", "--resize", "top:0:-50" })
end)
hs.hotkey.bind({ "shift", "alt", "cmd" }, "k", function()
	yabai({ "-m", "window", "--resize", "bottom:0:-50" })
end)

-- J: move bottom edge down / shift: move top edge down
hs.hotkey.bind({ "alt", "cmd" }, "j", function()
	yabai({ "-m", "window", "--resize", "bottom:0:50" })
end)
hs.hotkey.bind({ "shift", "alt", "cmd" }, "j", function()
	yabai({ "-m", "window", "--resize", "top:0:50" })
end)

-- ############################################################### --
-- HIGHLIGHT FOCUSED WINDOW WITH BORDER
-- ############################################################### --

local focusBorder = nil

local function updateFocusBorder()
	if focusBorder then
		focusBorder:delete()
		focusBorder = nil
	end

	local win = hs.window.focusedWindow()
	if not win then return end

	local app = win:application()
	if not app or app:name() ~= "kitty" then return end

	-- Only show border if app has more than 1 window
	local windows = app:allWindows()
	local visibleCount = 0
	for _, w in ipairs(windows) do
		if w:isStandard() and w:isVisible() then
			visibleCount = visibleCount + 1
		end
	end
	if visibleCount <= 1 then return end

	local frame = win:frame()
	local borderWidth = 4

	focusBorder = hs.canvas.new(frame)
	focusBorder:appendElements({
		type = "rectangle",
		action = "stroke",
		strokeColor = { red = 1, green = 0.5, blue = 0, alpha = 1 },
		strokeWidth = borderWidth,
		roundedRectRadii = { xRadius = 10, yRadius = 10 },
	})
	focusBorder:level(hs.canvas.windowLevels.overlay)
	focusBorder:show()
end

hs.window.filter.default:subscribe(hs.window.filter.windowFocused, updateFocusBorder)

-- ############################################################### --
-- WINDOW LABELS
-- ############################################################### --

local windowLabels = {}  -- window ID -> { canvas, name }
local activeColor = { red = 1, green = 0.5, blue = 0, alpha = 1 }
local inactiveColor = { white = 1, alpha = 1 }
local labelFontSize = 12
local labelPadding = 8

local function getLabelWidth(name)
	local textSize = hs.drawing.getTextDrawingSize(name, { size = labelFontSize })
	return textSize.w + labelPadding * 2
end

local function updateLabelPosition(winId)
	local labelData = windowLabels[winId]
	if not labelData then return end

	local win = hs.window.get(winId)
	if not win then
		labelData.canvas:delete()
		windowLabels[winId] = nil
		return
	end

	local frame = win:frame()
	local labelHeight = 18
	local labelWidth = getLabelWidth(labelData.name)
	labelData.canvas:frame({
		x = frame.x + (frame.w - labelWidth) / 2,
		y = frame.y,
		w = labelWidth,
		h = labelHeight
	})
end

local function updateLabelColors()
	local focusedWin = hs.window.focusedWindow()
	local focusedId = focusedWin and focusedWin:id() or nil

	-- Check if focused app is kitty
	local app = focusedWin and focusedWin:application()
	local isKittyFocused = app and app:name() == "kitty"

	for winId, labelData in pairs(windowLabels) do
		if isKittyFocused and winId == focusedId then
			labelData.canvas:show()
			labelData.canvas[2].textColor = activeColor
		else
			labelData.canvas:hide()
		end
	end
end

local function createWindowLabel(win, name)
	local winId = win:id()

	-- Remove existing label if any
	if windowLabels[winId] then
		windowLabels[winId].canvas:delete()
	end

	local frame = win:frame()
	local labelHeight = 18
	local labelWidth = getLabelWidth(name)
	local focusedWin = hs.window.focusedWindow()
	local isFocused = focusedWin and focusedWin:id() == winId

	local canvas = hs.canvas.new({
		x = frame.x + (frame.w - labelWidth) / 2,
		y = frame.y,
		w = labelWidth,
		h = labelHeight
	})
	canvas:appendElements({
		type = "rectangle",
		action = "fill",
		fillColor = { red = 0, green = 0, blue = 0, alpha = 0.8 },
		roundedRectRadii = { xRadius = 4, yRadius = 4 },
	}, {
		type = "text",
		text = name,
		textColor = isFocused and activeColor or inactiveColor,
		textAlignment = "center",
		textSize = labelFontSize,
		frame = { x = 0, y = 2, w = "100%", h = "100%" },
	})
	canvas:level(hs.canvas.windowLevels.overlay)
	canvas:show()

	windowLabels[winId] = { canvas = canvas, name = name }
end

-- Hotkey to add label to focused window (Cmd+Alt+N)
hs.hotkey.bind({ "cmd", "alt" }, "n", function()
	local win = hs.window.focusedWindow()
	if not win then return end

	local button, text = hs.dialog.textPrompt("Window Label", "Enter a name for this window:", "", "OK", "Cancel")
	if button == "OK" and text ~= "" then
		createWindowLabel(win, text)
	end
end)

-- Track window movements and destruction
local labelWatcher = hs.window.filter.new():setDefaultFilter()
labelWatcher:subscribe(hs.window.filter.windowMoved, function(win)
	if win then updateLabelPosition(win:id()) end
end)
labelWatcher:subscribe(hs.window.filter.windowFocused, function(win)
	updateLabelColors()
end)
labelWatcher:subscribe(hs.window.filter.windowDestroyed, function(win, appName, event)
	-- Clean up any orphaned labels
	for winId, labelData in pairs(windowLabels) do
		if not hs.window.get(winId) then
			labelData.canvas:delete()
			windowLabels[winId] = nil
		end
	end
end)

-- ############################################################### --
-- ARRANGE WINDOWS IN GRID
-- ############################################################### --

-- Arrange windows in two vertical halves (side by side)
hs.hotkey.bind({ "cmd", "alt" }, "v", function()
	local focusedWindow = hs.window.focusedWindow()
	if not focusedWindow then return end

	local app = focusedWindow:application()
	local windows = app:allWindows()

	local visibleWindows = {}
	for _, win in ipairs(windows) do
		if win:isStandard() and win:isVisible() then
			table.insert(visibleWindows, win)
		end
	end

	if #visibleWindows == 0 then return end

	local screen = focusedWindow:screen()
	local frame = screen:frame()
	local gap = 1

	local halfWidth = (frame.w - gap * 3) / 2

	for i, win in ipairs(visibleWindows) do
		if i > 2 then break end
		local x = frame.x + gap + (i - 1) * (halfWidth + gap)
		win:setFrame(hs.geometry.rect(x, frame.y + gap, halfWidth, frame.h - gap * 2))
	end
end)

-- Arrange all windows of current application in a 2x2 grid with gaps
hs.hotkey.bind({ "cmd", "alt" }, "g", function()
	local focusedWindow = hs.window.focusedWindow()
	if not focusedWindow then return end

	local app = focusedWindow:application()
	local windows = app:allWindows()

	-- Filter to only visible, standard windows
	local visibleWindows = {}
	for _, win in ipairs(windows) do
		if win:isStandard() and win:isVisible() then
			table.insert(visibleWindows, win)
		end
	end

	if #visibleWindows == 0 then return end

	local screen = focusedWindow:screen()
	local frame = screen:frame()

	local gap = 1  -- Gap size in pixels
	local cols = 2
	local rows = 2

	local cellWidth = (frame.w - gap * (cols + 1)) / cols
	local cellHeight = (frame.h - gap * (rows + 1)) / rows

	for i, win in ipairs(visibleWindows) do
		if i > 4 then break end  -- Max 4 windows in 2x2 grid

		local col = (i - 1) % cols
		local row = math.floor((i - 1) / cols)

		local x = frame.x + gap + col * (cellWidth + gap)
		local y = frame.y + gap + row * (cellHeight + gap)

		win:setFrame(hs.geometry.rect(x, y, cellWidth, cellHeight))
	end
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
