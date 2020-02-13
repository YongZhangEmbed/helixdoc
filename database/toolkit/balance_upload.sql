
select distinct DATEDIFF(DAY, Sent_At, GETDATE()) DateDiffOfSent_At from Guest_Balance_Uploads 
select count(*) 'less than 1 month' from Guest_Balance_Uploads where DATEDIFF(DAY, Sent_At, GETDATE())<=30
select count(*) 'great than 1 month' from Guest_Balance_Uploads where DATEDIFF(DAY, Sent_At, GETDATE())>30
--select card_prefix,count(*) from Guest_Balance_Uploads where DATEDIFF(DAY, Sent_At, GETDATE())<=30 group by card_prefix


select Card_Prefix,count(*) from Guest_Balance_Uploads group by Card_Prefix
select * from Guest_Balance_Uploads where Card_Prefix <120 or Card_Prefix>126
select count(*) from Guest_Balance_Uploads with(nolock)
select count(*) from Guest_Balance_Uploads where Sent_At='2019-05-10 13:54:00.000'
--update Guest_Balance_Uploads set Sent_At='2019-06-01 13:54:00.000' where Card_Prefix =147
select * from  Guest_Balance_Uploads where id ='C98867DB-F42B-480D-89CB-001D68226C78'
