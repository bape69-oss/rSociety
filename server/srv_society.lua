TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local Chest = {}

function AddSocietyMoney(src, society, amount)
    local player = ESX.GetPlayerFromId(src)
    local playerMoney = player.getMoney()
    if society == nil then
        print("[^4Society^7] Cette société n'est pas répertorier ou invalide")
    else
        MySQL.Async.fetchAll("SELECT * FROM society WHERE society_name = @name", {
            ["@name"] = society
        }, function(result)
            if result[1] then
                if playerMoney >= amount then
                    MySQL.Async.execute("UPDATE society SET account = @account WHERE society_name = @society", {
                        ["@account"] = result[1].account + amount,
                        ["@society"] = society
                    }, function(rowChange)
                        player.removeMoney(amount)
                        SendLogs(GetPlayerName(player.source).." ["..player.source.."] viens de déposer une somme d'argent dans le coffre de société\n\nSommes : "..ESX.Math.GroupDigits(amount).."$\nSociété : "..society, Cfg_log.DepotAmount)
                        TriggerClientEvent("esx:showNotification", src, "Vous venez de déposer ~g~"..ESX.Math.GroupDigits(amount).."$~s~ dans le coffre de société")
                        TriggerClientEvent('rSociety:GetSocietyMoney', -1, result[1].account + amount)
                    end)
                else
                    TriggerClientEvent("esx:showNotification", src, "Vous n'avez pas asser d'argent")
                end
            end
        end)
    end
end

function RemoveSocietyMoney(src, society, amount)
    local player = ESX.GetPlayerFromId(src)
    if society == nil then
        print("[^4Society^7] Cette société n'est pas répertorier ou invalide")
    else
        MySQL.Async.fetchAll("SELECT * FROM society WHERE society_name = @name", {
            ["@name"] = society
        }, function(result)
            if result[1] then
                if result[1].account >= amount then
                    MySQL.Async.execute("UPDATE society SET account = @account WHERE society_name = @society", {
                        ["@account"] = result[1].account - amount,
                        ["@society"] = society
                    }, function(rowChange)
                        player.addMoney(amount)
                        SendLogs(GetPlayerName(player.source).." ["..player.source.."] viens de retirer une somme d'argent dans le coffre de société\n\nSommes : "..ESX.Math.GroupDigits(amount).."$\nSociété : "..society, Cfg_log.WithDrawAmount)
                        TriggerClientEvent("esx:showNotification", src, "Vous venez de retirer ~g~"..ESX.Math.GroupDigits(amount).."$~s~ dans le coffre de société")
                        TriggerClientEvent('rSociety:GetSocietyMoney', -1, result[1].account - amount)
                    end)
                else
                    TriggerClientEvent("esx:showNotification", src, "La société n'as pas asser d'argent")
                end
            end
        end)
    end
end

function GetSocietyMoney(src, society)
    if society == nil then
        print("[^4Society^7] Cette société n'est pas répertorier ou invalide")
    else
        MySQL.Async.fetchAll("SELECT * FROM society WHERE society_name = @name", {
            ["@name"] = society
        }, function(result)
            if result[1] then
                TriggerClientEvent('rSociety:GetSocietyMoney', -1, result[1].account)
            end
        end)
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
function AddSocietyDirty(src, society, amount)
    local player = ESX.GetPlayerFromId(src)
    local playerDirty= player.getAccount("black_money").money
    if society == nil then
        print("[^4Society^7] Cette société n'est pas répertorier ou invalide")
    else
        MySQL.Async.fetchAll("SELECT * FROM society WHERE society_name = @name", {
            ["@name"] = society
        }, function(result)
            if result[1] then
                if playerDirty >= amount then
                    MySQL.Async.execute("UPDATE society SET black_money = @account WHERE society_name = @society", {
                        ["@account"] = result[1].black_money + amount,
                        ["@society"] = society
                    }, function(rowChange)
                        player.removeAccountMoney('black_money', amount)
                        SendLogs(GetPlayerName(player.source).." ["..player.source.."] viens de déposer une somme d'argent sale dans le coffre de société\n\nSommes : "..ESX.Math.GroupDigits(amount).."$\nSociété : "..society, Cfg_log.DepotAmount)
                        TriggerClientEvent("esx:showNotification", src, "Vous venez de déposer ~r~"..ESX.Math.GroupDigits(amount).."$~s~ dans le coffre de société")
                        TriggerClientEvent('rSociety:GetSocietyDirty', -1, result[1].black_money + amount)
                    end)
                else
                    TriggerClientEvent("esx:showNotification", src, "Vous n'avez pas asser d'argent sale")
                end
            end
        end)
    end
