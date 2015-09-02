Param (
  [Parameter(Mandatory=$True, Position=0)]
  [string]$LogFilePath,
 
  [Parameter(Mandatory=$True, Position=1)]
  [string]$SiteUrl,
 
  [Parameter(Mandatory=$True, Position=2)]
  [string[]]$exclusionSitesTitles
)
 
[System.Reflection.Assembly]::LoadWithPartialName(&amp;quot;Microsoft.SharePoint&amp;quot;)
$site = New-Object Microsoft.SharePoint.SPSite($siteUrl)
$webs = $site.AllWebs | ?{-not ($exclusionSitesTitles -contains $_.Title)}
 
function checkPermissions([Microsoft.SharePoint.SPRoleAssignmentCollection]$roles)
{
    $roles | Out-File -Append -FilePath $logfilepath
    $roles | %{
        if($_.RoleDefinitionBindings.Count -eq 1 -and $_.RoleDefinitionBindings.Contains($guestPermission))
        {
            $_.RoleDefinitionBindings.RemoveAll();
        }
        else
        {
            $_.RoleDefinitionBindings.RemoveAll();
            $_.RoleDefinitionBindings.Add($readPermission);
        }
        $_.Update();
    }
}
 
function checkLists($web)
{
    $web.Lists | %{
        if($_.HasUniqueRoleAssignments)
        {
            checkPermissions($_.RoleAssignments)
        }
    }
}
 
$webs | %{
    $readPermission = $_.RoleDefinitions.GetByType([Microsoft.SharePoint.SPRoleType]::Reader);
    $guestPermission = $_.RoleDefinitions.GetByType([Microsoft.SharePoint.SPRoleType]::Guest);
    $_.Url | Out-File -Append -FilePath $logfilepath
    if($_.HasUniqueRoleAssignments)
    {
        checkPermissions($_.RoleAssignments)
    }
    checkLists($_)
    $_.Dispose();
}
$site.Dispose();
