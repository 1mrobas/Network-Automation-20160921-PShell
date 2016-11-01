# Generate configuration example
Sample scripts for generating FC device alias and zoning configuration read for copy&paste to a device.

## PowerShell scripts
* **GEN-devalias.ps1** - generate FC device alias configuration PSHELL script
* **GEN-zoning.ps1** - generate FC zones & zoneset configuration PSHELL script

## Input CSV files for GEN-devalias.ps1 script
* wwpnUCS.csv - CSV list with server HBAs and WWPNs
* wwpnVNX5400.csv - CSV list with storage HBAs and WWPNs

## Input CSV files for GEN-zoning.ps1 script
* zone-srv-A.csv - CSV list with server HBA name and corresponding device alias names for SAN fabric A
* zone-srv-B.csv - CSV list with server HBA name and corresponding device alias names for SAN fabric B
* zone-storage-A.csv - CSV list with storage HBA name and corresponding device alias names for SAN fabric A
* zone-storage-B.csv - CSV list with storage HBA name and corresponding device alias names for SAN fabric B

## Output/result files
20160921-devalias-UCS.txt - device-alias configuration for servers
20160921-zones.txt - zones for SAN fabric A (VSAN 11)
20160921-zoneset.txt - zoneset for SAN fabric A (VSAN 11)
