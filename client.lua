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
            end
        end
    end
    return 0
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

            if GetEntityVirtualWorld(playerPed) ~= GetEntityVirtualWorld(entity) and (entity ~= playerPed) then
                SetEntityVisible(entity, false, 0)
                FreezeEntityPosition(entity, true)
                SetEntityCollision(entity, false, true)
            end

            if GetEntityVirtualWorld(playerPed) == GetEntityVirtualWorld(entity) then
                for k,v in pairs(virtualworlds[worldid]) do
                    SetEntityVisible(v.entity, true, true)
                    FreezeEntityPosition(v.entity, false)
                    SetEntityCollision(v.entity, true, true)
                end
            end
            
            for k,v in pairs(virtualworlds) do
                for g,w in pairs(virtualworlds[k]) do
                    if (GetEntityVirtualWorld(playerPed) ~= GetEntityVirtualWorld(w.entity)) and (w.entity ~= playerPed) then
                        SetEntityVisible(w.entity, false, 0)
                        FreezeEntityPosition(w.entity, true)
                        SetEntityCollision(w.entity, false, true)
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        while myworld ~= 0 do
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