end

function RemoveSocietyDirty(src, society, amount)
    local player = ESX.GetPlayerFromId(src)
    if society == nil then
        print("[^4Society^7] Cette société n'est pas répertorier ou invalide")
    else
        MySQL.Async.fetchAll("SELECT * FROM society WHERE society_name = @name", {
            ["@name"] = society
        }, function(result)
            if result[1] then
                if result[1].black_money >= amount then
                    MySQL.Async.execute("UPDATE society SET black_money = @account WHERE society_name = @society", {
                        ["@account"] = amount - result[1].black_money,
                        ["@society"] = society
                    }, function(rowChange)
                        player.addAccountMoney('black_money', amount)
                        SendLogs(GetPlayerName(player.source).." ["..player.source.."] viens de retirer une somme d'argent sale dans le coffre de société\n\nSommes : "..ESX.Math.GroupDigits(amount).."$\nSociété : "..society, Cfg_log.WithDrawAmount)
                        TriggerClientEvent("esx:showNotification", src, "Vous venez de retirer ~r~"..ESX.Math.GroupDigits(amount).."$~s~ dans le coffre de société")
                        TriggerClientEvent('rSociety:GetSocietyDirty', -1, amount - result[1].black_money)
                    end)
                else
                    TriggerClientEvent("esx:showNotification", src, "La société n'as pas asser d'argent")
                end
            end
        end)
    end
end

function GetSocietyDirty(src, society)
    if society == nil then
        print("[^4Society^7] Cette société n'est pas répertorier ou invalide")
    else
        MySQL.Async.fetchAll("SELECT * FROM society WHERE society_name = @name", {
            ["@name"] = society
        }, function(result)
            if result[1] then
                TriggerClientEvent('rSociety:GetSocietyDirty', -1, result[1].black_money)
            end
        end)
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
function AddSocietyItem(src, society, label, name, count, weight)
    local xPlayer = ESX.GetPlayerFromId(source)
    local plyName = {}

    if xPlayer.getInventoryItem(name).count >= tonumber(count) then
        MySQL.Async.fetchAll("SELECT * FROM society_data WHERE name = @item and society_name = @society", {-- Fetch all pour savoir si item dupli
            ['@item'] = name,
            ["@society"] = society
        }, function(result)
            if json.encode(result) == "[]" then

                MySQL.Async.execute("INSERT INTO society_data (society_name, label, name, count, weight) VALUES (@society, @label, @name, @count, @weight)", {
                    ["@society"] = society,
                    ["@label"] = label,
                    ["@name"] = name,
                    ["@count"] = count,
                    ["@weight"] = weight
                })
            else

                MySQL.Async.execute("UPDATE society_data SET count = count + @quantity WHERE society_name = @society AND name = @item", {
                    ['@quantity'] = count,
                    ['@item'] = name,
                    ["@society"] = society
                })
            end

        end)
        SendLogs(GetPlayerName(src).." ["..src.."] viens de déposer un object dans le coffre de société\n\nObjet : "..label.."\nQuantité : "..count.."\nSociété : "..society, Cfg_log.DepositItem)
        xPlayer.removeInventoryItem(name, tonumber(count))
    else
        TriggerClientEvent("esx:showNotification", xPlayer.source, "~r~Vous n'avez pas assez d'objet")
    end
end

