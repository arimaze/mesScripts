#
# Configure_Super_Accounts.ps1
#

# 1. Add on all Web Applications super reader : read and super user : full control in user policy

# 2. WARNING : input names should be in CLAIM !

$wa = Get-SPWebApplication -Identity "https://myb.bourbon-online.com"
$wa.Properties["portalsuperuseraccount"]="i:0#.w|bourbon\svc.wsscachesu-pre"
$wa.Properties["portalsuperreaderaccount"] = "i:0#.w|bourbon\svc.wsscachesr-pre"
$wa.Update()


$wa = Get-SPWebApplication -Identity "https://hub-pre.bourbon-online.com"
$wa.Properties["portalsuperuseraccount"]="i:0#.w|bourbon\svc.wsscachesu-pre"
$wa.Properties["portalsuperreaderaccount"] = "i:0#.w|bourbon\svc.wsscachesr-pre"
$wa.Update()



$wa = Get-SPWebApplication -Identity "https://perso-intranet-pre.bourbon-online.com"
$wa.Properties["portalsuperuseraccount"]="i:0#.w|bourbon\svc.wsscachesu-pre"
$wa.Properties["portalsuperreaderaccount"] = "i:0#.w|bourbon\svc.wsscachesr-pre"
$wa.Update()

$wa = Get-SPWebApplication -Identity "https://myb-perso.bourbon-online.com"
$wa.Properties["portalsuperuseraccount"]="i:0#.w|bourbon\svc.wsscachesu-pre"
$wa.Properties["portalsuperreaderaccount"] = "i:0#.w|bourbon\svc.wsscachesr-pre"
$wa.Update()