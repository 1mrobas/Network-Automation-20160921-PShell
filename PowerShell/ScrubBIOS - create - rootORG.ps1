<#
Parameters
- Name
- Descr
- Org <OrgOrg>
- BiosSettingsScrub = yes, no
- DiskScrub = yes, no
- FlexFlashScrub = yes, no

Set individual values to non-default
#>

#Get ORG to configure policy at
$CfgOrg = Get-UcsOrg -Name root

#Load SCRUB policy list
$List= Import-Csv “.\ScrubBIOS.csv“

#Add SCRUB policies
foreach($item in $List)
{ 
 #create policy
 Add-UcsScrubPolicy -Name $item.Name -Descr $item.Descr -Org $CfgOrg.Dn -BiosSettingsScrub $item.Bios -DiskScrub $item.Disk -FlexFlashScrub $item.Flash 
}