$sqlserver = New-Object Microsoft.SqlServer.Management.Smo.Server "localhost\dev2016"
$sqlserver.Databases | select name