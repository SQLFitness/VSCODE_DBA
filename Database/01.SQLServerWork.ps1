##############################################################################################
## Make sure to run the docker_multi.ps1 to setup the environment
##############################################################################################
sqlcmd -S localhost,15789 -U sa -P "1qaz@WSX"

# do something T-SQL'y...
SELECT name
FROM sys.databases;
GO
# Wow!
# Don't forget to exit the cmd shell





















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
# Don't forget to exit the cmd shell



















# Don't forget to exit the cmd shell






















##############################################################################################
## connect and do something with the server... using programs
## requires a DB called testdb and a table called dbo.inventory...
##############################################################################################
$SrcServer = "localhost,15789" #Source Server Name
$SrcDatabase = "testdb" #Source Database Name
$SrcUser = "sa" #Source Login : User Name
$SrcPwd = "1qaz@WSX" #Source Login : Password
$SrcTable = "dbo.inventory" #Source Table Name

#$SrcConnStr = New-Object System.Data.SqlClient.SqlConnection
#$SrcConn.ConnectionString  = "Server=$SrcServer;Database=$SrcDatabase; User Id=$SrcUser; Password=$SrcPwd;"
#$SrcConnStr = ConnectionStringS $SrcServer $SrcDatabase $SrcUser $SrcPwd
$SrcConnStr = "Server=$SrcServer;uid=$SrcUser; pwd=$SrcPwd;Database=$SrcDatabase;Integrated Security=False;"
$SrcConn  = New-Object System.Data.SqlClient.SQLConnection($SrcConnStr)
$CmdText = "SELECT * FROM " + $SrcTable
$SqlCommand = New-Object system.Data.SqlClient.SqlCommand($CmdText, $SrcConn)
$SrcConn.Open()
[System.Data.SqlClient.SqlDataReader] $SqlReader = $SqlCommand.ExecuteReader()
$Datatable = New-Object System.Data.DataTable
$Datatable.Load($SqlReader)
$SrcConn.close()

$Datatable | Format-Table -AutoSize

$Datatable | Out-GridView

##############################################################################################
## this function is needed or is it?
##############################################################################################
Function ConnectionStringS ([string] $ServerName, [string] $DbName, [string] $User, [string] $Pwd)
{
"Server=$ServerName;uid=$User; pwd=$Pwd;Database=$DbName;Integrated Security=False;"
}