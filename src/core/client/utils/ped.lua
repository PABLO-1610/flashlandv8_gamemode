--[[
  This file is part of FlashLand.
  Created at 25/10/2021 11:26
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610}

_FlashClient_Utils.ped_spawn = function(model, spawn)
    if ((PlayerId() ~= nil) and (PlayerPedId() ~= nil) and (GetEntityModel(PlayerPedId()) == _FlashLand.hash(model))) then
        return
    end
    _FlashClient_Utils.ped_freeze(PlayerId(), true)
    _FlashClient_Utils.memory_load(model)
    SetPlayerModel(PlayerId(), _FlashLand.hash(model))
    _FlashClient_Utils.memory_unload(model)
    RequestCollisionAtCoord(spawn.x, spawn.y, spawn.z)
    local ped = PlayerId()
    SetEntityCoordsNoOffset(ped, spawn.x, spawn.y, spawn.z, false, false, false, true)
    NetworkResurrectLocalPlayer(spawn.x, spawn.y, spawn.z, spawn.heading, true, true, false)
    ClearPedTasksImmediately(ped)
    RemoveAllPedWeapons(ped)
    ClearPlayerWantedLevel(PlayerId())
    local time = GetGameTimer()
    ShutdownLoadingScreen()
    ShutdownLoadingScreenNui()
    _FlashClient_Utils.ped_freeze(PlayerId(), false)
    SetPedDefaultComponentVariation(PlayerPedId())
end

_FlashClient_Utils.ped_freeze = function(playerId, bool)
    local player = playerId
    SetPlayerControl(player, not bool, false)
    local ped = GetPlayerPed(player)
    if not bool then
        if not IsEntityVisible(ped) then
            SetEntityVisible(ped, true)
        end
        if not IsPedInAnyVehicle(ped) then
            SetEntityCollision(ped, true)
        end
        FreezeEntityPosition(ped, false)
        SetPlayerInvincible(player, false)
    else
        if IsEntityVisible(ped) then
            SetEntityVisible(ped, false)
        end
        SetEntityCollision(ped, false)
        FreezeEntityPosition(ped, true)
        SetPlayerInvincible(player, true)
        if not IsPedFatallyInjured(ped) then
            ClearPedTasksImmediately(ped)
        end
    end
end