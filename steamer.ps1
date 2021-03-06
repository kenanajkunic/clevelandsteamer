Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$ErrorActionPreference = 'SilentlyContinue'
$wshell = New-Object -ComObject Wscript.Shell
$Button = [System.Windows.MessageBoxButton]::YesNoCancel
$ErrorIco = [System.Windows.MessageBoxImage]::Error
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	Exit
}

# GUI Specs
Write-Host "Checking winget..."

# Check if winget is installed
if (Test-Path ~\AppData\Local\Microsoft\WindowsApps\winget.exe){
    'Winget Already Installed'
}  
else{
    # Installing winget from the Microsoft Store
	Write-Host "Winget not found, installing it now."
    $ResultText.text = "`r`n" +"`r`n" + "Installing Winget... Please Wait"
	Start-Process "ms-appinstaller:?source=https://aka.ms/getwinget"
	$nid = (Get-Process AppInstaller).Id
	Wait-Process -Id $nid
	Write-Host Winget Installed
    $ResultText.text = "`r`n" +"`r`n" + "Winget Installed - Ready for Next Task"
}


$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(525,400)
$Form.text                       = "Cleveland Steamer - Un-sh*t your Windows install"
$Form.TopMost                    = $false
$Form.StartPosition              = "CenterScreen"
$Form.AutoScaleDimensions        = '192, 192'
$Form.AutoScaleMode              = "Dpi"
$Form.AutoSize                   = $True
$Form.AutoScroll                 = $True
$Form.FormBorderStyle            = 'FixedSingle'

$RemoveBloatware                         = New-Object system.Windows.Forms.Button
$RemoveBloatware.text                    = "Remove Bloatware"
$RemoveBloatware.width                   = 250
$RemoveBloatware.height                  = 50
$RemoveBloatware.location                = New-Object System.Drawing.Point(5,5)
$RemoveBloatware.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$RemoveDefender                         = New-Object system.Windows.Forms.Button
$RemoveDefender.text                    = "Remove Windows Defender"
$RemoveDefender.width                   = 250
$RemoveDefender.height                  = 50
$RemoveDefender.location                = New-Object System.Drawing.Point(5,60)
$RemoveDefender.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$UninstallOneDrive                         = New-Object system.Windows.Forms.Button
$UninstallOneDrive.text                    = "Remove OneDrive"
$UninstallOneDrive.width                   = 250
$UninstallOneDrive.height                  = 50
$UninstallOneDrive.location                = New-Object System.Drawing.Point(5,115)
$UninstallOneDrive.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$DefaultUpdates                         = New-Object system.Windows.Forms.Button
$DefaultUpdates.text                    = "Default Updates"
$DefaultUpdates.width                   = 250
$DefaultUpdates.height                  = 50
$DefaultUpdates.location                = New-Object System.Drawing.Point(5,170)
$DefaultUpdates.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$SecurityUpdatesOnly                        = New-Object system.Windows.Forms.Button
$SecurityUpdatesOnly.text                    = "Security Updates Only"
$SecurityUpdatesOnly.width                   = 250
$SecurityUpdatesOnly.height                  = 50
$SecurityUpdatesOnly.location                = New-Object System.Drawing.Point(5,225)
$SecurityUpdatesOnly.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$EnableUpdates                        = New-Object system.Windows.Forms.Button
$EnableUpdates.text                    = "Enable Updates"
$EnableUpdates.width                   = 250
$EnableUpdates.height                  = 50
$EnableUpdates.location                = New-Object System.Drawing.Point(270,170)
$EnableUpdates.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$DisableUpdates                        = New-Object system.Windows.Forms.Button
$DisableUpdates.text                    = "Disable Updates"
$DisableUpdates.width                   = 250
$DisableUpdates.height                  = 50
$DisableUpdates.location                = New-Object System.Drawing.Point(270,225)
$DisableUpdates.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$RemoveCortana                         = New-Object system.Windows.Forms.Button
$RemoveCortana.text                    = "Disable Cortana"
$RemoveCortana.width                   = 250
$RemoveCortana.height                  = 50
$RemoveCortana.location                = New-Object System.Drawing.Point(270,5)
$RemoveCortana.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$DisableTelemetry                         = New-Object system.Windows.Forms.Button
$DisableTelemetry.text                    = "Disable Telemetry"
$DisableTelemetry.width                   = 250
$DisableTelemetry.height                  = 50
$DisableTelemetry.location                = New-Object System.Drawing.Point(270,60)
$DisableTelemetry.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$InstallSoftware                         = New-Object system.Windows.Forms.Button
$InstallSoftware.text                    = "Install Software"
$InstallSoftware.width                   = 250
$InstallSoftware.height                  = 50
$InstallSoftware.location                = New-Object System.Drawing.Point(270,115)
$InstallSoftware.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$LogBox                        = New-Object system.Windows.Forms.TextBox
$LogBox.multiline              = $true
$LogBox.width                  = 515
$LogBox.height                 = 100
$LogBox.location               = New-Object System.Drawing.Point(5,295)
$LogBox.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Form.controls.AddRange(@($RemoveBloatware,$RemoveDefender,$UninstallOneDrive,$DefaultUpdates,$SecurityUpdatesOnly,$EnableUpdates,$DisableUpdates,$RemoveCortana,$DisableTelemetry,$InstallSoftware,$LogBox))

