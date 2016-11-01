<#
Parameters
-Name
-Descr
-Org <OrgOrg>
-AssignmentOrder = default, sequential

Set individual values to non-default
#>

$MACTest = [regex]"^[A-Fa-f0-9:]*$"

#Load list
$List= Import-Csv “.\MACPool.csv“

#Add pools
foreach($item in $List)
{ 
 #Get ORG to configure pool at
 $CfgOrg = Get-UcsOrg -Name $item.Org

 #create pool
 $Pool = Add-UCSMacPool -Name $item.Name -Descr $item.Descr -Org $CfgOrg.Dn -AssignmentOrder $item.Order

 #Add MAC addresses
 if (($item.From.Length -ne 0) -and (($MACTest.Match($item.From).Success)))
 {  
   Add-UcsMACMemberBlock -MacPool $Pool -From $Item.From -To $Item.To
 }
}