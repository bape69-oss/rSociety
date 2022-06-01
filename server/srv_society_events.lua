TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

CreateThread(function()
    MySQL.ready(function()
        MySQL.Async.fetchAll("SELECT * FROM society", {}, function(result)
            print("[^4Society^7] Toute les sociétés du serveur à été charger : ^1"..#result.."^7")
        end)
        MySQL.Async.fetchAll("SELECT * FROM jobs", {}, function(result)
            print("[^4Society^7] Tout les métiers du serveur à été charger : ^1"..#result.."^7")
        end)
        MySQL.Async.fetchAll("SELECT * FROM organisation", {}, function(result)
            print("[^4Society^7] Toute les organisation du serveur à été charger : ^1"..#result.."^7")
        end)
    end)
end)

----------------------------------------------------------------------------------------------------------------

RegisterNetEvent("rSociety:GetSocietyMoney")
AddEventHandler("rSociety:GetSocietyMoney", function(society)
    local src = source
    GetSocietyMoney(src, society)
end)

RegisterNetEvent("rSociety:AddSocietyMoney")
AddEventHandler("rSociety:AddSocietyMoney", function(society, amount)
    local src = source
    print("[^4Society^7] "..amount.." à été déposer dans la société ^1"..society.." ")
    AddSocietyMoney(src, society, amount)
end)

RegisterNetEvent('rSociety:RemoveSocietyMoney')
AddEventHandler("rSociety:RemoveSocietyMoney",function(society, amount)
    local src = source
    print("[^4Society^7] "..amount.." à été retirer dans la société ^1"..society.." ")
    RemoveSocietyMoney(src, society, amount)
end)

----------------------------------------------------------------------------------------------------------------
RegisterNetEvent("rSociety:GetSocietyDirty")
AddEventHandler("rSociety:GetSocietyDirty", function(society)
    local src = source
    GetSocietyDirty(src, society)
end)

RegisterNetEvent("rSociety:AddSocietyDirty")
AddEventHandler("rSociety:AddSocietyDirty", function(society, amount)
    local src = source
    print("[^4Society^7] "..amount.." (argent sale) à été déposer dans la société ^1"..society.." ")
    AddSocietyDirty(src, society, amount)
end)

RegisterNetEvent('rSociety:RemoveSocietyDirty')
AddEventHandler("rSociety:RemoveSocietyDirty",function(society, amount)
    local src = source
    print("[^4Society^7] "..amount.." (argent sale) à été retirer dans la société ^1"..society.." ")
    RemoveSocietyDirty(src, society, amount)
end)

----------------------------------------------------------------------------------------------------------------
RegisterNetEvent("rSociety:GetSocietyInventory")
AddEventHandler("rSociety:GetSocietyInventory", function(society)
    local src = source
    GetSocietyInventory(src, society)
end)

RegisterNetEvent("rSociety:AddSocietyItem")
AddEventHandler("rSociety:AddSocietyItem", function(society, label, name, count, weight)
    local src = source
    print("[^4Society^7] "..label.." x "..count.." à été déposer dans la société ^1"..society.." ")
    AddSocietyItem(src, society, label, name, count, weight)
end)

RegisterNetEvent('rSociety:RemoveSocietyItem')
AddEventHandler("rSociety:RemoveSocietyItem",function(society, label, name, count, weight)
    local src = source
    print("[^4Society^7] "..label.." x "..count.." à été retirer dans la société ^1"..society.." ")
    RemoveSocietyItem(src, society, label, name, count, weight)
end)

----------------------------------------------------------------------------------------------------------------
RegisterNetEvent("rSociety:GetSocietyWeapon")
AddEventHandler("rSociety:GetSocietyWeapon", function(society)
    local src = source
    local player = ESX.GetPlayerFromId(src)
    GetSocietyWeapon(src, society, player.getLoadout())
end)

RegisterNetEvent("rSociety:AddSocietyWeapon")
AddEventHandler("rSociety:AddSocietyWeapon", function(society, label, name, count)
    local src = source
    print("[^4Society^7] "..label.." x "..count.." à été déposer dans la société ^1"..society.." ")
    AddSocietyWeapon(src, society, label, name, count)
end)

RegisterNetEvent('rSociety:RemoveSocietyWeapon')
AddEventHandler("rSociety:RemoveSocietyWeapon",function(society, label, name, count)
    local src = source
    print("[^4Society^7] "..label.." x "..count.." à été retirer dans la société ^1"..society.." ")
    RemoveSocietyWeapon(src, society, label, name, count)
end)

RegisterNetEvent("rSociety:Blanchissement")
AddEventHandler("rSociety:Blanchissement", function(society, amount)
    local src = source
    BlanchissementSociety(src, society, amount)
end)

----------------------------------------------------------------------------------------------------------------
RegisterNetEvent("rSociety:Salary")
AddEventHandler("rSociety:Salary", function(salary)
    local player = ESX.GetPlayerFromId(source)
    SocietySalary(player.source, player.job.name, salary)
end)