#########################################
### Remove Bloatware
#########################################

$Bloatware = @(
    "Microsoft.3DBuilder"
    "Microsoft.Microsoft3DViewer"
    "Microsoft.AppConnector"
    "Microsoft.BingFinance"
    "Microsoft.BingNews"
    "Microsoft.BingSports"
    "Microsoft.BingTranslator"
    "Microsoft.BingWeather"
    "Microsoft.BingFoodAndDrink"
    "Microsoft.BingHealthAndFitness"
    "Microsoft.BingTravel"
    "Microsoft.MinecraftUWP"
    "Microsoft.GamingServices"
    "Microsoft.WindowsReadingList"
    "Microsoft.GetHelp"
    "Microsoft.Getstarted"
    "Microsoft.Messaging"
    "Microsoft.Microsoft3DViewer"
    "Microsoft.MicrosoftSolitaireCollection"
    "Microsoft.NetworkSpeedTest"
    "Microsoft.News"
    "Microsoft.Office.Lens"
    "Microsoft.Office.Sway"
    "Microsoft.Office.OneNote"
    "Microsoft.OneConnect"
    "Microsoft.People"
    "Microsoft.Print3D"
    "Microsoft.SkypeApp"
    "Microsoft.Wallet"
    "Microsoft.Whiteboard"
    "Microsoft.WindowsAlarms"
    "microsoft.windowscommunicationsapps"
    "Microsoft.WindowsFeedbackHub"
    "Microsoft.WindowsMaps"
    "Microsoft.WindowsPhone"
    "Microsoft.WindowsSoundRecorder"
    "Microsoft.XboxApp"
    "Microsoft.ConnectivityStore"
    "Microsoft.CommsPhone"
    "Microsoft.ScreenSketch"
    "Microsoft.Xbox.TCUI"
    "Microsoft.XboxGameOverlay"
    # "Microsoft.XboxGameCallableUI"
    "Microsoft.XboxSpeechToTextOverlay"
    "Microsoft.MixedReality.Portal"
    "Microsoft.XboxIdentityProvider"
    "Microsoft.ZuneMusic"
    "Microsoft.ZuneVideo"
    # "Microsoft.YourPhone"
    "Microsoft.Getstarted"
    "Microsoft.MicrosoftOfficeHub"
    "*EclipseManager*"
    "*ActiproSoftwareLLC*"
    "*AdobeSystemsIncorporated.AdobePhotoshopExpress*"
    "*Duolingo-LearnLanguagesforFree*"
    "*PandoraMediaInc*"
    "*CandyCrush*"
    "*BubbleWitch3Saga*"
    "*Wunderlist*"
    "*Flipboard*"
    "*Twitter*"
    "*Facebook*"
    "*Royal Revolt*"
    "*Sway*"
    "*Speed Test*"
    "*Dolby*"
    "*Viber*"
    "*ACGMediaPlayer*"
    "*Netflix*"
    "*OneCalendar*"
    "*LinkedInforWindows*"
    "*HiddenCityMysteryofShadows*"
    "*Hulu*"
    "*HiddenCity*"
    "*AdobePhotoshopExpress*"
    "*HotspotShieldFreeVPN*"
    "*Microsoft.Advertising.Xaml*"
    #"*Microsoft.MSPaint*"
    #"*Microsoft.MicrosoftStickyNotes*"
    #"*Microsoft.Windows.Photos*"
    #"*Microsoft.WindowsCalculator*"
    #"*Microsoft.WindowsStore*"
)