function RemoveSocietyItem(src, society, label, name, count, weight)
    local player = ESX.GetPlayerFromId(src)

    MySQL.Async.fetchAll("SELECT * FROM society_data WHERE name = @name AND society_name = @society", {
        ["@name"] = name,
        ["@society"] = society
    }, function(result)
        if result[1].count >= tonumber(count) then
            MySQL.Async.execute("UPDATE society_data SET count = count - @count WHERE society_name = @society AND name = @name", {
                ["@name"] = name,
                ["@society"] = society,
                ["@count"] = count
            })
            SendLogs(GetPlayerName(src).." ["..src.."] viens de retirer un object dans le coffre de société\n\nObjet : "..label.."\nQuantité : "..count.."\nSociété : "..society, Cfg_log.WithDrawItem)
            player.addInventoryItem(name, count)
        else
            player.showNotification("~r~La société n'as pas asser de cette objet")
        end
    end)
end

function GetSocietyInventory(src, society)
    local Stock = {}
    if society == nil then
        print("[^4Society^7] Cette société n'est pas répertorier ou invalide")
    else
        MySQL.Async.fetchAll("SELECT * FROM society_data WHERE society_name = @name AND type = @type", {
            ["@name"] = society,
            ["@type"] = "item"
        }, function(result)
            if result[1] then
                for k,v in pairs(result) do
                    if v.count > 0 then
                        table.insert(Stock, {
                            label = v.label,
                            name = v.name,
                            count = v.count,
                            weight = v.weight
                        })
                    end
                    TriggerClientEvent('rSociety:GetSocietyInventory', -1, Stock)
                end
            end
        end)
    end
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
function GetSocietyWeapon(src, society, playerLoadout)
    local Stock = {}
    if society == nil then
        print("[^4Society^7] Cette société n'est pas répertorier ou invalide")
    else
        MySQL.Async.fetchAll("SELECT * FROM society_data WHERE society_name = @society AND type = @type", {
            ["@society"] = society,
            ["@type"] = "weapon"
        }, function(result)
            if result[1] then
                for k,v in pairs(result) do
                    if v.count > 0 then
                        table.insert(Stock, {
                            label = v.label,
                            name = v.name,
                            count = v.count,
                            weight = 2
                        })
                    end
                    TriggerClientEvent("rSociety:GetSocietyWeapon", -1, Stock, playerLoadout)
                end
            end
        end)
    end
end

function AddSocietyWeapon(src, society, label, name, count)
    local xPlayer = ESX.GetPlayerFromId(source)
    local plyName = {}

    if xPlayer.hasWeapon(name) then
        MySQL.Async.fetchAll("SELECT * FROM society_data WHERE name = @item and society_name = @society AND type = @type", {-- Fetch all pour savoir si item dupli
            ['@item'] = name,
            ["@society"] = society,
            ["@type"] = "weapon"
        }, function(result)
            if json.encode(result) == "[]" then

                MySQL.Async.execute("INSERT INTO society_data (society_name, label, name, count, weight, type) VALUES (@society, @label, @name, @count, @weight, @type)", {
                    ["@society"] = society,
                    ["@label"] = label,
                    ["@name"] = name,
                    ["@count"] = count,
                    ["@weight"] = 2,
                    ["@type"] = "weapon"
                })
            else

                MySQL.Async.execute("UPDATE society_data SET count = count + @quantity WHERE society_name = @society AND name = @item AND type = @type", {
                    ['@quantity'] = count,
                    ['@item'] = name,
                    ["@society"] = society,
                    ["@type"] = "weapon"
                })
            end

        end)
        SendLogs(GetPlayerName(src).." ["..src.."] viens de déposer une armes dans le coffre de société\n\nObjet : "..label.."\nQuantité : "..count.."\nSociété : "..society, Cfg_log.DepositItem)
        xPlayer.removeWeapon(name)
    else
        TriggerClientEvent("esx:showNotification", xPlayer.source, "~r~Vous n'avez pas cette armes")
    end
end

