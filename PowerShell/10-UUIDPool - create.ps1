<#
Parameters
-Name
-Descr
-Org <OrgOrg>
-AssignmentOrder = default, sequential

Set individual values to non-default
#>

$UUIDTest = [regex]"^[A-Fa-f0-9-]*$"

#Load list
$List= Import-Csv “.\UUIDPool.csv“

#Add pools
foreach($item in $List)
{ 
 #Get ORG to configure pool at
 $CfgOrg = Get-UcsOrg -Name $item.Org

 #create pool
 $Pool = Add-UcsUuidSuffixPool -Org $CfgOrg.Dn -Name $item.Name -Descr $item.Descr -AssignmentOrder $item.Order -Prefix $item.Prefix

 #Add Suffixes
 if (($item.From.Length -ne 0) -and (($UUIDTest.Match($item.From).Success)))
 {  
   Add-UcsUuidSuffixBlock -UuidSuffixPool $Pool -From $Item.From -To $Item.To
 }
}