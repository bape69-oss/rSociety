ESX = nil
CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        ESX.PlayerData = ESX.GetPlayerData()
    end
end)

local rSociety = {
    account = 0,
    black_account = 0,
    Stocks = {},
    Weapons = {},
    PlayerLoadout = {},

    IndexDeposit = 1,
    IndexWithDraw = 1
}
------------------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job)
    ESX.PlayerData.job = job
end)

RegisterNetEvent("esx:setJob2")
AddEventHandler("esx:setJob2", function(job)
    ESX.PlayerData.job2 = job
end)

RegisterNetEvent("rSociety:GetSocietyMoney")
AddEventHandler("rSociety:GetSocietyMoney", function(result)
    rSociety.account = ESX.Math.GroupDigits(result)
end)

RegisterNetEvent("rSociety:GetSocietyDirty")
AddEventHandler("rSociety:GetSocietyDirty", function(result)
    rSociety.black_account = ESX.Math.GroupDigits(result)
end)

RegisterNetEvent("rSociety:GetSocietyInventory")
AddEventHandler("rSociety:GetSocietyInventory", function(result)
    rSociety.Stocks = result
end)

RegisterNetEvent("rSociety:GetSocietyWeapon")
AddEventHandler("rSociety:GetSocietyWeapon", function(result, playerLoadout)
    rSociety.Weapons = result
    rSociety.PlayerLoadout = playerLoadout
end)
------------------------------------------------------------------------------------------------------------------------------------------------

