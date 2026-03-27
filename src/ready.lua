local modPath = debug.getinfo(1, "S").source:match("@?(.+[\\/])")
local jsonPath = modPath .. "drp.json"
local exePath = modPath .. "rpc.exe"

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

modutil.mod.Path.Wrap("StartRoom", function(base, currentRun, currentRoom)
    base(currentRun, currentRoom)
    WriteData()
end)

if not _G.DRP_STARTED then
    _G.DRP_STARTED = true
    local ok = os.execute('start "" "' .. exePath .. '"')
    print("RPC launch result: " .. tostring(ok))
end