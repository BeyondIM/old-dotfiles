hs.hints.showTitleThresh = 0
hs.window.animationDuration = 0
hs.grid.MARGINX 	= 0
hs.grid.MARGINY 	= 0
hs.grid.GRIDWIDTH 	= 10
hs.grid.GRIDHEIGHT 	= 8

-- key define
local shift_alt = {"shift", "alt"}
local shift_cmd = {"shift", "cmd"}

-- app shortcuts
local key2app = {
    i = 'iTerm',
    v = 'MacVim',
    e = 'Clearview',
    b = 'Firefox',
    f = 'Finder'
}

for key, app in pairs(key2app) do
    hs.hotkey.bind(shift_alt, key, function() hs.application.launchOrFocus(app) end)
end

-- move window within a grid
hs.hotkey.bind(shift_alt, 'up', hs.grid.pushWindowUp)
hs.hotkey.bind(shift_alt, 'right', hs.grid.pushWindowRight)
hs.hotkey.bind(shift_alt, 'down', hs.grid.pushWindowDown)
hs.hotkey.bind(shift_alt, 'left', hs.grid.pushWindowLeft)

-- resize window within a grid
hs.hotkey.bind(shift_cmd, 'up', hs.grid.resizeWindowShorter)
hs.hotkey.bind(shift_cmd, 'right', hs.grid.resizeWindowWider)
hs.hotkey.bind(shift_cmd, 'down', hs.grid.resizeWindowTaller)
hs.hotkey.bind(shift_cmd, 'left', hs.grid.resizeWindowThinner)

-- resize window via function
function push(x, y, w, h)
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    f.x = max.x + (max.w*x)
    f.y = max.y + (max.h*y)
    f.w = max.w*w
    f.h = max.h*h
    win:setFrame(f)
end

hs.hotkey.bind(shift_cmd, 'h', function() push(0,0,0.5,1) end)
hs.hotkey.bind(shift_cmd, 'l', function() push(0.5,0,0.5,1) end)
hs.hotkey.bind(shift_cmd, 'j', function() push(0,0.5,1,0.5) end)
hs.hotkey.bind(shift_cmd, 'k', function() push(0,0,1,0.5) end)
hs.hotkey.bind(shift_cmd, 'y', function() push(0,0,0.5,0.5) end)
hs.hotkey.bind(shift_cmd, 'u', function() push(0.5,0,0.5,0.5) end)
hs.hotkey.bind(shift_cmd, 'b', function() push(0,0.5,0.5,0.5) end)
hs.hotkey.bind(shift_cmd, 'n', function() push(0.5,0.5,0.5,0.5) end)

-- toggle zoom
hs.hotkey.bind(shift_cmd, 'return', function() hs.window.focusedWindow():toggleZoom() end)

-- snap window
hs.hotkey.bind(shift_cmd, "/", function() hs.fnutils.map(hs.window.visibleWindows(), hs.grid.snap) end)

-- show hints
hs.hotkey.bind(shift_alt, 'space', hs.hints.windowHints)

-- change focus
hs.hotkey.bind(shift_alt, 'h', function() hs.window.focusedWindow():focusWindowWest() end)
hs.hotkey.bind(shift_alt, 'l', function() hs.window.focusedWindow():focusWindowEast() end)
hs.hotkey.bind(shift_alt, 'j', function() hs.window.focusedWindow():focusWindowSouth() end)
hs.hotkey.bind(shift_alt, 'k', function() hs.window.focusedWindow():focusWindowNorth() end)

-- layout
local screens = hs.screen.allScreens()
local display_main, display_sec = nil, nil
if #screens == 2 then
    if screens[1]:fullFrame().w > screens[2]:fullFrame().w then
        display_main, display_sec = screens[1]:name(), screens[2]:name()
    else
        display_main, display_sec = screens[2]:name(), screens[1]:name()
    end
else
    display_main = screens[1]:name()
end

local single_display = {
    { "MacVim", nil, display_main, hs.layout.left50, nil, nil },
    { "Firefox", nil, display_main, hs.layout.right50, nil, nil },
}

local dual_display = {
    { "Firefox", nil, display_sec, hs.layout.maximized, nil, nil },
    { "MacVim", nil, display_main, { x=0, y=0, w=0.6, h=1}, nil, nil },
    { "Finder", nil, display_main, { x=0.6, y=0, w=0.4, h=0.5}, nil, nil },
    { "iTerm", nil, display_main, { x=0.6, y=0.5, w=0.4, h=0.5}, nil, nil },
}

function applySingleDisplay()
    for _,app in pairs(single_display) do
        hs.application.launchOrFocus(app[1])
    end
    hs.layout.apply(single_display)
end

function applyDualDisplay()
    if #screens == 2 then
        for _,app in pairs(dual_display) do
            hs.application.launchOrFocus(app[1])
        end
        hs.layout.apply(dual_display)
    else
        hs.alert.show("Only one monitor exists!")
    end
end

hs.hotkey.bind(shift_alt, '1', function() applySingleDisplay() end)
hs.hotkey.bind(shift_alt, '2', function() applyDualDisplay() end)

-- mouse circle
local mouseCircle = nil
local mouseCircleTimer = nil

function mouseHighlight()
    if mouseCircle then
        mouseCircle:delete()
        if mouseCircleTimer then
            mouseCircleTimer:stop()
        end
    end
    mousepoint = hs.mouse.getAbsolutePosition()
    mouseCircle = hs.drawing.circle(hs.geometry.rect(mousepoint.x-20, mousepoint.y-20, 40, 40))
    mouseCircle:setStrokeColor({["red"]=1,["blue"]=0,["green"]=0,["alpha"]=1})
    mouseCircle:setFill(false)
    mouseCircle:setStrokeWidth(5)
    mouseCircle:bringToFront(true)
    mouseCircle:show()
    mouseCircleTimer = hs.timer.doAfter(3, function() mouseCircle:delete() end)
end

hs.hotkey.bind(shift_alt, 'm', mouseHighlight)

-- caffeine
local notice = nil
local time = 15

function setCaffeine(mode)
    local c = hs.caffeinate
    if c.get(mode) then
        if notice then
            c.set(mode,nil,true)
            hs.alert.show("Decaffeinated")
        else
            hs.alert.show("Press the key again within "..time.."s to set caffeine "..mode.." mode off")
            notice = true
            hs.timer.doAfter(time, function() notice=nil end)
        end
    else
        c.set(mode,true,true)
        hs.alert.show("Caffeine on for "..mode)
    end
end

hs.hotkey.bind(shift_alt, 'c', function() setCaffeine("displayIdle") end)
hs.hotkey.bind(shift_cmd, 'c', function() setCaffeine("systemIdle") end)

-- reload config
function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end

hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
