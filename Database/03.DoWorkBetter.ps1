#get-help restore | Out-GridView
#get-help Restore-DbaDatabase 
#get-help dbadatabase
#get-help New-DbaDatabase -Examples
#get-help Remove-DbaDatabase -examples

##############################################################################################
## when you set up the docker you have to specify the file location, it wont let you create
## the container unless the folder exits
##############################################################################################
$backuppath = "C:\temp\Docker\SQL\Backup\"
$backupfile = "VSDBA.bak"

if((Test-Path -Path $backuppath) -eq $false) {
    md $backuppath
}

if((Test-Path -Path ($backuppath + $backupfile)) -eq $false) {
    Copy-Item ".\Files\VSDBA.bak" $backuppath
}

##############################################################################################
## get a credential object that is used in the dbatools ps modules
##############################################################################################
$sqlcred = Get-Credential

##############################################################################################
## make 31 lot of databases 
##############################################################################################
$dblist = New-Object System.Collections.ArrayList

for ($i = 1; $i -lt 5; $i++) {
    $dblist.Add("SQL14$($i.ToString().PadLeft(2,"0"))")
}

# for ($i = 1; $i -lt 31; $i++) {
#     $dblist.Add("SQL14$($i.ToString().PadLeft(2,"0"))")
# }

##############################################################################################
## list of SQL Servers that we are adding databases to
##############################################################################################
$serverlist = "localhost,1401", "localhost,1402"

##############################################################################################
## setup databases
##############################################################################################
foreach($sqlinst in $serverlist) {
    #$sqlinst = "localhost,1401"

    #this takes an array of database names :)
    New-DbaDatabase -SqlInstance $sqlinst -Name $dblist -Recoverymodel Simple -SqlCredential  $sqlcred 
}

##############################################################################################
## teardown all the databases we created, this is sorta pointless because when you remove
## the docker container all the databases are wiped out.
##############################################################################################
foreach($sqlinst in $serverlist) {
    #this does too :D
    Remove-DbaDatabase -SqlInstance $sqlinst -Database $dblist -Confirm:$false -SqlCredential $sqlcred
}
    
##############################################################################################
## restore db using dbatools
##############################################################################################
$sqlcred = Get-Credential
Restore-DbaDatabase -SqlInstance "Localhost,1401" -SqlCredential $sqlcred -Path "/sql/Backup/VSDBA.bak" 

#get-help backup
#get-help query | out-gridview
##############################################################################################
## backup everything...
##############################################################################################

$backupdirectory = "/sql/Backup/new" 
if((Test-Path -Path "c:\temp\docker\$backupdirectory") -eq $false) {
    md "c:\temp\docker\$backupdirectory"
}

$sqlinst = "Localhost,1401"
$sqlinst2 = "Localhost,1404"

$dbnames = Invoke-DbaQuery -SqlInstance $sqlinst -SqlCredential $sqlcred -Query "SELECT TOP(3) name FROM sys.databases WHERE database_id > 4 ORDER BY name DESC; "
$dbnames | foreach-object {
    Backup-DbaDatabase -SqlInstance $sqlinst -SqlCredential $sqlcred -BackupDirectory $backupdirectory -Database $_.Name -Type Full
}

$backuplist = Invoke-DbaQuery -SqlInstance $sqlinst -SqlCredential $sqlcred -Query "SELECT TOP(3) d.name, REPLACE(backscript.physical_device_name, 'c:\sql\backup\new\', '/sql/Backup/new/') AS backuppath 
FROM sys.databases d 
LEFT JOIN sys.master_files AS MDF ON MDF.database_id = D.database_id AND MDF.file_id = 1
LEFT JOIN sys.master_files AS LDF ON LDF.database_id = D.database_id AND LDF.file_id = 2
CROSS APPLY (
	SELECT top 1 backup_set_id, b.database_name, 'RESTORE DATABASE [' + b.database_name + '] FROM DISK = ''' 
				   + mf.physical_device_name + ''' WITH NORECOVERY', b.backup_finish_date, mf.logical_device_name, mf.physical_device_name
	FROM    msdb.dbo.backupset b,
			   msdb.dbo.backupmediafamily mf
	WHERE    b.media_set_id = mf.media_set_id
			   AND b.database_name = d.name
			   and mf.physical_device_name like '%.bak'
	order by b.backup_set_id desc 
			  ) as backscript(backup_set_id, database_name, cmd, backup_finish_date, logical_device_name, physical_device_name)
WHERE d.database_id > 4 
ORDER BY d.name DESC ;"

$backuplist | ForEach-Object {
    Restore-DbaDatabase -SqlInstance $sqlinst2 -DatabaseName $_.name -Path $_.backuppath -WithReplace -SqlCredential $sqlcred
} 

$dbnames
$dbnames | Format-Table -AutoSize
$dbnames | ForEach-Object { Test-DbaLastBackup -SqlInstance $sqlinst -SqlCredential $sqlcred -Database $_.name }



#Get-DbaBackupInformation -SqlInstance "localhost,15789" -SqlCredential $sqlcred -DatabaseName VSDBA

