docker pull mcr.microsoft.com/mssql/server:2017-latest

docker run --name SQL1401 -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=1qaz@WSX" -p 1401:1433 -v C:\temp\Docker\SQL:/sql -d mcr.microsoft.com/mssql/server:2017-latest
docker run --name SQL1402 -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=1qaz@WSX" -p 1402:1433 -v C:\temp\Docker\SQL:/sql -d mcr.microsoft.com/mssql/server:2017-latest

docker ps -a

docker start SQL1401
docker start SQL1402

##############################################################################################
## powershell
##############################################################################################
sqlcmd -S .,1401 -U SA -P "1qaz@WSX"
sqlcmd -S .,1402 -U SA -P "1qaz@WSX"

##############################################################################################
## bash
##############################################################################################
docker exec -it SQL1401 "bash"
/opt/mssql-tools/bin/sqlcmd -S .,1401 -U SA -P "1qaz@WSX"

docker exec -it SQL1402 "bash"
/opt/mssql-tools/bin/sqlcmd -S .,1402 -U SA -P "1qaz@WSX"

##############################################################################################
## T-SQL
##############################################################################################
CREATE DATABASE TestDB;
SELECT Name from sys.Databases;
GO

USE TestDB
CREATE TABLE Inventory (id INT, name NVARCHAR(50), quantity INT);
INSERT INTO Inventory VALUES (1, 'banana', 150); INSERT INTO Inventory VALUES (2, 'orange', 154);
GO

SELECT * FROM Inventory WHERE quantity > 152;
SELECT * FROM Inventory;
GO

##############################################################################################
## stop and rm dockers
##############################################################################################
docker stop SQL1401
docker stop SQL1402

docker rm SQL1401
docker rm SQL1402