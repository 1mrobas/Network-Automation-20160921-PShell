<#
Parameters
- Name
- Descr
- Org <OrgOrg>
- UptimeDisc = user-ack, immediate, scheduled

Set individual values to non-default
#>

#Get ORG to configure policy at
$CfgOrg = Get-UcsOrg -Name root

#Load BIOS policy list
$List= Import-Csv “.\MaintPolicy.csv“

#Add Maintenance policies
foreach($item in $List)
{
 #create policy
 Add-UcsMaintenancePolicy -Name $item.Name -Descr $item.Descr -Org $CfgOrg.Dn -UptimeDisr $item.When
}