$RemoveBloatware.Add_Click({
    $BloatwareForm                   = New-Object system.Windows.Forms.Form
    $BloatwareForm.ClientSize        = New-Object System.Drawing.Point(433,528)
    $BloatwareForm.text              = "Remove Bloatware"
    $BloatwareForm.TopMost           = $false

    $BloatwareList                          = New-Object System.Windows.Forms.CheckedListBox
    $BloatwareList.height                   = 435
    $BloatwareList.width                    = 415
    $BloatwareList.location                 = New-Object System.Drawing.Point(10,12)

    $Button1                         = New-Object system.Windows.Forms.Button
    $Button1.text                    = "Remove Selected Bloatware"
    $Button1.width                   = 414
    $Button1.height                  = 53
    $Button1.location                = New-Object System.Drawing.Point(11,460)
    $Button1.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

    $BloatwareForm.controls.AddRange(@($BloatwareList,$Button1))

    $Installed = @((Get-AppxPackage).Name)

    ForEach ($item in $Installed) {
        $BloatwareList.Items.Add($item)
    }

    ForEach ($item in $Bloatware) {
        $BloatwareList.SetItemChecked($BloatwareList.Items.IndexOf($item), $true);
    }

    $Button1.Add_Click({
        Write-Host "Removing Bloatware"
        $LogBox.text = "`r`n" +"`r`n" + "Removing Bloatware" 
        For ($i = 0; $i -le $BloatwareList.Items.Count-1; $i++) {
            if ($BloatwareList.GetItemChecked($i)) {
                $Bloat = $BloatwareList.Items[$i]
                Write-Host "Removing $Bloat"
                $LogBox.text = "`r`n" +"`r`n" + "Removing $Bloat" 
                Get-AppxPackage -Name $Bloat| Remove-AppxPackage
                Get-AppxProvisionedPackage -Online | Where-Object DisplayName -like $Bloat | Remove-AppxProvisionedPackage -Online
                Write-Host "Finished Removing $Bloat"
                $LogBox.text = "`r`n" +"`r`n" + "Finished Removing $Bloat"
            }
        }
        Write-Host "Finished Removing Bloatware Apps"
        $LogBox.text = "`r`n" +"`r`n" + "Finished Removing Bloatware"
    })
    [void]$BloatwareForm.ShowDialog()
})

#########################################
### Remove Windows Defender
#########################################

