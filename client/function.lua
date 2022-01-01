function Notif(notifmsg)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(notifmsg)
    DrawNotification(0,1)
end

function Help(helpmsg)
    AddTextEntry('HelpNotification', helpmsg)
    DisplayHelpTextThisFrame('HelpNotification', false)
end

function TocToc()
    FreezeEntityPosition(PlayerPedId(), true)
    Notif('TocToc')
    Wait(3000)
    Notif('Quelqu\'un ta suivi ?')
    Wait(1500)
    OpenMenuVendeur()
end

RegisterNetEvent('Froot:Notif')
AddEventHandler('Froot:Notif', function(notif)
    Notif(notif)
end)