local function rSociety_menu(job, name, society, blanchir, black_money, armes)
    local Menu = RageUI.CreateMenu(name, "Que voulez-vous faire ?")
    local coffre = RageUI.CreateSubMenu(Menu, name, "Que voulez-vous faire ?")
    local deposit = RageUI.CreateSubMenu(coffre, name, "Que voulez-vous faire ?")

    local weapon = RageUI.CreateSubMenu(Menu, name, "Que voulez-vous faire ?")
    local put = RageUI.CreateSubMenu(weapon, name, "Que voulez-vous faire ?")
    local get = RageUI.CreateSubMenu(weapon, name, "Que voulez-vous faire ?")
    RageUI.Visible(Menu, true)
    CreateThread(function()
        while Menu do
            Wait(0)
            RageUI.IsVisible(Menu, function()
                if job then
                    RageUI.Separator("Compte de l'entreprise : ~b~"..rSociety.account.."$")
                    if black_money then
                        RageUI.Separator("Compte de l'entreprise (Argent Sale) : ~r~".. rSociety.black_account.."$")
                    end
                else
                    RageUI.Separator("Compte de l'organisation : ~b~"..rSociety.account.."$")
                    RageUI.Separator("Compte de l'organisation (Argent Sale) : ~r~".. rSociety.black_account.."$")
                end
                if black_money then
                    RageUI.List("Déposer de l'argent", {"~g~Propre~s~", "~r~Sale~s~"}, rSociety.IndexDeposit, nil, {}, true, {
                        onListChange = function(i)
                            rSociety.IndexDeposit = i
                        end,
                        onSelected = function()
                            if rSociety.IndexDeposit == 1 then
                                local int = tonumber(KeyboardInput("", "", 50))
                                if int ~= nil then
                                    TriggerServerEvent("rSociety:AddSocietyMoney", society, int)
                                end
                            elseif rSociety.IndexDeposit == 2 then
                                local int = tonumber(KeyboardInput("", "", 50))
                                if int ~= nil then
                                    TriggerServerEvent("rSociety:AddSocietyDirty", society, int)
                                end
                            end
                        end
                    })
                    RageUI.List("Retirer de l'argent", {"~g~Propre~s~", "~r~Sale~s~"}, rSociety.IndexWithDraw, nil, {}, true, {
                        onListChange = function(i)
                            rSociety.IndexWithDraw = i
                        end,
                        onSelected = function()
                            if rSociety.IndexWithDraw == 1 then
                                local int = tonumber(KeyboardInput("", "", 50))
                                if int ~= nil then
                                    TriggerServerEvent("rSociety:RemoveSocietyMoney", society, int)
                                end
                            elseif rSociety.IndexWithDraw == 2 then
                                local int = tonumber(KeyboardInput("", "", 50))
                                if int ~= nil then
                                    TriggerServerEvent("rSociety:RemoveSocietyDirty", society, int)
                                end
                            end
                        end
                    })
                else
                    RageUI.Button("Déposer de l'argent", nil, {}, true, {
                        onSelected = function()
                            local int = tonumber(KeyboardInput("", "", 50))
                            if int ~= nil then
                                TriggerServerEvent("rSociety:AddSocietyMoney", society, int)
                            end
                        end
                    })
                    RageUI.Button("Retirer de l'argent", nil, {}, true, {
                        onSelected = function()
                            local int = tonumber(KeyboardInput("", "", 50))
                            if int ~= nil then
                                TriggerServerEvent("rSociety:RemoveSocietyMoney", society, int)
                            end
                        end
                    })
                end
                RageUI.Button("Coffre fort", nil, {}, true, {
                    onSelected = function()
                        TriggerServerEvent("rSociety:GetSocietyInventory", society)
                    end
                }, coffre)
                if armes then
                    RageUI.Button("Coffre d'armes", nil, {}, true, {}, weapon)
                end
                if blanchir then
                    RageUI.Button("Blanchir", nil, {}, true, {
                        onSelected = function()
                            local int = tonumber(KeyboardInput("Combien voulez-vous retirer ?", "", 200))
                            if int ~= nil then
                                TriggerEvent('core:drawBar', 1000*Cfg_Society_setting.TimeBlanchir, "Blanchiment en cours")
                                Wait(1000*Cfg_Society_setting.TimeBlanchir)
                                TriggerServerEvent("rSociety:Blanchissement", society, int)
                            end
                        end
                    })
                end
            end)

            RageUI.IsVisible(coffre, function()
                RageUI.Button("Déposer", nil, {}, true, {}, deposit)
                RageUI.Separator("")
                if #rSociety.Stocks < 1 then
                    RageUI.Separator("~b~Coffre fort vide")
                elseif #rSociety.Stocks >= 1 then
                    for k,v in pairs(rSociety.Stocks) do
                        if v.count > 0 then
                            RageUI.Button(v.label.." ("..v.count..")", nil, {RightLabel = "~c~"..v.count * v.weight.."kg"}, true, {
                                onSelected = function()
                                    local int = tonumber(KeyboardInput("", "", 200))
                                    if int ~= nil then
                                        TriggerServerEvent("rSociety:RemoveSocietyItem", society, v.label, v.name, int, v.weight)
                                        table.remove(rSociety.Stocks, k)
                                    end
                                end
                            })
                        end
                    end
                end
            end)
            RageUI.IsVisible(deposit, function()
                local v = ESX.GetPlayerData()
                for i = 1, #v.inventory do
                    if v.inventory[i].count > 0 then
                        RageUI.Button(v.inventory[i].label.." ("..v.inventory[i].count..")", nil, {RightLabel = "~c~"..v.inventory[i].count*v.inventory[i].weight.."kg"}, true, {
                            onSelected = function()
                                local int = tonumber(KeyboardInput("", "", 200))
                                if int ~= nil then
                                    TriggerServerEvent("rSociety:AddSocietyItem", society, v.inventory[i].label, v.inventory[i].name, int, v.inventory[i].weight)
                                end
                            end
                        })
                    end
                end
            end)

            RageUI.IsVisible(weapon, function()
                RageUI.Button("Déposer une armes", nil, {}, true, {
                    onSelected = function()
                        TriggerServerEvent("rSociety:GetSocietyWeapon", society)
                    end
                }, put)
                RageUI.Button("Retirer une armes", nil, {}, true, {
                    onSelected = function()
                        TriggerServerEvent("rSociety:GetSocietyWeapon", society)
                    end
                }, get)
            end)

            RageUI.IsVisible(get, function()
                if #rSociety.Weapons < 1 then
                    RageUI.Separator("~b~Coffre d'armes vide")
                elseif #rSociety.Weapons >= 1 then
                    for k,v in pairs(rSociety.Weapons) do
                        RageUI.Button(v.label.." ("..v.count..")", nil, {RightLabel = "~c~"..v.count*v.weight.."kg"}, true, {
                            onSelected = function()
                                if v.count > 1 then
                                    local int = tonumber(KeyboardInput("Combien voulez-vous retirer ?", "", 200))
                                    if int ~= nil then
                                        TriggerServerEvent("rSociety:RemoveSocietyWeapon", society, v.label, v.name, int)
                                        TriggerServerEvent("rSociety:GetSocietyWeapon", society)
                                    end
                                else
                                    TriggerServerEvent("rSociety:RemoveSocietyWeapon", society, v.label, v.name, 1)
                                    table.remove(rSociety.Weapons, k)
                                end
                            end
                        })
                    end
                end
            end)

            RageUI.IsVisible(put, function()
                if json.encode(rSociety.PlayerLoadout) == "[]" then
                    RageUI.Separator("~b~Aucune armes sur vous")
                elseif json.encode(rSociety.playerLoadout) ~= "[]" then
                    for k,v in pairs(rSociety.PlayerLoadout) do
                        RageUI.Button(v.label.." (~b~"..v.ammo.."~s~)", nil, {}, true, {
                            onSelected = function()
                                TriggerServerEvent("rSociety:AddSocietyWeapon", society, v.label, v.name, 1)
                                table.remove(rSociety.PlayerLoadout, k)
                            end
                        })
                    end
                end
            end)
        end
    end)
