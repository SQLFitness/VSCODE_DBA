
##############################################################################################
## SQL SERVER localhost
##############################################################################################
docker pull mcr.microsoft.com/mssql/server:2019-CTP3.2-ubuntu

docker run `
--name DEVSQL19 `
-p 15789:1433 `
-e "ACCEPT_EULA=Y" `
-e "SA_PASSWORD=1qaz@WSX" `
-v C:\temp\Docker\SQL:/sql `
-d mcr.microsoft.com/mssql/server:2019-CTP3.2-ubuntu

docker start DEVSQL19

# docker stop DEVSQL19

docker ps -a
docker logs 9b6931c93ad4

##############################################################################################
## powershell to run SQL CMD SHELL
##############################################################################################
sqlcmd -S localhost,15789 -U SA -P "1qaz@WSX"

CREATE DATABASE TestDB;
SELECT Name from sys.Databases;
GO

USE TestDB
CREATE TABLE Inventory (id INT, name NVARCHAR(50), quantity INT)
INSERT INTO Inventory VALUES (1, 'banana', 150); INSERT INTO Inventory VALUES (2, 'orange', 154);
GO

SELECT * FROM Inventory WHERE quantity > 152;
SELECT * FROM Inventory;
GO
