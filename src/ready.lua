local file = io.open("drp.json", "w")

local jsonPath = "drp.json"

local function WriteData()
    if not CurrentRun or not CurrentRun.CurrentRoom then return end

    local biome = CurrentRun.CurrentRoom.RoomSetName or "Unknown"
    local room = CurrentRun.RoomsEntered or 0

    local data = string.format(
        '{ "biome": "%s", "room": "%s" }',
        biome,
        tostring(room)
    )

    local file = io.open(jsonPath, "w")
    if file then
        file:write(data)
        file:close()
    end
end

-- Hook into room start
modutil.mod.Path.Wrap("StartRoom", function(base, currentRun, currentRoom)
    base(currentRun, currentRoom)
    WriteData()
end)

-- Auto start RPC

local modPath = _PLUGIN and _PLUGIN.path or debug.getinfo(1, "S").source:match("@?(.+[\\/])")
local exePath = modPath .. "rpc.exe"

if not _G.DRP_STARTED then
    _G.DRP_STARTED = true
    os.execute('start "" "' .. exePath .. '"')
end