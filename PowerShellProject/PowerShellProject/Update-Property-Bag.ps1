#
# Update_Property_Bag.ps1
#
$web = Get-SPWeb -Identity https://perso-intranet.bourbon-online.com
$web.Properties["intraneturl"] = "https://hub.bourbon-online.com/"
$web.Properties.update()
$web.Update()

