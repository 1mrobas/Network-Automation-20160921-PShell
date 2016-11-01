#Number of VMs
#$srcVM = Read-Host -Prompt "Source VM: "
$srcVM = "fsFS-01"

#Destination Folder
$dstFolderName = "Test"

#Get source cluster & folder
$Cluster = "fsCompute01"
$srcFolder = "VMs"
$dstEsxi = "fsesxi6-01.flashstack.local"
$dstDatastore = "PURE-srv6-03"

#Create folder
$dstFolder = Get-Folder -Name $DstFolderName

# VM name
$vmName = "vm01-cl01"

$exectime=Measure-Command{New-VM -VM $srcVM -VMHost $dstEsxi -Name $vmName -Location $dstFolder -ResourcePool "Srv" -Datastore $DstDatastore -DiskStorageFormat Thin}

$exectime | Export-csv 11-CLONE-time.txt -notype