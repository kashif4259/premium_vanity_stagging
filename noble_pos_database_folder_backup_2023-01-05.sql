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
-- Table structure for table `adjust_product_stock_types`
--

DROP TABLE IF EXISTS `adjust_product_stock_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adjust_product_stock_types` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `created_by` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adjust_product_stock_types`
--

LOCK TABLES `adjust_product_stock_types` WRITE;
/*!40000 ALTER TABLE `adjust_product_stock_types` DISABLE KEYS */;
INSERT INTO `adjust_product_stock_types` VALUES (1,'Damaged Product',1,'2022-11-16 17:09:07',NULL);
/*!40000 ALTER TABLE `adjust_product_stock_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `branches`
--

DROP TABLE IF EXISTS `branches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `branches` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `branch_type` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `taxable` tinyint NOT NULL,
  `is_default` tinyint NOT NULL DEFAULT '0',
  `tax_id` int NOT NULL DEFAULT '0',
  `is_cash_register` tinyint NOT NULL,
  `is_shipment` tinyint NOT NULL,
  `user_id` int NOT NULL,
  `created_by` int NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branches`
--

LOCK TABLES `branches` WRITE;
/*!40000 ALTER TABLE `branches` DISABLE KEYS */;
INSERT INTO `branches` VALUES (1,'Main Branch','retail',1,1,1,1,0,1,1,'2022-11-16 17:09:00','2023-01-03 21:26:46');
/*!40000 ALTER TABLE `branches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cash_register_logs`
--

DROP TABLE IF EXISTS `cash_register_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cash_register_logs` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `cash_register_id` int NOT NULL,
  `opening_amount` double DEFAULT NULL,
  `closing_amount` double DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `opening_time` datetime DEFAULT NULL,
  `closing_time` datetime DEFAULT NULL,
  `opened_by` int DEFAULT NULL,
  `closed_by` int DEFAULT NULL,
  `note` text COLLATE utf8mb3_unicode_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cash_register_logs`
--

LOCK TABLES `cash_register_logs` WRITE;
/*!40000 ALTER TABLE `cash_register_logs` DISABLE KEYS */;
INSERT INTO `cash_register_logs` VALUES (2,'1',1,0,NULL,'open','2022-11-16 22:37:00',NULL,1,NULL,NULL,'2022-11-16 17:37:03','2022-11-16 17:37:03');
/*!40000 ALTER TABLE `cash_register_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cash_registers`
--

DROP TABLE IF EXISTS `cash_registers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cash_registers` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `branch_id` int NOT NULL,
  `sales_invoice_id` int NOT NULL,
  `receiving_invoice_id` int NOT NULL,
  `created_by` int NOT NULL,
  `multiple_access` tinyint NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cash_registers`
--

LOCK TABLES `cash_registers` WRITE;
/*!40000 ALTER TABLE `cash_registers` DISABLE KEYS */;
INSERT INTO `cash_registers` VALUES (1,'Main Cash Register',1,1,2,1,0,'2022-11-16 17:09:03',NULL);
/*!40000 ALTER TABLE `cash_registers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `corn_job_logs`
--

DROP TABLE IF EXISTS `corn_job_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `corn_job_logs` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` int NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corn_job_logs`
--

LOCK TABLES `corn_job_logs` WRITE;
/*!40000 ALTER TABLE `corn_job_logs` DISABLE KEYS */;
INSERT INTO `corn_job_logs` VALUES (1,0,'2022-12-17 03:58:23','2022-12-17 03:58:23'),(2,0,'2022-12-17 04:01:00','2022-12-17 04:01:00'),(3,1,'2022-12-17 04:01:01','2022-12-17 04:01:01'),(4,0,'2022-12-17 04:02:16','2022-12-17 04:02:16'),(5,1,'2022-12-17 04:02:17','2022-12-17 04:02:17'),(6,0,'2022-12-17 04:06:46','2022-12-17 04:06:46'),(7,1,'2022-12-17 04:06:47','2022-12-17 04:06:47'),(8,0,'2022-12-17 04:10:11','2022-12-17 04:10:11'),(9,1,'2022-12-17 04:10:13','2022-12-17 04:10:13'),(10,0,'2022-12-17 04:11:45','2022-12-17 04:11:45'),(11,1,'2022-12-17 04:11:46','2022-12-17 04:11:46'),(12,0,'2022-12-17 04:15:02','2022-12-17 04:15:02'),(13,1,'2022-12-17 04:15:02','2022-12-17 04:15:02'),(14,0,'2022-12-17 04:15:33','2022-12-17 04:15:33'),(15,1,'2022-12-17 04:15:34','2022-12-17 04:15:34'),(16,0,'2022-12-17 04:17:45','2022-12-17 04:17:45'),(17,1,'2022-12-17 04:17:48','2022-12-17 04:17:48'),(18,0,'2022-12-17 04:18:01','2022-12-17 04:18:01'),(19,1,'2022-12-17 04:18:01','2022-12-17 04:18:01'),(20,0,'2022-12-17 04:18:50','2022-12-17 04:18:50'),(21,1,'2022-12-17 04:18:50','2022-12-17 04:18:50'),(22,0,'2022-12-17 04:20:41','2022-12-17 04:20:41'),(23,1,'2022-12-17 04:20:41','2022-12-17 04:20:41'),(24,0,'2022-12-17 04:24:30','2022-12-17 04:24:30'),(25,1,'2022-12-17 04:24:32','2022-12-17 04:24:32'),(26,0,'2022-12-17 04:25:21','2022-12-17 04:25:21'),(27,1,'2022-12-17 04:25:22','2022-12-17 04:25:22'),(28,0,'2022-12-17 04:25:50','2022-12-17 04:25:50'),(29,1,'2022-12-17 04:25:51','2022-12-17 04:25:51'),(30,0,'2022-12-17 04:30:19','2022-12-17 04:30:19'),(31,1,'2022-12-17 04:30:19','2022-12-17 04:30:19'),(32,0,'2022-12-17 05:06:34','2022-12-17 05:06:34'),(33,1,'2022-12-17 05:06:35','2022-12-17 05:06:35'),(34,0,'2022-12-17 05:07:59','2022-12-17 05:07:59'),(35,1,'2022-12-17 05:08:01','2022-12-17 05:08:01'),(36,0,'2022-12-17 05:08:33','2022-12-17 05:08:33'),(37,1,'2022-12-17 05:08:33','2022-12-17 05:08:33'),(38,0,'2022-12-17 05:13:04','2022-12-17 05:13:04'),(39,1,'2022-12-17 05:13:04','2022-12-17 05:13:04'),(40,0,'2022-12-17 05:13:59','2022-12-17 05:13:59'),(41,1,'2022-12-17 05:13:59','2022-12-17 05:13:59'),(42,0,'2022-12-17 05:16:37','2022-12-17 05:16:37'),(43,1,'2022-12-17 05:16:37','2022-12-17 05:16:37'),(44,0,'2022-12-17 05:19:15','2022-12-17 05:19:15'),(45,1,'2022-12-17 05:19:15','2022-12-17 05:19:15');
/*!40000 ALTER TABLE `corn_job_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_groups`
--

DROP TABLE IF EXISTS `customer_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_groups` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `discount` double(8,2) NOT NULL,
  `is_default` int NOT NULL,
  `created_by` int NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_groups`
--

LOCK TABLES `customer_groups` WRITE;
/*!40000 ALTER TABLE `customer_groups` DISABLE KEYS */;
INSERT INTO `customer_groups` VALUES (1,'Default',0.00,0,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(2,'Marketing',0.00,0,1,'2022-11-14 20:22:18','2022-11-14 20:22:18'),(3,'Vanity Customers',0.00,0,1,'2022-11-16 17:28:57','2022-11-16 17:28:57'),(4,'Vanities Customer',0.00,0,1,'2022-11-21 19:34:04','2022-11-21 19:34:04');
/*!40000 ALTER TABLE `customer_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `company` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `tin_number` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `phone_number` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `address` mediumtext COLLATE utf8mb3_unicode_ci,
  `avatar` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'default.jpg',
  `customer_group` int NOT NULL DEFAULT '1',
  `created_by` int NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (2,'Hank','Rearden','crystal18@gutmann.com','Spinka Ltd',NULL,'93196538','3507 Whitman Court,Stamford','default.jpg',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(3,'MdCarol','Miller','Ah-Uaynih@iffymedia.com','Fahey Inc',NULL,'58586567','1724 Michigan Avenue,Pittsburgh','default.jpg',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(4,'Arthur','Dent','ShaunWong@claimab.com','Rippin Group',NULL,'45445646','236 Oliver Street,','default.jpg',1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(5,'Saad','Iqbal','saadiqbal@gmail.com','Test',NULL,'+92 345 4705575','Sharaqpur Sharif','default.jpg',1,0,'2022-11-16 17:26:45','2022-11-16 17:26:45'),(6,'Shawal','Ahmad','shawal@gmail.com','Test Company',NULL,'+92 335 4359568','6th floor, salaar center, near barket market','default.jpg',4,0,'2022-11-21 19:35:43','2022-11-21 19:36:35');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_templates`
--

DROP TABLE IF EXISTS `email_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_templates` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `template_type` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `template_subject` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `default_content` longtext COLLATE utf8mb3_unicode_ci NOT NULL,
  `custom_content` longtext COLLATE utf8mb3_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_templates`
--

LOCK TABLES `email_templates` WRITE;
/*!40000 ALTER TABLE `email_templates` DISABLE KEYS */;
INSERT INTO `email_templates` VALUES (1,'user_invitation','You are invited','<html>\n                            <div style=\"max-width: 60%; color: #000000 !important; font-family: Helvetica; margin:auto; padding-bottom: 10px;\">\n                                <div style=\"text-align:center; padding-top: 10px; padding-bottom: 10px;\">\n                                    <h1>{app_name}</h1>\n                                </div>\n                                <div style=\"padding: 35px;padding-left:20px; font-size:17px; border-bottom: 1px solid #cccccc; border-top: 1px solid #cccccc;\">Hi,<br>\n                {invited_by} invited you to join with the team on {app_name}.<br>\n                Please click the link below to accept the invitation!<br>\n                {verification_link}        </div>\n                            </div>\n                        </html>','',NULL,NULL),(2,'account_verification','Account verification','<html>\n                            <div style=\"max-width: 60%; color: #000000 !important; font-family: Helvetica; margin:auto; padding-bottom: 10px;\">\n                                <div style=\"text-align:center; padding-top: 10px; padding-bottom: 10px;\">\n                                    <h1>{app_name}</h1>\n                                </div>\n                                <div style=\"padding: 35px;padding-left:20px; font-size:17px; border-bottom: 1px solid #cccccc; border-top: 1px solid #cccccc;\">Hi {first_name},<br>\n                        Your account has been created.<br>\n                        Please click the link below to verify your email.<br>\n                        {verification_link}        </div>\n                            </div>\n                        </html>','',NULL,NULL),(3,'reset_password','Reset password','<html>\n                            <div style=\"max-width: 60%; color: #000000 !important; font-family: Helvetica; margin:auto; padding-bottom: 10px;\">\n                                <div style=\"text-align:center; padding-top: 10px; padding-bottom: 10px;\">\n                                    <h1>{app_name}</h1>\n                                </div>\n                                <div style=\"padding: 35px;padding-left:20px; font-size:17px; border-bottom: 1px solid #cccccc; border-top: 1px solid #cccccc;\">Hi,<br>\n                        You have requested to change your password.<br>\n                        Please click the link below to change your password!<br>\n                        {reset_password_link}        </div>\n                            </div>\n                        </html>','',NULL,NULL),(4,'pos_invoice','Invoice','<html>\n                            <div style=\"max-width: 60%; color: #000000 !important; font-family: Helvetica; margin:auto; padding-bottom: 10px;\">\n                                <div style=\"text-align:center; padding-top: 10px; padding-bottom: 10px;\">\n                                    <h1>{app_name}</h1>\n                                </div>\n                                <div style=\"padding: 35px;padding-left:20px; font-size:17px; border-bottom: 1px solid #cccccc; border-top: 1px solid #cccccc;\">Hi {first_name},<br>\n                        Thanks for shopping with us.<br>\n                        Please find the attachment for your purchase ({invoice_id}) details.        </div>\n                            </div>\n                        </html>','',NULL,NULL),(5,'low_stock','Low Stock Template','<div style=\"text-align: center; font-family: DejaVu Sans, \'Lato\', sans-serif;\">\n                            <p>{app_logo}</p>\n                            <h1 style=\"font-weight: lighter; margin-bottom: 0;\">{app_name}</h1>\n                            <br>\n                            <small>Low Stock Notification</small>\n                            <br>\n                            <h3 style=\"text-align:center;\">Out Of Stock List</h3>\n                        </div>\n                        <!--header bottom start-->\n                        <div style=\"margin-bottom:-30px; height:170px; width: 100%; overflow: hidden; display: block; font-family: DejaVu Sans, \'Lato\', sans-serif;\">\n                                <div style=\"float:left; width: 50%;\">\n                                    <p style=\"font-weight:bold;\">Branch Name: <span>{branch_name}</span></p>\n                                    <p style=\"font-weight:bold;\">Branch Manager: <span>{branch_manager}</span></p>\n                                </div>\n                                <div style=\"float:right; width: 45%;\">\n                                    <p style=\"font-weight:bold; text-align: right;\">Date : <span>{date}</span></p>\n                                    <p style=\"font-weight:bold; text-align: right;\">Time : <span>{time}</span></p>\n                                </div>\n                        </div>\n                        <table style=\"border-top: 1px solid #bfbfbf; border-bottom: 1px solid #bfbfbf; border-collapse: collapse; font-weight:500; width: 100%; max-width: 100%; margin-bottom: 0; background-color: transparent; font-family: DejaVu Sans, \'Lato\', sans-serif;\">\n                            <tr>\n                                <th style=\"text-align: left; padding: 7px 0; border-bottom: 1px solid #bfbfbf; width: 40%;\">Item</th>\n                                <th style=\"text-align: right; padding: 7px 0; border-bottom: 1px solid #bfbfbf;\">Re Order</th>\n                                <th style=\"text-align: right; padding: 7px 0; border-bottom: 1px solid #bfbfbf;\">Qty</th>\n                            </tr><br><td style=\"padding: 7px 0;\" class=\"text-center\" colspan=\"5\">{item_details}</td></table>','',NULL,NULL);
/*!40000 ALTER TABLE `email_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invites`
--

DROP TABLE IF EXISTS `invites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invites` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `invited_as` int NOT NULL,
  `invited_branch` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `is_accepted` tinyint(1) NOT NULL DEFAULT '0',
  `invited_by` int NOT NULL,
  `token` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invites`
--

LOCK TABLES `invites` WRITE;
/*!40000 ALTER TABLE `invites` DISABLE KEYS */;
/*!40000 ALTER TABLE `invites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice_templates`
--

DROP TABLE IF EXISTS `invoice_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice_templates` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `template_title` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `template_type` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `is_default_template` tinyint NOT NULL,
  `invoice_size` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `default_content` longtext COLLATE utf8mb3_unicode_ci NOT NULL,
  `custom_content` longtext COLLATE utf8mb3_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice_templates`
--

LOCK TABLES `invoice_templates` WRITE;
/*!40000 ALTER TABLE `invoice_templates` DISABLE KEYS */;
INSERT INTO `invoice_templates` VALUES (1,'Thermal Sales Invoice','sales',1,'thermal','<div class=\"pos\">\n                <div class=\"pos__item pos__item--header\">\n                    <!--Invoice Logo-->\n                    <img src=\"{logo_source}\" class=\"img-fluid\"\n                        alt=\"\">\n                    <div class=\"pos__item--header__title\">\n                        <h3>{app_name}</h3>\n                        <p>Sales Invoice</p>\n                        <small>{date} - {time}</small>\n                    </div>\n                    <!--Invoice Info-->\n                    <div class=\"pos__item--header__info\">\n                        <p> <span>Invoice ID: {invoice_id}</span> </p>\n                        <p> <span>Sold To: {customer_name}</span> </p>\n                        <p> <span>Sold By: {employee_name}</span> </p>\n                        <p> <span>Phone: {phone_number}</span> </p>\n                        <p> <span>Address: {address}</span> </p>\n                        <p> <span>TIN: {tin}</span> </p>\n                        <p> <span>Note: {note}</span> </p>\n                    </div>\n                </div>\n                <!--Invoice Body-->\n                <div class=\"pos__item pos__item--body\">\n                    <div class=\"pos__item--body__content\">\n                        <table class=\"\">\n                            <thead>\n                                <tr>\n                                    <th>Price</th>\n                                    <th>Disc%</th>\n                                    <th>Total</th>\n                                </tr>\n                            </thead>\n                            <tbody>\n                                <tr><td>{item_details}</td></tr>\n                            </tbody>\n                        </table>\n                        <div class=\"dashed-separator\"></div>\n                        <table>\n                            <tbody>\n                                <tr>\n                                    <td>Subtotal</td>\n                                    <td>{sub_total}</td>\n                                </tr>\n                                <tr>\n                                    <td>Shipment</td>\n                                    <td>{shipment_amount}</td>\n                                </tr>\n                                <tr>\n                                    <td>Tax</td>\n                                    <td>{tax}</td>\n                                </tr>\n                                <tr>\n                                    <td>Discount</td>\n                                    <td>{discount}</td>\n                                </tr>\n                                <tr>\n                                    <td>Total</td>\n                                    <td>{total}</td>\n                                </tr>\n                                <tr>{payment_details}</tr>\n                                <tr>\n                                    <td>Exchange</td>\n                                    <td>{exchange}</td>\n                                </tr>\n                            </tbody>\n                        </table>\n                    </div>\n                </div>\n                <div class=\"pos__item pos__item--footer\">\n                    <div class=\"shipment-address\">{shipment_address}</div>\n                    <div class=\"barcode\">{barcode}</div>\n                </div>\n            </div>\n            ','',NULL,NULL),(2,'Thermal Purchase Invoice','receiving',1,'thermal','\n               <div class=\"pos\">\n                <div class=\"pos__item pos__item--header\">\n                    <!--Invoice Logo-->\n                    <img src=\"{logo_source}\" class=\"img-fluid\"\n                        alt=\"\">\n                    <div class=\"pos__item--header__title\">\n                        <h3>{app_name}</h3>\n                        <p>Purchase Invoice</p>\n                        <small>{date} - {time}</small>\n                    </div>\n                    <!--Invoice Info-->\n                    <div class=\"pos__item--header__info\">\n                        <p> <span>Invoice ID: {invoice_id}</span> </p>\n                        <p> <span>Supplier: {supplier_name}</span> </p>\n                        <p> <span>TIN: {tin}</span> </p>\n                        <p> <span>Purchased By: {employee_name}</span> </p>\n                    </div>\n                </div>\n                <!--Invoice Body-->\n                <div class=\"pos__item pos__item--body\">\n                    <div class=\"pos__item--body__content\">\n                        <table class=\"\">\n                            <thead>\n                                <tr>\n                                    <th>Price</th>\n                                    <th>Disc%</th>\n                                    <th>Total</th>\n                                </tr>\n                            </thead>\n                            <tbody>\n                                <tr><td>{item_details}</td></tr>\n                            </tbody>\n                        </table>\n                        <div class=\"dashed-separator\"></div>\n                        <table>\n                            <tbody>\n                                <tr>\n                                    <td>Subtotal</td>\n                                    <td>{sub_total}</td>\n                                </tr>\n                                <tr>\n                                    <td>Tax</td>\n                                    <td>{tax}</td>\n                                </tr>\n                                <tr>\n                                    <td>Discount</td>\n                                    <td>{discount}</td>\n                                </tr>\n                                <tr>\n                                    <td>Total</td>\n                                    <td>{total}</td>\n                                </tr>\n                                <tr>{payment_details}</tr>\n                                <tr>\n                                    <td>Exchange</td>\n                                    <td>{exchange}</td>\n                                </tr>\n                            </tbody>\n                        </table>\n                    </div>\n                </div>\n                <div class=\"pos__item pos__item--footer\">\n                    <div class=\"barcode\">{barcode}</div>\n                </div>\n            </div>\n            ','',NULL,NULL),(3,'Small Sales Invoice','sales',0,'small','<div class=\"invoice-page-wrapper\">\n                <div class=\"thermal-invoice\" style=\"width: 70mm;\">\n                    <!--Invoice Header-->\n                    <div class=\"text-center invoice-header mb-3\">\n                    \n                        <!--Invoice Logo-->\n                        <img src=\"{logo_source}\" class=\"img-fluid\" alt=\"\">\n                        <div class=\"app-name my-2\">{app_name}</div>\n                        <div class=\"invoice-type my-2\">\n                            <span class=\"text-uppercase font-weight-bold\">Sales Invoice</span>\n                        </div>\n                        <small class=\"invoice-date\">\n                            {date} - {time}\n                        </small>\n                    </div>\n    \n                    <!--Invoice Info-->\n                    <div class=\"mb-3 font-weight-bold invoice-info\">\n                        <p>\n                            <span>Invoice ID: {invoice_id}</span> \n                        </p>\n                         <p >\n                            <span>Sold To: {customer_name}</span> \n                        </p>\n                        <p>\n                            <span>Sold By: {employee_name}</span> \n                        </p>\n                        <p>\n                            <span>Phone: {phone_number}</span> \n                        </p>\n                        <p>\n                            <span>Address: {address}</span> \n                        </p>\n                        <p>\n                            <span>TIN: {tin}</span> \n                        </p>\n                        <p>\n                            <span>Note: {note}</span> \n                        </p>\n                    </div>\n    \n                    <!--Invoice Body-->\n                    <table class=\"table table-borderless\">\n                        <tbody class=\"font-weight-bold\">\n                            <tr class=\"border-top border-bottom t-header\">\n                                <th class=\"w-25 pl-0\">Price</th>\n                                <th class=\"text-right\">Qty</th>\n                                <th class=\"text-right\">Disc%</th>\n                                <th class=\"text-right pr-0\">Total</th>\n                            </tr>\n                            <tr><td>{item_details}</td></tr>\n                            <tr class=\"t-footer border-top\">\n                                <td class=\"text-left\">Subtotal</td>\n                                <td class=\"font-weight-bold\" colspan=\"3\">{sub_total}</td>\n                            </tr>\n                            <tr class=\"t-footer\">\n                                <td class=\"text-left\">Shipment</td>\n                                <td class=\"font-weight-bold\" colspan=\"3\">{shipment_amount}</td>\n                            </tr>\n                            <tr class=\"t-footer\"> \n                                <td class=\"text-left\">Tax</td>\n                                <td class=\"font-weight-bold\" colspan=\"3\">{tax}</td>\n                            </tr>\n                            <tr class=\"t-footer\">\n                                <td class=\"text-left\">Discount</td>\n                                <td class=\"font-weight-bold\" colspan=\"3\">{discount}</td>\n                            </tr>\n                            <tr class=\"t-footer\">\n                                <td class=\"text-left\">Total</td>\n                                <td class=\"font-weight-bold\" colspan=\"3\">{total}</td>\n                            </tr>\n                            <tr><td>{payment_details}</td></tr>\n                            <tr class=\"t-footer\">\n                                <td class=\"text-left\">Exchange</td>\n                                <td class=\"font-weight-bold\" colspan=\"3\">{exchange}</td>\n                            </tr>\n                        </tbody>\n                    </table>\n                    <div class=\"shipment-address\">{shipment_address}</div>\n                    <div class=\"text-center\">{barcode}</div>\n                </div>\n            </div>','',NULL,NULL),(4,'Small Purchase Invoice','receiving',0,'small','<div class=\"invoice-page-wrapper\">\n                <div class=\"thermal-invoice\" style=\"width: 70mm;\">\n                    <!--Invoice Header-->\n                    <div class=\"text-center invoice-header mb-3\">\n                    \n                        <!--Invoice Logo-->\n                         <img src=\"{logo_source}\" width=\"100\" class=\"img-fluid\" alt=\"\">\n                        <div class=\"app-name my-2\">{app_name}</div>\n                        <div>\n                            <h6 class=\"text-uppercase font-weight-bold\">Purchase Invoice</h6>\n                        </div>\n                        <small class=\"font-weight-bold\">\n                            {date} - {time}\n                        </small>\n                    </div>\n    \n                    <!--Invoice Info-->\n                    <div class=\"mb-3 font-weight-bold invoice-info\">\n                        <p class=\"mb-1\">\n                            <span class=\"font-weight-bold\">Invoice ID: </span> {invoice_id}\n                        </p>\n                         <p class=\"mb-1\">\n                            <span class=\"font-weight-bold\">Supplier: </span> {supplier_name}\n                        </p>\n                        <p class=\"mb-1\">\n                            <span class=\"font-weight-bold\">TIN: </span> {tin}\n                        </p>\n                        <p class=\"mb-1\">\n                            <span class=\"font-weight-bold\">Purchased By: </span> {employee_name}\n                        </p>\n                    </div>\n    \n                    <!--Invoice Body-->\n                    <table class=\"table table-borderless\">\n                        <tbody class=\"font-weight-bold\">\n                            <tr class=\"border-top border-bottom t-header\">\n                                <th class=\"w-25 pl-0\">Price</th>\n                                <th class=\"text-right\">Qty</th>\n                                <th class=\"text-right\">Disc%</th>\n                                <th class=\"text-right pr-0\">Total</th>\n                            </tr>\n                            <tr><td>{item_details}</td></tr>\n                            <tr class=\"t-footer border-top\">\n                                <td>Subtotal</td>\n                                <td class=\"font-weight-bold\" colspan=\"3\">{sub_total}</td>\n                            </tr>\n                            <tr class=\"t-footer\">\n                                <td>Tax</td>\n                                <td class=\"font-weight-bold\" colspan=\"3\">{tax}</td>\n                            </tr>\n                            <tr class=\"t-footer\">\n                                <td>Discount</td>\n                                <td class=\"font-weight-bold\" colspan=\"3\">{discount}</td>\n                            </tr>\n                            <tr class=\"t-footer\">\n                                <td>Total</td>\n                                <td class=\"font-weight-bold\" colspan=\"3\">{total}</td>\n                            </tr>\n                            <tr><td>{payment_details}</td></tr>\n                            <tr class=\"t-footer\">\n                                <td>Exchange</td>\n                                <td class=\"font-weight-bold\" colspan=\"3\">{exchange}</td>\n                            </tr>\n                        </tbody>\n                    </table>\n                    <div class=\"text-center\">{barcode}</div>\n                </div>\n            </div>','',NULL,NULL),(5,'Large Sales Invoice','sales',0,'large','<div class=\"invoice-page-wrapper\">\n                <div class=\"thermal-invoice\" style=\"width: 95mm;\">\n                    <!--Invoice Header-->\n                    <div class=\"text-center invoice-header mb-3\">\n                    \n                        <!--Invoice Logo-->\n                        <img src=\"{logo_source}\" width=\"100\" class=\"img-fluid\" alt=\"\">\n                        <div class=\"app-name my-2\">{app_name}</div>\n                        <div>\n                            <h6 class=\"text-uppercase font-weight-bold\">Sales Invoice</h6>\n                        </div>\n                        <small class=\"font-weight-bold\">\n                            {date} - {time}\n                        </small>\n                    </div>\n    \n                    <!--Invoice Info-->\n                    <div class=\"mb-3 font-weight-bold invoice-info\">\n                        <p class=\"mb-1\">\n                            <span class=\"font-weight-bold\">Invoice ID: </span> {invoice_id}\n                        </p>\n                         <p class=\"mb-1\">\n                            <span class=\"font-weight-bold\">Sold To: </span> {customer_name}\n                        </p>\n                        <p class=\"mb-1\">\n                            <span class=\"font-weight-bold\">Sold By: </span> {employee_name}\n                        </p>\n                        <p class=\"mb-1\">\n                            <span class=\"font-weight-bold\">Phone: </span> {phone_number}\n                        </p>\n                        <p class=\"mb-1\">\n                            <span class=\"font-weight-bold\">Address: </span> {address}\n                        </p>\n                        <p class=\"mb-1\">\n                            <span class=\"font-weight-bold\">TIN: </span> {tin}\n                        </p>\n                        <p class=\"mb-1\">\n                            <span class=\"font-weight-bold\">Note: </span> {note}\n                        </p>\n                    </div>\n    \n                    <!--Invoice Body-->\n                    <table class=\"table table-borderless\">\n                        <tbody class=\"font-weight-bold\">\n                            <tr class=\"border-top border-bottom t-header\">\n                                <th class=\"pl-0\">Items</th>\n                                <th class=\"text-right\">Qty</th>\n                                <th class=\"text-right\">Price</th>\n                                <th class=\"text-right\">Discount</th>\n                                <th class=\"text-right pr-0\">Total</th>\n                            </tr>\n                            <tr><td>{item_details}</td></tr>\n                            <tr class=\"t-footer border-top\">\n                                <td class=\"text-left\">Subtotal</td>\n                                <td class=\"font-weight-bold\" colspan=\"4\">{sub_total}</td>\n                            </tr>\n                            <tr class=\"t-footer\">\n                                <td class=\"text-left\">Shipment</td>\n                                <td class=\"font-weight-bold\" colspan=\"4\">{shipment_amount}</td>\n                            </tr>\n                            <tr class=\"t-footer\">\n                                <td class=\"text-left\">Tax</td>\n                                <td class=\"font-weight-bold\" colspan=\"4\">{tax}</td>\n                            </tr>\n                            <tr class=\"t-footer\">\n                                <td class=\"text-left\">Discount</td>\n                                <td class=\"font-weight-bold\" colspan=\"4\">{discount}</td>\n                            </tr>\n                            <tr class=\"t-footer\">\n                                <td class=\"text-left\">Total</td>\n                                <td class=\"font-weight-bold\" colspan=\"4\">{total}</td>\n                            </tr>\n                            <tr><td>{payment_details}</td></tr>\n                            <tr class=\"t-footer\">\n                                <td class=\"text-left\">Exchange</td>\n                                <td class=\"font-weight-bold\" colspan=\"4\">{exchange}</td>\n                            </tr>\n                        </tbody>\n                    </table>\n                    <div class=\"shipment-address\">{shipment_address}</div>\n                    <div class=\"text-center\">{barcode}</div>\n                </div>\n            </div>','',NULL,NULL),(6,'Large Purchase Invoice','receiving',0,'large','<div class=\"invoice-page-wrapper\">\n                <div class=\"thermal-invoice\" style=\"width: 95mm;\">\n                    <!--Invoice Header-->\n                    <div class=\"text-center invoice-header mb-3\">\n                    \n                        <!--Invoice Logo-->\n                       <img src=\"{logo_source}\" width=\"100\" class=\"img-fluid\" alt=\"\">\n                        <div class=\"app-name my-2\">{app_name}</div>\n                        <div>\n                            <h6 class=\"text-uppercase font-weight-bold\">Purchase Invoice</h6>\n                        </div>\n                        <small class=\"font-weight-bold\">\n                            {date} - {time}\n                        </small>\n                    </div>\n    \n                    <!--Invoice Info-->\n                    <div class=\"mb-3 font-weight-bold invoice-info\">\n                        <p class=\"mb-1\">\n                            <span class=\"font-weight-bold\">Invoice ID: </span> {invoice_id}\n                        </p>\n                         <p class=\"mb-1\">\n                            <span class=\"font-weight-bold\">Supplier: </span> {supplier_name}\n                        </p>\n                        <p class=\"mb-1\">\n                            <span class=\"font-weight-bold\">TIN: </span> {tin}\n                        </p>\n                        <p class=\"mb-1\">\n                            <span class=\"font-weight-bold\">Purchased By: </span> {employee_name}\n                        </p>\n                    </div>\n    \n                    <!--Invoice Body-->\n                    <table class=\"table table-borderless\">\n                        <tbody class=\"font-weight-bold\">\n                            <tr class=\"border-top border-bottom t-header\">\n                                <th class=\"pl-0\">Items</th>\n                                <th class=\"text-right\">Qty</th>\n                                <th class=\"text-right\">Price</th>\n                                <th class=\"text-right\">Discount</th>\n                                <th class=\"text-right pr-0\">Total</th>\n                            </tr>\n                            <tr><td>{item_details}</td></tr>\n                            <tr class=\"t-footer border-top\">\n                                <td>Subtotal</td>\n                                <td class=\"font-weight-bold\" colspan=\"4\">{sub_total}</td>\n                            </tr>\n                            <tr class=\"t-footer\">\n                                <td>Tax</td>\n                                <td class=\"font-weight-bold\" colspan=\"4\">{tax}</td>\n                            </tr>\n                            <tr class=\"t-footer\">\n                                <td>Discount</td>\n                                <td class=\"font-weight-bold\" colspan=\"4\">{discount}</td>\n                            </tr>\n                            <tr class=\"t-footer\">\n                                <td>Total</td>\n                                <td class=\"font-weight-bold\" colspan=\"4\">{total}</td>\n                            </tr>\n                            <tr><td>{payment_details}</td></tr>\n                            <tr class=\"t-footer\">\n                                <td>Exchange</td>\n                                <td class=\"font-weight-bold\" colspan=\"4\">{exchange}</td>\n                            </tr>\n                        </tbody>\n                    </table>\n                    <div class=\"text-center\">{barcode}</div>\n                </div>\n            </div>','',NULL,NULL);
/*!40000 ALTER TABLE `invoice_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_10_12_000000_create_users_table',1),(2,'2014_10_12_100000_create_password_resets_table',1),(3,'2018_03_04_124154_create_settings_table',1),(4,'2018_03_05_134724_create_roles_table',1),(5,'2018_03_06_125804_create_email_templates_table',1),(6,'2018_03_11_081629_create_invites_table',1),(7,'2018_04_04_122419_create_notifications_table',1),(8,'2018_04_23_093600_create_product_categories_table',1),(9,'2018_04_23_094449_create_payment_types_table',1),(10,'2018_04_23_133454_create_customer_groups_table',1),(11,'2018_04_24_065209_create_product_brands_table',1),(12,'2018_04_24_074704_create_product_groups_table',1),(13,'2018_04_24_114457_create_products_table',1),(14,'2018_04_24_120528_create_product_variants_table',1),(15,'2018_04_24_123129_create_product_attributes_table',1),(16,'2018_04_25_063137_create_taxes_table',1),(17,'2018_04_25_113030_create_branches_table',1),(18,'2018_05_06_093016_create_product_attribute_values_table',1),(19,'2018_09_24_121807_create_orders_table',1),(20,'2018_09_24_122120_create_order_items_table',1),(21,'2018_09_24_122145_create_payments_table',1),(22,'2018_09_25_102442_create_cash_registers_table',1),(23,'2018_10_18_080804_create_cash_register_logs_table',1),(24,'2018_12_26_065902_create_product_units_table',1),(25,'2019_04_15_074946_create_customers_table',1),(26,'2019_04_15_080443_create_suppliers_table',1),(27,'2019_05_29_073208_create_shortcut_keys_table',1),(28,'2019_08_26_071749_invoice_template_table',1),(29,'2019_10_03_110011_create_restaurant_tables_table',1),(30,'2019_11_21_100102_create_adjust_product_stock_types_table',1),(31,'2019_11_26_072652_create_todo_lists_table',1),(32,'2019_12_26_082431_create_corn_job_logs_table',1),(33,'2020_02_17_071037_create_sms_templates_table',1),(34,'2020_03_09_122331_create_shipping_areas_table',1),(35,'2020_03_11_083720_create_shipping_information_table',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `event` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `booking_id` int NOT NULL,
  `booking_by` int NOT NULL,
  `notify_to` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `read_by` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `variant_id` int NOT NULL,
  `type` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `quantity` double(8,2) NOT NULL,
  `price` double(20,2) NOT NULL,
  `discount` double(20,2) NOT NULL DEFAULT '0.00',
  `sub_total` double(20,2) NOT NULL DEFAULT '0.00',
  `tax_id` int DEFAULT NULL,
  `order_id` int NOT NULL,
  `adjust_stock_type_id` int NOT NULL DEFAULT '0',
  `note` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `product_custom_details` json DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (1,1,3,'receiving',3.00,100.00,0.00,300.00,NULL,1,0,NULL,'2022-11-14 20:37:52','2022-11-14 20:37:52',NULL),(3,0,0,'discount',1.00,1.30,0.00,-1.30,NULL,2,0,NULL,'2022-11-14 20:46:27','2022-11-14 20:46:27',NULL),(5,1,1,'receiving',7.00,100.00,0.00,700.00,NULL,4,0,NULL,'2022-11-16 17:15:11','2022-11-16 17:15:11',NULL),(6,1,2,'receiving',5.00,500.00,0.00,2500.00,NULL,5,0,NULL,'2022-11-16 17:34:12','2022-11-16 17:34:12',NULL),(7,2,3,'receiving',10.00,650.00,0.00,6500.00,NULL,6,0,NULL,'2022-11-16 17:39:43','2022-11-16 17:39:43',NULL),(10,3,4,'receiving',15.00,600.00,0.00,9000.00,NULL,9,0,NULL,'2022-11-21 19:40:59','2022-11-21 19:40:59',NULL),(13,0,0,'shipment',1.00,500.00,0.00,500.00,NULL,11,0,NULL,'2022-11-25 21:28:17','2022-11-25 21:28:17',NULL),(15,0,0,'shipment',1.00,500.00,0.00,500.00,NULL,12,0,NULL,'2022-11-25 21:33:42','2022-11-25 21:33:42',NULL),(29,0,0,'shipment',1.00,500.00,0.00,500.00,NULL,24,0,NULL,'2022-12-12 14:51:10','2022-12-12 14:51:10',NULL),(45,5,7,'receiving',5.00,5665.00,0.00,28325.00,NULL,39,0,NULL,NULL,NULL,NULL),(81,5,7,'sales',-1.00,4550.00,0.00,4550.00,NULL,72,0,NULL,'2023-01-02 17:42:28','2023-01-02 17:42:28','{\"hole\": null, \"size\": null, \"color\": null, \"filler\": null, \"handles\": null, \"wall_side\": null, \"drawer_side\": null}'),(82,0,0,'delivery',1.00,87.00,0.00,87.00,NULL,72,0,NULL,'2023-01-02 17:42:28','2023-01-02 17:42:28',NULL),(83,3,4,'sales',-1.00,850.00,0.00,850.00,NULL,73,0,NULL,'2023-01-02 20:12:21','2023-01-02 20:12:21',NULL),(84,5,7,'sales',-1.00,4550.00,0.00,4550.00,NULL,74,0,NULL,'2023-01-03 21:08:51','2023-01-03 21:08:51','{\"hole\": null, \"size\": null, \"color\": null, \"filler\": null, \"handles\": null, \"wall_side\": null, \"drawer_side\": null}'),(85,0,0,'delivery',1.00,23.00,0.00,23.00,NULL,74,0,NULL,'2023-01-03 21:08:51','2023-01-03 21:08:51',NULL),(86,2,3,'sales',-1.00,875.00,0.00,875.00,NULL,75,0,NULL,'2023-01-03 21:14:46','2023-01-03 21:14:46',NULL),(87,1,1,'sales',-1.00,650.00,0.00,650.00,NULL,76,0,NULL,'2023-01-03 21:16:05','2023-01-03 21:16:05',NULL),(88,0,0,'delivery',1.00,25.00,0.00,25.00,NULL,76,0,NULL,'2023-01-03 21:16:05','2023-01-03 21:16:05',NULL),(89,5,7,'sales',-1.00,4550.00,0.00,4550.00,NULL,77,0,NULL,'2023-01-03 21:28:21','2023-01-03 21:28:21','{\"hole\": null, \"size\": null, \"color\": null, \"filler\": null, \"handles\": null, \"wall_side\": null, \"drawer_side\": null}'),(90,0,0,'delivery',1.00,100.00,0.00,100.00,NULL,77,0,NULL,'2023-01-03 21:28:21','2023-01-03 21:28:21',NULL);
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `order_type` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `sales_note` longtext COLLATE utf8mb3_unicode_ci,
  `sub_total` double(20,2) NOT NULL,
  `total_tax` double(20,2) NOT NULL DEFAULT '0.00',
  `due_amount` double(20,2) NOT NULL DEFAULT '0.00',
  `total` double(20,2) NOT NULL,
  `type` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `profit` double(20,2) NOT NULL DEFAULT '0.00',
  `status` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `all_discount` double(20,2) NOT NULL DEFAULT '0.00',
  `customer_id` int DEFAULT NULL,
  `supplier_id` int DEFAULT NULL,
  `branch_id` int NOT NULL,
  `transfer_branch_id` int DEFAULT NULL,
  `table_id` int DEFAULT NULL,
  `created_by` int NOT NULL,
  `returned_invoice` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `return_type` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `invoice_id` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `product_custom_details` json DEFAULT NULL,
  `order_status` enum('pending','pickedup','cancelled','hold','processing','ready') CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `delivery_or_pickup` enum('delivery','pickup') COLLATE utf8mb3_unicode_ci DEFAULT 'delivery',
  `delivery_or_pickup_date` date DEFAULT NULL,
  `delivery_charges` decimal(20,2) DEFAULT '0.00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'2022-11-14','receiving',NULL,300.00,0.00,0.00,300.00,'supplier',0.00,'done',0.00,NULL,NULL,1,NULL,NULL,1,NULL,NULL,'1','2022-11-14 20:37:51','2022-11-14 20:37:51',NULL,NULL,'delivery',NULL,0.00),(4,'2022-11-16','receiving',NULL,700.00,0.00,0.00,700.00,'supplier',0.00,'done',0.00,NULL,NULL,1,NULL,NULL,1,NULL,NULL,'1','2022-11-16 17:15:09','2022-11-16 17:15:10',NULL,NULL,'delivery',NULL,0.00),(5,'2022-11-16','receiving',NULL,2500.00,0.00,0.00,2500.00,'supplier',0.00,'done',0.00,NULL,NULL,1,NULL,NULL,1,NULL,NULL,'2','2022-11-16 17:34:11','2022-11-16 17:34:11',NULL,NULL,'delivery',NULL,0.00),(6,'2022-11-16','receiving',NULL,6500.00,0.00,0.00,6500.00,'supplier',0.00,'done',0.00,NULL,NULL,1,NULL,NULL,1,NULL,NULL,'3','2022-11-16 17:39:40','2022-11-16 17:39:41',NULL,NULL,'delivery',NULL,0.00),(9,'2022-11-21','receiving',NULL,9000.00,0.00,0.00,9000.00,'supplier',0.00,'done',0.00,NULL,NULL,1,NULL,NULL,1,NULL,NULL,'4','2022-11-21 19:40:57','2022-11-21 19:40:58',NULL,NULL,'delivery',NULL,0.00),(39,'2022-12-29','receiving',NULL,28325.00,0.00,0.00,28325.00,'supplier',0.00,'done',0.00,NULL,NULL,1,NULL,NULL,1,NULL,NULL,'5','2022-12-29 19:46:58','2022-12-29 19:46:58',NULL,NULL,'delivery',NULL,0.00),(72,'2023-01-02','sales',NULL,4550.00,0.00,0.00,4550.00,'customer',-1115.00,'done',0.00,NULL,NULL,1,NULL,NULL,1,NULL,NULL,'NS64','2023-01-02 22:42:00','2023-01-04 20:55:45',NULL,'hold','delivery','2022-12-28',87.00),(73,'2023-01-02','sales',NULL,850.00,0.00,0.00,850.00,'customer',250.00,'done',0.00,NULL,NULL,1,NULL,NULL,1,NULL,NULL,'NS65','2023-01-03 01:12:00','2023-01-02 20:23:44',NULL,'ready','pickup','2023-01-25',0.00),(74,'2023-01-03','sales',NULL,4550.00,0.00,0.00,4550.00,'customer',-1115.00,'done',0.00,NULL,NULL,1,NULL,NULL,1,NULL,NULL,'NS66','2023-01-04 02:08:00','2023-01-04 21:14:41',NULL,'processing','delivery','2023-01-31',23.00),(75,'2023-01-03','sales','dssdfdsf',875.00,0.00,0.00,875.00,'customer',225.00,'done',0.00,NULL,NULL,1,NULL,NULL,1,NULL,NULL,'NS67','2023-01-04 02:14:00','2023-01-03 21:14:46',NULL,'pickedup','pickup','2023-02-16',0.00),(76,'2023-01-03','sales',NULL,650.00,0.00,0.00,650.00,'customer',550.00,'delete',0.00,NULL,NULL,1,NULL,NULL,1,NULL,NULL,'NS68','2023-01-04 02:16:00','2023-01-03 21:16:35',NULL,'cancelled','delivery','2023-01-04',25.00),(77,'2023-01-03','sales','sdffd',4550.00,0.00,4200.00,4550.00,'customer',-1115.00,'done',0.00,6,NULL,1,NULL,NULL,1,NULL,NULL,'NS69','2023-01-04 02:28:00','2023-01-03 21:28:21',NULL,'pending','delivery','2023-02-01',100.00);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_resets`
--

LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_types`
--

DROP TABLE IF EXISTS `payment_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_types` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `status` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `is_default` tinyint NOT NULL DEFAULT '0',
  `created_by` int NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_types`
--

LOCK TABLES `payment_types` WRITE;
/*!40000 ALTER TABLE `payment_types` DISABLE KEYS */;
INSERT INTO `payment_types` VALUES (1,'Cash','cash','no_round',1,1,NULL,NULL),(2,'Credit','credit','no_round',0,1,NULL,NULL);
/*!40000 ALTER TABLE `payment_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `paid` double(20,2) NOT NULL,
  `exchange` double(20,2) DEFAULT NULL,
  `payment_method` int NOT NULL,
  `options` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `order_id` int NOT NULL,
  `cash_register_id` int DEFAULT NULL,
  `is_active` tinyint NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (1,'2022-11-14',200.00,NULL,1,NULL,1,1,1,'2022-11-14 14:05:47','2022-11-14 14:05:47'),(2,'2022-11-14',200.00,NULL,1,NULL,2,1,1,'2022-11-14 14:20:21','2022-11-14 14:20:21'),(3,'2022-11-14',500.00,NULL,1,NULL,3,1,1,'2022-11-14 15:15:05','2022-11-14 15:15:05'),(4,'2022-11-14',500.00,0.00,1,'a:0:{}',4,1,1,'2022-11-14 20:25:00',NULL),(5,'2022-11-14',300.00,NULL,1,NULL,1,1,1,'2022-11-14 15:37:52','2022-11-14 15:37:52'),(6,'2022-11-14',697.90,0.00,1,'a:0:{}',2,1,1,'2022-11-14 20:46:00',NULL),(7,'2022-11-14',1748.00,0.00,1,'a:0:{}',3,1,1,'2022-11-14 20:56:00',NULL),(8,'2022-11-16',700.00,NULL,1,NULL,4,1,1,'2022-11-16 12:15:11','2022-11-16 12:15:11'),(9,'2022-11-16',2500.00,NULL,1,NULL,5,1,1,'2022-11-16 12:34:12','2022-11-16 12:34:12'),(10,'2022-11-16',6500.00,NULL,1,NULL,6,1,1,'2022-11-16 12:39:42','2022-11-16 12:39:42'),(11,'2022-11-16',547.00,0.00,1,'a:0:{}',7,1,1,'2022-11-16 17:51:00',NULL),(12,'2022-11-16',875.00,0.00,1,'a:0:{}',8,1,1,'2022-11-16 19:49:00',NULL),(13,'2022-11-21',9000.00,NULL,1,NULL,9,1,1,'2022-11-21 14:40:59','2022-11-21 14:40:59'),(14,'2022-11-21',100.00,0.00,1,'a:0:{}',10,1,1,'2022-11-21 19:45:00',NULL),(15,'2022-11-21',733.00,0.00,1,'a:0:{}',10,1,1,'2022-11-21 19:45:00',NULL),(16,'2022-11-25',650.00,0.00,1,'a:0:{}',11,1,1,'2022-11-25 21:27:00',NULL),(17,'2022-11-25',500.00,0.00,1,'a:0:{}',11,1,1,'2022-11-25 21:28:00',NULL),(18,'2022-11-25',650.00,0.00,1,'a:0:{}',12,1,1,'2022-11-25 21:32:00',NULL),(20,'2022-11-25',350.00,0.00,2,'a:0:{}',12,1,1,'2022-11-25 21:34:00',NULL),(21,'2022-11-25',150.00,0.00,1,'a:0:{}',12,1,1,'2022-11-25 21:34:00',NULL),(22,'2022-12-04',250.00,0.00,1,'a:0:{}',13,1,1,'2022-12-04 14:51:00',NULL),(23,'2022-12-04',600.00,0.00,1,'a:0:{}',13,1,1,'2022-12-04 14:51:00',NULL),(24,'2022-12-04',150.00,0.00,1,'a:0:{}',14,1,1,'2022-12-04 16:03:00',NULL),(25,'2022-12-04',700.00,0.00,1,'a:0:{}',14,1,1,'2022-12-04 16:03:00',NULL),(26,'2022-12-04',150.00,0.00,1,'a:0:{}',15,1,1,'2022-12-04 16:07:00',NULL),(27,'2022-12-04',150.00,0.00,1,'a:0:{}',15,1,1,'2022-12-04 16:08:00',NULL),(28,'2022-12-04',50.00,0.00,1,'a:0:{}',15,1,1,'2022-12-04 16:08:00',NULL),(29,'2022-12-04',525.00,0.00,1,'a:0:{}',15,1,1,'2022-12-04 16:08:00',NULL),(30,'2022-12-04',850.00,0.00,1,'a:0:{}',16,1,1,'2022-12-04 18:56:00',NULL),(31,'2022-12-12',850.00,0.00,1,'a:0:{}',17,1,1,'2022-12-12 12:45:00',NULL),(32,'2022-12-12',850.00,0.00,1,'a:0:{}',18,1,1,'2022-12-12 13:51:00',NULL),(33,'2022-12-12',850.00,0.00,1,'a:0:{}',19,1,1,'2022-12-12 13:55:00',NULL),(34,'2022-12-12',850.00,0.00,1,'a:0:{}',20,1,1,'2022-12-12 14:26:00',NULL),(35,'2022-12-12',50.00,0.00,1,'a:0:{}',23,1,1,'2022-12-12 14:46:00',NULL),(36,'2022-12-12',825.00,0.00,2,'a:0:{}',23,1,1,'2022-12-12 14:46:00',NULL),(37,'2022-12-12',30.00,0.00,1,'a:0:{}',24,1,1,'2022-12-12 14:50:00',NULL),(39,'2022-12-12',2545.00,0.00,2,'a:0:{}',24,1,1,'2022-12-12 14:51:00',NULL),(40,'2022-12-12',500.00,0.00,1,'a:0:{}',24,1,1,'2022-12-12 14:51:00',NULL),(41,'2022-12-17',11900.00,0.00,1,'a:0:{}',25,1,1,'2022-12-17 15:56:00',NULL),(42,'2022-12-17',850.00,0.00,1,'a:0:{}',26,1,1,'2022-12-17 16:17:00',NULL),(43,'2022-12-17',6825.00,0.00,1,'a:0:{}',27,1,1,'2022-12-17 16:19:00',NULL),(44,'2022-12-17',850.00,0.00,1,'a:0:{}',28,1,1,'2022-12-17 16:25:00',NULL),(45,'2022-12-17',850.00,0.00,1,'a:0:{}',29,1,1,'2022-12-17 16:29:00',NULL),(46,'2022-12-17',850.00,0.00,1,'a:0:{}',30,1,1,'2022-12-17 17:03:00',NULL),(47,'2022-12-17',850.00,0.00,1,'a:0:{}',31,1,1,'2022-12-17 17:05:00',NULL),(48,'2022-12-17',850.00,0.00,1,'a:0:{}',32,1,1,'2022-12-17 17:08:00',NULL),(49,'2022-12-17',850.00,0.00,1,'a:0:{}',33,1,1,'2022-12-17 17:13:00',NULL),(50,'2022-12-17',850.00,0.00,1,'a:0:{}',34,1,1,'2022-12-17 17:13:00',NULL),(51,'2022-12-17',850.00,0.00,1,'a:0:{}',35,1,1,'2022-12-17 17:16:00',NULL),(52,'2022-12-17',850.00,0.00,1,'a:0:{}',36,1,1,'2022-12-17 17:19:00',NULL),(53,'2022-12-17',850.00,0.00,1,'a:0:{}',37,1,1,'2022-12-17 17:27:00',NULL),(54,'2022-12-29',875.00,0.00,1,'a:0:{}',38,1,1,'2022-12-29 19:20:00',NULL),(55,'2022-12-29',28325.00,NULL,1,NULL,39,1,1,'2022-12-29 14:46:59','2022-12-29 14:46:59'),(56,'2022-12-31',875.00,0.00,1,'a:0:{}',40,1,1,'2022-12-31 10:22:00',NULL),(57,'2022-12-31',1750.00,0.00,1,'a:0:{}',41,1,1,'2022-12-31 10:23:00',NULL),(58,'2022-12-31',2400.00,0.00,1,'a:0:{}',42,1,1,'2022-12-31 11:57:00',NULL),(59,'2022-12-31',4550.00,0.00,1,'a:0:{}',43,1,1,'2022-12-31 20:38:00',NULL),(60,'2022-12-31',4550.00,0.00,1,'a:0:{}',44,1,1,'2022-12-31 20:46:00',NULL),(61,'2022-12-31',4550.00,0.00,1,'a:0:{}',45,1,1,'2022-12-31 20:48:00',NULL),(62,'2022-12-31',9100.00,0.00,1,'a:0:{}',46,1,1,'2022-12-31 20:50:00',NULL),(63,'2023-01-01',13650.00,0.00,1,'a:0:{}',47,1,1,'2023-01-01 11:35:00',NULL),(64,'2023-01-01',13650.00,0.00,1,'a:0:{}',52,1,1,'2023-01-01 11:35:00',NULL),(65,'2023-01-01',4550.00,0.00,1,'a:0:{}',53,1,1,'2023-01-01 11:54:00',NULL),(66,'2023-01-01',4550.00,0.00,1,'a:0:{}',54,1,1,'2023-01-01 13:06:00',NULL),(67,'2023-01-01',4550.00,0.00,1,'a:0:{}',55,1,1,'2023-01-01 13:13:00',NULL),(68,'2023-01-01',4550.00,0.00,1,'a:0:{}',56,1,1,'2023-01-01 15:13:00',NULL),(69,'2023-01-01',4550.00,0.00,1,'a:0:{}',57,1,1,'2023-01-01 15:13:00',NULL),(70,'2023-01-01',4550.00,0.00,1,'a:0:{}',57,1,1,'2023-01-01 15:14:00',NULL),(71,'2023-01-01',4550.00,0.00,1,'a:0:{}',58,1,1,'2023-01-01 15:13:00',NULL),(72,'2023-01-01',4550.00,0.00,1,'a:0:{}',58,1,1,'2023-01-01 15:14:00',NULL),(73,'2023-01-01',5050.00,0.00,1,'a:0:{}',59,1,1,'2023-01-01 15:26:00',NULL),(74,'2023-01-01',5050.00,0.00,1,'a:0:{}',60,1,1,'2023-01-01 15:27:00',NULL),(75,'2023-01-01',850.00,0.00,1,'a:0:{}',61,1,1,'2023-01-01 15:28:00',NULL),(76,'2023-01-01',850.00,0.00,1,'a:0:{}',62,1,1,'2023-01-01 15:36:00',NULL),(77,'2023-01-01',5400.00,0.00,1,'a:0:{}',63,1,1,'2023-01-01 15:37:00',NULL),(78,'2023-01-01',850.00,0.00,1,'a:0:{}',64,1,1,'2023-01-01 15:46:00',NULL),(79,'2023-01-01',850.00,0.00,1,'a:0:{}',65,1,1,'2023-01-01 15:53:00',NULL),(80,'2023-01-01',850.00,0.00,1,'a:0:{}',66,1,1,'2023-01-01 16:14:00',NULL),(81,'2023-01-01',850.00,0.00,1,'a:0:{}',67,1,1,'2023-01-01 16:24:00',NULL),(82,'2023-01-01',4550.00,0.00,1,'a:0:{}',68,1,1,'2023-01-01 18:12:00',NULL),(83,'2023-01-01',850.00,0.00,1,'a:0:{}',69,1,1,'2023-01-01 20:50:00',NULL),(84,'2023-01-02',850.00,0.00,1,'a:0:{}',70,1,1,'2023-01-02 17:37:00',NULL),(85,'2023-01-02',850.00,0.00,1,'a:0:{}',71,1,1,'2023-01-02 17:41:00',NULL),(86,'2023-01-02',4550.00,0.00,1,'a:0:{}',72,1,1,'2023-01-02 17:42:00',NULL),(87,'2023-01-02',850.00,0.00,1,'a:0:{}',73,1,1,'2023-01-02 20:12:00',NULL),(88,'2023-01-03',4550.00,0.00,1,'a:0:{}',74,1,1,'2023-01-03 21:08:00',NULL),(89,'2023-01-03',875.00,0.00,1,'a:0:{}',75,1,1,'2023-01-03 21:14:00',NULL),(90,'2023-01-03',650.00,0.00,1,'a:0:{}',76,1,1,'2023-01-03 21:16:00',NULL),(91,'2023-01-03',350.00,0.00,2,'a:0:{}',77,1,1,'2023-01-03 21:27:00',NULL),(92,'2023-01-03',4200.00,0.00,2,'a:0:{}',77,1,1,'2023-01-03 21:28:00',NULL);
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_attribute_values`
--

DROP TABLE IF EXISTS `product_attribute_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_attribute_values` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `attribute_id` int NOT NULL,
  `values` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_attribute_values`
--

LOCK TABLES `product_attribute_values` WRITE;
/*!40000 ALTER TABLE `product_attribute_values` DISABLE KEYS */;
INSERT INTO `product_attribute_values` VALUES (1,4,1,',36',NULL,NULL),(2,4,2,',Red,Blue',NULL,NULL),(5,5,1,',52',NULL,NULL),(6,5,2,',Red',NULL,NULL);
/*!40000 ALTER TABLE `product_attribute_values` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_attributes`
--

DROP TABLE IF EXISTS `product_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_attributes` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `created_by` int NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_attributes`
--

LOCK TABLES `product_attributes` WRITE;
/*!40000 ALTER TABLE `product_attributes` DISABLE KEYS */;
INSERT INTO `product_attributes` VALUES (1,'Size',1,'2022-11-13 19:13:44','2022-11-13 19:13:44'),(2,'Color',1,'2022-11-14 20:10:23','2022-11-14 20:10:23'),(3,'DRAWERS SIDE',1,'2022-11-21 20:12:06','2022-11-21 20:12:06'),(4,'HANDLES',1,'2022-11-21 20:12:27','2022-11-21 20:12:27'),(5,'FILLER',1,'2022-11-21 20:12:58','2022-11-21 20:12:58'),(6,'Whole',1,'2022-11-21 20:14:19','2022-11-21 20:14:19');
/*!40000 ALTER TABLE `product_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_brands`
--

DROP TABLE IF EXISTS `product_brands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_brands` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `created_by` int NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_brands`
--

LOCK TABLES `product_brands` WRITE;
/*!40000 ALTER TABLE `product_brands` DISABLE KEYS */;
INSERT INTO `product_brands` VALUES (1,'King',1,NULL,NULL),(2,'Lillie',1,NULL,NULL),(3,'Rose',2,NULL,NULL),(4,'Royal',1,NULL,NULL);
/*!40000 ALTER TABLE `product_brands` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_categories`
--

DROP TABLE IF EXISTS `product_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_categories` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `created_by` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_categories`
--

LOCK TABLES `product_categories` WRITE;
/*!40000 ALTER TABLE `product_categories` DISABLE KEYS */;
INSERT INTO `product_categories` VALUES (1,'Vanities',1,NULL,NULL),(2,'STONE',1,NULL,NULL),(3,'SINKS',1,NULL,NULL),(4,'SHOWER',1,NULL,NULL),(5,'Shelf Panel',1,NULL,NULL),(6,'Shaker',1,NULL,NULL),(7,'Riobel',1,NULL,NULL),(8,'pick up',1,NULL,NULL),(9,'Mirror',1,NULL,NULL),(10,'LED MIRRORS',1,NULL,NULL),(11,'KNOBS',1,NULL,NULL),(12,'Faucets',1,NULL,NULL),(13,'BASIN',1,NULL,NULL),(14,'Accessories',1,NULL,NULL),(15,'Test Category',1,'2022-11-21 14:38:14','2022-11-21 14:38:14');
/*!40000 ALTER TABLE `product_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_groups`
--

DROP TABLE IF EXISTS `product_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_groups` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `created_by` int NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_groups`
--

LOCK TABLES `product_groups` WRITE;
/*!40000 ALTER TABLE `product_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_units`
--

DROP TABLE IF EXISTS `product_units`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_units` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `short_name` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `created_by` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_units`
--

LOCK TABLES `product_units` WRITE;
/*!40000 ALTER TABLE `product_units` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_units` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_variants`
--

DROP TABLE IF EXISTS `product_variants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_variants` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `sku` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `product_id` int NOT NULL,
  `variant_title` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `attribute_values` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `variant_details` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `purchase_price` double(20,2) NOT NULL,
  `selling_price` double(20,2) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `isNotify` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `imageURL` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'no_image.png',
  `bar_code` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `re_order` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_variants_sku_unique` (`sku`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_variants`
--

LOCK TABLES `product_variants` WRITE;
/*!40000 ALTER TABLE `product_variants` DISABLE KEYS */;
INSERT INTO `product_variants` VALUES (1,'DFD',1,'default_variant','default_variant',NULL,100.00,650.00,1,'','no_image.png',NULL,10,'2022-11-16 17:15:09','2023-01-03 21:16:04'),(3,'RRRR',2,'default_variant','default_variant',NULL,650.00,875.00,1,'','no_image.png',NULL,10,'2022-11-16 17:39:39','2023-01-03 21:14:46'),(4,'HJI87',3,'default_variant','default_variant',NULL,600.00,850.00,1,'','no_image.png',NULL,10,'2022-11-21 19:40:56','2023-01-02 20:12:17'),(7,'TRE',5,'52,Red','52,Red',NULL,5665.00,4550.00,1,NULL,'product_48929501.jpeg',NULL,10,NULL,'2023-01-03 21:28:18');
/*!40000 ALTER TABLE `product_variants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb3_unicode_ci,
  `category_id` int DEFAULT NULL,
  `brand_id` int DEFAULT NULL,
  `unit_id` int DEFAULT NULL,
  `group_id` int DEFAULT NULL,
  `taxable` tinyint NOT NULL DEFAULT '0',
  `tax_type` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `tax_id` tinyint(1) DEFAULT NULL,
  `product_type` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `branch_id` int DEFAULT NULL,
  `imageURL` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `is_customization` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Vanity Rose Pansy White 24\'\' update','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',1,3,NULL,NULL,0,'',NULL,'standard',NULL,'product_28554543.jpeg',1,'2022-11-16 17:34:11','2022-11-16 17:54:28',0),(2,'LED Mirror','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',10,NULL,NULL,NULL,0,'',NULL,'standard',NULL,'product_62395957.jpeg',1,'2022-11-16 17:39:38','2022-11-16 17:40:37',0),(3,'36\" LED mirror','This is test description.',10,1,NULL,NULL,0,'',NULL,'standard',NULL,'product_30582466.jpeg',1,'2022-11-21 19:40:56','2022-11-21 19:40:56',0),(5,'Variant Product',NULL,1,1,NULL,NULL,0,'',NULL,'variant',NULL,'product_7645622.jpeg',1,'2022-12-29 19:46:58','2022-12-29 19:47:23',1);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurant_tables`
--

DROP TABLE IF EXISTS `restaurant_tables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurant_tables` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `branch_id` int NOT NULL,
  `status` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'available',
  `created_by` int NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurant_tables`
--

LOCK TABLES `restaurant_tables` WRITE;
/*!40000 ALTER TABLE `restaurant_tables` DISABLE KEYS */;
/*!40000 ALTER TABLE `restaurant_tables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `permissions` longtext COLLATE utf8mb3_unicode_ci NOT NULL,
  `created_by` int NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

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
INSERT INTO `settings` VALUES (1,'time_format','12h','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(2,'date_format','Y-m-d','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(3,'currency_symbol','$','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(4,'currency_format','left','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(5,'thousand_separator',',','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(6,'language_setting','english','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(7,'decimal_separator','.','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(8,'number_of_decimal','2','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(9,'offday_setting','','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(10,'email_from_name','Kashif Asghar','',NULL,0,'0000-00-00 00:00:00','2023-01-04 20:36:21'),(11,'email_from_address','passionhill123@gmail.com','',NULL,0,'0000-00-00 00:00:00','2023-01-04 20:36:21'),(12,'email_driver','mailgun','',NULL,0,'0000-00-00 00:00:00','2023-01-04 20:36:21'),(13,'email_smtp_host','smtp.gmail.com','',NULL,0,'0000-00-00 00:00:00','2023-01-04 20:36:21'),(14,'email_port','465','',NULL,0,'0000-00-00 00:00:00','2023-01-04 20:36:21'),(15,'email_smtp_password','4705575123!@#abc','',NULL,0,'0000-00-00 00:00:00','2023-01-04 20:36:21'),(16,'email_encryption_type','tls','',NULL,0,'0000-00-00 00:00:00','2023-01-04 20:36:21'),(17,'mandrill_api','eca3d6f482fec8d7fb77d488651a68f4-us21','',NULL,0,'0000-00-00 00:00:00','2023-01-04 20:36:22'),(18,'sparkpost_api','','',NULL,0,'0000-00-00 00:00:00','2023-01-04 20:36:23'),(19,'mailgun_domain','sandbox0e71c30081634b118970a5ba55a80106.mailgun.org','',NULL,0,'0000-00-00 00:00:00','2023-01-04 20:36:21'),(20,'mailgun_api','bd9cdb3ce724d9de16d7f89c58f3e636-48d7d97c-2aeb4934','',NULL,0,'0000-00-00 00:00:00','2023-01-04 20:36:22'),(21,'max_row_per_table','10','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(22,'app_name','Noble POS','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(23,'app_logo','default-logo.png','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(24,'currency_code','usd','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(25,'can_signup','1','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(26,'can_login','1','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(27,'invoice_prefix','NS','',NULL,0,'0000-00-00 00:00:00','2022-12-04 16:02:05'),(28,'invoice_suffix','','',NULL,0,'0000-00-00 00:00:00','2022-12-04 16:02:05'),(29,'last_invoice_number','70','',NULL,0,'0000-00-00 00:00:00','2023-01-03 21:28:21'),(30,'auto_generate_invoice','0','',NULL,0,'0000-00-00 00:00:00','2022-12-04 16:02:05'),(31,'auto_email_receive','0','',NULL,0,'0000-00-00 00:00:00','2022-12-04 16:02:06'),(32,'invoice_starts_from','1','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(33,'invoiceLogo','default-logo.png','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(34,'purchase_invoice_prefix','','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(35,'purchase_invoice_suffix','','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(36,'purchase_last_invoice_number','6','',NULL,0,'0000-00-00 00:00:00','2022-12-29 19:46:59'),(37,'purchase_auto_generate_invoice','0','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(38,'purchase_invoice_starts_from','1','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(39,'purchase_invoiceLogo','default-logo.png','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(40,'re_order','10','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(41,'sku_prefix','','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(42,'sales_return_status','sales','',NULL,0,'0000-00-00 00:00:00','2023-01-03 21:08:35'),(43,'purchase_return_status','purchase','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(44,'offline_mode','0','',NULL,0,'0000-00-00 00:00:00','2022-12-22 14:28:57'),(45,'time_zone','UTC','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(46,'notification_time','2019-12-25T04:00:00.641Z','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(47,'low_stock_notification','0','',NULL,0,'0000-00-00 00:00:00','2022-12-17 19:09:47'),(48,'out_of_stock_products','1','',NULL,0,'0000-00-00 00:00:00','2022-12-22 14:28:57'),(49,'sales_list_delete_option','1','',NULL,0,'0000-00-00 00:00:00','2022-12-22 14:28:57'),(50,'sms_recive_to_customer','0','',NULL,0,'0000-00-00 00:00:00','2022-12-22 14:28:58'),(51,'new_customer_welcome_sms','0','',NULL,0,'0000-00-00 00:00:00','2022-12-22 14:28:58'),(52,'sms_from_name_phone_number','','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(53,'sms_driver','','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(54,'key','','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(55,'secret_key','','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(56,'sales_list_edit_option','1','',NULL,0,'0000-00-00 00:00:00','2022-12-22 14:28:57'),(57,'purchase_code','test','',NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(58,'current_branch','1','user',1,0,'2022-11-16 17:09:18','2022-11-16 17:09:18'),(59,'sales_type','customer','',1,0,'0000-00-00 00:00:00','2022-12-22 14:06:11');
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipping_areas`
--

DROP TABLE IF EXISTS `shipping_areas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipping_areas` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `area` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `price` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipping_areas`
--

LOCK TABLES `shipping_areas` WRITE;
/*!40000 ALTER TABLE `shipping_areas` DISABLE KEYS */;
INSERT INTO `shipping_areas` VALUES (1,'Test',500,'2022-11-25 15:50:20','2022-11-25 15:50:20');
/*!40000 ALTER TABLE `shipping_areas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipping_information`
--

DROP TABLE IF EXISTS `shipping_information`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipping_information` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `shipping_area_id` int NOT NULL,
  `price` double NOT NULL,
  `shipping_address` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `order_id` int NOT NULL,
  `branch_id` int NOT NULL,
  `status` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipping_information`
--

LOCK TABLES `shipping_information` WRITE;
/*!40000 ALTER TABLE `shipping_information` DISABLE KEYS */;
INSERT INTO `shipping_information` VALUES (1,1,500,'test address of shipping',11,1,'pending','2022-11-25 16:28:16','2022-11-25 16:28:16'),(2,1,500,'test address',12,1,'pending','2022-11-25 16:33:41','2022-11-25 16:33:41'),(3,1,500,'6th floor, salaar center, near barket market',24,1,'delivered','2022-12-12 09:51:09','2022-12-12 09:54:17'),(4,1,500,'test',56,1,'pending','2023-01-01 10:13:57','2023-01-01 10:13:57'),(5,1,500,'test',57,1,'pending','2023-01-01 10:14:31','2023-01-01 10:14:31'),(6,1,500,'test',58,1,'pending','2023-01-01 10:25:34','2023-01-01 10:25:34');
/*!40000 ALTER TABLE `shipping_information` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shortcut_keys`
--

DROP TABLE IF EXISTS `shortcut_keys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shortcut_keys` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `defaultShortcuts` longtext COLLATE utf8mb3_unicode_ci NOT NULL,
  `customShortcuts` longtext COLLATE utf8mb3_unicode_ci,
  `created_by` int NOT NULL,
  `shortcutsStatus` int NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shortcut_keys`
--

LOCK TABLES `shortcut_keys` WRITE;
/*!40000 ALTER TABLE `shortcut_keys` DISABLE KEYS */;
INSERT INTO `shortcut_keys` VALUES (1,1,'a:7:{s:13:\"productSearch\";a:3:{s:11:\"action_name\";s:13:\"productSearch\";s:12:\"shortcut_key\";s:6:\"ctrl+s\";s:6:\"status\";b:1;}s:8:\"holdCard\";a:3:{s:11:\"action_name\";s:8:\"holdCard\";s:12:\"shortcut_key\";s:6:\"ctrl+h\";s:6:\"status\";b:1;}s:3:\"pay\";a:3:{s:11:\"action_name\";s:3:\"pay\";s:12:\"shortcut_key\";s:6:\"ctrl+p\";s:6:\"status\";b:1;}s:11:\"addCustomer\";a:3:{s:11:\"action_name\";s:11:\"addCustomer\";s:12:\"shortcut_key\";s:6:\"ctrl+a\";s:6:\"status\";b:1;}s:14:\"cancelCarditem\";a:3:{s:11:\"action_name\";s:14:\"cancelCarditem\";s:12:\"shortcut_key\";s:6:\"ctrl+d\";s:6:\"status\";b:1;}s:13:\"loadSalesPage\";a:3:{s:11:\"action_name\";s:13:\"loadSalesPage\";s:12:\"shortcut_key\";s:6:\"ctrl+l\";s:6:\"status\";b:1;}s:12:\"donePayment1\";a:3:{s:11:\"action_name\";s:12:\"donePayment1\";s:12:\"shortcut_key\";s:6:\"ctrl+m\";s:6:\"status\";b:1;}}',NULL,0,0,'0000-00-00 00:00:00','0000-00-00 00:00:00');
/*!40000 ALTER TABLE `shortcut_keys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sms_templates`
--

DROP TABLE IF EXISTS `sms_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sms_templates` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `template_type` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `template_subject` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `default_content` longtext COLLATE utf8mb3_unicode_ci NOT NULL,
  `custom_content` longtext COLLATE utf8mb3_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sms_templates`
--

LOCK TABLES `sms_templates` WRITE;
/*!40000 ALTER TABLE `sms_templates` DISABLE KEYS */;
INSERT INTO `sms_templates` VALUES (1,'pos_sms','Sales sms','Hi, {first_name} Thanks for shopping with {app_name}. Your invoice is {invoice_id} Total amount {total}','',NULL,NULL),(2,'customer_welcome_sms','Customer Welcome sms','Hi, {first_name} Thanks for join with {app_name}','',NULL,NULL);
/*!40000 ALTER TABLE `sms_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suppliers`
--

DROP TABLE IF EXISTS `suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `suppliers` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `company` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `tin_number` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `phone_number` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `address` mediumtext COLLATE utf8mb3_unicode_ci,
  `avatar` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'default.jpg',
  `created_by` int NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suppliers`
--

LOCK TABLES `suppliers` WRITE;
/*!40000 ALTER TABLE `suppliers` DISABLE KEYS */;
/*!40000 ALTER TABLE `suppliers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taxes`
--

DROP TABLE IF EXISTS `taxes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `taxes` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `percentage` double NOT NULL DEFAULT '0',
  `is_default` tinyint NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taxes`
--

LOCK TABLES `taxes` WRITE;
/*!40000 ALTER TABLE `taxes` DISABLE KEYS */;
INSERT INTO `taxes` VALUES (1,'Zero Tax',0,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(2,'5% Tax',5,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(3,'15% Tax',15,0,'0000-00-00 00:00:00','0000-00-00 00:00:00');
/*!40000 ALTER TABLE `taxes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `todo_lists`
--

DROP TABLE IF EXISTS `todo_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `todo_lists` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb3_unicode_ci,
  `due_date` date DEFAULT NULL,
  `completed_date` date DEFAULT NULL,
  `completed` tinyint(1) NOT NULL,
  `user_id` int DEFAULT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `todo_lists`
--

LOCK TABLES `todo_lists` WRITE;
/*!40000 ALTER TABLE `todo_lists` DISABLE KEYS */;
INSERT INTO `todo_lists` VALUES (1,'Update to Saad Iqbal for laptop',NULL,'2022-11-17','2022-11-16',0,1,'2022-11-16 12:22:55','2022-11-16 12:23:34'),(2,'update related to pos to sir zeshan',NULL,'2022-11-30',NULL,0,1,'2022-11-16 12:24:10','2022-11-16 12:24:15'),(3,'Salaries transfer',NULL,NULL,NULL,0,1,'2022-11-21 14:25:40','2022-11-21 14:25:40'),(4,'dfdf',NULL,NULL,NULL,0,1,'2022-12-30 07:57:00','2022-12-30 07:57:00');
/*!40000 ALTER TABLE `todo_lists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `gender` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `company` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `phone_number` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `address` mediumtext COLLATE utf8mb3_unicode_ci,
  `avatar` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'default.jpg',
  `verified` tinyint(1) NOT NULL DEFAULT '0',
  `is_admin` tinyint(1) NOT NULL DEFAULT '0',
  `role_id` int NOT NULL DEFAULT '0',
  `user_type` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `tax_excluded` tinyint NOT NULL DEFAULT '1',
  `enabled` tinyint NOT NULL DEFAULT '1',
  `created_by` int NOT NULL,
  `branch_id` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `token` varchar(254) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `notification_check` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Kashif','Asghar','kashif-asghar@hotmail.com','$2y$10$vgrXU1YNTChBuW1QZHVYGO6knoWg/s7prCrtWByy1/xj3CFvBgjRm',NULL,NULL,NULL,NULL,NULL,'default.jpg',1,1,0,'staff',1,1,0,'1','',NULL,NULL,'2022-11-12 20:19:10','2022-11-12 20:19:10');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-01-05  2:20:09
