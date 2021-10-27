--[[
  This file is part of FlashLand.
  Created at 27/10/2021 16:20
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

local defaultModels = {
    "mp_m_freemode_01",
    "mp_f_freemode_01"
}

_FlashLand.onReceive("creator:init", function()
    Wait(5000)
    local coords, heading = _ConfigClient.Creator.pedPosition.coords, _ConfigClient.Creator.pedPosition.heading
    _FlashLand.toInternal("creator:initCamera")
    _FlashClient_Utils.controls_disable()
    _FlashClient_Utils.screen_radar(false)
    _FlashClient_Utils.loading_show("Chargement de l'éditeur de personnage", 4)
    _FlashClient_Utils.memory_loadAll(defaultModels)
    _FlashClient_Utils.ped_spawn("mp_m_freemode_01", { x = coords.x, y = coords.y, z = coords.z, heading = _ConfigClient.Creator.pedPosition.heading})
    _FlashClient_Utils.ped_tp(PlayerPedId(), coords, heading)
    _FlashClient_Utils.screen_reveal(3500, true)
    _FlashClient_Utils.loading_hide()
end)

_FlashLand.log("Chargement de l'addon: ^3creator")