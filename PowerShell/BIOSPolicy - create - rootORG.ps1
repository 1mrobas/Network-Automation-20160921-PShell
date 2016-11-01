<#
Parameters
- Name
- Descr
- Org <OrgOrg>
- PolicyOwner = local, pending-policy,policy
- RebootOnUpdate = false,no,true,yes

Set individual values to non-default
#>

#Get ORG to configure policy at
$CfgOrg = Get-UcsOrg -Name root

#Load BIOS policy list
$List= Import-Csv “.\BIOSPolicy.csv“

#Add BIOS policies
foreach($item in $List)
{ 
 #create policy
 $Policy = Add-UcsBiosPolicy -Name $item.Name -Descr $item.Descr -Org $CfgOrg.Dn -RebootOnUpdate $item.Reboot 
 
 #Enable hyperthreading
 Set-UcsBiosHyperThreading -force -BiosPolicy $Policy -VpIntelHyperThreadingTech $item.Hypthrd
 
 #Enable VT bit
 Set-UcsBiosVfIntelVirtualizationTechnology -force -BiosPolicy $Policy -VpIntelVirtualizationTechnology $item.VT
 
 #Enable VT for IO
 Set-UcsBiosIntelDirectedIO -force -BiosPolicy $Policy -VpIntelVTForDirectedIO $item.VTIO
}