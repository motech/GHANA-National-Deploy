update scheduler_task_config_property set task_config_id = null;
DELETE FROM scheduler_task_config;
update users set password = '731f205148c4d16aa4ada1e74544ddc27aac0f10226a330a25224f0f9dd16d1048a80ab8beecff6b03e088b3342070b01bb21fa3ec96dd77b90b3d2c7c1d1538',
 salt = '44057890d359ee9307fec4ebf797d493bb68fc0401543cd583272c239ceb8637087e001e735b97ead7dd793e6139d92cdbac47605a7b0db9672c501f096258b3'  where system_id='admin';
update patient_identifier_type set validator = 'org.motechproject.openmrs.omod.validator.MotechIdVerhoeffValidator' where name like 'MoTeCH Id%';
update patient_identifier_type set validator = 'org.motechproject.openmrs.omod.validator.VerhoeffValidator' where name like 'MoTeCH Staff Id%';
update patient_identifier_type set validator = 'org.motechproject.openmrs.omod.validator.VerhoeffValidator' where name like 'MoTeCH Facility Id%';
update patient_identifier_type set validator = 'org.motechproject.openmrs.omod.validator.VerhoeffValidator' where name like 'MoTeCH Community Id%';
