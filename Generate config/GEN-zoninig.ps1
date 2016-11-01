<####
# Parameters
#   csvList - input CSV file with list of host alias names and WWPNs
# 
# Output
#   DevAlias.txt file 
#
#####>


###Collect input parameters
$csvStorageList=Read-Host -Prompt "Storage list:"
$csvServerList=Read-Host -Prompt "Server HBA list:"
$fabricVSAN=Read-host -Prompt "VSAN:"
$outFile = Read-Host -Prompt "Output zone cfg file: "
$outFile2 = Read-Host -Prompt "Output zoneset cfg file: "

###Load lists
$listStorage=Import-Csv $csvStorageList
$listServer=Import-Csv $csvServerList

###Get date & time
$today = get-date
$day = $today.Day
$mth = $today.Month
$year = $today.Year
$hour = $today.Hour
$min = $today.Minute
$sec = $today.Second
$date = "$year-$mth-$day-$hour$min$sec"

out-file $outFile -encoding ascii 
out-file $outFile -encoding ascii -append -InputObject "! $date Zone Config"

out-file $outFile2 -encoding ascii 
out-file $outFile2 -encoding ascii -append -InputObject "! $date Zoneset Config"
"zoneset name zsetSANfabric-"+$fabricVSAN.ToString()+" vsan "+$fabricVSAN.ToString() | out-file $outFile2 -encoding ascii -append

###Zones
foreach($itemStorage in $listStorage)
{
 foreach($itemServer in $listServer)
 {
   #create zone
   "zone name "+$itemStorage.Name+"--"+$itemServer.Name+" vsan "+$fabricVSAN.ToString() | out-file $outFile -encoding ascii -append
   " member device-alias "+$itemStorage.DevAlias | out-file $outFile -encoding ascii -append
   " member device-alias "+$itemServer.DevAlias | out-file $outFile -encoding ascii -append
   "!" | out-file $outFile -encoding ascii -append
   
   #add member to zoneset
   " member "+$itemStorage.Name+"--"+$itemServer.Name | out-file $outFile2 -encoding ascii -append
 }
 #commit zones
 "zone commit vsan "+$fabricVSAN.ToString() | out-file $outFile -encoding ascii -append
 "!" | out-file $outFile -encoding ascii -append
 
#commit zoneset
# "zone commit vsan "+$fabricVSAN.ToString() | out-file $outFile2 -encoding ascii -append
# "!" | out-file $outFile2 -encoding ascii -append
}

#Commit and activate zoneset
"zoneset activate name zsetSANfabric-"+$fabricVSAN.ToString()+" vsan "+$fabricVSAN.ToString() | out-file $outFile2 -encoding ascii -append
"zone commit vsan "+$fabricVSAN.ToString() | out-file $outFile2 -encoding ascii -append