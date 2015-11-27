#
# Change_CentralAdmin_Banner.ps1
#
Add-PSSnapin Microsoft.SharePOint.PowerShell

#Get the Web Application

$webApp = Get-SPWebApplication "http://mrsspi03:2013"


#Set the "SharePoint" text Property 

$webApp.SuiteBarBrandingElementHtml = "SharePoint - Integration"

#Update changes

$webApp.Update()