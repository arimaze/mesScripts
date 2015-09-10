Dismount-SPContentDatabase -Identity BB2013_PreProd_Publishing_Content


RESTORE DATABASE [BB2013_PreProd_Publishing_Content] 
FROm disk = 't:\BB2013_Prod_Publishing_Content.bak' WITH FILE = 1,  NOUNLOAD, STATS = 10,
MOVE N'BB2013_Prod_Publishing_Content' To 'S:\data\MSSQL11.SPPP\MSSQL\DATA\BB2013_PreProd_Publishing_Content.mdf',
MOVE N'BB2013_Prod_Publishing_Content_log' To 'S:\log\MSSQL11.SPPP\MSSQL\Data\BB2013_PreProd_Publishing_Content_log.LDF'
GO

RESTORE DATABASE [BB2013_PreProd_Portal_Content] 
FROm disk = 't:\BB2013_Prod_Portal_Content.bak' WITH FILE = 1,  NOUNLOAD, STATS = 10,
MOVE N'Portal_Content' To 'S:\data\MSSQL11.SPPP\MSSQL\DATA\BB2013_PreProd_Portal_Content.mdf',
MOVE N'Portal_Content_log' To 'S:\log\MSSQL11.SPPP\MSSQL\Data\BB2013_PreProd_Portal_Content_log.LDF'
GO

CREATE USER [BOURBON\svc.wssapp-pre] FOR LOGIN [BOURBON\svc.wssapp-pre] WITH DEFAULT_SCHEMA=[BOURBON\svc.wssapp-pre]
GO
ALTER ROLE [SPDataAccess] ADD MEMBER [BOURBON\svc.wssapp-pre]

CREATE USER [BOURBON\svc.wssfarm-pre] FOR LOGIN [BOURBON\svc.wssfarm-pre] WITH DEFAULT_SCHEMA=[BOURBON\svc.wssfarm-pre]
GO
ALTER ROLE [Db_owner] ADD MEMBER [BOURBON\svc.wssfarm-pre]
ALTER ROLE [SPDataAccess] ADD MEMBER [BOURBON\svc.wssfarm-pre]

CREATE USER [BOURBON\svc.wssweb-pre] FOR LOGIN [BOURBON\svc.wssweb-pre] WITH DEFAULT_SCHEMA=[BOURBON\svc.wssweb-pre]
GO
ALTER ROLE [SPDataAccess] ADD MEMBER [BOURBON\svc.wssweb-pre] 




Mount-SPContentDatabase BB2013_PreProd_Publishing_Content –WebApplication https://intranet-pre.bourbon-online.com
Test-SPContentDatabase -Name BB2013_PreProd_Publishing_Content –WebApplication https://intranet-pre.bourbon-online.com
Get-SPContentDatabase | Add-SPShellAdmin bourbon\svc.bippfront