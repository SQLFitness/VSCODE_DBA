
$sqlservers = New-Object System.Collections.ArrayList


for ($i = 1; $i -lt 3; $i++)
{
    $sqlservers.Add("SQL14$($i.ToString().PadLeft(2,"0"))")
}

$sqlservers

#$sqlservers.Add("SQL1401")

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
docker pull mcr.microsoft.com/mssql/server:2019-CTP2.5-ubuntu
foreach($sqlserver in $sqlservers) 
{
    $port = $sqlserver -replace "\D", ""

    docker run --name $sqlserver -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=1QAZ2wsx" -p $port`:1433 -d mcr.microsoft.com/mssql/server:2019-CTP2.5-ubuntu
    docker start $sqlserver
   
}

foreach($sqlserver in $sqlservers) 
{
    $port = $sqlserver -replace "\D", ""

    sqlcmd -S .,$port -U SA -P "1QAZ2wsx"
}

sqlcmd -S .,15789 -U SA -P "1QAZ2wsx"


# docker run --name SQL1401 -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=!QAZ2wsx" -p 1401:1433 -v C:\temp\Docker\SQL1401:/var/opt/mssql -d mcr.microsoft.com/mssql/server:2017-latest
# docker run --name SQL1402 -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=!QAZ2wsx" -p 1402:1433 -v C:\temp\Docker\SQL1402:/var/opt/mssql -d mcr.microsoft.com/mssql/server:2017-latest

# docker images
# docker container ls -a
docker ps -a

foreach($sqlserver in $sqlservers)
{
    docker start $sqlserver
}

docker start $(docker ps -aq -f status=exited)
# docker stop $(docker ps -aq -f status=running)
# docker rm $(docker ps -aq -f status=exited)
# docker rm $(docker ps -aq)

docker ps -a  
docker logs 4c2285e7de91

# docker start SQL1402
# docker start infallible_buck

# docker stop nostalgic_germain
# docker stop infallible_buck 

##############################################################################################
## why
##############################################################################################

# docker rm 3c0
# docker rm 6d7

foreach($sqlserver in $sqlservers)
{

}