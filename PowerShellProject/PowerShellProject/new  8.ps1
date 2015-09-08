New-SPContentDatabase "BB2013_Int_Dashboards_Content" -DatabaseServer "MRSSPI01\SPI" -WebApplication https://intranet-int.bourbon-online.com -MaxSiteCount 5000 -WarningSiteCount 2000



Move-SPSite https://intranet-int.bourbon-online.com/mydashboards -DestinationDatabase BB2013_Int_Dashboards_Content
Get-SPSite -ContentDatabase BB2013_Int_Portal_Content




get-spcontentdatabase | add-spshelladmin bourbon\svc.bippfront

