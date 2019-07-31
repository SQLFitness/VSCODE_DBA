docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=<YourStrong!Passw0rd>" `
   -p 1433:1433 --name sql1 `
   -d mcr.microsoft.com/mssql/server:2017-latest

docker ps -a

docker exec -it sql1 /opt/mssql-tools/bin/sqlcmd `
   -S localhost -U SA -P "<YourStrong!Passw0rd>" `
   -Q "ALTER LOGIN SA WITH PASSWORD='1qaz@WSX'"


##############################################################################################
## bash
##############################################################################################
docker exec -it sql1 "bash"
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "1qaz@WSX"

CREATE DATABASE TestDB
SELECT Name from sys.Database
GO

USE TestDB
CREATE TABLE Inventory (id INT, name NVARCHAR(50), quantity INT)
INSERT INTO Inventory VALUES (1, 'banana', 150); INSERT INTO Inventory VALUES (2, 'orange', 154);
GO

SELECT * FROM Inventory WHERE quantity > 152;
SELECT * FROM Inventory;
GO

##############################################################################################
## powershell
##############################################################################################
sqlcmd -S localhost -U SA -P "1qaz@WSX"

docker stop sql1
docker rm sql1