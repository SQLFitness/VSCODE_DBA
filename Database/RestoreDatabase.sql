USE [master]
RESTORE DATABASE [VSDBA] FROM  DISK = N'/sql/Backup/VSDBA.bak' WITH  FILE = 1,  
	MOVE N'VSDBA' TO N'/var/opt/mssql/data/VSDBA.mdf',  
	MOVE N'VSDBA_log' TO N'/var/opt/mssql/data/VSDBA_log.ldf',  
	NOUNLOAD,  STATS = 5

GO

USE [master]
RESTORE DATABASE [VSDBA_stag] FROM  DISK = N'/sql/Backup/VSDBA.bak' WITH  FILE = 1,  
	MOVE N'VSDBA' TO N'/var/opt/mssql/data/VSDBA_stag.mdf',  
	MOVE N'VSDBA_log' TO N'/var/opt/mssql/data/VSDBA_stag_log.ldf',  NOUNLOAD,  STATS = 5

GO


