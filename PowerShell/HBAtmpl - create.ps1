<#
Create vHBA template

Org
Name
Description
WWNPool
Mtu
SPG
QoS 
Fabric - a,b,none
Tmpltype - initial-template, updating-template

#>


#Load list
$List= Import-Csv “.\HBAtmpl.csv“

#Add templates
foreach($item in $List)
{ 
  #Get ORG to configure template at
  if ($CfgOrg.Name -ne $item.Org)
    { $CfgOrg = Get-UcsOrg -Name $item.Org }

  #create vHBA template
  $HBAtempl = Add-UcsVhbaTemplate -Name $item.Name -Org $CfgOrg.Dn -Descr $item.Descr -IdentPoolname $item.WWNPool -MaxDataFieldSize $item.Mtu -PinToGroupName $item.SPG -QoSPolicyName $item.QoS -SwitchId $item.Fabric -Templtype $item.TemplType

  Add-UcsVhbaInterface -Name $item.VSAN -VhbaTemplate $HBAtempl
}



