#
# Restore_Back_Hub_To_PreProd.ps1
#
RESTORE DATABASE [BB2013_PreProd_Publish_Content] 
FROM DISK = 'S:\data\SQLInitialDataSynchronisationSPPP\BB2013_Prod_Publish_Content_backup_2015_10_27_001504_0008144.bak' WITH  FILE = 1,  NOUNLOAD,  STATS = 10,
MOVE N'BB2013_Prod_Publish_Content' To 'S:\data\MSSQL11.SPPP\MSSQL\DATA\BB2013_PreProd_Publish_Content.mdf',
MOVE N'BB2013_Prod_Publish_Content_log' To 'S:\log\MSSQL11.SPPP\MSSQL\Data\BB2013_PreProd_Publish_Content_log.LDF'
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

--change dbo

EXEC sp_changedbowner 'bourbon\svc.wssadmin-pre'