$RemoveDefender.Add_Click({
    Write-Host "Removing Defender"
    $LogBox.text = "`r`n" +"`r`n" + "Removing Defender"

    Write-Host "Elevating priviledges for this process"
    do {} until (Elevate-Privileges SeTakeOwnershipPrivilege)

    $tasks = @(
        "\Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance"
        "\Microsoft\Windows\Windows Defender\Windows Defender Cleanup"
        "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan"
        "\Microsoft\Windows\Windows Defender\Windows Defender Verification"
    )

    ForEach ($task in $tasks) {
        $parts = $task.split('\')
        $name = $parts[-1]
        $path = $parts[0..($parts.length-2)] -join '\'

        Write-Host "Trying to disable scheduled task $name"
        Disable-ScheduledTask -TaskName "$name" -TaskPath "$path"
    }

    Write-Host "Disabling Windows Defender via Group Policies"
    New-Item -Path "HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows Defender" -ItemType Directory -Force
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows Defender" "DisableAntiSpyware" 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows Defender" "DisableRoutinelyTakingAction" 1
    New-Item -Path "HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows Defender\Real-Time Protection" -ItemType Directory -Force
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows Defender\Real-Time Protection" "DisableRealtimeMonitoring" 1

    Write-Host "Disabling Windows Defender Services"
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\WinDefend" "Start" 4
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\WinDefend" "AutorunsDisabled" 3
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\WdNisSvc" "Start" 4
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\WdNisSvc" "AutorunsDisabled" 3
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Sense" "Start" 4
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Sense" "AutorunsDisabled" 3

    Write-Host "Removing Windows Defender context menu item"
    Set-Item "HKLM:\SOFTWARE\Classes\CLSID\{09A47860-11B0-4DA5-AFA5-26D86198A780}\InprocServer32" ""

    Write-Host "Removing Windows Defender GUI / tray from autorun"
    Remove-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" "WindowsDefender" -ea 0

    Write-Host "Finished Removing Defender"
    $LogBox.text = "`r`n" +"`r`n" + "Finished Removing Defender"
})

#########################################
### Uninstall OneDrive
#########################################

$UninstallOneDrive.Add_Click({
    Write-Host "Uninstalling OneDrive"
    $LogBox.text = "`r`n" +"`r`n" + "Uninstalling OneDrive"
    
    New-PSDrive  HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT
    $onedrive = "$env:SYSTEMROOT\SysWOW64\OneDriveSetup.exe"
    $ExplorerReg1 = "HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}"
    $ExplorerReg2 = "HKCR:\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}"
	Stop-Process -Name "OneDrive*"
	Start-Sleep 2
	If (!(Test-Path $onedrive)) {
		$onedrive = "$env:SYSTEMROOT\System32\OneDriveSetup.exe"
	}
	Start-Process $onedrive "/uninstall" -NoNewWindow -Wait
	Start-Sleep 2
    Write-Host "Stopping Explorer"
    Start-Sleep 1
	.\taskkill.exe /F /IM explorer.exe
	Start-Sleep 3
    Write-Host "Removing leftover files"
	Remove-Item "$env:USERPROFILE\OneDrive" -Force -Recurse
	Remove-Item "$env:LOCALAPPDATA\Microsoft\OneDrive" -Force -Recurse
	Remove-Item "$env:PROGRAMDATA\Microsoft OneDrive" -Force -Recurse
	If (Test-Path "$env:SYSTEMDRIVE\OneDriveTemp") {
		Remove-Item "$env:SYSTEMDRIVE\OneDriveTemp" -Force -Recurse
	}
    Write-Host "Removing OneDrive from Explorer"
    If (!(Test-Path $ExplorerReg1)) {
        New-Item $ExplorerReg1
    }
    Set-ItemProperty $ExplorerReg1 System.IsPinnedToNameSpaceTree -Value 0 
    If (!(Test-Path $ExplorerReg2)) {
        New-Item $ExplorerReg2
    }
    Set-ItemProperty $ExplorerReg2 System.IsPinnedToNameSpaceTree -Value 0
    Write-Host "Restarting Explorer"
    Start-Process explorer.exe -NoNewWindow

    Write-Host "Finished Uninstalling OneDrive"
    $LogBox.text = "`r`n" +"`r`n" + "Finished Uninstalling OneDrive"
})

#########################################
### Default Updates
#########################################

$DefaultUpdates.Add_Click({
    Write-Host "Enabling driver offering through Windows Update..."
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" -Name "PreventDeviceMetadataFromNetwork" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "DontPromptForWindowsUpdate" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "DontSearchWindowsUpdate" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "DriverUpdateWizardWuSearchEnabled" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "ExcludeWUDriversInQualityUpdate" -ErrorAction SilentlyContinue
    Write-Host "Enabling Windows Update automatic restart..."
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "NoAutoRebootWithLoggedOnUsers" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "AUPowerManagement" -ErrorAction SilentlyContinue
    Write-Host "Enabled driver offering through Windows Update"
    $LogBox.text = "`r`n" +"`r`n" + "Set Windows Updates to Default Settings"
})

#########################################
### Security Updates Only
#########################################

$SecurityUpdatesOnly.Add_Click({
    Write-Host "Disabling driver offering through Windows Update..."
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" -Name "PreventDeviceMetadataFromNetwork" -Type DWord -Value 1
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "DontPromptForWindowsUpdate" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "DontSearchWindowsUpdate" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "DriverUpdateWizardWuSearchEnabled" -Type DWord -Value 0
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "ExcludeWUDriversInQualityUpdate" -Type DWord -Value 1
    Write-Host "Disabling Windows Update automatic restart..."
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "NoAutoRebootWithLoggedOnUsers" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "AUPowerManagement" -Type DWord -Value 0
    Write-Host "Disabled driver offering through Windows Update"
    $LogBox.text = "`r`n" +"`r`n" + "Set Windows Updates to Security Updates Only"
})

#########################################
### Enable Updates
#########################################

$EnableUpdates.Add_Click({
    # https://github.com/rgl/windows-vagrant/blob/master/disable-windows-updates.ps1
    Set-StrictMode -Version Latest
    $ProgressPreference = 'SilentlyContinue'
    $ErrorActionPreference = 'Stop'
    trap {
        Write-Host
        Write-Host "ERROR: $_"
        Write-Host (($_.ScriptStackTrace -split '\r?\n') -replace '^(.*)$','ERROR: $1')
        Write-Host (($_.Exception.ToString() -split '\r?\n') -replace '^(.*)$','ERROR EXCEPTION: $1')
        Write-Host
        Write-Host 'Sleeping for 60m to give you time to look around the virtual machine before self-destruction...'
        Start-Sleep -Seconds (60*60)
        Exit 1
    }

    # disable automatic updates.
    # XXX this does not seem to work anymore.
    # see How to configure automatic updates by using Group Policy or registry settings
    #     at https://support.microsoft.com/en-us/help/328010
    function New-Directory($path) {
        $p, $components = $path -split '[\\/]'
        $components | ForEach-Object {
            $p = "$p\$_"
            if (!(Test-Path $p)) {
                New-Item -ItemType Directory $p | Out-Null
            }
        }
        $null
    }
    $auPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU'
    New-Directory $auPath 
    # set NoAutoUpdate.
    # 0: Automatic Updates is enabled (default).
    # 1: Automatic Updates is disabled.
    New-ItemProperty `
        -Path $auPath `
        -Name NoAutoUpdate `
        -Value 0 `
        -PropertyType DWORD `
        -Force `
        | Out-Null
    # set AUOptions.
    # 1: Keep my computer up to date has been disabled in Automatic Updates.
    # 2: Notify of download and installation.
    # 3: Automatically download and notify of installation.
    # 4: Automatically download and scheduled installation.
    New-ItemProperty `
        -Path $auPath `
        -Name AUOptions `
        -Value 3 `
        -PropertyType DWORD `
        -Force `
        | Out-Null

    # disable Windows Update Delivery Optimization.
    # NB this applies to Windows 10.
    # 0: Disabled
    # 1: PCs on my local network
    # 3: PCs on my local network, and PCs on the Internet
    $deliveryOptimizationPath = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config'
    if (Test-Path $deliveryOptimizationPath) {
        New-ItemProperty `
            -Path $deliveryOptimizationPath `
            -Name DODownloadMode `
            -Value 0 `
            -PropertyType DWORD `
            -Force `
            | Out-Null
    }
    # Service tweaks for Windows Update

    $services = @(
        "BITS"
        "wuauserv"
    )

    foreach ($service in $services) {
        # -ErrorAction SilentlyContinue is so it doesn't write an error to stdout if a service doesn't exist

        Write-Host "Setting $service StartupType to Automatic"
        Get-Service -Name $service -ErrorAction SilentlyContinue | Set-Service -StartupType Automatic
    }

    $LogBox.text = "`r`n" +"`r`n" + "Enabled Updates"
})

#########################################
### Disable Updates
#########################################

$DisableUpdates.Add_Click({
    # https://github.com/rgl/windows-vagrant/blob/master/disable-windows-updates.ps1
    Set-StrictMode -Version Latest
    $ProgressPreference = 'SilentlyContinue'
    $ErrorActionPreference = 'Stop'
    trap {
        Write-Host
        Write-Host "ERROR: $_"
        Write-Host (($_.ScriptStackTrace -split '\r?\n') -replace '^(.*)$','ERROR: $1')
        Write-Host (($_.Exception.ToString() -split '\r?\n') -replace '^(.*)$','ERROR EXCEPTION: $1')
        Write-Host
        Write-Host 'Sleeping for 60m to give you time to look around the virtual machine before self-destruction...'
        Start-Sleep -Seconds (60*60)
        Exit 1
    }

    # disable automatic updates.
    # XXX this does not seem to work anymore.
    # see How to configure automatic updates by using Group Policy or registry settings
    #     at https://support.microsoft.com/en-us/help/328010
    function New-Directory($path) {
        $p, $components = $path -split '[\\/]'
        $components | ForEach-Object {
            $p = "$p\$_"
            if (!(Test-Path $p)) {
                New-Item -ItemType Directory $p | Out-Null
            }
        }
        $null
    }
    $auPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU'
    New-Directory $auPath 
    # set NoAutoUpdate.
    # 0: Automatic Updates is enabled (default).
    # 1: Automatic Updates is disabled.
    New-ItemProperty `
        -Path $auPath `
        -Name NoAutoUpdate `
        -Value 1 `
        -PropertyType DWORD `
        -Force `
        | Out-Null
    # set AUOptions.
    # 1: Keep my computer up to date has been disabled in Automatic Updates.
    # 2: Notify of download and installation.
    # 3: Automatically download and notify of installation.
    # 4: Automatically download and scheduled installation.
    New-ItemProperty `
        -Path $auPath `
        -Name AUOptions `
        -Value 1 `
        -PropertyType DWORD `
        -Force `
        | Out-Null

    # disable Windows Update Delivery Optimization.
    # NB this applies to Windows 10.
    # 0: Disabled
    # 1: PCs on my local network
    # 3: PCs on my local network, and PCs on the Internet
    $deliveryOptimizationPath = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config'
    if (Test-Path $deliveryOptimizationPath) {
        New-ItemProperty `
            -Path $deliveryOptimizationPath `
            -Name DODownloadMode `
            -Value 0 `
            -PropertyType DWORD `
            -Force `
            | Out-Null
    }
    # Service tweaks for Windows Update

    $services = @(
        "BITS"
        "wuauserv"
    )

    foreach ($service in $services) {
        # -ErrorAction SilentlyContinue is so it doesn't write an error to stdout if a service doesn't exist

        Write-Host "Setting $service StartupType to Disabled"
        Get-Service -Name $service -ErrorAction SilentlyContinue | Set-Service -StartupType Disabled
    }

    $LogBox.text = "`r`n" +"`r`n" + "Disabled Updates"
})

#########################################
### Disable Telemetry
#########################################

$DisableTelemetry.Add_Click({
    Write-Host "Disabling Telemetry"
    $LogBox.text = "`r`n" +"`r`n" + "Disabling Telemetry"

    Write-Host "Running O&O Shutup with Recommended Settings"
    Import-Module BitsTransfer
    Start-BitsTransfer -Source "https://raw.githubusercontent.com/kenanajkunic/clevelandsteamer/master/ooshutup.cfg" -Destination ooshutup.cfg
    Start-BitsTransfer -Source "https://dl5.oo-software.com/files/ooshutup10/OOSU10.exe" -Destination OOSU10.exe
    ./OOSU10.exe ooshutup.cfg /quiet

    #Disables Windows Feedback Experience
    Write-Host "Disabling Windows Feedback Experience program"
    $Advertising = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo"
    If (Test-Path $Advertising) {
        Set-ItemProperty $Advertising Enabled -Value 0 
    }
        
    #Stops Cortana from being used as part of your Windows Search Function
    Write-Host "Stopping Cortana from being used as part of your Windows Search Function"
    $Search = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
    If (Test-Path $Search) {
        Set-ItemProperty $Search AllowCortana -Value 0 
    }

    #Disables Web Search in Start Menu
    Write-Host "Disabling Bing Search in Start Menu"
    $WebSearch = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
    Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" BingSearchEnabled -Value 0 
    If (!(Test-Path $WebSearch)) {
        New-Item $WebSearch
    }
    Set-ItemProperty $WebSearch DisableWebSearch -Value 1 
        
    #Stops the Windows Feedback Experience from sending anonymous data
    Write-Host "Stopping the Windows Feedback Experience program"
    $Period = "HKCU:\Software\Microsoft\Siuf\Rules"
    If (!(Test-Path $Period)) { 
        New-Item $Period
    }
    Set-ItemProperty $Period PeriodInNanoSeconds -Value 0 

    #Prevents bloatware applications from returning and removes Start Menu suggestions               
    Write-Host "Adding Registry key to prevent bloatware apps from returning"
    $registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
    $registryOEM = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
    If (!(Test-Path $registryPath)) { 
        New-Item $registryPath
    }
    Set-ItemProperty $registryPath DisableWindowsConsumerFeatures -Value 1 

    If (!(Test-Path $registryOEM)) {
        New-Item $registryOEM
    }
    Set-ItemProperty $registryOEM ContentDeliveryAllowed -Value 0 
    Set-ItemProperty $registryOEM OemPreInstalledAppsEnabled -Value 0 
    Set-ItemProperty $registryOEM PreInstalledAppsEnabled -Value 0 
    Set-ItemProperty $registryOEM PreInstalledAppsEverEnabled -Value 0 
    Set-ItemProperty $registryOEM SilentInstalledAppsEnabled -Value 0 
    Set-ItemProperty $registryOEM SystemPaneSuggestionsEnabled -Value 0          

    #Preping mixed Reality Portal for removal    
    Write-Host "Setting Mixed Reality Portal value to 0 so that you can uninstall it in Settings"
    $Holo = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Holographic"    
    If (Test-Path $Holo) {
        Set-ItemProperty $Holo  FirstRunSucceeded -Value 0 
    }

    #Disables Wi-fi Sense
    Write-Host "Disabling Wi-Fi Sense"
    $WifiSense1 = "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting"
    $WifiSense2 = "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots"
    $WifiSense3 = "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config"
    If (!(Test-Path $WifiSense1)) {
        New-Item $WifiSense1
    }
    Set-ItemProperty $WifiSense1  Value -Value 0 
    If (!(Test-Path $WifiSense2)) {
        New-Item $WifiSense2
    }
    Set-ItemProperty $WifiSense2  Value -Value 0 
    Set-ItemProperty $WifiSense3  AutoConnectAllowedOEM -Value 0 
    
    #Disables live tiles
    Write-Host "Disabling live tiles"
    $Live = "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications"    
    If (!(Test-Path $Live)) {      
        New-Item $Live
    }
    Set-ItemProperty $Live  NoTileApplicationNotification -Value 1 
    
    #Turns off Data Collection via the AllowTelemtry key by changing it to 0
    Write-Host "Turning off Data Collection"
    $DataCollection1 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection"
    $DataCollection2 = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
    $DataCollection3 = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection"    
    If (Test-Path $DataCollection1) {
        Set-ItemProperty $DataCollection1  AllowTelemetry -Value 0 
    }
    If (Test-Path $DataCollection2) {
        Set-ItemProperty $DataCollection2  AllowTelemetry -Value 0 
    }
    If (Test-Path $DataCollection3) {
        Set-ItemProperty $DataCollection3  AllowTelemetry -Value 0 
    }

    #Disabling Location Tracking
    Write-Host "Disabling Location Tracking"
    $SensorState = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}"
    $LocationConfig = "HKLM:\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration"
    If (!(Test-Path $SensorState)) {
        New-Item $SensorState
    }
    Set-ItemProperty $SensorState SensorPermissionState -Value 0 
    If (!(Test-Path $LocationConfig)) {
        New-Item $LocationConfig
    }
    Set-ItemProperty $LocationConfig Status -Value 0 
    
    #Disables People icon on Taskbar
    Write-Host "Disabling People icon on Taskbar"
    $People = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People'
    If (Test-Path $People) {
        Set-ItemProperty $People -Name PeopleBand -Value 0
    } 
    
    #Disables scheduled tasks that are considered unnecessary 
    Write-Host "Disabling scheduled tasks"
    #Get-ScheduledTask XblGameSaveTaskLogon | Disable-ScheduledTask
    Get-ScheduledTask XblGameSaveTask | Disable-ScheduledTask
    Get-ScheduledTask Consolidator | Disable-ScheduledTask
    Get-ScheduledTask UsbCeip | Disable-ScheduledTask
    Get-ScheduledTask DmClient | Disable-ScheduledTask
    Get-ScheduledTask DmClientOnScenarioDownload | Disable-ScheduledTask

    #Write-Host "Uninstalling Telemetry Windows Updates"
    #Uninstalls Some Windows Updates considered to be Telemetry. !WIP!
    #Wusa /Uninstall /KB:3022345 /norestart /quiet
    #Wusa /Uninstall /KB:3068708 /norestart /quiet
    #Wusa /Uninstall /KB:3075249 /norestart /quiet
    #Wusa /Uninstall /KB:3080149 /norestart /quiet        

    Write-Host "Stopping and disabling WAP Push Service"
    #Stop and disable WAP Push Service
    Stop-Service "dmwappushservice"
    Set-Service "dmwappushservice" -StartupType Disabled

    Write-Host "Stopping and disabling Diagnostics Tracking Service"
    #Disabling the Diagnostics Tracking Service
    Stop-Service "DiagTrack"
    Set-Service "DiagTrack" -StartupType Disabled

    Write-Host "Finished Disabling Telemetry"
    $LogBox.text = "`r`n" +"`r`n" + "Finished Disabling Telemetry"
})

