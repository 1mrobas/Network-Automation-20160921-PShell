Get-Module –ListAvailable
Get-Module -All
$env:PSModulePath
$env:PSModulePath = $env:PSModulePath + ";D:\Demo"
Import-Module .\PowerNSX_v1
Import-Module .\SSH-Sessions
