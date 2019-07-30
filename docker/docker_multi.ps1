
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

docker rmi mcr.microsoft.com/mssql/server:2019-CTP2.5-ubuntu
docker pull mcr.microsoft.com/mssql/server:2019-CTP3.2-ubuntu

foreach($sqlserver in $sqlservers) 
{
    $port = $sqlserver -replace "\D", ""

    "$port = " + $port

    docker run --name $sqlserver -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=!QAZ2wsx" -p $port`:1433 -d mcr.microsoft.com/mssql/server:2019-CTP3.2-ubuntu
    #-v C:\temp\Docker\SQL:/sql 
    docker start $sqlserver
}

# docker run --name SQL1401 -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=!QAZ2wsx" -p 1433:1433 -v C:\temp\Docker\SQL:/var/opt/mssql -d mcr.microsoft.com/mssql/server:2019-CTP3.2-ubuntu
# docker run --name SQL1402 -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=!QAZ2wsx" -p 1402:1433 -v C:\temp\Docker\SQL1402:/var/opt/mssql -d mcr.microsoft.com/mssql/server:2017-latest

docker start SQL1401

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
docker port  SQL1401

# docker start SQL1402
# docker start infallible_buck

# docker stop nostalgic_germain
# docker stop infallible_buck

# docker rm 3c0
# docker rm 6d7

sqlcmd -S 0.0.0.0,1401 -U SA -P !QAZ2wsx
docker-machine ls

docker logs e202645a0fba
