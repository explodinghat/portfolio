<#
# Author: Matt Warren
# Created - Jan-Jun 2021

# Edited to remove company/customer-specific information, so may read as incomplete in its current state

Script obtains extended information about shared mailboxes in order to determine who is the custodian,
when the mailbox was last logged into, how large the mailbox is and when the last mail was sent
from the mailbox

#TODO: 
- Updated 12/06/2021 to remove company/user-specific info - update needed to prompt user for input on execution
- Connect to exchange/ azure ad without manual input
- Enable logging instead of write-host
- Set as a weekly scheduled task
- Change return value of o365mailbox size to a sortable value
- Update latestsentemail to return useful information

#>

# Connect to exchange online
Import-Module ExchangeOnlineManagement
write-host -ForegroundColor Green "Connecting to Exchange Online"
Connect-ExchangeOnline -userprincipalname #enter admin username
# Connect to azure AD
write-host -ForegroundColor Green "Connecting to AzureAD"
Connect-AzureAD

# TODO : Cache the list of user accounts from the exchange generics OU (CSV?)
#$users = get-aduser -blahblahOU -eq exchange generic

$oupath = #enter OU path to query

$users = Get-ADUser -Filter * -SearchBase $OUpath

#Initiate a list for storing all user info - this will be exported at the end 

$list = new-object system.collections.generic.list[system.object]

# Get user's manager info

foreach($user in $users) {
    $username = $user.SamAccountName
    $manager = ""
    write-host -ForegroundColor Yellow "Getting info from AD for $username"
    $userad = get-aduser -filter {samaccountname -like $username} -Properties manager, displayname, emailaddress
    $displayname = $userad.displayname
    if($userad.manager -eq $null){
    write-host -ForegroundColor Yellow "$displayname has no manager listed"
    $managerad = [pscustomobject]@{
        displayname = "NO MANAGER!"
        emailaddress = "NO MANAGER!"
        }
    }
    else
    {
    write-host -ForegroundColor Green "$displayname has a manager listed, getting details"
    $manager = $userad.manager
    $managerad = get-aduser $manager -Properties displayname, emailaddress
    }

    # Get info about user's mailbox usage 

    if($userad.emailaddress -eq $null){
        Write-host -ForegroundColor Yellow "$displayname has no email address listed"
        $email = "No email"
        $mailboxsize = "No email"
        $lastlogin = "No email"}
    else{
        $email = $userad.emailaddress
        # Get info from exchange online
        write-host -foregroundcolor Green "Email address listed. Getting mailbox statistics and size for $email"

        $mailboxstats = Get-EXOMailboxStatistics -Identity $email

        $mailboxstats | Add-Member -MemberType ScriptProperty -Name TotalItemSizeInBytes {$this.TotalItemSize -replace �(.*\()|,| [a-z]*\)�, ��}

        $mailboxsize = $mailboxstats | Select-Object TotalItemSizeInBytes,@{Name=”TotalItemSizeinGB�; Expression={[math]::Round($_.TotalItemSizeInBytes/1GB,2)}}

        $mailboxsize = $mailboxsize.totalitemsizeingb

        $lastlogin = Get-MailboxStatistics $email | Select LastLogonTime
            if($lastlogin.LastLogonTime -eq $null){
            write-host -ForegroundColor Yellow "$email has no lastlogontime"
            $lastlogintime = 'Unknown'
            }
            else{
            write-host -ForegroundColor Green "$email has a login time listed, checking.."
            $lastlogintime = ($lastlogin.LastLogonTime).ToString('dd-MM-yyy HH:MM:ss')
            }

        # Get info from message trace
        write-host -ForegroundColor Yellow "Checking if $email has sent an email in the last 10 days"
        $date = (Get-Date).ToString('MM-dd-yyyy')
        $10days = (Get-Date).AddDays(-10).ToString('MM-dd-yyyy')
        $latestsent = get-messagetrace -SenderAddress $email -StartDate $10daysFormatted -EndDate $dateFormatted | Select-Object -First 1 | select received
        $latestsent = $latestsent.Received
        }  
    
# Build an array from variables created by obtained info 

       $props = @{
           displayname = $displayname
           managerdisplayname = $managerad.displayname
           manageremailaddress = $managerad.emailaddress
           email = $email 
           o365mailboxsizegb = $mailboxsize
           o365lastlogin = $lastlogintime
           latestsentemail = $latestsent
           }
       

       $object = new-object psobject -Property $props



       $list.add($object)
   }

$todaysdate = (Get-Date).ToString('yyyy-MM-dd')

# Output a csv locally with the output info 

$list | export-csv -Path "C:\output\$todaysdate-genericaccounts.csv" -NoTypeInformation 