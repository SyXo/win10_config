
function Pin-App { param(
[string]$appname,
[switch]$unpin
)
try{
if ($unpin.IsPresent){
((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() | ?{$_.Name -eq $appname}).Verbs() | ?{$_.Name.replace('&','') -match 'From "Start" UnPin|Unpin from Start'} | %{$_.DoIt()}
return "App '$appname' unpinned from Start"
}else{
((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() | ?{$_.Name -eq $appname}).Verbs() | ?{$_.Name.replace('&','') -match 'To "Start" Pin|Pin to Start'} | %{$_.DoIt()}
return "App '$appname' pinned to Start"
}
}catch{
Write-Error "Error Pinning/Unpinning App! (App-Name correct?)"
}
}

Write-Host "Configuring start menu"

# Apps to remove
Pin-App "xbox" -unpin
Pin-App "Microsoft Edge" -unpin
Pin-App "Photos" -unpin
Pin-App "Store" -unpin
Pin-App "Paint 3D" -unpin

# Pinned Apps
Pin-App "Google Chrome" 
Pin-App "Control Panel"
Pin-App "This PC"
Pin-App "Store"
Pin-App "Onenote" 
Pin-App "Sublime Text 3" 
Pin-App "Git Extensions" 
Pin-App "Deluge" 
Pin-App "Teamviewer 13" 
Pin-App "Reddit Wallpaper Changer" 


# Autohotkey script auto-start
Write-Host "Place default AHK script in Startup folder. Shell:startup to navigate there"

New-Item "$env:appdata\Microsoft\Windows\Start Menu\Programs\Startup\auto_closers.ahk" -type file -value "#NoEnv
SetWorkingDir %A_ScriptDir%
CoordMode, Mouse, Window
SendMode Input
#SingleInstance Force
SetTitleMatchMode 2
DetectHiddenWindows Off
#WinActivateForce
SetControlDelay 1
SetWinDelay 0
SetKeyDelay -1
SetMouseDelay -1
SetBatchLines -1


Macro1:
Loop
{
    WinActivate, This is an unregistered copy
    Sleep, 333
    WinKill, This is an unregistered copy
    Sleep, 333
}
Return
"

Write-Host "Removing old scheduled tasks"
Unregister-ScheduledTask -TaskName "2_configure_windows" -Confirm:$false
Unregister-ScheduledTask -TaskName "3_main_install" -Confirm:$false
Unregister-ScheduledTask -TaskName "4_post_install" -Confirm:$false
