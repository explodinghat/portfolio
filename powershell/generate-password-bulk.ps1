# Author: Matt Warren
# Created - Jan-Jun 2020
# Powershell script to generate passwords for users via Dinopass API call from a CSV (generated
# as an output from creating users via a companion script). Returns a CSV output of user passwords
# + extended user information 

# Edited to remove company/customer-specific information, so may read as incomplete in its current state

Import-Module ActiveDirectory
$list = new-object system.collections.generic.list[system.object]

Import-csv "C:\output\brunel-users.csv" | ForEach-Object {

$upn = $_.username + #Enter UPN suffix here or edit to prompt user
$ou = #Enter OU here or edit to prompt user
$password = Invoke-WebRequest -Uri https://www.dinopass.com/password/strong | Select-Object -ExpandProperty content

$props = @{
    Name = $_.username
    Displayname = $_.name
    GivenName = $_.first
    Surname = $_.last
    UserPrincipalName = $upn
    SamAccountName = $_.username
    Path = $OU
    AccountPassword = $password
    }
       

       $object = new-object psobject -Property $props


    $list.add($object)
    }
 
$list | export-csv -Path 'C:\output\brunel-users2.csv' -NoTypeInformation 


