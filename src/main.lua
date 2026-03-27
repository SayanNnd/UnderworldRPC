local mods = rom.mods

mods['LuaENVY-ENVY'].auto()

rom = rom
_PLUGIN = _PLUGIN

game = rom.game
import_as_fallback(game)

sjson = mods['SGG_Modding-SJSON']
modutil = mods['SGG_Modding-ModUtil']
chalk = mods["SGG_Modding-Chalk"]
reload = mods['SGG_Modding-ReLoad']

config = chalk.auto 'config.lua'
public.config = config

local function on_ready()
    if config.enabled == false then return end
    mod = modutil.mod.Mod.Register(_PLUGIN.guid)
    import 'ready.lua'
end

local function on_reload()
    if config.enabled == false then return end
    import 'reload.lua'
end

local function on_ready_late()
    if config.enabled == false then return end
    import 'ready_late.lua'
end

local function on_reload_late()
    if config.enabled == false then return end
    import 'reload_late.lua'
end

local loader = reload.auto_multiple()

modutil.once_loaded.game(function()
    loader.load("early", on_ready, on_reload)
end)

mods.on_all_mods_loaded(function()
    modutil.once_loaded.game(function()
        loader.load("late", on_ready_late, on_reload_late)
    end)
end)