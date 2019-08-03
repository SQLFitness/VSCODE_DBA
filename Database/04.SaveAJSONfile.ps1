##############################################################################################
## get some data and output a json file
##############################################################################################
$sqlcred = Get-Credential

$rows = Invoke-DbaQuery -SqlInstance "localhost,15789" -Database "VSDBA" -Query "SELECT TOP(200) * FROM SampleCSV" -SqlCredential $sqlcred -Verbose

$jsonfile = "c:\temp\docker\JSON\"
if((Test-Path -Path $jsonfile) -eq $false) {
    mkdir $jsonfile
}

$rows | ConvertTo-Json | Out-File ($jsonfile+"csvtojson.json")
