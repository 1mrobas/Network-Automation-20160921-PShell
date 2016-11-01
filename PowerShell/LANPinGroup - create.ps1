<#
LAN Pin Group parameters
- Name
- Description
- Targets 
   Fabric-A => interface
   Fabric-B => interface
#>

#Create LAN Pin Group
Add-UcsEthernetPinGroup -Name XXX -Description XXX 

#Bind PinGriup to targets
Add-UcsEthernetPinGroupTarget -EthernetPinGroup XXX -FabricID a/b/dual