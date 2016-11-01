<#
Create SAN boot policy
Always hbaA0 and hbaB0
demoPure as target
Fabric A - CT0-FC0, CT1-FC0
Fabric B - CT0-FC2, CT1-FC2
Reboot on boot order change = no
Enforce vNIC/vHBA7iSCSI Name = yes
Boot mode = legacy
Local device = CD/DVD

#>

#Load list of boot policies
$List = Import-Csv ".\BOOTPolicy.csv"

#Get ORG
$CfgOrg = Get-UcsOrg -Name FlashStack

#Number of boot devices
$BootDevQty = "0"

#Add templates
foreach($item in $List)
{ 
  #create Boot policy
  $BootPolicy = Add-UcsBootPolicy -Org $CfgOrg.Dn -Name $item.Name -Descr $item.Descr -BootMode $item.BootMode -EnforceVnicName $item.Enforce -RebootOnUpdate $item.Reboot

  #Load VLAN list
  $filename = ".\BOOTPolicy - "+$item.Name+".csv"
  $List1 = Import-Csv $filename
  foreach($item1 in $List1)
  { 
    if ($item1.DeviceType -eq "CD")
    {
      Add-UcsLsbootVirtualMedia -BootPolicy $BootPolicy -Access $item1.Type -LunId $item1.PrimTLUN -MappingName "" -Order $item1.Order
      $BootDevQty = $item1.Order
    }
    elseif ($item1.DeviceType -eq "SAN")
    {
      #Add boot order to existing policy if not present
      if ($BootDevQty -ne $item1.Order)
      {
        $SANboot = Add-UcsLsbootSan -ModifyPresent -Order $item1.Order -BootPolicy $BootPolicy
        $BootDevQty = $item1.Order
      }
      
      #Add boot HBA boot device
      $BootHBA = Add-UcsLsbootSanCatSanImage -Type $item1.Type -VnicName $item1.Device -LsbootSan $SANboot  
      
      #Add primary target LUN and WWPN
      Add-UcsLsbootSanCatSanImagePath -Lun $item1.PrimTLUN -Type $item1.PrimTType -Wwn $item1.PrimTWWPN -LsbootSanCatSanImage $BootHBA
      
      #Add secondary target LUN and WWPN
      Add-UcsLsbootSanCatSanImagePath -Lun $item1.SecTLUN -Type $item1.SecTType -Wwn $item1.SecTWWPN -LsbootSanCatSanImage $BootHBA
          
    }
  }   
}



