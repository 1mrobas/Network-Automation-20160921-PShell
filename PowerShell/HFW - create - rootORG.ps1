<#
Parameters
- Name
- Descr
- Org <OrgOrg>
- BladeBundleVersion

Set individual values to non-default
#>

#Get ORG to configure policy at
$CfgOrg = Get-UcsOrg -Name root

#Load HFW packages list
$List= Import-Csv “.\HFW.csv“

#Add HFW packages
foreach($item in $List)
{ 
 #create package
 Add-UcsFirmwareComputeHostPack -Name $item.Name -Descr $item.Descr -Org $CfgOrg.Dn -BladeBundleVersion $item.BladeFW 
}