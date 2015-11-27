#
# Update_People_Picker_Multi_Domains.ps1
#
 $wa = Get-SPWebApplication "http://mrsspi07:1818"

$newdomain = new-object Microsoft.SharePoint.Administration.SPPeoplePickerSearchActiveDirectoryDomain

$newdomain.DomainName = "bbint.priv"; 

$newdomain.ShortDomainName = "bbint";

$wa.PeoplePickerSettings.SearchActiveDirectoryDomains.add($newdomain);

$wa.update();
 

$wa = Get-SPWebApplication "https://mybourbon-perso.bourbon-online.com"

$newdomain = new-object Microsoft.SharePoint.Administration.SPPeoplePickerSearchActiveDirectoryDomain

$newdomain.DomainName = "mybourbon.PRIV"; 

$newdomain.ShortDomainName = "mybourbon";

$wa.PeoplePickerSettings.SearchActiveDirectoryDomains.add($newdomain);

$wa.update();

 
$wa = Get-SPWebApplication "https://mybourbon.bourbon-online.com"

$newdomain = new-object Microsoft.SharePoint.Administration.SPPeoplePickerSearchActiveDirectoryDomain

$newdomain.DomainName = "BOURBON.PRIV"; 

$newdomain.ShortDomainName = "BOURBON";

$wa.PeoplePickerSettings.SearchActiveDirectoryDomains.add($newdomain);

$wa.update();
 

$wa = Get-SPWebApplication "https://mybourbon-perso.bourbon-online.com"

$newdomain = new-object Microsoft.SharePoint.Administration.SPPeoplePickerSearchActiveDirectoryDomain

$newdomain.DomainName = "BOURBON.PRIV"; 

$newdomain.ShortDomainName = "BOURBON";

$wa.PeoplePickerSettings.SearchActiveDirectoryDomains.add($newdomain);

$wa.update();