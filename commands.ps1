Get-WindowsFeature | where{$_.InstallState -eq "Installed"} | select Name,Installstate

Get-WindowsFeature | where{$_.InstallState -eq "Installed"} | select Name | Export-Csv C:\temp\features.csv

Import-Csv C:\Users\Administrator\Desktop\features.csv | foreach{ Install-WindowsFeature $_.name}