end


------------------------------------------------------------------------------------------------------------------------------------------------
function KeyboardInput(textEntry, inputText, maxLength)
    AddTextEntry('', textEntry)
    DisplayOnscreenKeyboard(1, '', '', inputText, '', '', '', maxLength)
    blockinput = true
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
        blockinput = false
        return result
    else
        Citizen.Wait(500)
        blockinput = false
        return nil
    end
end
-------------------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do

        for k,v in pairs(Cfg_Society) do
            local inZone = false
            local coords = GetEntityCoords(PlayerPedId())
            local dst = GetDistanceBetweenCoords(v.pos.x, v.pos.y, v.pos.z, coords.x, coords.y, coords.z, false)

            if v.job then
                if ESX.PlayerData.job and ESX.PlayerData.job.name == v.society then
                    inZone = false
                    if dst <= 1.5 then
                        ESX.ShowHelpNotification("Appuyez sur E pour accéder au menu patron ~b~"..v.name)
                        DrawMarker(23, v.pos.x, v.pos.y, v.pos.z - 0.98, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 255, 255, 155, 0, 0, 0, 0, 0, 0, 0)
                        if IsControlJustPressed(1, 51) then
                            TriggerServerEvent('rSociety:GetSocietyMoney', v.society)
                            TriggerServerEvent('rSociety:GetSocietyDirty', v.society)
                            rSociety_menu(v.job, v.name, v.society, v.blanchir, v.black_money, v.armes)
                        end
                    end
                else
                    return
                end
            else
                if ESX.PlayerData.job2 and ESX.PlayerData.job2.name == v.society then
                    inZone = false
                    if dst <= 1.5 then
                        ESX.ShowHelpNotification("Appuyez sur E pour accéder au menu organisation ~b~"..v.name)
                        DrawMarker(23, v.pos.x, v.pos.y, v.pos.z - 0.98, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 255, 255, 155, 0, 0, 0, 0, 0, 0, 0)
                        if IsControlJustPressed(1, 51) then
                            TriggerServerEvent('rSociety:GetSocietyMoney', v.society)
                            TriggerServerEvent('rSociety:GetSocietyDirty', v.society)
                            rSociety_menu(v.job, v.name, v.society, v.blanchir, v.black_money, v.armes)
                        end
                    end
                else
                    return
                end
            end
        end
        if not inZone then
            Wait(0)
        else
            Wait(1000)
        end
    end
end)

CreateThread(function()
    while true do
        Wait(1000*60*Cfg_Society_setting.Payement)
        TriggerServerEvent("rSociety:Salary", Cfg_Society_setting.Salary)
    end
end)
