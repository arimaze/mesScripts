cd "C:\Distrib\CV-CM"
.\DeploySolutionCrewMatrixCV.ps1

disable-SPFeature -identity "MyBourbon.SharePoint.CrewMatrixCV_SynchroDocsComponents" -URL https://intranet-int.bourbon-online.com
disable-SPFeature -identity "MyBourbon.SharePoint.CrewMatrixCV_SynchroDocsListInstance" -URL https://intranet-int.bourbon-online.com

Enable-SPFeature -identity "MyBourbon.SharePoint.CrewMatrixCV_SynchroDocsComponents" -URL https://intranet-int.bourbon-online.com
Enable-SPFeature -identity "MyBourbon.SharePoint.CrewMatrixCV_SynchroDocsListInstance" -URL https://intranet-int.bourbon-online.com
