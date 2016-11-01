<#
Create ORGs
#>

$ORGTest = [regex]"^[A-Za-z0-9:.-_]*$"

#Load list
$List= Import-Csv “.\ORG.csv“

#Add ORGs
foreach($item in $List)
{ 
 #Get parent ORG to configure ORG at
 $CfgOrg = Get-UcsOrg -Name $item.ParentOrg

 #create ORG

 #Add MAC addresses
 if (($item.Name.Length -le 16) -and (($ORGTest.Match($item.Name).Success)))
 {  
   Add-UcsOrg -Name $item.Name -Descr $item.Descr -Org $CfgOrg.Dn 
 }
}