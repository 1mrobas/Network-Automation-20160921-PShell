<#

Set individual values to non-default
#>

$WWNTest = [regex]"^[A-Fa-f0-9:]*$"

#Load list
$List= Import-Csv “.\WWNPool.csv“

#Add pools
foreach($item in $List)
{ 
 #Get ORG to configure pool at
 $CfgOrg = Get-UcsOrg -Name $item.Org

 #create pool
 $Pool = Add-UcsWwnPool -Org $CfgOrg.Dn -Name $item.Name -AssignmentOrder $item.Order -Descr $item.Descr -Purpose $item.Type

 #Add WWN addresses
 if (($item.From.Length -ne 0) -and (($WWNTest.Match($item.From).Success)))
 {  
   Add-UcsWWNMemberBlock -WWnPool $Pool -From $Item.From -To $Item.To
 }
}