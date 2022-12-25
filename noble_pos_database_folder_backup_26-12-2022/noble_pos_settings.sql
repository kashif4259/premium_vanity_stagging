-- MySQL dump 10.13  Distrib 8.0.31, for Linux (x86_64)
--
-- Host: localhost    Database: noble_pos
-- ------------------------------------------------------
-- Server version	8.0.31-0ubuntu0.20.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `settings` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `setting_name` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `setting_value` mediumtext COLLATE utf8mb3_unicode_ci NOT NULL,
  `setting_type` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `user_id` int DEFAULT NULL,
  `created_by` int NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES (1,'time_format','12h','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(2,'date_format','Y-m-d','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(3,'currency_symbol','$','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(4,'currency_format','left','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(5,'thousand_separator',',','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(6,'language_setting','english','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(7,'decimal_separator','.','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(8,'number_of_decimal','2','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(9,'offday_setting','','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(10,'email_from_name','Kashif Asghar','',NULL,0,'0000-00-00 00:00:00','2022-12-17 16:13:16'),(11,'email_from_address','passionhill123@gmail.com','',NULL,0,'0000-00-00 00:00:00','2022-12-17 16:13:17'),(12,'email_driver','mailgun','',NULL,0,'0000-00-00 00:00:00','2022-12-17 16:13:18'),(13,'email_smtp_host','smtp.gmail.com','',NULL,0,'0000-00-00 00:00:00','2022-12-17 16:13:18'),(14,'email_port','465','',NULL,0,'0000-00-00 00:00:00','2022-12-17 16:13:18'),(15,'email_smtp_password','4705575123!@#abc','',NULL,0,'0000-00-00 00:00:00','2022-12-17 16:13:18'),(16,'email_encryption_type','tls','',NULL,0,'0000-00-00 00:00:00','2022-12-17 16:13:18'),(17,'mandrill_api','eca3d6f482fec8d7fb77d488651a68f4-us21','',NULL,0,'0000-00-00 00:00:00','2022-12-17 16:13:20'),(18,'sparkpost_api','','',NULL,0,'0000-00-00 00:00:00','2022-12-17 16:13:20'),(19,'mailgun_domain','sandbox0e71c30081634b118970a5ba55a80106.mailgun.org','',NULL,0,'0000-00-00 00:00:00','2022-12-17 16:13:18'),(20,'mailgun_api','bd9cdb3ce724d9de16d7f89c58f3e636-48d7d97c-2aeb4934','',NULL,0,'0000-00-00 00:00:00','2022-12-17 16:13:19'),(21,'max_row_per_table','10','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(22,'app_name','Noble POS','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(23,'app_logo','default-logo.png','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(24,'currency_code','usd','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(25,'can_signup','1','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(26,'can_login','1','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(27,'invoice_prefix','NS','',NULL,0,'0000-00-00 00:00:00','2022-12-04 16:02:05'),(28,'invoice_suffix','','',NULL,0,'0000-00-00 00:00:00','2022-12-04 16:02:05'),(29,'last_invoice_number','31','',NULL,0,'0000-00-00 00:00:00','2022-12-17 17:27:17'),(30,'auto_generate_invoice','0','',NULL,0,'0000-00-00 00:00:00','2022-12-04 16:02:05'),(31,'auto_email_receive','0','',NULL,0,'0000-00-00 00:00:00','2022-12-04 16:02:06'),(32,'invoice_starts_from','1','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(33,'invoiceLogo','default-logo.png','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(34,'purchase_invoice_prefix','','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(35,'purchase_invoice_suffix','','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(36,'purchase_last_invoice_number','5','',NULL,0,'0000-00-00 00:00:00','2022-11-21 19:40:59'),(37,'purchase_auto_generate_invoice','0','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(38,'purchase_invoice_starts_from','1','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(39,'purchase_invoiceLogo','default-logo.png','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(40,'re_order','10','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(41,'sku_prefix','','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(42,'sales_return_status','sales','',NULL,0,'0000-00-00 00:00:00','2022-12-22 14:06:05'),(43,'purchase_return_status','purchase','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(44,'offline_mode','0','',NULL,0,'0000-00-00 00:00:00','2022-12-22 14:28:57'),(45,'time_zone','UTC','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(46,'notification_time','2019-12-25T04:00:00.641Z','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(47,'low_stock_notification','0','',NULL,0,'0000-00-00 00:00:00','2022-12-17 19:09:47'),(48,'out_of_stock_products','1','',NULL,0,'0000-00-00 00:00:00','2022-12-22 14:28:57'),(49,'sales_list_delete_option','1','',NULL,0,'0000-00-00 00:00:00','2022-12-22 14:28:57'),(50,'sms_recive_to_customer','0','',NULL,0,'0000-00-00 00:00:00','2022-12-22 14:28:58'),(51,'new_customer_welcome_sms','0','',NULL,0,'0000-00-00 00:00:00','2022-12-22 14:28:58'),(52,'sms_from_name_phone_number','','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(53,'sms_driver','','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(54,'key','','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(55,'secret_key','','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(56,'sales_list_edit_option','1','',NULL,0,'0000-00-00 00:00:00','2022-12-22 14:28:57'),(57,'purchase_code','test','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(58,'current_branch','1','user',1,0,'2022-11-16 17:09:18','2022-11-16 17:09:18'),(59,'sales_type','customer','',1,0,'0000-00-00 00:00:00','2022-12-22 14:06:11');
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-12-26  1:50:59
