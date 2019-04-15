--za warudo
local MaxPlayers = 255
local virtualworlds = {}
local myworld = 0

function SetEntityVirtualWorld(entity, worldid)
    TriggerServerEvent('SetEntityVirtualWorld', entity, worldid)
end

function GetEntityVirtualWorld(entity)
    for k, v in pairs(virtualworlds) do
        for g,w in pairs(virtualworlds[k]) do
            if w.entity == entity then
                return k
            else
                return 0
            end
        end
    end
end


RegisterNetEvent('SetEntityVirtualWorld')
AddEventHandler('SetEntityVirtualWorld', function(vwtable, entity, worldid)
    virtualworlds = vwtable
    for i=0, MaxPlayers do
        local playerPed = GetPlayerPed(i)

        if i == PlayerId() and entity == playerPed then
            myworld = worldid
        end

        if NetworkIsPlayerActive(i) then
            if worldid == 0 then
                SetEntityVisible(entity, true, 0)
                SetEntityCollision(entity, true, true)
                return
            end

            if GetEntityVirtualWorld(playerPed) ~= worldid then
                SetEntityVisible(entity, false, 0)
                SetEntityCollision(entity, false, false)
                SetEntityNoCollisionEntity(playerPed, entity, true)
                SetEntityNoCollisionEntity(entity, playerPed, true)
            end

            if GetEntityVirtualWorld(playerPed) == worldid then
                for k,v in pairs(virtualworlds[worldid]) do
                    SetEntityVisible(v.entity, true, 0)
                    SetEntityCollision(v.entity, true, true)
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        while myworld ~= 0 then
            SetPedDensityMultiplierThisFrame(0)
            SetScenarioPedDensityMultiplierThisFrame(0, 0)
            SetParkedVehicleDensityMultiplierThisFrame(0)
            SetRandomVehicleDensityMultiplierThisFrame(0)
            SetSomeVehicleDensityMultiplierThisFrame(0)
            SetVehicleDensityMultiplierThisFrame(0)
            ClearPlayerWantedLevel(PlayerId())
            Citizen.Wait(0)
        end
        Citizen.Wait(1000)
    end
end)
