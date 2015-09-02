Dismount-SPContentDatabase -Identity BB2013_PreProd_MyBourbon_Content

RESTORE DATABASE [test2] 
FROM DISK = '‪C:\Users\svc.wssadmin-pre\Desktop\BB2013_PreProd_MyBourbon_Content_backup_2015_05_21_001510_2864272.bak' WITH FILE = 1, NOUNLOAD, STATS = 10,
MOVE N'BB2013_PreProd_MyBourbon_Content' To 'S:\data\MSSQL11.SPPP\MSSQL\DATA\test2.mdf',
MOVE N'BB2013_PreProd_MyBourbon_Content_log' To 'S:\log\MSSQL11.SPPP\MSSQL\Data\test2_log.LDF'
GO

Mount-SPContentDatabase BB2013_PreProd_MyBourbon_Content –WebApplication https://myb.bourbon-online.com