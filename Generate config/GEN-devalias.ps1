<#####
# Parameters
#   csvList - input CSV file with list of host alias names and WWPNs
# 
# Output
#   DevAlias.txt file 
#
#####>


#PWWN list
$csvList = Read-Host -Prompt "PWWN list: "
$outFile = Read-Host -Prompt "Output file: "

#Load lists
$listCSV=Import-Csv $csvList


#Get date & time
$today = get-date
$day = $today.Day
$mth = $today.Month
$year = $today.Year
$hour = $today.Hour
$min = $today.Minute
$sec = $today.Second
$date = "$year-$mth-$day-$hour$min$sec"

out-file $outFile -encoding ascii 
out-file $outFile -encoding ascii -append -InputObject "! $date Device Alias Configuration"

"device-alias database" | out-file $outFile -encoding ascii -append 

foreach($item in $listCSV)
{
 "device-alias name "+$item.Port+" pwwn "+$item.WWPN | out-file $outFile -encoding ascii -append
}

"";"device-alias commit" | out-file $outFile -encoding ascii -append 