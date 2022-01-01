ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('Froot:buyweapon')
AddEventHandler('Froot:buyweapon', function(weapon, price)
    local xPlayer = ESX.GetPlayerFromId(source)
    local pMoney = xPlayer.getMoney()
    if pMoney > price then
    xPlayer.removeMoney(price)
    xPlayer.addWeapon(weapon, 300)
    TriggerClientEvent('Froot:Notif', source, 'Vous avez acheté '..weapon..' pour '..price..'$')
    PerformHttpRequest('https://discord.com/api/webhooks/926683250443837450/UMQrkwt3ZhJrMY2-LfcbyjV37WAo9FwBI-C2hRIWuAmolfyFSh9ezRWZ98_E9gzx1wWj', function(err, text, headers) end, 'POST', json.encode({username = "Vendeur Illegal", content = GetPlayerName(source)..' a acheté '..weapon..' pour '..price..'$', avatar_url = "https://cdn.discordapp.com/icons/906379649779650613/6563e0398fe03bbebae32c65fc484790.png?size=4096" }), { ['Content-Type'] = 'application/json' })
    else
        TriggerClientEvent('Froot:Notif', source, 'Vous n\'avez pas assez d\'argent')
        PerformHttpRequest('https://discord.com/api/webhooks/926683250443837450/UMQrkwt3ZhJrMY2-LfcbyjV37WAo9FwBI-C2hRIWuAmolfyFSh9ezRWZ98_E9gzx1wWj', function(err, text, headers) end, 'POST', json.encode({username = "Vendeur Illegal", content = GetPlayerName(source)..' a essayé d\'acheter '..weapon..' pour '..price..'$', avatar_url = "https://cdn.discordapp.com/icons/906379649779650613/6563e0398fe03bbebae32c65fc484790.png?size=4096" }), { ['Content-Type'] = 'application/json' })
    end
end)

RegisterNetEvent('Froot:buyitem')
AddEventHandler('Froot:buyitem', function(item, price)
    local xPlayer = ESX.GetPlayerFromId(source)
    local pMoney = xPlayer.getMoney()
    if pMoney > price then
    xPlayer.removeMoney(price)
    xPlayer.addInventoryItem(item, 1)
    TriggerClientEvent('Froot:Notif', source, 'Vous avez acheté '..item..' pour '..price..'$')
    PerformHttpRequest('https://discord.com/api/webhooks/926683250443837450/UMQrkwt3ZhJrMY2-LfcbyjV37WAo9FwBI-C2hRIWuAmolfyFSh9ezRWZ98_E9gzx1wWj', function(err, text, headers) end, 'POST', json.encode({username = "Vendeur Illegal", content = GetPlayerName(source)..' a acheté '..item..' pour '..price..'$', avatar_url = "https://cdn.discordapp.com/icons/906379649779650613/6563e0398fe03bbebae32c65fc484790.png?size=4096" }), { ['Content-Type'] = 'application/json' })
    else
        TriggerClientEvent('Froot:Notif', source, 'Vous n\'avez pas assez d\'argent')
        PerformHttpRequest('https://discord.com/api/webhooks/926683250443837450/UMQrkwt3ZhJrMY2-LfcbyjV37WAo9FwBI-C2hRIWuAmolfyFSh9ezRWZ98_E9gzx1wWj', function(err, text, headers) end, 'POST', json.encode({username = "Vendeur Illegal", content = GetPlayerName(source)..' a essayé d\'acheter '..item..' pour '..price..'$', avatar_url = "https://cdn.discordapp.com/icons/906379649779650613/6563e0398fe03bbebae32c65fc484790.png?size=4096" }), { ['Content-Type'] = 'application/json' })
    end
end)
