<#
Create vNIC template

Org
Name
Description
MACPool
Mtu
NetCtrlPolicy
LPG
QoS 
Fabric - a,a-b,b,b-a,none
Target - adaptor,Defaultvalue,vm
Tmpltype - initial-template, updating-template

#>


# $MACTest = [regex]"^[A-Fa-f0-9:]*$"

#Load list
$List= Import-Csv “.\NICtmpl.csv“

#Add templates
foreach($item in $List)
{ 
  #Get ORG to configure template at
  if ($CfgOrg.Name -ne $item.Org)
    { $CfgOrg = Get-UcsOrg -Name $item.Org }

  #create vNIC template
  $NICtempl = Add-UcsVnicTemplate -Name $item.Name -Org $CfgOrg.Dn -Descr $item.Descr -IdentPoolname $item.MACPool -Mtu $item.Mtu -NwCtrlPolicyName $item.NetCtrl -PinToGroupName $item.LPG -QoSPolicyName $item.QoS -SwitchId $item.Fabric -Target $item.target -Templtype $item.TemplType
 
  #Load VLAN list
  $filename = ".\VLANlist - "+$item.Name+".csv"
  $VLANlist = Import-Csv $filename
  foreach($VLANitem in $VLANList)
  { 
    #Add VLAN to the vNIC template
    Add-UcsVnicInterface -Name $VLANitem.Name -VnicTemplate $NICtempl -DefaultNet $VLANitem.Native
  }
}



