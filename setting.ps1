##############################################################################################
## change the size of the fonts in VS Code editor and terminal
##############################################################################################
#texteditor.font.size
#terminal.integrated.shell.windows #changes

#font.size

Install-Module dbatools -MaximumVersion 0.9.752 
Install-Module dbatools -MaximumVersion 0.9.752 -scope CurrentUser
Save-Module dbatools -path c:\temp\savedmoduless
$newdir = c:\temp\savedmoduless
$newdir = "c:\temp\savedmoduless"

$newdir
md $newdir
Save-Module dbatools -path $newdir


get-module

Get-Content $profile