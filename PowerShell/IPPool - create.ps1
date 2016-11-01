<#
Parameters
-Name
-Descr
-Org <OrgOrg>
-AssignmentOrder = default, sequential

Set individual values to non-default
#>

$NumberTest = [regex]"^[0-9.]*$"

#Load list
$List= Import-Csv “.\IPPool.csv“

#Add pools
foreach($item in $List)
{ 
 #Get ORG to configure pool at
 $CfgOrg = Get-UcsOrg -Name $item.Org

 #create pool
 $Pool = Add-UCSIpPool -Name $item.Name -Descr $item.Descr -Org $CfgOrg.Dn -AssignmentOrder $item.Order

 #Add IPv4 addresses
 if (($item.DNS2.Length -ne 0) -and (($NumberTest.Match($item.DNS2).Success)))
 {  
   Add-UcsIpPoolBlock -ipPool $Pool -From $Item.From -To $Item.To -DefGw $Item.DefGw -PrimDns $item.DNS1 -SecDns $item.DNS2 -Subnet $item.Mask
 }
 else
 {
   Add-UcsIpPoolBlock -ipPool $Pool -From $Item.From -To $Item.To -DefGw $Item.DefGw -PrimDns $item.DNS1 -Subnet $item.Mask
 }
}