#
# Int-Refonte
#
#on MRSSPI03
Backup-SPSite -Identity https://intranet-int.bourbon-online.com -Path c:\root3.bak

New-SPContentDatabase "BB2013_Int_Quality_Content" -DatabaseServer "MRSSPI01\SPI" -WebApplication https://intranet-int.bourbon-online.com -MaxSiteCount 5000 -WarningSiteCount 2000
New-SPManagedPath "qapps" -WebApplication "https://intranet-int.bourbon-online.com" -Explicit

get-spcontentdatabase | add-spshelladmin bourbon\svc.bippfront


Restore-SPSite https://intranet-int.bourbon-online.com/qa -Path c:\root3.bak -ContentDatabase BB2013_Int_Quality_Content -force


#check orphans
$db=get-spcontentdatabase bb2013_int_portal_content

$db.repair($false)

#On MRSSPI04
Backup-SPSite -Identity https://intranet-int.bourbon-online.com/sites/refonteintranet -Path c:\refonte.bak
Remove-SPSite https://intranet-int.bourbon-online.com/sites/refonteintranet

#gradual delete

#Resto
Restore-SPSite https://intranet-int.bourbon-online.com -Path c:\refonte.bak -ContentDatabase BB2013_Int_Publishing_Content -force


#check orphans
$db=get-spcontentdatabase bb2013_int_publishing_content

$db.repair($false)













