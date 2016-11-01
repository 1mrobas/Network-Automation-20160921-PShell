# Load Cisco UCS PowerTool
Import-Module CiscoUcsPs


# Initialize vCenter modules
Add-PSSnapin VMware.VimAutomation.Core
cd "C:\Program Files (x86)\VMware\Infrastructure\vSphere PowerCLI\Scripts"
.\Initialize-PowerCLIEnvironment.ps1

# Import SSH module
Import-Module .\SSH-Sessions

#load custom functions
.\mrFunc.ps1

# Import PowerNSX module
Import-Module .\PowerNSX_v1

# move to appropriate directoy
cd "d:\demo"
