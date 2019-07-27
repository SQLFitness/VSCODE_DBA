#Import-Module dbatools
#get-module 

$ItemCodes = 004872, 004919, 004873, 004920, 004937

$ProductItemCodes = $ItemCodes | ForEach-Object {$_.ToString().PadLeft(6,"0")} | ForEach-Object { "'$($_.tostring())'" } 
$ProductItemCodes = [system.string]::Join(", ", $ProductItemCodes)

$ProductItemCodes

# if($ProductItemCodes.count -gt 0)
# {
#     $ProductItemCodes[$ProductItemCodes.count-1] = $ProductItemCodes[$ProductItemCodes.count-1].Substring(0,$ProductItemCodes[$ProductItemCodes.count-1].Length-1)
# }

# $itemCodeString = [system.string]::Join(" ", $ProductItemCodes)
$lensquery = "SELECT * FROM dbo.LENS AS L WHERE L.OLDITEM IN ( $($ProductItemCodes) )"

$lensquery

Copy-DbaDbTableData -SqlInstance "dr0-sql-31" -Database "800contacts" -Destination "speterson-3420\dev2016" -DestinationDatabase DarkHorse -Query $lensquery -DestinationTable "dbo.lens"  -Verbose

$local = @{
    Database = "800contacts";
    Destination = "speterson-3420\dev2016";
    DestinationDatabase = "DarkHorse";
    DestinationTable = "dbo.lens";
    Query = $lensquery;
}

Copy-DbaDbTableData -SqlInstance "dr0-sql-31"  $local

$local




$var

#get-help Copy-DbaDbTableData -examples

$prodrows  
