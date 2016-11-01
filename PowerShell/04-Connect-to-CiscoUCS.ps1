# Connect to Cisco UCS system
$global:UCSusr = "admin"
$global:UCSusrpwd = ConvertTo-SecureString "Cisco123" -AsPlainText -Force
$global:UCS01host = "demoUCS01.flashstack.local"
$global:UCS01cred = New-Object System.Management.Automation.PSCredential ($UCSusr, $UCSusrpwd)
$global:UCS01handle= Connect-Ucs -Name $UCS01host -Credential $UCS01cred
