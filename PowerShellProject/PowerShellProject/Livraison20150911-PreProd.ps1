#
# Livraison20150911-PreProd
#
cd "C:\Livraisons\Livraison20150911\Livraison_Lot4\Livraison_Lot4"
cd .\Scripts
.\AddUserProperties2.PS1 -siteUrl "https://intranet-pre.bourbon-online.com/sites/RefonteIntranet" –managedMetadataServiceName "Managed Metadata Service"

.\UpdateBourbon-v1.2.ps1 -siteUrl "https://intranet-pre.bourbon-online.com/sites/RefonteIntranet" -managedMetadataServiceName "Managed Metadata Service" -searchServiceName "Search Service Application" -searchContentSourceName "Publishing" -packagePath "C:\Livraisons\Livraison20150911\Livraison_Lot4\Livraison_Lot4"

$siteUrl = "https://intranet-pre.bourbon-online.com/sites/RefonteIntranet"
$managedMetadataServiceName = "Managed Metadata Service"
.\InitCompaniesList.ps1 -fileName ".\XML\Companies.xml" -url $siteUrl -managedMetadataServiceName $managedMetadataServiceName | Out-Host



cd "C:\Livraisons\Livraison20150911\Livraison_Lot5\Livraison_Lot5\Scripts\v1.5"
.\UpdateBourbon.ps1 -siteUrl "https://intranet-pre.bourbon-online.com/sites/RefonteIntranet" -myDeskRelativeUrl "mydesk" -mySiteUrl "https://perso-intranet-pre.bourbon-online.com/" -managedMetadataServiceName "Managed Metadata Service" –packagePath "C:\Livraisons\Livraison20150911\Livraison_Lot5\Livraison_Lot5\WSP"


#Get-SPSite "https://perso-intranet-pre.bourbon-online.com/personal/*" -Limit ALL | Remove-SPSite -Confirm:$false


cd "C:\Livraisons\Livraison20150911\Livraison_Lot5\Livraison_Lot5\Scripts\v1.5.1"
.\UpdateBourbon.ps1 -siteUrl "https://intranet-pre.bourbon-online.com/sites/RefonteIntranet"  -mySiteUrl " https://perso-intranet-pre.bourbon-online.com" -packagePath "C:\Livraisons\Livraison20150911\Livraison_Lot5\Livraison_Lot5\WSP"  -searchServiceName "Search Service Application" –searchContentSourceName "Publishing"