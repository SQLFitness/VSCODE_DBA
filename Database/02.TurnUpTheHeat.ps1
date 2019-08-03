$sqlcred = Get-Credential
$sqlinst = "localhost,1401"
$dbname = "VSDBA"
#$csvfile = ".\files\SampleCSVFile_5300kb.csv"
$csvfile = ".\files\SampleCSVFile_556kb.csv"

Import-DbaCsv -SqlInstance $sqlinst -Database $dbname -SqlCredential $sqlcred -Csv $csvfile -Table SampleCSV -AutoCreateTable 

$csv = Invoke-DbaQuery -SqlInstance $sqlinst -Database $dbname -SqlCredential $sqlcred -query "SELECT TOP(2000) * FROM SampleCSV;"

$csv
$csv | format-table -autosize
$csv | Out-GridView