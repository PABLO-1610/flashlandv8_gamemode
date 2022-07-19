--[[
  This file is part of FlashLand.
  Created at 29/01/2022 21:32
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashServer_Job = {}
local list = {}

local baseGrades = {
    { id = "boss", label = "Boss", salary = 1500, permissions = {} },
    { id = "manager", label = "Manager", salary = 1000, permissions = {} },
    { id = "employee", label = "Employee", salary = 500, permissions = {} },
}

local function retrieveGrades(id)
    if (not (_FlashServer_Utils.file_exists(("resources/%s/src/jobs/%s/grades.json"):format(GetCurrentResourceName(), id)))) then
        CreateThread(function()
            _FlashServer_Utils.file_write(("resources/%s/src/jobs/%s/grades.json"):format(GetCurrentResourceName(), id), json.encode(id == _ConfigServer.Start.job and { { id = "civilian", label = "Sans emploi", salary = 0, permissions = {} } } or baseGrades))
        end)
        return baseGrades
    else
        local grades = _FlashServer_Utils.file_read(("resources/%s/src/jobs/%s/grades.json"):format(GetCurrentResourceName(), id))
        return json.decode(grades)
    end
end

function _FlashServer_Job:getAll()
    return (list)
end

function _FlashServer_Job:exists(id)
    return (list[id] ~= nil)
end

function _FlashServer_Job:registerJob(id, label)
    if (self:exists(id)) then
        return nil
    end
    local grades = {}
    for _, data in pairs(retrieveGrades(id)) do
        table.insert(grades, _JobGrade(data.id, data.label, data.salary, data.permissions))
    end
    local job = _Job(id, label, grades)
    list[id] = job
    return job
end

function _FlashServer_Job:get(id)
    return (list[id])
end