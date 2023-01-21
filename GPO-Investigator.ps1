$GPOs = Get-GPO -All
foreach ($GPO in $GPOs) {
    Write-Host "[+] Analyzing GPO: $($GPO.DisplayName)"

    # Exporting the GPO content in XML format
    [xml]$currentGPO = Get-GPOReport -Guid $GPO.Id -ReportType xml

    # Extracting the defined Account Settings
    $accountSettings = $currentGPO.GPO.Computer.ExtensionData.Extension.Account
    if ($accountSettings) {
        Write-Host "`t[+] Analyzing Account Settings"
        foreach ($accountSetting in $accountSettings) {
            if ($accountSetting) {
                Write-Host "`t`tFound Account Setting: $($accountSetting.Name)"
            }
        }
    }

    # Extracting the defined Scheduled Tasks
    $scheduledTasks = $currentGPO.GPO.Computer.ExtensionData.Extension.ScheduledTasks.ChildNodes
    if ($scheduledTasks) {
        Write-Host "`t[+] Analyzing Scheduled Tasks"
        foreach ($scheduledTask in $scheduledTasks) {
            Write-Host "`t`tFound Scheduled Task: $($scheduledTask.name)"
        }
    }

    # Extracting the defined Services
    $services = $currentGPO.GPO.Computer.ExtensionData.Extension.NTServices.ChildNodes
    if ($services) {
        Write-Host "`t[+] Analyzing Services"
        foreach ($service in $services) {
            Write-Host "`t`tFound Service: $($service.name)"
        }
    }

    # Extracting the defined Local Users and Groups
    $localUsersAndGroups = $currentGPO.GPO.Computer.ExtensionData.Extension.LocalUsersAndGroups.ChildNodes
    if ($localUsersAndGroups) {
        Write-Host "`t[+] Analyzing Local Users and Groups"
        foreach ($localUsersAndGroup in $localUsersAndGroups) {
            if ($localUsersAndGroup.Properties.userName) {
                Write-Host "`t`tFound Local User: $($localUsersAndGroup.name)"
            }
            elseif ($localUsersAndGroup.Properties.groupName) {
                Write-Host "`t`tFound Local Group: $($localUsersAndGroup.name)"
            }
        }
    }

    # Extracting the defined Printers
    $printers = $currentGPO.GPO.Computer.ExtensionData.Extension.Printers.ChildNodes
    if ($printers) {
        Write-Host "`t[+] Analyzing Printers"
        foreach ($printer in $printers) {
            Write-Host "`t`tFound Printer: $($printer.name)"
        }
    }

    # Extracting the defined Registry Settings
    $registrySettings = $currentGPO.GPO.Computer.ExtensionData.Extension.RegistrySettings.ChildNodes
    if ($registrySettings) {
        Write-Host "`t[+] Analyzing Registry Settings"
        foreach ($registrySetting in $registrySettings) {
            Write-Host "`t`tFound Registry Setting: $($registrySetting.name)"
        }
    }

    # Extracting the defined Folders
    $folders = $currentGPO.GPO.Computer.ExtensionData.Extension.Folders.ChildNodes
    if ($folders) {
        Write-Host "`t[+] Analyzing Folders"
        foreach ($folder in $folders) {
            Write-Host "`t`tFound Folder: $($folder.name)"
        }
    }

    # Extracting the defined Network Shares
    $networkShares = $currentGPO.GPO.Computer.ExtensionData.Extension.NetworkShares.ChildNodes
    if ($folders) {
        Write-Host "`t[+] Analyzing Network Shares"
        foreach ($networkShare in $networkShares) {
            Write-Host "`t`tFound Network Share: $($networkShare.name)"
        }
    }

    # Extracting the defined Environment Variables
    $environmentVariables = $currentGPO.GPO.Computer.ExtensionData.Extension.EnvironmentVariables.ChildNodes
    if ($folders) {
        Write-Host "`t[+] Analyzing Environment Variables"
        foreach ($environmentVariable in $environmentVariables) {
            Write-Host "`t`tFound Environment Variable: $($environmentVariable.name)"
        }
    }

    Write-Host
}