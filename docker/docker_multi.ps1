
$sqlservers = New-Object System.Collections.ArrayList


for ($i = 1; $i -lt 6; $i++)
{
    $sqlservers.Add("SQL14$($i.ToString().PadLeft(2,"0"))")
}

$sqlservers

##############################################################################################
## make the directories
##############################################################################################
# foreach($sqlserver in $sqlservers)
# {
#     md "C:\temp\Docker\$($sqlserver)"
# }

##############################################################################################
## make the continers
##############################################################################################

foreach($sqlserver in $sqlservers) 
{
    $port = $sqlserver -replace "\D", ""

    docker run --name $sqlserver -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=!QAZ2wsx" -p $port`:1433 -v C:\temp\Docker\SQL:/sql -d mcr.microsoft.com/mssql/server:2019-CTP2.5-ubuntu
    docker start $sqlserver
}

# docker run --name SQL1401 -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=!QAZ2wsx" -p 1401:1433 -v C:\temp\Docker\SQL1401:/var/opt/mssql -d mcr.microsoft.com/mssql/server:2017-latest
# docker run --name SQL1402 -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=!QAZ2wsx" -p 1402:1433 -v C:\temp\Docker\SQL1402:/var/opt/mssql -d mcr.microsoft.com/mssql/server:2017-latest

# docker images
# docker container ls -a
docker ps -a

# foreach($sqlserver in $sqlservers)
# {
#     docker start $sqlserver
# }

docker start $(docker ps -aq -f status=exited)
# docker stop $(docker ps -aq -f status=running)
# docker rm $(docker ps -aq -f status=exited)
# docker rm $(docker ps -aq)

docker ps -a  

# docker start SQL1402
# docker start infallible_buck

# docker stop nostalgic_germain
# docker stop infallible_buck

# docker rm 3c0
# docker rm 6d7