-- MySQL dump 10.11
--
-- Host: localhost    Database: openmrs
-- ------------------------------------------------------
-- Server version	5.0.77

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `report_object`
--

DROP TABLE IF EXISTS `report_object`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `report_object` (
  `report_object_id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `description` varchar(1000) default NULL,
  `report_object_type` varchar(255) NOT NULL,
  `report_object_sub_type` varchar(255) NOT NULL,
  `xml_data` text,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) default NULL,
  `date_changed` datetime default NULL,
  `voided` smallint(6) NOT NULL default '0',
  `voided_by` int(11) default NULL,
  `date_voided` datetime default NULL,
  `void_reason` varchar(255) default NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY  (`report_object_id`),
  UNIQUE KEY `report_object_uuid_index` (`uuid`),
  KEY `user_who_changed_report_object` (`changed_by`),
  KEY `report_object_creator` (`creator`),
  KEY `user_who_voided_report_object` (`voided_by`),
  CONSTRAINT `report_object_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_changed_report_object` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_voided_report_object` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `report_object`
--

LOCK TABLES `report_object` WRITE;
/*!40000 ALTER TABLE `report_object` DISABLE KEYS */;
INSERT INTO `report_object` VALUES (1,'Child Health Return','','Report Definition','Report Definition','<?xml version=\"1.0\" encoding=\"UTF-8\"?> \n<java version=\"1.6.0_20\" class=\"java.beans.XMLDecoder\"> \n <object class=\"org.openmrs.reporting.report.ReportDefinition\"> \n  <void property=\"dataExport\"> \n   <null/> \n  </void> \n  <void property=\"description\"> \n   <string></string> \n  </void> \n  <void property=\"id\"> \n   <int>1</int> \n  </void> \n  <void property=\"name\"> \n   <string>Child Health Return</string> \n  </void> \n  <void property=\"uuid\"> \n   <string>cd4037c6-15f6-417a-b147-8d7ecaef330b</string> \n  </void> \n </object> \n</java> \n',1,'2011-01-03 23:34:57',5785,'2011-08-05 17:02:09',0,NULL,NULL,NULL,'cd4037c6-15f6-417a-b147-8d7ecaef330b'),(2,'Communicable Disease Surveillance','','Report Definition','Report Definition','<?xml version=\"1.0\" encoding=\"UTF-8\"?> \n<java version=\"1.6.0_20\" class=\"java.beans.XMLDecoder\"> \n <object class=\"org.openmrs.reporting.report.ReportDefinition\"> \n  <void property=\"dataExport\"> \n   <null/> \n  </void> \n  <void property=\"description\"> \n   <string></string> \n  </void> \n  <void property=\"id\"> \n   <int>2</int> \n  </void> \n  <void property=\"name\"> \n   <string>Communicable Disease Surveillance</string> \n  </void> \n  <void property=\"uuid\"> \n   <string>380bb0c4-3538-4371-855e-47ba82c847e6</string> \n  </void> \n </object> \n</java> \n',1,'2011-01-04 00:38:26',5785,'2011-08-05 17:03:27',0,NULL,NULL,NULL,'380bb0c4-3538-4371-855e-47ba82c847e6'),(3,'Immunization Returns','','Report Definition','Report Definition','<?xml version=\"1.0\" encoding=\"UTF-8\"?> \n<java version=\"1.6.0_20\" class=\"java.beans.XMLDecoder\"> \n <object class=\"org.openmrs.reporting.report.ReportDefinition\"> \n  <void property=\"dataExport\"> \n   <null/> \n  </void> \n  <void property=\"description\"> \n   <string></string> \n  </void> \n  <void property=\"id\"> \n   <int>3</int> \n  </void> \n  <void property=\"name\"> \n   <string>Immunization Returns</string> \n  </void> \n  <void property=\"uuid\"> \n   <string>4209d574-246e-45d7-8011-5f7043aaf847</string> \n  </void> \n </object> \n</java> \n',1,'2011-01-04 00:39:15',5785,'2011-11-18 19:29:32',0,NULL,NULL,NULL,'4209d574-246e-45d7-8011-5f7043aaf847'),(4,'Malaria','','Report Definition','Report Definition','<?xml version=\"1.0\" encoding=\"UTF-8\"?> \n<java version=\"1.6.0_20\" class=\"java.beans.XMLDecoder\"> \n <object class=\"org.openmrs.reporting.report.ReportDefinition\"> \n  <void property=\"dataExport\"> \n   <null/> \n  </void> \n  <void property=\"description\"> \n   <string></string> \n  </void> \n  <void property=\"id\"> \n   <int>4</int> \n  </void> \n  <void property=\"name\"> \n   <string>Malaria</string> \n  </void> \n  <void property=\"uuid\"> \n   <string>3b133299-a19e-4909-a811-e7f73ca9b8ca</string> \n  </void> \n </object> \n</java> \n',1,'2011-01-04 00:39:28',5785,'2011-08-05 17:07:14',0,NULL,NULL,NULL,'3b133299-a19e-4909-a811-e7f73ca9b8ca'),(5,'Mid-Wife','','Report Definition','Report Definition','<?xml version=\"1.0\" encoding=\"UTF-8\"?> \n<java version=\"1.6.0_20\" class=\"java.beans.XMLDecoder\"> \n <object class=\"org.openmrs.reporting.report.ReportDefinition\"> \n  <void property=\"dataExport\"> \n   <null/> \n  </void> \n  <void property=\"description\"> \n   <string></string> \n  </void> \n  <void property=\"id\"> \n   <int>5</int> \n  </void> \n  <void property=\"name\"> \n   <string>Mid-Wife</string> \n  </void> \n  <void property=\"uuid\"> \n   <string>c171ba4c-056f-444c-b106-404ad3925b4c</string> \n  </void> \n </object> \n</java> \n',1,'2011-01-04 00:39:42',5785,'2011-08-05 17:08:49',0,NULL,NULL,NULL,'c171ba4c-056f-444c-b106-404ad3925b4c'),(6,'OPD Morbidity','','Report Definition','Report Definition','<?xml version=\"1.0\" encoding=\"UTF-8\"?> \n<java version=\"1.6.0_20\" class=\"java.beans.XMLDecoder\"> \n <object class=\"org.openmrs.reporting.report.ReportDefinition\"> \n  <void property=\"dataExport\"> \n   <null/> \n  </void> \n  <void property=\"description\"> \n   <string></string> \n  </void> \n  <void property=\"id\"> \n   <int>6</int> \n  </void> \n  <void property=\"name\"> \n   <string>OPD Morbidity</string> \n  </void> \n  <void property=\"uuid\"> \n   <string>6fc7fc10-5a2a-4100-bc48-bde71db6a250</string> \n  </void> \n </object> \n</java> \n',1,'2011-01-04 00:39:55',5785,'2011-08-05 17:10:24',0,NULL,NULL,NULL,'6fc7fc10-5a2a-4100-bc48-bde71db6a250'),(7,'OPD Statement','','Report Definition','Report Definition','<?xml version=\"1.0\" encoding=\"UTF-8\"?> \n<java version=\"1.6.0_20\" class=\"java.beans.XMLDecoder\"> \n <object class=\"org.openmrs.reporting.report.ReportDefinition\"> \n  <void property=\"dataExport\"> \n   <null/> \n  </void> \n  <void property=\"description\"> \n   <string></string> \n  </void> \n  <void property=\"id\"> \n   <int>7</int> \n  </void> \n  <void property=\"name\"> \n   <string>OPD Statement</string> \n  </void> \n  <void property=\"uuid\"> \n   <string>c4db600b-87d1-478a-9f83-16be75ec0f0f</string> \n  </void> \n </object> \n</java> \n',1,'2011-01-04 00:40:09',5785,'2011-09-20 18:29:30',0,NULL,NULL,NULL,'c4db600b-87d1-478a-9f83-16be75ec0f0f');
/*!40000 ALTER TABLE `report_object` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-06-15  9:07:17
