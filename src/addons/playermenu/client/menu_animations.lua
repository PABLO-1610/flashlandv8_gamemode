--[[
  This file is part of FlashLand.
  Created at 09/11/2021 21:05
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

local categoriesType = { _FlashEnum_ANIMATIONTYPE.EXPRESSION, _FlashEnum_ANIMATIONTYPE.PROCESS, _FlashEnum_ANIMATIONTYPE.ANIMATION }
local categoriesIndex = 1
local animationList = { }
for _, v in pairs(_Static_Animation.animation) do
    table.insert(animationList, ("~r~%s~s~"):format(v.label))
end
local animationIndex = 1

_FlashClient_PlayerMenu.drawer[4] = function()
    RageUI.List("Catégorie : ", categoriesType, categoriesIndex, "", {}, true, {
        onListChange = function(Index)
            categoriesIndex = Index
        end,
    })
    if categoriesIndex == 1 then
        RageUI.Line()
        for _, anim in pairs(_Static_Animation.expression) do
            RageUI.Button(("%s"):format(anim.label), nil, {}, true, {
                onSelected = function()
                    _FlashClient_Utils.ped_expression(PlayerPedId(), anim.name, 0)
                end
            })
        end
    elseif categoriesIndex == 2 then
        RageUI.Line()
        for _, process in pairs(_Static_Animation.process) do
            RageUI.Button(("Démarche %s"):format(process.label), nil, {}, true, {
                onSelected = function()
                    _FlashClient_Utils.process_load(process.name)
                    _FlashClient_Utils.ped_process(PlayerPedId(), process.name, 0.4)
                end
            })
        end
    elseif categoriesIndex == 3 then
        RageUI.List("Type : ", animationList, animationIndex, nil, {}, true, {
            onListChange = function(Index)
                animationIndex = Index
            end,
        })
        RageUI.Line()
        for _, animation in pairs(_Static_Animation.animation[animationIndex].items) do
            RageUI.Button(("%s"):format(animation.label), nil, {}, true, {
                onSelected = function()
                    if ( not (IsPedInAnyVehicle(PlayerPedId(), false))) then
                        if animation.type == "anim" then
                            _FlashClient_Utils.animation_load(animation.data.lib)
                            _FlashClient_Utils.ped_animation(PlayerPedId(), animation.data.lib, animation.data.anim)
                        elseif animation.type == "scenario" then
                            _FlashClient_Utils.ped_scenario(PlayerPedId(), animation.data.anim)
                        end
                    end
                end,
            })
        end
    end
end