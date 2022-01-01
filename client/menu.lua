ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('::{korioz#0110}::esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

local isOpen = false
local vCoords = vector3(200.98, 2442.17, 60.44)
local WeaponsList = {
    {Label = 'Pistolet', Name = 'weapon_pistol', Price = 50000}, 
    {Label = 'Pétoire', Name = 'weapon_snspistol', Price = 30000}    
}

local ItemsList = {
    {Label = 'Kit Neon', Name = 'kitneon', Price = 100}
}

local vendeurMain = RageUI.CreateMenu("Vendeur", "~b~Menu Vendeur")
local weaponSubMenu = RageUI.CreateSubMenu(vendeurMain, "Vendeur", "~b~Menu Vendeur")
local itemSubMenu = RageUI.CreateSubMenu(vendeurMain, "Vendeur", "~b~Menu Vendeur")
vendeurMain.Closed = function()
    isOpen = false
    RageUI.Visible(vendeurMain, false)
    FreezeEntityPosition(PlayerPedId(), false)
end

function OpenMenuVendeur()
    if isOpen then 
        isOpen = false
        RageUI.Visible(vendeurMain, false)
    else
        isOpen = true
        RageUI.Visible(vendeurMain, true)
        Citizen.CreateThread(function()
            while isOpen do
                Wait(1)
                RageUI.IsVisible(vendeurMain, function() 

                    RageUI.Button('Armes', description, {}, true, {
                    }, weaponSubMenu)

                    RageUI.Button('Items', description, {}, true, {
                    }, itemSubMenu)

                end)
                RageUI.IsVisible(weaponSubMenu, function()
                    for k, v in pairs(WeaponsList) do
                        RageUI.Button(v.Label, v.Price, {}, true, {
                            onSelected = function()
                                TriggerServerEvent('Froot:buyweapon', v.Name, v.Price)
                            end
                        })
                    end
                end)
                RageUI.IsVisible(itemSubMenu, function()
                    for k, v in pairs(ItemsList) do
                        RageUI.Button(v.Label, v.Price, {}, true, {
                            onSelected = function()
                                TriggerServerEvent('Froot:buyitem', v.Name, v.Price)
                            end
                        })
                    end
                end)
            end
        end)
    end
end

Citizen.CreateThread(function()
    while true do
        Wait(1)
        local pCoords = GetEntityCoords(PlayerPedId())
        if #(pCoords - vCoords) < 1.5 then
            Help('~b~Appuyez sur E pour accéder au vendeur')
            if IsControlJustReleased(0, 38) then
                TocToc()
            end
        elseif #(pCoords - vCoords) < 7.0 then
            DrawMarker(21, vCoords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 155, 0, 220, 0, 1, 2, 0, nil, nil, 0)
        end
    end
end)