docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=<YourStrong!Passw0rd>" `
   -p 1433:1433 --name sql1 `
   -d mcr.microsoft.com/mssql/server:2017-latest

docker ps -a

docker exec -it sql1 /opt/mssql-tools/bin/sqlcmd `
   -S localhost -U SA -P "<YourStrong!Passw0rd>" `
   -Q "ALTER LOGIN SA WITH PASSWORD='1QAZ2wsx'"


##############################################################################################
## bash
##############################################################################################
docker exec -it sql1 "bash"
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "1QAZ2wsx"

create database TestDB
select name from sys.databases
go



##############################################################################################
## powershell
##############################################################################################
sqlcmd -S localhost -U SA -P "1QAZ2wsx"

docker stop sql1
docker rm sql1