$sqlserver = New-Object Microsoft.SqlServer.Management.Smo.Server "localhost,1402"
$sqlserver.Databases | select name