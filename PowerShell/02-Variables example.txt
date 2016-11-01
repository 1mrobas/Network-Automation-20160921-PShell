# read from stdIN
$csvList = Read-Host -Prompt "Input file: "
$outFile = Read-Host -Prompt "Output file: "

# import module
Import-Module .\globalVars

# variables with global scope
$global:workdir = "D:\Demo"
$global:VC01host = "fsVC6-01a.flashstack.local"

# variables with local scope
$VC01usr = "administrator@vsphere.local"
$outpath="d:\temp\"

# import data from CSV
$csvList= Import-Csv “CSV-ESXI-vmk-add.csv“

# create CSV result file with FC device aliases based on WWPN CSV input
$outlist=$csvList
out-file $outFile -encoding ascii 
out-file $outFile -encoding ascii -append -InputObject "### header"
foreach($item in $outList)
 {
   "device-alias name "+$item.Name+" pwwn "+$item.WWPN | out-file $outFile -encoding ascii -append 
 }
