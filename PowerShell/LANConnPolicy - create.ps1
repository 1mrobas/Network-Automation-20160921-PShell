<#
Create LAN connectivity Policy

Org
Name
Description
NwTemplateName
AdaptorProfileName = Linux,SRIOV,VMware,Windows
#>


#Load list
$List= Import-Csv “.\LANConnPolicy.csv“

#Add templates
foreach($item in $List)
{ 
  #Get ORG to configure template at
  if ($CfgOrg.Name -ne $item.Org)
    { $CfgOrg = Get-UcsOrg -Name $item.Org }

  #create LCP
  $LCP = Add-UcsVnicLanConnPolicy -Org $CfgOrg.Dn -Name $item.name -Descr $item.Descr
   
  #Load vNIC list
  $filename = ".\NIClist - "+$item.Name+".csv"
  $NIClist = Import-Csv $filename
  foreach($NICitem in $NICList)
  { 
    #Add vNIC to the LCP
    Add-UcsVnic -Name $NICitem.Name -VnicLanConnPolicy $LCP -NwTemplName $NICitem.NICTemplate -AdaptorProfileName $NICitem.AdapterType
  }
}



