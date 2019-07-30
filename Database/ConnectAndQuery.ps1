$sqlserver = New-Object Microsoft.SqlServer.Management.Smo.Server "."
$sqlserver.Databases | select name