-- MySQL dump 10.13  Distrib 8.0.30, for Linux (x86_64)
--
-- Host: localhost    Database: orion_pos
-- ------------------------------------------------------
-- Server version	8.0.30-0ubuntu0.20.04.2

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
-- Table structure for table `admin_sessions`
--

DROP TABLE IF EXISTS `admin_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_sessions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `auth_key` varchar(255) NOT NULL,
  `api_key` varchar(255) NOT NULL,
  `user_id` int unsigned NOT NULL,
  `never_expire` tinyint(1) NOT NULL DEFAULT '0',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='To Store admin sessions information in this table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_sessions`
--

LOCK TABLES `admin_sessions` WRITE;
/*!40000 ALTER TABLE `admin_sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin_sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admins` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` VALUES (1,'admin','$2y$10$8QkrgVpVQi2108gUpemUCO5tJVST4ko450UQXVfQahEjdu8f7XIve');
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int unsigned DEFAULT '0' COMMENT 'parent_id  = parent category id, if parent_id = 0 it means this is parent category',
  `category_name` varchar(255) NOT NULL,
  `category_slug` varchar(255) NOT NULL,
  `status` enum('Y','N') DEFAULT 'Y',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int unsigned DEFAULT NULL,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `udpated_by` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `category_name_UNIQUE` (`category_name`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (2,0,'STONE','stone','Y','2022-09-30 17:50:05',NULL,'2022-09-30 17:50:05',NULL),(3,0,'SINKS','sinks','Y','2022-09-30 17:50:05',NULL,'2022-09-30 17:50:05',NULL),(4,0,'SHOWER','shower','Y','2022-09-30 17:50:05',NULL,'2022-09-30 17:50:05',NULL),(5,0,'Shelf Panel','shelf-panel','Y','2022-09-30 17:50:05',NULL,'2022-09-30 17:50:05',NULL),(6,0,'Shaker','shaker','Y','2022-09-30 17:50:05',NULL,'2022-09-30 17:50:05',NULL),(7,0,'Riobel','riobel','Y','2022-09-30 17:50:05',NULL,'2022-09-30 17:50:05',NULL),(8,0,'pick up','pick-up','Y','2022-09-30 17:50:06',NULL,'2022-09-30 17:50:06',NULL),(9,0,'Mirror','mirror','Y','2022-09-30 17:50:07',NULL,'2022-09-30 17:50:07',NULL),(10,0,'LED MIRRORS','led-mirrors','Y','2022-09-30 17:50:07',NULL,'2022-09-30 17:50:07',NULL),(11,0,'KNOBS','knobs','Y','2022-09-30 17:50:07',NULL,'2022-09-30 17:50:07',NULL),(12,0,'Faucets','faucets','Y','2022-09-30 17:50:08',NULL,'2022-09-30 17:50:08',NULL),(13,0,'BASIN','basin','Y','2022-09-30 17:50:08',NULL,'2022-09-30 17:50:08',NULL),(14,0,'Accessories','accessories','Y','2022-09-30 17:50:08',NULL,'2022-09-30 17:50:08',NULL),(19,9,'hghgadmi555n','hghgadmi555n','Y','2022-10-01 11:31:08',1,'2022-10-01 11:31:08',NULL);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config`
--

DROP TABLE IF EXISTS `config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `config` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `set_name` varchar(50) DEFAULT NULL COMMENT 'setting name',
  `set_value` text COMMENT 'setting value',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config`
--

LOCK TABLES `config` WRITE;
/*!40000 ALTER TABLE `config` DISABLE KEYS */;
/*!40000 ALTER TABLE `config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `customer_uuid` varchar(40) DEFAULT NULL COMMENT 'Customer uuid',
  `name` varchar(110) NOT NULL COMMENT 'Customer Name',
  `address` varchar(355) DEFAULT NULL COMMENT 'Customer Address(optional)',
  `contact_no` varchar(45) DEFAULT NULL COMMENT 'Customer Contact Number',
  `is_enable` enum('N','Y') NOT NULL DEFAULT 'Y',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='To Store Customer information in this table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `groups` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(60) DEFAULT NULL,
  `access_type` enum('all','limited') NOT NULL DEFAULT 'limited',
  `access_level` int NOT NULL DEFAULT '50',
  `api_perms` json DEFAULT NULL,
  `front_perms` json DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups`
--

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
INSERT INTO `groups` VALUES (1,'Super Admin','all',100,NULL,NULL,'2022-09-29 20:50:24','2022-09-29 20:50:24'),(2,'Administrator','all',90,NULL,NULL,'2022-09-30 06:58:19','2022-09-30 06:58:19');
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory`
--

DROP TABLE IF EXISTS `inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory` (
  `id` int unsigned NOT NULL,
  `product_id` int unsigned NOT NULL,
  `location_id` int unsigned NOT NULL,
  `opening_qty` int unsigned NOT NULL,
  `opening_date` datetime NOT NULL,
  `qty_in` int unsigned NOT NULL,
  `qty_in_date` datetime NOT NULL,
  `qty_out` int unsigned NOT NULL,
  `qty_out_date` datetime NOT NULL,
  `qty_adj` datetime NOT NULL,
  `qty_adj_date` datetime NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int unsigned NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by` int unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory`
--

LOCK TABLES `inventory` WRITE;
/*!40000 ALTER TABLE `inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invites`
--

DROP TABLE IF EXISTS `invites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int DEFAULT NULL,
  `sent_to_name` varchar(100) NOT NULL,
  `sent_to_email` varchar(150) NOT NULL,
  `invite_token` varchar(100) NOT NULL,
  `invite_sent_on` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `invite_expiry` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `invite_status` enum('new','expired','used') DEFAULT 'new',
  `invite_used_on` datetime DEFAULT NULL,
  `sent_count` int DEFAULT '0',
  `group_id` int NOT NULL DEFAULT '2',
  PRIMARY KEY (`id`),
  UNIQUE KEY `invitetoken_UNIQUE` (`invite_token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invites`
--

LOCK TABLES `invites` WRITE;
/*!40000 ALTER TABLE `invites` DISABLE KEYS */;
/*!40000 ALTER TABLE `invites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `locations` (
  `id` int unsigned NOT NULL,
  `location_type` enum('shop','warehouse') NOT NULL DEFAULT 'shop',
  `address` varchar(255) NOT NULL,
  `contact_no` varchar(45) NOT NULL,
  `city` varchar(150) NOT NULL,
  `country` varchar(150) NOT NULL,
  `zip_code` varchar(45) NOT NULL,
  `created_by` int unsigned NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_by` int unsigned NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int unsigned NOT NULL,
  `category_id` int unsigned DEFAULT NULL,
  `inventory_id` int unsigned DEFAULT NULL,
  `category_name` varchar(255) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `product_slug` varchar(255) NOT NULL,
  `product_sku` varchar(250) NOT NULL,
  `make` varchar(150) DEFAULT NULL,
  `product_image` varchar(255) NOT NULL,
  `product_description` tinytext,
  `status` enum('Y','N') DEFAULT 'Y',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int unsigned DEFAULT NULL,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `auth_key` varchar(255) NOT NULL,
  `api_key` varchar(255) NOT NULL,
  `user_id` int unsigned NOT NULL,
  `never_expire` tinyint(1) NOT NULL DEFAULT '0',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3 COMMENT='To Store user sessions information in this table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES (1,'OTM3MjhiZTgyNTMxN2MzODcwMGM0ZjU5NWFkMzU5NTMwOWY0MTEzMDczZDU4YjZmZTlmM2M3ODExYmRkYzlkMA==','ADLKH2KJLHSADFLKJH32PODASVIOUHKJN39923876D243242G21DF1345V21321DV0A3LKJ',1,0,'2022-09-30 07:35:16','2022-09-30 07:35:16'),(2,'Y2Y5Y2Y4MDIyNDE2NGJmZjJiZThiNmExOWU1YWMzNDU1NjdkMzA1ODg4MGNiNTFjOGQzYTA0YjIxN2VlNTBhMw==','ADLKH2KJLHSADFLKJH32PODASVIOUHKJN39923876D243242G21DF1345V21321DV0A3LKJ',1,0,'2022-09-30 07:35:36','2022-09-30 07:35:36'),(3,'NmYwMDJhZGI5MzgzOWMxZmMzYzA2OTBkNDk0ZmUxMzk3MmE2Zjc5ZWM4OTg1ZjU5YzQ3NGU1YmI0MmM4YjZmOA==','SEL6Fynf6kEfZCscglYs0qgXg693DvJ79PQ9YzXLTyYhmnykh53Uo0GoH5g5HnjM',1,0,'2022-09-30 10:59:37','2022-09-30 10:59:37'),(4,'NjAzODIwMzVhYjY4NzI4ZDI0MGU4MDk5MzI2MzAyMmQwMWU5ZTBkYWQ3MTI4ZDEyZmMzZmM3OTA4MDllYzJhNw==','SEL6Fynf6kEfZCscglYs0qgXg693DvJ79PQ9YzXLTyYhmnykh53Uo0GoH5g5HnjM',1,0,'2022-09-30 11:04:04','2022-09-30 11:04:04'),(5,'NWQ3ZDJhMWJiY2JiY2FmOTNmMzU3Zjg1NmZmNDc1YjFlMzkxYWVkODgyODk4OTVjMzBjZmY0Y2NkYzc2YzRjOA==','SEL6Fynf6kEfZCscglYs0qgXg693DvJ79PQ9YzXLTyYhmnykh53Uo0GoH5g5HnjM',1,0,'2022-09-30 11:04:23','2022-09-30 11:04:23'),(11,'NjJhMzZmMGIwNjYzY2VlYzdkNWM1MmQ5MTNkZTgwNmE1N2NjNmQwODAzYzMxYWVmNGY1MWFkNjNlNGYwNTcyMw==','SEL6Fynf6kEfZCscglYs0qgXg693DvJ79PQ9YzXLTyYhmnykh53Uo0GoH5g5HnjM',1,0,'2022-10-01 11:07:05','2022-10-01 11:06:58'),(12,'Y2U1ZDBmMWQ1ODI3OWM1YWZiMjhiYzQ4ZTI0ZDMyZjk5NjhmMGJhM2QzNzU1MTgwZjYxNGJjMWEzNjFhMjAwYQ==','SEL6Fynf6kEfZCscglYs0qgXg693DvJ79PQ9YzXLTyYhmnykh53Uo0GoH5g5HnjM',1,0,'2022-10-01 11:31:23','2022-10-01 11:24:12');
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `full_name` varchar(80) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('superadmin','administrator','analyst') NOT NULL DEFAULT 'administrator',
  `group_id` int NOT NULL DEFAULT '2',
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `is_enable` enum('N','Y') NOT NULL DEFAULT 'Y',
  `is_enable_old` enum('N','Y') NOT NULL DEFAULT 'Y',
  `customer_id` int unsigned NOT NULL,
  `display_timezone` varchar(70) NOT NULL DEFAULT 'Etc/UTC',
  `timezone_displayname` varchar(100) NOT NULL DEFAULT 'UTC - Coordinated Universal Time',
  `last_login_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int unsigned NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_email_uniq` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COMMENT='To Store ecc users information in this table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Kashif Asghar','kashif-asghar@hotmail.com','$2y$10$/TThGjTzoxlOxZeHF.Nq0.TaFnTvGnTaUQXNL8/6WUWE1aZQlWxZC','administrator',2,0,'Y','Y',1,'Etc/Universal','UTC - Coordinated Universal Time','2022-09-30 01:34:41','2022-09-30 01:34:41',1,'2022-09-30 01:34:41',1);
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

-- Dump completed on 2022-10-02  1:58:26
