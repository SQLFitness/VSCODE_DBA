##############################################################################################
## this is used to test some functionality... As I learn to be a developer again
##############################################################################################
$list = New-Object System.Collections.ArrayList

for ($i = 1; $i -lt 99; $i++)
{
    $list.Add("SQL14$($i.ToString().PadLeft(2,"0"))")
}

$list