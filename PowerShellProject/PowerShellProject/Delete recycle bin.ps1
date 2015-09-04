#
# Delete_recycle_bin.ps1
#
 Add-PSSnapin microsoft.sharepoint.powershell 

 $sitecollectionUrl = “https://intranet-int.bourbon-online.com/workspaces”
 $siteCollection = New-Object Microsoft.SharePoint.SPSite($sitecollectionUrl)
 write-host(“Items to be deleted : ” +$siteCollection.RecycleBin.Count.toString())
 
 $siteCollection.RecycleBin.DeleteAll();
 



$siteCollection.Dispose();
