local virtualworlds = {}

RegisterServerEvent('SetEntityVirtualWorld')
AddEventHandler('SetEntityVirtualWorld', function(entity, worldid)
    if (worldid < 0) or (worldid > 2147483647)  then
        Citizen.Trace("Attempt to place entity "..entity.." in out of bounds virtual world ("..worldid..")!\n")
        return
    end
    
    for k,v in pairs(virtualworlds) do
        if virtualworlds[worldid] ~= nil then
            for g,w in pairs(virtualworlds[k]) do
                if w.entity == entity then
                    table.remove(virtualworlds[k], g)
                end
            end
        end
    end
    
    if virtualworlds[worldid] ~= nil then
        table.insert(virtualworlds[worldid], {['entity'] = entity})
    else
        virtualworlds[worldid] = {} 
        table.insert(virtualworlds[worldid], {['entity'] = entity})
    end

    TriggerClientEvent('SetEntityVirtualWorld', -1, virtualworlds, entity, worldid)
end)
