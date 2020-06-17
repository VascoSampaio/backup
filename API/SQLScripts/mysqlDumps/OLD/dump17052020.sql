-- MySQL dump 10.17  Distrib 10.3.22-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: pleezApp
-- ------------------------------------------------------
-- Server version	10.3.22-MariaDB-0ubuntu0.19.10.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `attributecategory`
--

DROP TABLE IF EXISTS `attributecategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attributecategory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `multipleChoice` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`multipleChoice` in (0,1))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attributecategory`
--

LOCK TABLES `attributecategory` WRITE;
/*!40000 ALTER TABLE `attributecategory` DISABLE KEYS */;
INSERT INTO `attributecategory` VALUES (1,'Tipo',0),(2,'Temperatura',1);
/*!40000 ALTER TABLE `attributecategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attributes`
--

DROP TABLE IF EXISTS `attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attributes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `attributeCategoryId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `attributeCategoryId` (`attributeCategoryId`),
  CONSTRAINT `attributes_ibfk_1` FOREIGN KEY (`attributeCategoryId`) REFERENCES `attributecategory` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attributes`
--

LOCK TABLES `attributes` WRITE;
/*!40000 ALTER TABLE `attributes` DISABLE KEYS */;
INSERT INTO `attributes` VALUES (1,'Verde',2,1),(2,'Branco',1.5,1),(3,'Fresco',0,2),(4,'Ambiente',0,2);
/*!40000 ALTER TABLE `attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attributesOrderProduct`
--

DROP TABLE IF EXISTS `attributesOrderProduct`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attributesOrderProduct` (
  `orderProductId` int(11) NOT NULL,
  `attributeId` int(11) NOT NULL,
  PRIMARY KEY (`orderProductId`,`attributeId`),
  KEY `attributeId` (`attributeId`),
  CONSTRAINT `attributesOrderProduct_ibfk_1` FOREIGN KEY (`orderProductId`) REFERENCES `orderProducts` (`id`),
  CONSTRAINT `attributesOrderProduct_ibfk_2` FOREIGN KEY (`attributeId`) REFERENCES `attributes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attributesOrderProduct`
--

LOCK TABLES `attributesOrderProduct` WRITE;
/*!40000 ALTER TABLE `attributesOrderProduct` DISABLE KEYS */;
/*!40000 ALTER TABLE `attributesOrderProduct` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `description` varchar(280) DEFAULT NULL,
  `level` int(11) DEFAULT NULL,
  `categoryId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `categoryId` (`categoryId`),
  CONSTRAINT `categories_ibfk_1` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Bebidas','Bebidas com álcool e sem álcool',0,NULL),(4,'Pratos Principais','Pratos Principais',0,NULL),(6,'Massas e Risottos','Massas e Risottos',0,NULL),(7,'Sobremesas','Dolci',1,8),(8,'Sobremesa','Pratos de sobremesa',0,NULL),(9,'Massa e Risotto','Sopa do dias',1,6),(11,'Entradas','Entradas',0,NULL),(13,'Da Horta','Da Horta',1,4),(14,'Do Mar','Do Mar',1,4),(15,'Da Terra','Da Terra',1,4),(16,'Vinho Branco','Vinho Branco',1,1),(17,'Vinho Tinto','Vinho Tinto',1,1),(18,'Vinho Verde','Vinho Verde',1,1),(19,'Vinho Rosé','Vinho Rosé',1,1),(20,'Espumante','Espumante',1,1),(21,'Cocktails','Cocktails',1,1),(22,'Vodka','Vodka',1,1),(23,'Aperitivos','Aperitivos',1,1),(24,'Digestivos','Digestivos',1,1),(25,'Gin','Gin',1,1),(26,'Whiskey','Whiskey',1,1),(27,'Rum','Rum',1,1),(28,'Cerveja','Cerveja',1,1),(29,'Sangria','Sangria',1,1),(30,'Refrigerantes','Refrigerantes',1,1),(31,'Sumos Naturais','Sumos Naturais',1,1),(32,'Águas','Águas',1,1),(33,'Cafés','Cafés',1,1),(34,'Chás','Chás',1,1),(35,'Champanhe','Champanhe',1,1);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categoriesicons`
--

DROP TABLE IF EXISTS `categoriesicons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categoriesicons` (
  `categoryId` int(11) NOT NULL,
  `iconId` int(11) NOT NULL,
  PRIMARY KEY (`categoryId`,`iconId`),
  KEY `iconId` (`iconId`),
  CONSTRAINT `categoriesicons_ibfk_1` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`id`),
  CONSTRAINT `categoriesicons_ibfk_2` FOREIGN KEY (`iconId`) REFERENCES `icons` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoriesicons`
--

LOCK TABLES `categoriesicons` WRITE;
/*!40000 ALTER TABLE `categoriesicons` DISABLE KEYS */;
INSERT INTO `categoriesicons` VALUES (1,2),(4,1),(6,3),(7,1),(8,4);
/*!40000 ALTER TABLE `categoriesicons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categoryservices`
--

DROP TABLE IF EXISTS `categoryservices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categoryservices` (
  `categoryId` int(11) NOT NULL,
  `serviceId` int(11) NOT NULL,
  PRIMARY KEY (`categoryId`,`serviceId`),
  KEY `serviceId` (`serviceId`),
  CONSTRAINT `categoryservices_ibfk_1` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`id`),
  CONSTRAINT `categoryservices_ibfk_2` FOREIGN KEY (`serviceId`) REFERENCES `services` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoryservices`
--

LOCK TABLES `categoryservices` WRITE;
/*!40000 ALTER TABLE `categoryservices` DISABLE KEYS */;
INSERT INTO `categoryservices` VALUES (1,1);
/*!40000 ALTER TABLE `categoryservices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `icons`
--

DROP TABLE IF EXISTS `icons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `icons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `imageLocation` varchar(100) DEFAULT NULL,
  `iconType` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `icons`
--

LOCK TABLES `icons` WRITE;
/*!40000 ALTER TABLE `icons` DISABLE KEYS */;
INSERT INTO `icons` VALUES (1,'pratos','/static/images/Pleez_IconesMenu_32.png',NULL),(2,'bebidas','/static/images/Pleez_IconesMenu_5.png',NULL),(3,'entradas','/static/images/Pleez_IconesMenu_10.png',NULL),(4,'sobremesas','/static/images/Pleez_IconesMenu_24.png',NULL);
/*!40000 ALTER TABLE `icons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
INSERT INTO `locations` VALUES (1,'Sala 1'),(2,'Sala 2');
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderProducts`
--

DROP TABLE IF EXISTS `orderProducts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orderProducts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderId` int(11) DEFAULT NULL,
  `productId` int(11) DEFAULT NULL,
  `description` varchar(64) DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `orderId` (`orderId`),
  KEY `productId` (`productId`),
  CONSTRAINT `orderProducts_ibfk_1` FOREIGN KEY (`orderId`) REFERENCES `orders` (`id`),
  CONSTRAINT `orderProducts_ibfk_2` FOREIGN KEY (`productId`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderProducts`
--

LOCK TABLES `orderProducts` WRITE;
/*!40000 ALTER TABLE `orderProducts` DISABLE KEYS */;
INSERT INTO `orderProducts` VALUES (87,81,86,'',1),(88,81,17,'',1),(89,82,29,'',3),(90,85,42,'',3),(91,87,29,'',11),(92,94,16,'',1),(93,96,10,'',4),(94,98,21,'',1),(95,99,18,'',1);
/*!40000 ALTER TABLE `orderProducts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tableId` int(11) DEFAULT NULL,
  `orderAddTime` datetime DEFAULT NULL,
  `finishTime` datetime DEFAULT NULL,
  `callType` tinyint(1) DEFAULT NULL,
  `billType` tinyint(1) DEFAULT NULL,
  `nif` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `terminalId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tableId` (`tableId`),
  KEY `terminalId` (`terminalId`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`tableId`) REFERENCES `tables` (`id`),
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`terminalId`) REFERENCES `terminals` (`id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`callType` in (0,1)),
  CONSTRAINT `CONSTRAINT_2` CHECK (`billType` in (0,1))
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,'2020-05-14 00:05:52','2020-05-14 00:11:26',0,0,NULL,NULL,NULL),(2,1,'2020-05-14 00:06:17','2020-05-14 00:11:47',0,0,NULL,NULL,NULL),(3,1,'2020-05-14 00:06:21','2020-05-14 00:11:56',0,0,NULL,NULL,NULL),(4,2,'2020-05-14 00:06:59','2020-05-14 00:12:08',1,0,NULL,NULL,NULL),(5,1,'2020-05-14 00:07:02','2020-05-14 00:12:17',0,0,NULL,NULL,NULL),(6,1,'2020-05-14 00:11:10','2020-05-14 00:12:10',0,0,NULL,NULL,NULL),(7,1,'2020-05-14 00:13:11','2020-05-14 00:15:38',0,0,NULL,NULL,NULL),(8,1,'2020-05-14 00:13:14','2020-05-14 13:01:52',0,0,NULL,NULL,NULL),(9,1,'2020-05-14 00:16:02','2020-05-14 00:29:28',0,0,NULL,NULL,NULL),(10,1,'2020-05-14 00:17:24','2020-05-14 13:48:33',0,0,NULL,NULL,NULL),(11,1,'2020-05-14 00:18:47','2020-05-14 13:56:34',0,0,NULL,NULL,NULL),(12,1,'2020-05-14 00:19:32','2020-05-14 13:59:54',0,0,NULL,NULL,NULL),(13,1,'2020-05-14 00:20:44','2020-05-14 14:00:01',0,0,NULL,NULL,NULL),(14,1,'2020-05-14 00:20:55','2020-05-14 12:55:21',0,0,NULL,NULL,NULL),(15,1,'2020-05-14 00:21:43','2020-05-14 13:52:58',0,0,NULL,NULL,NULL),(16,1,'2020-05-14 00:22:45','2020-05-14 02:18:58',0,0,NULL,NULL,NULL),(17,1,'2020-05-14 00:23:31','2020-05-14 02:23:00',0,0,NULL,NULL,NULL),(18,1,'2020-05-14 00:24:36','2020-05-14 02:23:45',0,0,NULL,NULL,NULL),(20,1,'2020-05-14 00:28:11','2020-05-14 02:15:15',0,0,NULL,NULL,NULL),(21,1,'2020-05-14 00:28:19','2020-05-14 12:56:03',0,0,NULL,NULL,NULL),(22,1,'2020-05-14 00:29:15','2020-05-14 14:00:05',0,0,NULL,NULL,NULL),(23,1,'2020-05-14 00:32:07','2020-05-14 14:00:10',0,0,NULL,NULL,NULL),(24,1,'2020-05-14 00:32:41','2020-05-14 02:11:01',0,0,NULL,NULL,NULL),(25,1,'2020-05-14 00:33:30','2020-05-14 02:26:15',0,0,NULL,NULL,NULL),(26,1,'2020-05-14 00:34:08','2020-05-14 14:00:16',0,0,NULL,NULL,NULL),(27,2,'2020-05-14 00:37:34','2020-05-14 13:48:33',0,1,NULL,NULL,NULL),(28,2,'2020-05-14 01:18:08','2020-05-14 13:48:33',1,0,NULL,NULL,NULL),(29,2,'2020-05-14 01:33:36','2020-05-14 02:12:08',0,0,NULL,NULL,NULL),(30,2,'2020-05-14 02:07:29','2020-05-14 02:08:31',0,0,NULL,NULL,NULL),(31,1,'2020-05-14 11:29:34','2020-05-14 12:56:13',0,0,NULL,NULL,NULL),(32,1,'2020-05-14 11:39:29',NULL,0,1,876543,'jyhgfdsx',NULL),(33,1,'2020-05-14 11:42:35',NULL,1,0,NULL,NULL,NULL),(34,1,'2020-05-14 11:43:30',NULL,0,1,8765432,'ujhgfds',NULL),(35,1,'2020-05-14 11:43:57','2020-05-14 14:25:29',0,0,NULL,NULL,NULL),(36,1,'2020-05-14 11:44:08','2020-05-14 13:48:33',0,1,9876543,'kjhgfds',NULL),(37,1,'2020-05-14 12:05:59','2020-05-14 13:48:33',0,1,2132678,'yhgfdcs',NULL),(38,1,'2020-05-14 12:10:07','2020-05-14 13:48:33',1,0,NULL,NULL,NULL),(39,1,'2020-05-14 12:10:37','2020-05-14 13:48:33',0,1,123456,'uytrew',NULL),(40,2,'2020-05-14 13:54:50','2020-05-14 13:48:33',0,0,NULL,NULL,NULL),(41,2,'2020-05-14 14:16:01','2020-05-14 13:48:33',0,0,NULL,NULL,NULL),(42,2,'2020-05-14 14:24:35','2020-05-14 14:29:32',0,0,NULL,NULL,NULL),(43,2,'2020-05-14 14:24:36','2020-05-14 14:29:38',0,0,NULL,NULL,NULL),(44,2,'2020-05-14 14:24:45','2020-05-14 13:48:33',0,0,NULL,NULL,NULL),(45,2,'2020-05-14 14:24:45','2020-05-14 13:48:33',0,0,NULL,NULL,NULL),(46,2,'2020-05-14 14:24:45','2020-05-14 13:48:33',0,0,NULL,NULL,NULL),(47,2,'2020-05-14 14:24:45','2020-05-14 13:48:33',0,0,NULL,NULL,NULL),(48,2,'2020-05-14 14:24:45','2020-05-14 13:48:33',0,0,NULL,NULL,NULL),(49,2,'2020-05-14 14:24:45','2020-05-14 13:48:33',0,0,NULL,NULL,NULL),(50,2,'2020-05-14 14:24:45','2020-05-14 13:48:33',0,0,NULL,NULL,NULL),(51,2,'2020-05-14 14:24:45','2020-05-14 13:48:33',0,0,NULL,NULL,NULL),(52,2,'2020-05-14 14:24:45',NULL,1,0,NULL,NULL,NULL),(53,2,'2020-05-14 14:24:45',NULL,1,0,NULL,NULL,NULL),(54,2,'2020-05-14 14:24:45',NULL,0,0,NULL,NULL,NULL),(55,2,'2020-05-14 14:24:45',NULL,0,0,NULL,NULL,NULL),(56,2,'2020-05-14 14:24:45','2020-05-14 16:48:24',0,0,NULL,NULL,NULL),(57,2,'2020-05-14 14:24:45',NULL,0,0,NULL,NULL,NULL),(58,2,'2020-05-14 14:24:46',NULL,0,0,NULL,NULL,NULL),(59,2,'2020-05-14 14:24:46',NULL,0,0,NULL,NULL,NULL),(60,2,'2020-05-14 14:24:46',NULL,0,0,NULL,NULL,NULL),(61,2,'2020-05-14 14:24:46',NULL,0,0,NULL,NULL,NULL),(62,2,'2020-05-14 14:24:46',NULL,0,0,NULL,NULL,NULL),(63,2,'2020-05-14 14:24:46',NULL,0,0,NULL,NULL,NULL),(64,2,'2020-05-14 14:24:46',NULL,0,0,NULL,NULL,NULL),(65,2,'2020-05-14 14:24:46',NULL,0,0,NULL,NULL,NULL),(66,2,'2020-05-14 14:24:46','2020-05-14 16:16:50',0,0,NULL,NULL,NULL),(67,2,'2020-05-14 14:24:46',NULL,0,0,NULL,NULL,NULL),(68,2,'2020-05-14 14:24:46',NULL,0,0,NULL,NULL,NULL),(69,2,'2020-05-14 14:24:46','2020-05-14 16:16:57',0,0,NULL,NULL,NULL),(70,2,'2020-05-14 14:24:51',NULL,0,0,NULL,NULL,NULL),(71,2,'2020-05-14 14:24:53',NULL,0,0,NULL,NULL,NULL),(72,2,'2020-05-14 14:24:58','2020-05-14 14:29:28',0,0,NULL,NULL,NULL),(73,2,'2020-05-14 14:27:00','2020-05-14 14:27:56',0,0,NULL,NULL,NULL),(74,4,'2020-05-14 14:37:11',NULL,0,0,NULL,NULL,NULL),(75,4,'2020-05-14 14:53:35',NULL,0,1,515515515,'Rita',NULL),(76,1,'2020-05-14 22:01:02',NULL,0,0,NULL,NULL,NULL),(77,1,'2020-05-14 22:04:01',NULL,0,0,NULL,NULL,NULL),(78,1,'2020-05-14 22:04:40',NULL,0,1,13421,'sdas',NULL),(79,2,'2020-05-14 22:07:59',NULL,0,0,NULL,NULL,NULL),(80,1,'2020-05-15 10:20:34',NULL,0,0,NULL,NULL,NULL),(81,1,'2020-05-15 18:08:46',NULL,0,0,NULL,NULL,NULL),(82,1,'2020-05-15 21:16:53',NULL,0,0,NULL,NULL,NULL),(83,1,'2020-05-16 00:13:55',NULL,1,0,NULL,NULL,NULL),(84,1,'2020-05-16 00:14:10',NULL,1,0,NULL,NULL,NULL),(85,1,'2020-05-16 00:14:49',NULL,0,0,NULL,NULL,NULL),(86,1,'2020-05-16 00:15:07',NULL,0,1,7654,'jhgfd',NULL),(87,1,'2020-05-16 00:38:30',NULL,0,0,NULL,NULL,NULL),(88,1,'2020-05-16 00:38:32',NULL,1,0,NULL,NULL,NULL),(89,1,'2020-05-16 15:31:02',NULL,1,0,NULL,NULL,NULL),(90,1,'2020-05-16 15:31:26',NULL,1,0,NULL,NULL,NULL),(91,1,'2020-05-16 15:31:40',NULL,1,0,NULL,NULL,NULL),(92,1,'2020-05-16 15:31:46',NULL,1,0,NULL,NULL,NULL),(93,1,'2020-05-16 15:32:38',NULL,1,0,NULL,NULL,NULL),(94,1,'2020-05-16 15:59:45',NULL,0,0,NULL,NULL,NULL),(95,1,'2020-05-16 17:03:05',NULL,1,0,NULL,NULL,NULL),(96,1,'2020-05-16 17:06:30',NULL,0,0,NULL,NULL,NULL),(97,1,'2020-05-16 17:07:12',NULL,1,0,NULL,NULL,NULL),(98,1,'2020-05-16 17:11:44',NULL,0,0,NULL,NULL,NULL),(99,1,'2020-05-16 17:27:40',NULL,0,0,NULL,NULL,NULL);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paymentmethods`
--

DROP TABLE IF EXISTS `paymentmethods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paymentmethods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paymentmethods`
--

LOCK TABLES `paymentmethods` WRITE;
/*!40000 ALTER TABLE `paymentmethods` DISABLE KEYS */;
/*!40000 ALTER TABLE `paymentmethods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tableId` int(11) DEFAULT NULL,
  `paymentTime` datetime DEFAULT NULL,
  `value` float DEFAULT NULL,
  `paymentMethodId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tableId` (`tableId`),
  KEY `paymentMethodId` (`paymentMethodId`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`tableId`) REFERENCES `tables` (`id`),
  CONSTRAINT `payments_ibfk_2` FOREIGN KEY (`paymentMethodId`) REFERENCES `paymentmethods` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productattributes`
--

DROP TABLE IF EXISTS `productattributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productattributes` (
  `productId` int(11) NOT NULL,
  `attributeId` int(11) NOT NULL,
  PRIMARY KEY (`productId`,`attributeId`),
  KEY `attributeId` (`attributeId`),
  CONSTRAINT `productattributes_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `orders` (`id`),
  CONSTRAINT `productattributes_ibfk_2` FOREIGN KEY (`attributeId`) REFERENCES `products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productattributes`
--

LOCK TABLES `productattributes` WRITE;
/*!40000 ALTER TABLE `productattributes` DISABLE KEYS */;
INSERT INTO `productattributes` VALUES (29,1),(29,2),(29,3),(29,4);
/*!40000 ALTER TABLE `productattributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `categoryId` int(11) DEFAULT NULL,
  `allowDescription` tinyint(1) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `categoryId` (`categoryId`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`allowDescription` in (0,1))
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Salgado 1,5€',11,0,1.5,NULL),(2,'Creme do dia 3€',11,0,3,NULL),(3,'Camarão Panado 9,5€',11,0,9.5,'Panko, camarão, sweet chili'),(4,'Nigiri de pato fumado (4un) 7,5€',11,0,7.5,'Arroz sushi, pato fumado com ervas secas, molho teriyaki de laranja'),(5,'Ovos Sauvage 8€',11,0,8,'Ovo panado, lascas de batata, crumble de farinheira, molho aveludado de ervas'),(6,'Brás de farinheira 8,5€',11,0,8.5,'Batata palha, ovo, farinheira, azeitonas, salsa'),(7,'Prego de lombo de atum braseado 13€',11,0,13,'Pão brioche, atum fresco, compota de cebola roxa, chips de batata doce'),(8,'Ravioli al pesto 15€',9,0,15,'Recheado com bovino, espinafres, queijo parmesão e molho pesto'),(9,'Pad Thai Vegetais 13,5€',9,0,13.5,'Noodles de arroz, ovo, soja, amendoim, cebolinho, malagueta, tamarindo, legumes'),(10,'Pad Thai Frango 14,5€',9,0,14.5,'Noodles de arroz, ovo, soja, amendoim, cebolinho, malagueta, tamarindo, legumes'),(11,'Pad Thai Camarão 15,5€',9,0,15.5,'Noodles de arroz, ovo, soja, amendoim, cebolinho, malagueta, tamarindo, legumes'),(12,'Risotto de cogumelos 14€',9,0,14,'Arroz arbóreo, ragu de cogumelos, azeite trufado e queijo parmesão'),(13,'Risotto de pato 15€',9,0,15,'Arroz arbóreo, pato desfiado, chouriço crocante, queijo parmesão'),(14,'Spaghetti aioli 13,5€',9,0,13.5,'Tomate seco, alcaparras, salsa, picante, alho'),(15,'Salada de quinoa 12€',13,0,12,'Legumes salteados, cebola roxa, pesto de salsa e lascas de queijo parmesão'),(16,'Nasigoreng de legumes 13,5€',13,0,13.5,'Arroz frito, legumes, ovo, molho de soja'),(17,'Atum fresco 15,5€',14,0,15.5,'Tataki, legumes salteados, consomé de cogumelos, maionese de wasabi e salada wakamé'),(18,'Caril de camarão 15€',14,0,15,'Camarão, caril, arroz basmati'),(19,'Feijoada de choco com arroz basmati 14€',14,0,14,'Feijão branco, choco, enchidos, arroz basmati'),(20,'Pasteis de bacalhau 13€',14,0,13,'Pasteis de bacalhau, mayo de pickles, arroz tomate'),(21,'Bochechas de Porco 15,5€',15,0,15.5,'Bochechas de porco estufadas, puré de ervilhas, crispy bacon, ovo escalfado'),(22,'Empada de ragu de novilho 15€',15,0,15,'Com o molho do estufado, chips de batata doce, grelos salteados'),(23,'Chamuças de coelho 14€',15,0,14,'Com mayo de açafrão, arroz de ervilha'),(24,'Secretos à lagareiro 14,5€',15,0,14.5,'Com batata a murro, grelos salteados'),(25,'Mousse de chocolate negro 5€',7,0,5,'Flôr de sal e azeite'),(26,'Tarte de lima 5€',7,0,5,'Caramelizada'),(27,'Panna cotta 5€',7,0,5,'Chocolate branco, culi de frutos vermelhos'),(28,'Fruta da época 3,5€',7,0,3.5,NULL),(29,'Astronauta Moscatel Galego (DOURO) 20€',16,0,20,NULL),(30,'Ribeiro Santo Colheita (DÃO) 17€',16,0,17,NULL),(31,'Ribeiro Santo Colheita COPO 4,5€',16,0,4.5,NULL),(32,'5ª Lagar Novo (LISBOA) 20€',16,0,20,NULL),(33,'Maria Mora (ALENTEJO) 18€',16,0,18,NULL),(34,'Maria Mora (ALENTEJO) COPO 5€',16,0,5,NULL),(35,'Astronauta Vinhas Velhas (DOURO) 20€',17,0,20,NULL),(36,'Astronauta Vinhas Velhas (DOURO) COPO 5€',17,0,5,NULL),(37,'Ribeiro Santo Colheita (DÃO) 17€',17,0,17,NULL),(38,'Ribeiro Santo Colheita (DÃO) COPO 4,5€',17,0,4.5,NULL),(39,'Autocarro 27 (SETUBAL) 18€',17,0,18,NULL),(40,'Maria Mora (ALENTEJO) 18€',17,0,18,NULL),(41,'Maria Mora (ALENTEJO) COPO 5€',17,0,5,NULL),(42,'Soalheiro Allo 17€',18,0,17,NULL),(43,'Soalheiro Allo COPO 4,5€',18,0,4.5,NULL),(44,'Ribeiro Santo (DÃO) 17€',19,0,17,NULL),(45,'Ribeiro Santo (DÃO) COPO 4,5€',19,0,4.5,NULL),(46,'Luís Pato Blanc des Blancs 18€',20,0,18,NULL),(47,'Luís Pato Blanc des Blancs COPO 5€',20,0,5,NULL),(48,'Moet Chandon Brut Imperial 65€',35,0,65,NULL),(49,'Viper Eyes 8,5€',21,0,8.5,'Aperitivo: Martini Fiero, Martini Ambrato, sumo de limão, hibiscus, água Castello'),(50,'OIE 9,5€',21,0,9.5,'Aperitivo: Grey Goose, St. Germain, sumo de limão, água Castello'),(51,'Mico 9,5€',21,0,9.5,'Refeição: Bacardi 4, abacaxi, sumo de limão, hortelã, água Castello'),(52,'Mowgli 9,5€',21,0,9.5,'Refeição: Eristoff, morango, sumo de limão, hortelã, ginger beer'),(53,'Weasel 9,5€',21,0,9.5,'Digestivo: Aberfeldy, agave, bitter de laranja, bitter de chocolate'),(54,'Eristoff 6€',22,0,6,NULL),(55,'Grey Goose 8,5€',22,0,8.5,NULL),(56,'Martini Rubino 6€',23,0,6,NULL),(57,'Martini Ambrato 6€',23,0,6,NULL),(58,'Martini Fiero 6€',23,0,6,NULL),(59,'Carcavelos Villa Oeiras 6€',24,0,6,NULL),(60,'Porto Andresen Tawny 5€',24,0,5,NULL),(61,'Porto Andresen White 5€',24,0,5,NULL),(62,'Licor Beirão 4€',24,0,4,NULL),(63,'Amarguinha 4€',24,0,4,NULL),(64,'CRF 5€',24,0,5,NULL),(65,'Bombay Dry 8€',25,0,8,NULL),(66,'Star of Bombay 10€',25,0,10,NULL),(67,'Hendrick´s 9€',25,0,9,NULL),(68,'Citadelle 9€',25,0,9,NULL),(69,'Monkey 47 12€',25,0,12,NULL),(70,'Monkey 47 Sloe Gin 12€',25,0,12,NULL),(71,'Dewar´s 6€',26,0,6,NULL),(72,'Bushmills 8€',26,0,8,NULL),(73,'Jameson 7€',26,0,7,NULL),(74,'Nikka from the barrel 12€',26,0,12,NULL),(75,'Aberfeldy 12€',26,0,12,NULL),(76,'Bacardi Carta Blanca 6€',27,0,6,NULL),(77,'Bacardi 4 7€',27,0,7,NULL),(78,'Diplomatico Reserva Exclusivo 12€',27,0,12,NULL),(79,'Heineken 2€',28,0,2,NULL),(80,'Heineken Pint 2€',28,0,2,NULL),(81,'Heineken Panaché 4€',28,0,4,NULL),(82,'Heineken 0.0 2€',28,0,2,NULL),(83,'Heineken 0,33cl 2,5€',28,0,2.5,NULL),(84,'Bandida do Pomar 2,5€',28,0,2.5,NULL),(85,'Espumante (2L) 28€',29,0,28,'Espumante, vodka Eristoff, rum Bacardi, lima, puré de framboesa, hortelão, sprite'),(86,'Rosé (2L) 25€',29,0,25,'Vinho rosé, vodka Eristoff, rum Bacardi, puré de framboesa, hortelã, sprite'),(87,'Branca (2L) 22€',29,0,22,'Vinho branco, vodka Eristoff, rum Bacardi, laranja, limão, maçã, hortelã, frutos vermelhos, sumo maracujá, sprite'),(88,'Tinta (2L) 22€',29,0,22,'Vinho tinto, vodka Eristoff, rum Bacardi, laranja, limão, maçã, hortelã, canela, sprite'),(89,'Coca-cola 2,5€',30,0,2.5,NULL),(90,'Coca-cola zero 2,5€',30,0,2.5,NULL),(91,'Sprite copo 2€',30,0,2,NULL),(92,'Nestea Limão/Pêssego 2€',30,0,2,NULL),(93,'Ginge Ale Fever-Tree 3,5€',30,0,3.5,NULL),(94,'Ginger-Beer Fever-Tree 3,5€',30,0,3.5,NULL),(95,'Sumo de laranja 3,5€',31,0,3.5,NULL),(96,'Limonada 3,5€',31,0,3.5,NULL),(97,'Sumo Sauvage 3,5€',31,0,3.5,NULL),(98,'Água Luso 25cl 1,5€',32,0,1.5,NULL),(99,'Água Luso 50cl 2,8€',32,0,2.8,NULL),(100,'Água Tónica Fever-Tree 3,5€',32,0,3.5,NULL),(101,'Água Luso Gás 2,2€',32,0,2.2,NULL),(102,'Água Castello 2,2€',32,0,2.2,NULL),(103,'Café 1€',33,0,1,NULL),(104,'Descafeinado 1€',33,0,1,NULL),(105,'Café Duplo 2€',33,0,2,NULL),(106,'Cappuccino 2,5€',33,0,2.5,NULL),(107,'Carioca de Limão 1,5€',33,0,1.5,NULL),(108,'Preto 2,2€',34,0,2.2,NULL),(109,'Verde 2,2€',34,0,2.2,NULL),(110,'Tília 2,2€',34,0,2.2,NULL),(111,'Camomila 2,2€',34,0,2.2,NULL),(112,'Menta 2,2€',34,0,2.2,NULL),(113,'Cidreira 2,2€',34,0,2.2,NULL),(114,'Frutos Vermelhos 2,2€',34,0,2.2,NULL);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'ADMIN');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `services` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`),
  CONSTRAINT `services_ibfk_1` FOREIGN KEY (`locationId`) REFERENCES `locations` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES (1,'Serviço Sala 1',1);
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `serviceusers`
--

DROP TABLE IF EXISTS `serviceusers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serviceusers` (
  `userId` int(11) NOT NULL,
  `serviceId` int(11) NOT NULL,
  PRIMARY KEY (`userId`,`serviceId`),
  KEY `serviceId` (`serviceId`),
  CONSTRAINT `serviceusers_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`),
  CONSTRAINT `serviceusers_ibfk_2` FOREIGN KEY (`serviceId`) REFERENCES `services` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `serviceusers`
--

LOCK TABLES `serviceusers` WRITE;
/*!40000 ALTER TABLE `serviceusers` DISABLE KEYS */;
/*!40000 ALTER TABLE `serviceusers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `systemproperties`
--

DROP TABLE IF EXISTS `systemproperties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `systemproperties` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `resName` varchar(64) DEFAULT NULL,
  `resIcon` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `systemproperties`
--

LOCK TABLES `systemproperties` WRITE;
/*!40000 ALTER TABLE `systemproperties` DISABLE KEYS */;
/*!40000 ALTER TABLE `systemproperties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tables`
--

DROP TABLE IF EXISTS `tables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tables` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `internalNumber` int(11) DEFAULT NULL,
  `displayNumber` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `internalNumber` (`internalNumber`),
  UNIQUE KEY `displayNumber` (`displayNumber`),
  KEY `locationId` (`locationId`),
  CONSTRAINT `tables_ibfk_1` FOREIGN KEY (`locationId`) REFERENCES `locations` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tables`
--

LOCK TABLES `tables` WRITE;
/*!40000 ALTER TABLE `tables` DISABLE KEYS */;
INSERT INTO `tables` VALUES (1,1,12345,1),(2,2,54321,1),(3,3,14735,1),(4,4,15665,1),(5,5,611581,1),(6,6,403660,1),(7,7,858644,1),(8,8,850228,1),(9,9,184139,1);
/*!40000 ALTER TABLE `tables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `terminals`
--

DROP TABLE IF EXISTS `terminals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `terminals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `terminalTypeId` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `terminalTypeId` (`terminalTypeId`),
  KEY `userId` (`userId`),
  CONSTRAINT `terminals_ibfk_1` FOREIGN KEY (`terminalTypeId`) REFERENCES `terminaltypes` (`id`),
  CONSTRAINT `terminals_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `terminals`
--

LOCK TABLES `terminals` WRITE;
/*!40000 ALTER TABLE `terminals` DISABLE KEYS */;
INSERT INTO `terminals` VALUES (1,'Tablet POS',1,1),(2,'SmartWatch Balcao',2,1);
/*!40000 ALTER TABLE `terminals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `terminaltypes`
--

DROP TABLE IF EXISTS `terminaltypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `terminaltypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `terminaltypes`
--

LOCK TABLES `terminaltypes` WRITE;
/*!40000 ALTER TABLE `terminaltypes` DISABLE KEYS */;
INSERT INTO `terminaltypes` VALUES (1,'Tablet'),(2,'Smartwatch');
/*!40000 ALTER TABLE `terminaltypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(64) DEFAULT NULL,
  `email` varchar(64) DEFAULT NULL,
  `roleId` int(11) DEFAULT NULL,
  `passwordHash` varchar(128) DEFAULT NULL,
  `pinHash` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_users_username` (`username`),
  UNIQUE KEY `ix_users_email` (`email`),
  KEY `roleId` (`roleId`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`roleId`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','admin@admin.com',1,'pbkdf2:sha256:50000$c8JipWqy$746815d58ed3aea2db4628cd26db03f19b3fa1c2bc91c0b697fda348c638ac15','pbkdf2:sha256:50000$rBGGkHxk$3e565e32c8d332f109e04b6bfb3fac0356053570649033da56fbcb56bf999eb8');
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

-- Dump completed on 2020-05-17 18:31:22
