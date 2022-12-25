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
  `order_status` enum('pendding','pickedup','cancelled','hold','processed','ready') CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'pendding',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'2022-11-14','receiving',NULL,300.00,0.00,0.00,300.00,'supplier',0.00,'done',0.00,NULL,NULL,1,NULL,NULL,1,NULL,NULL,'1','2022-11-14 20:37:51','2022-11-14 20:37:51',NULL,'pendding'),(4,'2022-11-16','receiving',NULL,700.00,0.00,0.00,700.00,'supplier',0.00,'done',0.00,NULL,NULL,1,NULL,NULL,1,NULL,NULL,'1','2022-11-16 17:15:09','2022-11-16 17:15:10',NULL,'pendding'),(5,'2022-11-16','receiving',NULL,2500.00,0.00,0.00,2500.00,'supplier',0.00,'done',0.00,NULL,NULL,1,NULL,NULL,1,NULL,NULL,'2','2022-11-16 17:34:11','2022-11-16 17:34:11',NULL,'pendding'),(6,'2022-11-16','receiving',NULL,6500.00,0.00,0.00,6500.00,'supplier',0.00,'done',0.00,NULL,NULL,1,NULL,NULL,1,NULL,NULL,'3','2022-11-16 17:39:40','2022-11-16 17:39:41',NULL,'pendding'),(7,'2022-11-16','sales','abcd',547.00,0.00,0.00,547.00,'customer',447.00,'done',0.00,4,NULL,1,NULL,NULL,1,NULL,NULL,'1','2022-11-16 22:51:00','2022-11-16 17:51:55',NULL,'pendding'),(8,'2022-11-16','sales',NULL,875.00,0.00,0.00,875.00,'customer',225.00,'done',0.00,NULL,NULL,1,NULL,NULL,1,NULL,NULL,'2','2022-11-17 00:49:00','2022-11-16 19:49:08',NULL,'pendding'),(9,'2022-11-21','receiving',NULL,9000.00,0.00,0.00,9000.00,'supplier',0.00,'done',0.00,NULL,NULL,1,NULL,NULL,1,NULL,NULL,'4','2022-11-21 19:40:57','2022-11-21 19:40:58',NULL,'pendding'),(10,'2022-11-21','sales','test notes',833.00,0.00,0.00,833.00,'customer',233.00,'done',2.00,6,NULL,1,NULL,NULL,1,NULL,NULL,'3','2022-11-22 00:45:00','2022-11-21 19:45:43',NULL,'pendding'),(11,'2022-11-25','sales','test notes',650.00,0.00,0.00,1150.00,'customer',550.00,'delete',0.00,NULL,NULL,1,NULL,NULL,1,NULL,NULL,'4','2022-11-26 02:28:00','2022-12-22 14:40:23',NULL,'pendding'),(12,'2022-11-25','sales',NULL,650.00,0.00,350.00,1150.00,'customer',550.00,'done',0.00,2,NULL,1,NULL,NULL,1,NULL,NULL,'5','2022-11-26 02:33:00','2022-11-25 21:34:18',NULL,'pendding');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-12-26  1:51:06
