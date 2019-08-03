
$sqlservers = New-Object System.Collections.ArrayList


for ($i = 1; $i -lt 5; $i++)
{
    $sqlservers.Add("SQL14$($i.ToString().PadLeft(2,"0"))")
}

$sqlservers

# #$sqlservers.Add("SQL1401")

##############################################################################################
## needed to create the local folder that sql server can access
##############################################################################################
$backuppath = "C:\temp\Docker\SQL\"
if((Test-Path -Path $backuppath) -eq $false) {
    md $backuppath
}

# ##############################################################################################
# ## make the continers
# ##############################################################################################
docker pull mcr.microsoft.com/mssql/server:2019-CTP2.5-ubuntu
docker pull mcr.microsoft.com/mssql/server:2017-latest
foreach($sqlserver in $sqlservers) 
{
    $port = $sqlserver -replace "\D", ""

    docker run --name $sqlserver -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=1qaz@WSX" -p $port`:1433 -v C:\temp\Docker\SQL:/sql -d mcr.microsoft.com/mssql/server:2017-latest
    # docker start $sqlserver
}

# docker run --name SQL1401 -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=1qaz@WSX" -p 1401:1433 -v C:\temp\Docker\SQL:/sql -d mcr.microsoft.com/mssql/server:2017-latest
# docker run --name SQL1402 -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=1qaz@WSX" -p 1402:1433 -v C:\temp\Docker\SQL:/sql -d mcr.microsoft.com/mssql/server:2017-latest

# sqlcmd -S localhost,1401 -U SA -P "1qaz@WSX"
# sqlcmd -S .,1402 -U SA -P "1qaz@WSX"

docker ps -a

<#
DONT FORGET TO DISCONNECT FROM THE SERVER IN SSMS
IT DOESNT LIKE WHEN THE SERVER DISAPPEARS AND IS
A LITTLE CRANKY.

    foreach($sqlserver in $sqlservers)
    {
        docker stop $sqlserver
    }

    foreach($ss in $sqlservers)
    {
        docker rm $ss
    }

#>

#docker ps -a  
#docker logs SQL1401

