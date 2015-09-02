--Connect on MRSSPI03, open sharepoint powershell and disconnect the actual database:
Dismount-SPContentDatabase -Identity BB2013_Int_Intranet_Content

--Remove database from always on connecting on MRSSPI10 (primary replicate)
ALTER AVAILABILITY GROUP AGSharePoint REMOVE DATABASE BB2013_Int_Intranet_Content;

--On both nodes : MRSSPI11 and MRSSPI10 This will remove the backup history
EXEC msdb.dbo.sp_delete_database_backuphistory @database_name = N'BB2013_Int_Intranet_Content'
GO
USE [master]
GO
--This will drop all the open connections
ALTER DATABASE [BB2013_Int_Intranet_Content] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
USE [master]
GO
--This will remove  database
DROP DATABASE [BB2013_Int_Intranet_Content]
GO


--Copy a .bak from PROD to Integration on T:\ on primary replicate MRSSPI10
--Restore database
RESTORE DATABASE [BB2013_Int_Publishing_Content] 
FROM DISK = 'T:\BB2013_Prod_Publishing_Content.bak' WITH  FILE = 1,  NOUNLOAD,  STATS = 10,
MOVE N'BB2013_Prod_Publishing_Content' To 'S:\spi-data\MSSQL11.SPI\MSSQL\DATA\BB2013_Int_Publishing_Content.mdf',
MOVE N'BB2013_Prod_Publishing_Content_log' To 'S:\spi-log\MSSQL11.SPI\MSSQL\Data\BB2013_Int_Publishing_Content_log.LDF'
GO

--Delete all user except dbo and sys on this database.
--Sometimes you can't delete a user because he is a owner of schema or role. See next point
USE BB2013_Int_Publishing_Content
CREATE USER [bbint\svc.wssapp-int] FOR LOGIN [bbint\svc.wssapp-int] WITH DEFAULT_SCHEMA=[bbint\svc.wssapp-int]
GO
ALTER ROLE [SPDataAccess] ADD MEMBER [bbint\svc.wssapp-int]

CREATE USER [bbint\svc.wssfarm-int] FOR LOGIN [bbint\svc.wssfarm-int] WITH DEFAULT_SCHEMA=[bbint\svc.wssfarm-int]
GO
ALTER ROLE [Db_owner] ADD MEMBER [bbint\svc.wssfarm-int]
ALTER ROLE [SPDataAccess] ADD MEMBER [bbint\svc.wssfarm-int]

CREATE USER [bbint\svc.wssweb-int] FOR LOGIN [bbint\svc.wssweb-int] WITH DEFAULT_SCHEMA=[bbint\svc.wssweb-int]
GO
ALTER ROLE [SPDataAccess] ADD MEMBER [bbint\svc.wssweb-int] 


-- Query to get the user associated Database Role . Result you will see where this user is in use.
select DBPrincipal_2.name as role, DBPrincipal_1.name as owner 
from sys.database_principals as DBPrincipal_1 inner join sys.database_principals as DBPrincipal_2 
on DBPrincipal_1.principal_id = DBPrincipal_2.owning_principal_id 
where DBPrincipal_1.name = 'bourbon\svc.wssfarm-prod'

--Query to fix to change the owner
USE [BB2013_Int_Publishing_Content]
GO
ALTER AUTHORIZATION ON ROLE::[SharePoint_Shell_Access] TO [dbo]
GO

--Delete user bourbon\svc.wssfarm-prod


--change dbo
Use BB2013_Int_Publishing_Content
go
EXEC sp_changedbowner 'bbint\svc.wssadmin-int'

--add database to always on with GUI connecting on primary replicate


--Connect on MRSSPI03, open sharepoint powershell

Mount-SPContentDatabase BB2013_Int_Publishing_Content –WebApplication https://intranet-int.bourbon-online.com


--In central admin change first and second site collection administrators


