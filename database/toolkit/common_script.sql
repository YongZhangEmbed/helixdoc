--Exception: Application does not exist or is deleted
SELECT * FROM Applications 
WHERE Deleted = 0 
and Location_Id =(SELECT TOP 1 Location_Id FROM Locations WHERE Location_Is_Here = 1)

select * from locations where Location_Is_Here=1
--update locations set   Location_Is_Here=0 where Location_Id=10464


select * from Cards where Card_Barcode in('9900738890')
--update Cards set Cash_Balance=0,Bonus_Balance=0,Cumulative_Balance=0,Running_Cumulative_Balance=0 where Card_Barcode in('9900738890')

select * from cloud_cards


select * from System_Properties where descriptor like '%Global Cards%'
--delete from System_Properties where descriptor like '%Global Cards Type%'

select * from Cloud_Notifications where Received_At>'2020-02-10T03:10:18Z' order by Received_At desc
--update Cloud_Notifications set  processed=0 where sequence in (16432)

select * from Guest_Balance_Uploads