#########################################
### Disable Cortana
#########################################

$RemoveCortana.Add_Click({
    # https://github.com/Sycnex/Windows10Debloater/blob/master/Individual%20Scripts/Disable%20Cortana
    Write-Host "Disabling Cortana"
    $LogBox.text = "`r`n" +"`r`n" + "Disabling Cortana"

    $Cortana1 = "HKCU:\SOFTWARE\Microsoft\Personalization\Settings"
    $Cortana2 = "HKCU:\SOFTWARE\Microsoft\InputPersonalization"
    $Cortana3 = "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore"
	If (!(Test-Path $Cortana1)) {
		New-Item $Cortana1
	}
	Set-ItemProperty $Cortana1 AcceptedPrivacyPolicy -Value 0 
	If (!(Test-Path $Cortana2)) {
		New-Item $Cortana2
	}
	Set-ItemProperty $Cortana2 RestrictImplicitTextCollection -Value 1 
	Set-ItemProperty $Cortana2 RestrictImplicitInkCollection -Value 1 
	If (!(Test-Path $Cortana3)) {
		New-Item $Cortana3
	}
	Set-ItemProperty $Cortana3 HarvestContacts -Value 0

    Write-Host "Finished Disabling Cortana"
    $LogBox.text = "`r`n" +"`r`n" + "Finished Disabling Cortana"
})

