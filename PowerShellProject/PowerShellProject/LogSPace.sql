declare @LogSpace table

(

DB varchar(255),

LogSizeMB int,

PercentUsed float,

Status int

);

 

insert into @LogSpace

execute('DBCC SqlPerf(logspace)');

 

SELECT *

FROM @LogSpace
Azer 
ORDER By LogSizeMB desc;