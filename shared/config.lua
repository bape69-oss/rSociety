Cfg_log = {

    DepotAmount = "https://discordapp.com/api/webhooks/979765329259548732/bKvooc9fnwgAgOxllGYjk3X1YAZiPnCVRLTBMkrzcIRgqpW3jrsAoGR-YUM4qLFB12Dq",
    WithDrawAmount = "https://discordapp.com/api/webhooks/979765414525558784/vjOFnEjuLGANnM0gmdxbJNIVApSXmrqI4y68XiOd0BK6XXqg15ET8XXSO6zmTyEowjxA",
    DepositItem = "https://discordapp.com/api/webhooks/979765472268542043/Lg7ngYU8bx_uBPhfWkVJTqY-l-XrxxLH4-2cG1Aeb8kOfquWSnMGeM3Vl5FdMw3oQOX4",
    WithDrawItem = "https://discordapp.com/api/webhooks/979765545131966465/6DNQ2MDFXjtPFLd6WcyiSvGrn2_OG5akbatgj3G7ETGso2h5gPjrcKTJ30h6tA5Yeij0",
    Blanchissement = "https://discordapp.com/api/webhooks/979765619585077279/ajHaLUJp6BObeUpAE1lCBH8cUsOr9OJt0s9f_PjykeH73vsDbn0ZxdLOpYWeW-JiyRMv",
}

Cfg_Society_setting = {
    TaxeBlanchissement = 0.8, -- Taxe du blanchissement (20%) 1 - 0.8 = 0.2
    TimeBlanchir = 5, -- Temps pour blanchir en seconde
    Payement = 15, -- Intervalle de chaque payement en minutes
    Salary = 100, -- Salaire de tous
    TimeSave = 0.5, -- Temps pour save les fonds des entreprises et que sa t'envoies sur discord
}

Cfg_Society = {
    {
        name = "Police", -- Non sur le menu
        pos = vector3(77.259765625, -1920.1022949219, 20.988821029663),  --coordonnée
        society = "police", -- Non de la société (bdd) + non du job
        job = true, -- True = Job1 false = Job2
        blanchir = true, -- Si la société peut blanchir ou pas
        black_money = true, -- Si la société peut déposer de l'argent sale
        armes = true --Si la société peut déposer des armes
    },
    {
        name = "Ballas",
        pos = vector3(98.938148498535, -1938.5858154297, 20.803701400757),
        society = "ballas",
        job = false,
        blanchir = false,
        black_money = true,
        armes = true
    }
}