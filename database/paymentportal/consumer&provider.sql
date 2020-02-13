
select * from consumer where name ='1788'
select * from consumer_configuration 

--consumer and configuration
select c.id,c.description,c.name,c.url,c.default_consumer_configuration_id,cc.id,cc.description,cc.enabled,cc.consumer_id
from consumer c inner join consumer_configuration cc on c.id=cc.consumer_id
where c.description='1788'
order by c.url

--consumer & provider config value
select * from consumer_configuration_payment_provider_option_value
where config_id='a006fa08-ae01-4dcd-910b-b5049c34f2c6'

select * from payment_provider_option_value 
where id in (
	select value_id from consumer_configuration_payment_provider_option_value
	where config_id='a006fa08-ae01-4dcd-910b-b5049c34f2c6'
)

select * from payment_provider_option 
where id in(
	select option_id from payment_provider_option_value 
	where id in (
		select value_id from consumer_configuration_payment_provider_option_value
		where config_id='a006fa08-ae01-4dcd-910b-b5049c34f2c6'
	)
)

select * from payment_provider


--get consumer and provider relationship by provider
select c.id consumer_id,c.name,c.url
,cc.id consumer_config_id,cc.enabled
,pov.id value_id,pov.value
,po.id option_id,po.name option_name
,p.id provider_Id,p.end_point provider_end_point,p.name provider_name
from consumer c 
inner join consumer_configuration cc on cc.consumer_id=c.id
inner join consumer_configuration_payment_provider_option_value ccp on ccp.config_id = cc.id
inner join payment_provider_option_value pov on pov.id=ccp.value_id
inner join payment_provider_option po on po.id=pov.option_id
inner join payment_provider p on p.id=po.payment_provider_id
--where c.id  = '6bc2768a-a689-4c26-b309-972570a506e5'
where p.name='GlobalPaymentsUSA'
order by p.name

--get consumer and provider relationship by consumer
select *
,cc.id consumer_config_id
,pov.id value_id,pov.value
,po.id option_id,po.name option_name
,p.id provider_Id,p.end_point provider_end_point,p.name provider_name
from consumer c 
inner join consumer_configuration cc on cc.consumer_id=c.id
inner join consumer_configuration_payment_provider_option_value ccp on ccp.config_id = cc.id
inner join payment_provider_option_value pov on pov.id=ccp.value_id
inner join payment_provider_option po on po.id=pov.option_id
inner join payment_provider p on p.id=po.payment_provider_id
where c.description='1788'
order by consumer_id
