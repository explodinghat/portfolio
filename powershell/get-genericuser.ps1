# Author: Matt Warren
# Created - Jan-Jun 2020
# Powershell script to generate passwords for users via Dinopass API call from a CSV (generated
# as an output from creating users via a companion script). Returns a CSV output of user passwords
# + extended user information 

# Edited to remove company/customer-specific information, so may read as incomplete in its current state

<# This script can be used to gather information on users from AD based on a set attribute
The user can be further interrogated via the use of an if statement
eg.
- search each line of a CSV for a user in AD based on an email address
- determine if that user is in the OU 'exchange generic' based on their distinguished name
- if they are, find their manager's name through the 'manager' field
- search AD for the manager and return their manager's display name and email address 
#>


$users = import-csv -path 'C:\output\migrated_accounts_removed.csv' 

$list = new-object system.collections.generic.list[system.object]

foreach($user in $users) {
   $manager = "" 
   $email = $user.email
   $userad = get-aduser -filter {emailaddress -like $email} -Properties EmailAddress, manager
   if ($userad.distinguishedname -like "*Exchange Generic*"){
       $manager = $userad.manager
       $managerad = get-aduser $manager -Properties displayname, emailaddress
   
       $props = @{
           managerdisplayname = $managerad.displayname
           manageremailaddress = $managerad.emailaddress
           email = $user.email
       }

       $object = new-object psobject -Property $props

       $list.add($object)
   }
  
} 
$list | export-csv -Path 'C:\output\generics2.csv' -NoTypeInformation 

