$SrcServer = "localhost" #Source Server Name
 $SrcDatabase = "testdb" #Source Database Name
 $SrcUser = "sa" #Source Login : User Name
 $SrcPwd = "1QAZ2wsx" #Source Login : Password
 $DestServer = "localhost,1401" #Destination Server Name
 $DestDatabase = "testdb" #Destination Database Name
 $DestUser = "sa" #Destination Login : User Name
 $DestPwd = "1QAZ2wsx" #Destination Login : Password
 $SrcTable = "dbo.inventory" #Source Table Name
 $DestTable = "inventory" #Destination Table Name
 $BatchSize = 10 #Batch Size
 $TimeOut = 180 #Timeout period
 
 Function ConnectionStringS ([string] $ServerName, [string] $DbName, [string] $User, [string] $Pwd)
 {
 "Server=$ServerName;uid=$User; pwd=$Pwd;Database=$DbName;Integrated Security=False;"
 }

########## Main body ############
 If ($DestDatabase.Length –eq 0) {
 $DestDatabase = $SrcDatabase
 }
 If ($DestTable.Length –eq 0) {
 $DestTable = $SrcTable
 }
 #If ($Truncate) {
 #$TruncateSql = "TRUNCATE TABLE " + $DestTable
 # Sqlcmd -S $DestServer -d $DestDatabase -Q $TruncateSql
 #}
 #$SrcConnStr = New-Object System.Data.SqlClient.SqlConnection
 #$SrcConn.ConnectionString  = "Server=$SrcServer;Database=$SrcDatabase; User Id=$SrcUser; Password=$SrcPwd;"
 $SrcConnStr = ConnectionStringS $SrcServer $SrcDatabase $SrcUser $SrcPwd
 $SrcConn  = New-Object System.Data.SqlClient.SQLConnection($SrcConnStr)
 $CmdText = "SELECT * FROM " + $SrcTable
 $SqlCommand = New-Object system.Data.SqlClient.SqlCommand($CmdText, $SrcConn)
 $SrcConn.Open()
 [System.Data.SqlClient.SqlDataReader] $SqlReader = $SqlCommand.ExecuteReader()

Try
 {
 $DestConnStr = ConnectionStringS $DestServer $DestDatabase $DestUser $DestPwd
 $bulkCopy = New-Object Data.SqlClient.SqlBulkCopy($DestConnStr, [System.Data.SqlClient.SqlBulkCopyOptions]::KeepIdentity)
 $bulkCopy.DestinationTableName = $DestTable
 $bulkCopy.BatchSize = $BatchSize
 $bulkCopy.BulkCopyTimeout = $TimeOut
 $bulkCopy.WriteToServer($sqlReader)
 }
 Catch [System.Exception]
 {
 $ex = $_.Exception
 Write-Host $ex.Message
 }
  Finally
 {
 Write-Host "Bulk copy completed"
 $SqlReader.close()
 $SrcConn.Close()
 $SrcConn.Dispose()
 $bulkCopy.Close()
 }