#########################################
### Install Software
#########################################

$Software = @(
    "7zip.7zip"
    "BlenderFoundation.Blender"
    "BraveSoftware.BraveBrowser"
    "Google.Chrome"
    "Discord.Discord"
    "GIMP.GIMP"
    "GiorgioTani.PeaZip"
    "HandBrake.HandBrake"
    "Inkscape.Inkscape"
    "KDE.Krita"
    "Notepad++.Notepad++"
    "Microsoft.Edge"
    "Microsoft.Skype"
    "Microsoft.VisualStudioCode"
    "Mozilla.Firefox"
    "Mozilla.Thunderbird"
    "Opera.Opera"
    "PuTTY.PuTTY"
    "qBittorrent.qBittorrent"
    "RARLab.WinRAR"
    "ShareX.ShareX"
    "Spotify.Spotify"
    "TheDocumentFoundation.LibreOffice"
    "Valve.Steam"
    "VideoLAN.VLC"
    "vim.vim"
    "WinSCP.WinSCP"
    "Zoom.Zoom"
)

$InstallSoftware.Add_Click({
    $SoftwareForm                   = New-Object system.Windows.Forms.Form
    $SoftwareForm.ClientSize        = New-Object System.Drawing.Point(433,528)
    $SoftwareForm.text              = "Install Software"
    $SoftwareForm.TopMost           = $false

    $SoftwareList                          = New-Object System.Windows.Forms.CheckedListBox
    $SoftwareList.height                   = 435
    $SoftwareList.width                    = 415
    $SoftwareList.location                 = New-Object System.Drawing.Point(10,12)

    $InstallButton                         = New-Object system.Windows.Forms.Button
    $InstallButton.text                    = "Install Selected Software"
    $InstallButton.width                   = 414
    $InstallButton.height                  = 53
    $InstallButton.location                = New-Object System.Drawing.Point(11,460)
    $InstallButton.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

    $SoftwareForm.controls.AddRange(@($SoftwareList,$InstallButton))

    ForEach ($item in $Software) {
        $SoftwareList.Items.Add($item)
    }

    $InstallButton.Add_Click({
        Write-Host "Installing Software"
        $LogBox.text = "`r`n" +"`r`n" + "Installing Software"
        For ($i = 0; $i -le $SoftwareList.Items.Count-1; $i++) {
            if ($SoftwareList.GetItemChecked($i)) {
                $Soft = $SoftwareList.Items[$i]
                Write-Host "Installing $Soft"
                $LogBox.text = "`r`n" +"`r`n" + "Installing $Soft"
                winget install -e $Soft | Write-Host
                if($?) {
                    Write-Host "Installed $Soft"
                    $LogBox.text = "`r`n" +"`r`n" + "Installed $Soft"
                }
            }
        }
        Write-Host "Finished Installing Software"
        $LogBox.text = "`r`n" +"`r`n" + "Finished Installing Software"
    })
    [void]$SoftwareForm.ShowDialog()
})

[void]$Form.ShowDialog()