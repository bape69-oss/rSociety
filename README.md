# rbSociety

## UTILISATION ##

Afin de pouvoir l'utilisé, il suffit simplement d'utilisé les triggers. Malgré qu'un menu boss est directement intégrer, vous avez juste à changer les triggers dans les jobs que vous trouverez de partout.

**Add de l'argent**

```lua 
TriggerServerEvent("rSociety:AddSocietyMoney", "nom de la société", "montant du transfere")
```

**Remove de l'argent**

```lua 
TriggerServerEvent("rSociety:RemoveSocietyMoney", "nom de la société", "montant du retrait")
```

------------------------------------------------------------------------------------------------------------------------------

**Add de l'argent sale**

```lua 
TriggerServerEvent("rSociety:AddSocietyDirty", "nom de la société", "montant du transfere")
```

**Remove de l'argent sale**

```lua 
TriggerServerEvent("rSociety:AddSocietyDirty", "nom de la société", "montant du transfere")
```

------------------------------------------------------------------------------------------------------------------------------

Maintenant que vous savez faire pour inserer de l'argent dans la société voici les triggers qui permettent le transfere pour les items.

**Add un item**

```lua 
TriggerServerEvent("rSociety:AddSocietyItem", "nom de la société", label item, name item, count, weight(poid))
```

**Remove un item**

```lua 
TriggerServerEvent("rSociety:RemoveSocietyItem", "nom de la société", label item, name item, count, weight(poid))
```

------------------------------------------------------------------------------------------------------------------------------

**Add une armes**

```lua
TriggerServerEvent("rSociety:AddSocietyWeapon", "nom de la society", label, name, count)
```

**Remove une armes**

```lua
TriggerServerEvent("rSociety:RemoveSocietyWeapon", "nom de la society", label, name, count)
```

------------------------------------------------------------------------------------------------------------------------------

**Blanchir l'argent sale de la société**

```lua
TriggerServerEvent("rSociety:Blanchissement", "nom de la société", montant)
```

------------------------------------------------------------------------------------------------------------------------------
Maintenant que vous savez inserer il faut savoir comment get toute ces donnée. C'est très simple !

--Coté client
Vous crée un variable
```lua
local account = 0
local black_money = 0
local Stock = {}
local Weapon = {}

RegisterNetEvent("rSociety:GetSocietyMoney")
AddEventHandler("rSociety:GetSocietyMoney", function(result)
    account = ESX.Math.GroupDigits(result) --Get l'argent propre
end)

RegisterNetEvent("rSociety:GetSocietyDirty")
AddEventHandler("rSociety:GetSocietyDirty", function(result)
    black_account = ESX.Math.GroupDigits(result) --Get l'argent sale
end)

RegisterNetEvent("rSociety:GetSocietyInventory")
AddEventHandler("rSociety:GetSocietyInventory", function(result)
    Stock = result --Get l'inventaire de la société
end)

RegisterNetEvent("rSociety:GetSocietyWeapon")
AddEventHandler("rSociety:GetSocietyWeapon", function(result)
    Weapon = result --Get l'inventaire des armes de la société
end)
``` 

Voila, maintenant que vos triggers son installer, il faut les appeller, très simple, ajouter cela au point, menu afin de get.

```lua 
TriggerServerEvent('rSociety:GetSocietyMoney', "nom de la société") --Trigger pour get l'argent
TriggerServerEvent('rSociety:GetSocietyDirty', "nom de la société") --Trigger pour get l'argent sale
TriggerServerEvent("rSociety:GetSocietyInventory", "nom de la société") --Trigger pour get l'inventaire
TriggerServerEvent("rSociety:GetSocietyWeapon", "nom de la société") --Trigger pour get l'inventaire armes
```

------------------------------------------------------------------------------------------------------------------------------

Merci pour l'installation du rbSociety. J'espere qu'il vous plaira ! Pour toute question suplémentaire merci de passer sur mon discord https://discord.gg/HpvmmXMjCS

*Bape*
