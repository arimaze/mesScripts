#
# Select_Log_Reuse_Wait.ps1
#
select name, log_reuse_wait_desc from sys.databases where name = 'BB2013_PreProd_Portal_Content'
select name, log_reuse_wait_desc from sys.databases where name = 'BB2013_PreProd_Publish_Content'




USE BB2013_PreProd_Portal_Content
GO
DBCC Loginfo