<#
Create LAN connectivity Policy

Org
Name
Description
NwTemplateName
AdaptorProfileName = Linux,SRIOV,VMware,Windows
#>


#Load list
$List= Import-Csv “.\SANConnPolicy.csv“

#Add templates
foreach($item in $List)
{ 
  #Get ORG to configure template at
  if ($CfgOrg.Name -ne $item.Org)
    { $CfgOrg = Get-UcsOrg -Name $item.Org }

  #create SCP
  $SCP = Add-UcsVnicSanConnPolicy -Org $CfgOrg.Dn -Name $item.name -Descr $item.Descr
  Add-UcsVnicFcNode -VnicSanConnPolicy $SCP -Addr "pool-derived" -IdentPoolName $item.WWNN

  #Load vHBA list
  $filename = ".\HBAlist - "+$item.Name+".csv"
  $HBAList = Import-Csv $filename
  foreach($HBAitem in $HBAList)
  { 
    #Add vHBA to the SCP
    Add-UcsVhba -Name $HBAitem.Name -VnicSanConnPolicy $SCP -NwTemplName $HBAitem.HBATemplate -AdaptorProfileName $HBAitem.AdapterType
  }
}



