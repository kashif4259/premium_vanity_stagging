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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-12-26  1:51:06
