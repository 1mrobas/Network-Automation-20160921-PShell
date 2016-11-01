<#
VLAN creation paramters
  VLAN name
  Multicast policy - dfault
  Common/Global
  VLAN ID
  Sharing Type - None, Primary, Isolaed, Community
#>

#### load VLAN pool list
$listVLAN=Import-Csv "CSV-VLAN.csv"
$list=$listVLAN

#Create VLANs
foreach($item in $list)
 {Get-UcsLanCloud | Add-UcsVlan -Id $item.VLAN -Name $item.Name}