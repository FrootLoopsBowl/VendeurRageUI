ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

local isOpen = false

local vendeurMain = RageUI.CreateMenu("Vendeur", "Menu Vendeur")
local weaponSubMenu = RageUI.CreateSubMenu(vendeurMain, "Vendeur", "Menu Vendeur")
local itemSubMenu = RageUI.CreateSubMenu(vendeurMain, "Vendeur", "Menu Vendeur")
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
                    for k, v in pairs(Config.WeaponsList) do
                        RageUI.Button(v.Label, v.Price, {}, true, {
                            onSelected = function()
                                TriggerServerEvent('Froot:buyweapon', v.Name, v.Price)
                            end
                        })
                    end
                end)
                RageUI.IsVisible(itemSubMenu, function()
                    for k, v in pairs(Config.ItemsList) do
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
        if #(pCoords - Config.VendeurPos) < 1.5 then
            Help('~b~Appuyez sur E pour acc??der au vendeur')
            if IsControlJustReleased(0, 38) then
                TocToc()
            end
        elseif #(pCoords - Config.VendeurPos) < 7.0 then
            DrawMarker(21, Config.VendeurPos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 20, 147, 220, 0, 1, 2, 0, nil, nil, 0)
        end
    end
end)
