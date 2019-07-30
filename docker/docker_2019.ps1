
##############################################################################################
## SQL SERVER localhost
##############################################################################################
docker pull mcr.microsoft.com/mssql/server:2019-CTP3.2-ubuntu

docker run `
--name DEVSQL19 `
-p 15789:1433 `
-e "ACCEPT_EULA=Y" `
-e "SA_PASSWORD=1QAZ2wsx" `
-v C:\temp\Docker\SQL:/sql `
-d mcr.microsoft.com/mssql/server:2019-CTP3.2-ubuntu

# cleanup containers processes
# docker ps -aq
# docker rm $(docker ps -aq) #removes containers not images

# Cleanup images
# docker images
# docker rmi $(docker images -aq)
# docker rmi  b7b28af77ffe  

#running processes
# docker ps -a #ps stands for Process Start and -a will you show you all processes regardless of status

docker start DEVSQL19

# docker stop DEVSQL19

docker ps -a
docker logs 239d8e925e74


##############################################################################################
## powershell
##############################################################################################
sqlcmd -S .,15789 -U SA -P "1QAZ2wsx"

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
