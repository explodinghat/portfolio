# Author: Matt Warren
# Created - Jan-Jun 2020
# Powershell script to create AD accounts in bulk

# Edited to remove company/customer-specific information, so may read as incomplete in current state

Import-Module ActiveDirectory
$list = new-object system.collections.generic.list[system.object]

Import-csv "C:\output\users2.csv" | ForEach-Object {

New-ADUser -Name $_.Name `
    -DisplayName $_.SamAccountName `
    -GivenName $_.GivenName `
    -Surname $_.Surname `
    -UserPrincipalName $_.UserPrincipalName `
    -Path $_.Path `
    -AccountPassword (ConvertTo-SecureString $_.AccountPassword -AsPlainText -Force) `
    -Description "Add ticket number here" `
    -Enabled $true
    }
       

