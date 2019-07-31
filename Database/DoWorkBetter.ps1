#get-help restore | Out-GridView
#get-help Restore-DbaDatabase 
#get-help dbadatabase
#get-help New-DbaDatabase -Examples
#get-help Remove-DbaDatabase -examples

$sqlcred = Get-Credential

$dblist = New-Object System.Collections.ArrayList

for ($i = 0; $i -lt 31; $i++) {
    $dblist.Add("SQL14$($i.ToString().PadLeft(2,"0"))")
}

$serverlist = "localhost,1401", "localhost,1402"

##############################################################################################
## setup 
##############################################################################################
foreach($sqlinst in $serverlist) {
    #$sqlinst = "localhost,1401"

    #this takes an array of database names :)
    New-DbaDatabase -SqlInstance $sqlinst -Name $dblist -Recoverymodel Simple -SqlCredential  $sqlcred 
}

##############################################################################################
## teardown
##############################################################################################
foreach($sqlinst in $serverlist) {
    #this does too :D
    Remove-DbaDatabase -SqlInstance $sqlinst -Database $dblist -Confirm:$false -SqlCredential $sqlcred
}
    
##############################################################################################
## restore db
##############################################################################################
$sqlcred = Get-Credential
Restore-DbaDatabase -SqlInstance "Localhost,1401" -SqlCredential $sqlcred -Path "/sql/Backup/VSDBA.bak"