function RemoveSocietyWeapon(src, society, label, name, count, weight)
    local player = ESX.GetPlayerFromId(src)

    MySQL.Async.fetchAll("SELECT * FROM society_data WHERE name = @name AND society_name = @society AND type = @type", {
        ["@name"] = name,
        ["@society"] = society,
        ["@type"] = "weapon"
    }, function(result)
        if result[1].count >= tonumber(count) then
            MySQL.Async.execute("UPDATE society_data SET count = count - @count WHERE society_name = @society AND name = @name AND type = @type", {
                ["@name"] = name,
                ["@society"] = society,
                ["@count"] = count,
                ["@type"] = "weapon"
            })
            player.addWeapon(name, count)
            SendLogs(GetPlayerName(src).." ["..src.."] viens de déposer une armes dans le coffre de société\n\nObjet : "..label.."\nQuantité : "..count.."\nSociété : "..society, Cfg_log.WithDrawItem)
        else
            player.showNotification("~r~La société n'as pas asser de cette objet")
        end
    end)
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------

function BlanchissementSociety(src, society, amount)
    local player = ESX.GetPlayerFromId(src)
    local taxe = Cfg_Society_setting.TaxeBlanchissement
    local pourcentage = ESX.Math.Round(amount) * taxe
    local total = ESX.Math.Round(tonumber(pourcentage))

    if society == nil then
        print("[^4Society^7] Cette société n'est pas répertorier ou invalide")
    else
        MySQL.Async.fetchAll("SELECT * FROM society WHERE society_name = @name", {
            ["@name"] = society
        }, function(result)

            if result[1].black_money >= amount then
                print(result[1].black_money - amount)
                local black_money = result[1].black_money - amount
                local account = result[1].account + total
                MySQL.Async.execute("UPDATE society SET black_money = @account WHERE society_name = @society", {["@society"] = society, ["@account"] = black_money})
                MySQL.Async.execute("UPDATE society SET account = @account WHERE society_name = @society", {["@society"] = society, ["@account"] = account})

                SendLogs(GetPlayerName(src).." ["..src.."] viens de blanchir une somme d'argent avec sa société\n\nSociété : "..society.."\nMontant : "..ESX.Math.GroupDigits(amount).."$\nBlanchi : "..ESX.Math.GroupDigits(account).."$", Cfg_log.Blanchissement)

                TriggerClientEvent('rSociety:GetSocietyMoney', -1, account)
                TriggerClientEvent('rSociety:GetSocietyDirty', -1, black_money)
            else
                player.showNotification("~r~Votre société n'as pas asser d'argent sale")
            end
        end)
    end
end

function SocietySalary(src, society, amount)
    local player = ESX.GetPlayerFromId(src)

    if society == nil then
        print("[^[^4Society^7] Cette société n'est pas répertorier ou invalide")
    else
        MySQL.Async.fetchAll("SELECT * FROM society WHERE society_name = @name", {
            ["@name"] = society
        }, function(result)
            if result[1].account >= amount then
                MySQL.Async.execute("UPDATE society SET account = account - @account WHERE society_name = @society", {
                    ["@account"] = amount,
                    ["@society"] = society
                }, function()
                    player.showNotification("~b~Banque~s~\nVous venez de recevoir votre ~b~"..amount.."$ de paye")
                    player.addMoney(amount)
                    TriggerClientEvent('rSociety:GetSocietyMoney', -1, result[1].account - amount)
                end)
            else
                player.showNotification("~b~Banque~s~\n~r~La société n'as pas asser d'argent pour vous payez")
            end
        end)
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
function SendLogs (message,url)
    local DiscordWebHook = url
    local embeds = {
        {
            ["title"]=message,
            ["type"]="rich",
            ["color"] = 0xfc0303,
            ["footer"]=  {
                ["text"]= os.date('%d-%m-%Y %H:%M:%S', os.time() + (1 * 60 * 60)),
            },
        }
    }
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = "Luthers",embeds = embeds}), { ['Content-Type'] = 'application/json' })
end
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
