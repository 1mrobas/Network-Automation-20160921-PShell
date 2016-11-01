<#
Parameters
-Name
-Descr
-Org <OrgOrg>
-AssignmentOrder = default, sequential

Set individual values to non-default
#>


#### load MAC pool list
$listMACpool=Import-Csv "CSV-MACpool.csv"
$list=$listMACpool

# Add pools
foreach($item in $list)
{ 
 #Get ORG to configure pool at
 $CfgOrg = Get-UcsOrg -Name $item.Org

 #create pool
 $Pool = Add-UCSMacPool -Name $item.Name -Descr $item.Comment -Org $CfgOrg.Dn -AssignmentOrder $item.Order

 $toMAC=UCS-create-MAC -segment $item.ss -fabric $item.f -type $item.t -host $item.Size
 $fromMAC=UCS-create-MAC -segment $item.ss -fabric $item.f -type $item.t -host "01"

 #Add MAC addresses
 if (($item.Size  -ne "") -and (($regexMAC.Match($fromMAC).Success)) -and (($regexMAC.Match($fromTo).Success)))
 {  
   Add-UcsMACMemberBlock -MacPool $Pool -From $fromMAC -To $toMAC
 }
}

