---@diagnostic disable-next-line: undefined-global
local hs = hs

-- Variable to store the mute state before lock
local wasMuted = nil

local function handleScreenLock(event)
  if
    event == hs.caffeinate.watcher.screensaverDidStart
    or event == hs.caffeinate.watcher.screensDidLock
    or event == hs.caffeinate.watcher.systemWillSleep
  then
    -- Store the current mute state
    if wasMuted == nil then
      wasMuted = hs.audiodevice.defaultOutputDevice():muted()
    end
    -- Mute the audio
    hs.audiodevice.defaultOutputDevice():setMuted(true)
  elseif event == hs.caffeinate.watcher.screensDidUnlock then
    -- Restore the previous mute state
    if wasMuted ~= nil then
      hs.audiodevice.defaultOutputDevice():setMuted(wasMuted)
      wasMuted = nil
    end
  end
end

local function handleScreenChange()
  local screens = hs.screen.allScreens()
  local builtInActive = false

  for _, screen in ipairs(screens) do
    if screen:name() == "Built-in Retina Display" then
      builtInActive = true
      break
    end
  end

  -- If no built-in screen is detected, lid is closed -> lock
  if not builtInActive then
    hs.caffeinate.lockScreen()
  end
end

local screenWatcher = hs.screen.watcher.new(handleScreenChange)
screenWatcher:start()

local caffeinateWatcher = hs.caffeinate.watcher.new(handleScreenLock)
caffeinateWatcher:start()
