<#
Parameters
- Name
- Descr
- Org <OrgOrg>
- Cdp = enabled, disabled
- MacRegisterMode = only-native-vlan, all-hosts-vlan
- UplinkFailAction = link-down, warning
Set individual values to non-default
#>

#Get ORG to configure policy at
$CfgOrg = Get-UcsOrg -Name root

#Load list
$List= Import-Csv “.\NetCtrlPolicy.csv“

#Add policies
foreach($item in $List)
{ 
 #create policy
 Add-UcsNetworkControlPolicy -Name $item.Name -Descr $item.Descr -Org $CfgOrg.Dn -Cdp $item.Cdp -MacRegisterMode $item.Mac -UplinkFailAction $item.UplinkFail
}