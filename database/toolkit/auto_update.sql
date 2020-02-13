
select * from Software_Update_Status order by Update_Status

select * from AutoUpdate_Projects 
where channel='eap'
 order by channel,installed_version
 --update AutoUpdate_Projects set setup_file_hash ='' where name='ECS7 Embed API' and channel='eap'
 --delete from AutoUpdate_Projects 

select * from System_Properties  where descriptor like '%AutoUpdate Api Url%' --https://autoupdate-api.helix-playground.net 
--update System_Properties set value='https://autoupdate-api.helix-playground.net'  where descriptor like '%AutoUpdate Api Url%'


--SELECT Type = Software_Name, ApplicationId = Application_ID,
--    Version = Software_Ver, Id = SWV_Id, LastVerified = Last_Verified
SELECT Application_ID,Software_Name
    FROM Software_Versions ver
    WHERE Location_Id = 10464
    AND Last_Verified >= '1900-01-01 00:00:00'
	 and Software_Ver not like '%v6%'
    AND NOT EXISTS (SELECT 1 FROM Applications app
            WHERE app.Application_Id = ver.Application_Id AND app.Deleted = 1
                  AND app.Application_Id <> -1 AND app.Location_Id = 10464)
group by Application_ID,Software_Name
order by Software_Name

SELECT *
    FROM Software_Versions ver
    WHERE Location_Id = 10464
    AND Last_Verified >= '1900-01-01 00:00:00'
	 and Software_Ver not like '%v6%'
    AND NOT EXISTS (SELECT 1 FROM Applications app
            WHERE app.Application_Id = ver.Application_Id AND app.Deleted = 1
                  AND app.Application_Id <> -1 AND app.Location_Id = 10464)
order by Software_Name,last_verified desc
				 

select * from Software_Versions
where Software_Name like '%Kiosk%'
order by Software_Name,last_verified desc

select * from Software_Versions where swv_id=328
--update Software_Versions set Last_Verified='2019-06-30' where swv_id=328
