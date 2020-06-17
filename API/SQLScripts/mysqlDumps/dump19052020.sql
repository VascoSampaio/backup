-- MySQL dump 10.17  Distrib 10.3.22-MariaDB, for debian-linux-gnueabihf (armv8l)
--
-- Host: localhost    Database: pleezApp
-- ------------------------------------------------------
-- Server version	10.3.22-MariaDB-0+deb10u1

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

USE pleezApp;
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attributecategory`
--

LOCK TABLES `attributecategory` WRITE;
/*!40000 ALTER TABLE `attributecategory` DISABLE KEYS */;
INSERT INTO `attributecategory` VALUES (1,'Gelo',0),(2,'Sem Gelo',0);
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attributes`
--

LOCK TABLES `attributes` WRITE;
/*!40000 ALTER TABLE `attributes` DISABLE KEYS */;
INSERT INTO `attributes` VALUES (1,'Com Gelo',NULL,1),(2,'Sem Gelo',NULL,2);
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
INSERT INTO `attributesOrderProduct` VALUES (107,1),(107,2),(108,1),(108,2),(109,1),(109,2),(110,1),(110,2),(111,1),(111,2),(112,1),(112,2);
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
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Bebidas','Bebidas com álcool e sem álcool',0,NULL),(3,'Pizze Dolci','Pizze Dolci',1,8),(4,'Prato de Carne','Prato de Carne',0,NULL),(6,'Prato de Peixe','Prato de Peixe',0,NULL),(7,'Sobremesas','Sobremesas',1,8),(8,'Sobremesa','Pratos de sobremesa',0,NULL),(9,'Pizza Bambino','Pizza Bambino',1,4),(10,'Pizzas','Pizzas',1,4),(11,'Entradas','Entradas',0,NULL),(12,'Extra','Extra',1,4),(13,'Sumo Natural','Sumo Natural',1,1),(14,'Águas','Águas',1,1),(15,'Refrigerantes','Refrigerantes',1,1),(16,'Cervejas sem álcool','Cerveja sem lcool',1,1),(17,'Chás','Chás',1,1),(18,'Cafés','Cafés',1,1),(19,'Cervejas','Cervejas',1,1),(20,'Caipirinhas','Caipirinhas',1,1),(21,'Digestivos','Digestivos',1,1),(22,'Espirituosas','Espirituosas',1,1),(23,'Whiskey','Whiskey',1,1),(24,'Vinho da casa','Vinho da casa',1,1),(25,'Sangria de Vinho Branco ou Tinto ','Sangria de vinho',1,1),(26,'Sangria de spumante com Frutos Vermelhos','Sangria espumante',1,1),(27,'Sangria Tropical de Vinho Branco com Manga, Ananás, Maracujá','Sangria Tropical',1,1),(28,'Vinhos Italianos','Vinhos Italianos',1,1),(29,'Vinhos Portugueses','Vinhos Portugueses',1,1),(30,'Menu Executivo','Menu Executivo',1,4),(31,'Menu Almoço','Menu Almoço',1,4),(32,' Menu Executivo',' Menu Executivo',1,6),(33,' Menu Almoço',' Menu Almoço',1,6),(34,'Pratos de Massa','Pratos de Massa',1,4),(35,'Risotto','Risotto',1,4),(36,'Sangrias','Sangrias',1,1);
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
INSERT INTO `categoriesicons` VALUES (1,2),(4,1),(6,3),(7,1),(8,4),(11,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderProducts`
--

LOCK TABLES `orderProducts` WRITE;
/*!40000 ALTER TABLE `orderProducts` DISABLE KEYS */;
INSERT INTO `orderProducts` VALUES (96,100,58,'',3),(97,101,58,'',2),(98,102,11,'',3),(99,113,17,'',1),(100,114,18,'',2),(101,114,59,'',1),(102,114,17,'',2),(103,122,17,'',2),(104,125,17,'',1),(105,130,17,'',2),(106,133,18,'',1),(107,144,58,'',2),(108,145,58,'',1),(109,146,58,'kjhgfd',4),(110,151,58,'',2),(111,154,58,'',2),(112,155,58,'',2);
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
) ENGINE=InnoDB AUTO_INCREMENT=158 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,'2020-05-14 00:05:52','2020-05-14 00:11:26',0,0,NULL,NULL,NULL),(2,1,'2020-05-14 00:06:17','2020-05-14 00:11:47',0,0,NULL,NULL,NULL),(3,1,'2020-05-14 00:06:21','2020-05-14 00:11:56',0,0,NULL,NULL,NULL),(4,2,'2020-05-14 00:06:59','2020-05-14 00:12:08',1,0,NULL,NULL,NULL),(5,1,'2020-05-14 00:07:02','2020-05-14 00:12:17',0,0,NULL,NULL,NULL),(6,1,'2020-05-14 00:11:10','2020-05-14 00:12:10',0,0,NULL,NULL,NULL),(7,1,'2020-05-14 00:13:11','2020-05-14 00:15:38',0,0,NULL,NULL,NULL),(8,1,'2020-05-14 00:13:14','2020-05-14 13:01:52',0,0,NULL,NULL,NULL),(9,1,'2020-05-14 00:16:02','2020-05-14 00:29:28',0,0,NULL,NULL,NULL),(10,1,'2020-05-14 00:17:24','2020-05-14 13:48:33',0,0,NULL,NULL,NULL),(11,1,'2020-05-14 00:18:47','2020-05-14 13:56:34',0,0,NULL,NULL,NULL),(12,1,'2020-05-14 00:19:32','2020-05-14 13:59:54',0,0,NULL,NULL,NULL),(13,1,'2020-05-14 00:20:44','2020-05-14 14:00:01',0,0,NULL,NULL,NULL),(14,1,'2020-05-14 00:20:55','2020-05-14 12:55:21',0,0,NULL,NULL,NULL),(15,1,'2020-05-14 00:21:43','2020-05-14 13:52:58',0,0,NULL,NULL,NULL),(16,1,'2020-05-14 00:22:45','2020-05-14 02:18:58',0,0,NULL,NULL,NULL),(17,1,'2020-05-14 00:23:31','2020-05-14 02:23:00',0,0,NULL,NULL,NULL),(18,1,'2020-05-14 00:24:36','2020-05-14 02:23:45',0,0,NULL,NULL,NULL),(20,1,'2020-05-14 00:28:11','2020-05-14 02:15:15',0,0,NULL,NULL,NULL),(21,1,'2020-05-14 00:28:19','2020-05-14 12:56:03',0,0,NULL,NULL,NULL),(22,1,'2020-05-14 00:29:15','2020-05-14 14:00:05',0,0,NULL,NULL,NULL),(23,1,'2020-05-14 00:32:07','2020-05-14 14:00:10',0,0,NULL,NULL,NULL),(24,1,'2020-05-14 00:32:41','2020-05-14 02:11:01',0,0,NULL,NULL,NULL),(25,1,'2020-05-14 00:33:30','2020-05-14 02:26:15',0,0,NULL,NULL,NULL),(26,1,'2020-05-14 00:34:08','2020-05-14 14:00:16',0,0,NULL,NULL,NULL),(27,2,'2020-05-14 00:37:34','2020-05-14 13:48:33',0,1,NULL,NULL,NULL),(28,2,'2020-05-14 01:18:08','2020-05-14 13:48:33',1,0,NULL,NULL,NULL),(29,2,'2020-05-14 01:33:36','2020-05-14 02:12:08',0,0,NULL,NULL,NULL),(30,2,'2020-05-14 02:07:29','2020-05-14 02:08:31',0,0,NULL,NULL,NULL),(31,1,'2020-05-14 11:29:34','2020-05-14 12:56:13',0,0,NULL,NULL,NULL),(32,1,'2020-05-14 11:39:29','2020-05-18 13:28:57',0,1,876543,'jyhgfdsx',NULL),(33,1,'2020-05-14 11:42:35','2020-05-18 16:34:16',1,0,NULL,NULL,NULL),(34,1,'2020-05-14 11:43:30','2020-05-18 16:38:31',0,1,8765432,'ujhgfds',NULL),(35,1,'2020-05-14 11:43:57','2020-05-14 14:25:29',0,0,NULL,NULL,NULL),(36,1,'2020-05-14 11:44:08','2020-05-14 13:48:33',0,1,9876543,'kjhgfds',NULL),(37,1,'2020-05-14 12:05:59','2020-05-14 13:48:33',0,1,2132678,'yhgfdcs',NULL),(38,1,'2020-05-14 12:10:07','2020-05-14 13:48:33',1,0,NULL,NULL,NULL),(39,1,'2020-05-14 12:10:37','2020-05-14 13:48:33',0,1,123456,'uytrew',NULL),(40,2,'2020-05-14 13:54:50','2020-05-14 13:48:33',0,0,NULL,NULL,NULL),(41,2,'2020-05-14 14:16:01','2020-05-14 13:48:33',0,0,NULL,NULL,NULL),(42,2,'2020-05-14 14:24:35','2020-05-14 14:29:32',0,0,NULL,NULL,NULL),(43,2,'2020-05-14 14:24:36','2020-05-14 14:29:38',0,0,NULL,NULL,NULL),(44,2,'2020-05-14 14:24:45','2020-05-14 13:48:33',0,0,NULL,NULL,NULL),(45,2,'2020-05-14 14:24:45','2020-05-14 13:48:33',0,0,NULL,NULL,NULL),(46,2,'2020-05-14 14:24:45','2020-05-14 13:48:33',0,0,NULL,NULL,NULL),(47,2,'2020-05-14 14:24:45','2020-05-14 13:48:33',0,0,NULL,NULL,NULL),(48,2,'2020-05-14 14:24:45','2020-05-14 13:48:33',0,0,NULL,NULL,NULL),(49,2,'2020-05-14 14:24:45','2020-05-14 13:48:33',0,0,NULL,NULL,NULL),(50,2,'2020-05-14 14:24:45','2020-05-14 13:48:33',0,0,NULL,NULL,NULL),(51,2,'2020-05-14 14:24:45','2020-05-14 13:48:33',0,0,NULL,NULL,NULL),(52,2,'2020-05-14 14:24:45','2020-05-18 16:36:10',1,0,NULL,NULL,NULL),(53,2,'2020-05-14 14:24:45','2020-05-18 16:34:57',1,0,NULL,NULL,NULL),(54,2,'2020-05-14 14:24:45','2020-05-18 16:58:08',0,0,NULL,NULL,NULL),(55,2,'2020-05-14 14:24:45','2020-05-19 12:31:29',0,0,NULL,NULL,NULL),(56,2,'2020-05-14 14:24:45','2020-05-14 16:48:24',0,0,NULL,NULL,NULL),(57,2,'2020-05-14 14:24:45','2020-05-19 12:31:31',0,0,NULL,NULL,NULL),(58,2,'2020-05-14 14:24:46','2020-05-19 12:31:34',0,0,NULL,NULL,NULL),(59,2,'2020-05-14 14:24:46','2020-05-19 12:31:37',0,0,NULL,NULL,NULL),(60,2,'2020-05-14 14:24:46','2020-05-19 12:31:39',0,0,NULL,NULL,NULL),(61,2,'2020-05-14 14:24:46','2020-05-19 12:31:41',0,0,NULL,NULL,NULL),(62,2,'2020-05-14 14:24:46','2020-05-18 20:10:59',0,0,NULL,NULL,NULL),(63,2,'2020-05-14 14:24:46','2020-05-19 12:31:43',0,0,NULL,NULL,NULL),(64,2,'2020-05-14 14:24:46','2020-05-19 12:31:45',0,0,NULL,NULL,NULL),(65,2,'2020-05-14 14:24:46','2020-05-19 12:31:48',0,0,NULL,NULL,NULL),(66,2,'2020-05-14 14:24:46','2020-05-14 16:16:50',0,0,NULL,NULL,NULL),(67,2,'2020-05-14 14:24:46','2020-05-19 12:31:50',0,0,NULL,NULL,NULL),(68,2,'2020-05-14 14:24:46','2020-05-19 12:31:51',0,0,NULL,NULL,NULL),(69,2,'2020-05-14 14:24:46','2020-05-14 16:16:57',0,0,NULL,NULL,NULL),(70,2,'2020-05-14 14:24:51','2020-05-19 12:31:53',0,0,NULL,NULL,NULL),(71,2,'2020-05-14 14:24:53','2020-05-19 12:31:56',0,0,NULL,NULL,NULL),(72,2,'2020-05-14 14:24:58','2020-05-14 14:29:28',0,0,NULL,NULL,NULL),(73,2,'2020-05-14 14:27:00','2020-05-14 14:27:56',0,0,NULL,NULL,NULL),(74,4,'2020-05-14 14:37:11','2020-05-19 12:31:59',0,0,NULL,NULL,NULL),(75,4,'2020-05-14 14:53:35','2020-05-18 17:56:35',0,1,515515515,'Rita',NULL),(76,1,'2020-05-14 22:01:02','2020-05-19 12:32:01',0,0,NULL,NULL,NULL),(77,1,'2020-05-14 22:04:01','2020-05-19 12:32:03',0,0,NULL,NULL,NULL),(78,1,'2020-05-14 22:04:40','2020-05-18 17:55:38',0,1,13421,'sdas',NULL),(79,2,'2020-05-14 22:07:59','2020-05-19 12:32:05',0,0,NULL,NULL,NULL),(80,1,'2020-05-15 10:20:34','2020-05-19 12:32:07',0,0,NULL,NULL,NULL),(81,1,'2020-05-15 18:08:46','2020-05-19 12:32:09',0,0,NULL,NULL,NULL),(82,1,'2020-05-15 21:16:53','2020-05-18 16:58:39',0,0,NULL,NULL,NULL),(83,1,'2020-05-16 00:13:55','2020-05-18 16:53:09',1,0,NULL,NULL,NULL),(84,1,'2020-05-16 00:14:10','2020-05-18 16:53:43',1,0,NULL,NULL,NULL),(85,1,'2020-05-16 00:14:49','2020-05-19 12:32:10',0,0,NULL,NULL,NULL),(86,1,'2020-05-16 00:15:07','2020-05-18 20:11:34',0,1,7654,'jhgfd',NULL),(87,1,'2020-05-16 00:38:30','2020-05-19 12:32:12',0,0,NULL,NULL,NULL),(88,1,'2020-05-16 00:38:32','2020-05-18 16:53:32',1,0,NULL,NULL,NULL),(89,1,'2020-05-16 15:31:02','2020-05-18 16:53:39',1,0,NULL,NULL,NULL),(90,1,'2020-05-16 15:31:26','2020-05-18 16:53:37',1,0,NULL,NULL,NULL),(91,1,'2020-05-16 15:31:40','2020-05-18 16:53:19',1,0,NULL,NULL,NULL),(92,1,'2020-05-16 15:31:46','2020-05-18 16:53:35',1,0,NULL,NULL,NULL),(93,1,'2020-05-16 15:32:38','2020-05-18 16:53:17',1,0,NULL,NULL,NULL),(94,1,'2020-05-16 15:59:45','2020-05-19 12:32:15',0,0,NULL,NULL,NULL),(95,1,'2020-05-16 17:03:05','2020-05-18 16:53:14',1,0,NULL,NULL,NULL),(96,1,'2020-05-16 17:06:30','2020-05-19 12:32:17',0,0,NULL,NULL,NULL),(97,1,'2020-05-16 17:07:12','2020-05-18 16:53:12',1,0,NULL,NULL,NULL),(98,1,'2020-05-16 17:11:44','2020-05-19 12:32:19',0,0,NULL,NULL,NULL),(99,1,'2020-05-16 17:27:40','2020-05-18 15:48:51',0,0,NULL,NULL,NULL),(100,1,'2020-05-18 17:24:36','2020-05-18 17:52:54',0,0,NULL,NULL,NULL),(101,1,'2020-05-18 17:43:26','2020-05-19 12:32:21',0,0,NULL,NULL,NULL),(102,1,'2020-05-18 17:44:04','2020-05-18 19:30:01',0,0,NULL,NULL,NULL),(103,1,'2020-05-18 17:53:01','2020-05-18 17:53:08',1,0,NULL,NULL,NULL),(104,1,'2020-05-18 17:55:57','2020-05-18 17:56:04',1,0,NULL,NULL,NULL),(105,1,'2020-05-18 18:13:51','2020-05-18 19:19:24',0,1,2134567,'gfddddd',NULL),(106,1,'2020-05-18 19:01:34','2020-05-18 19:26:12',0,1,1234567,'iuytrew',NULL),(107,1,'2020-05-18 19:16:22','2020-05-18 19:18:10',1,0,NULL,NULL,NULL),(108,1,'2020-05-18 19:18:24','2020-05-18 19:18:44',1,0,NULL,NULL,NULL),(109,1,'2020-05-18 19:21:31','2020-05-18 19:21:42',1,0,NULL,NULL,NULL),(110,1,'2020-05-18 19:21:50','2020-05-18 19:21:59',1,0,NULL,NULL,NULL),(111,1,'2020-05-18 19:22:55','2020-05-18 19:23:04',1,0,NULL,NULL,NULL),(112,1,'2020-05-18 19:33:46','2020-05-18 19:35:44',1,0,NULL,NULL,NULL),(113,1,'2020-05-18 19:34:45','2020-05-19 10:46:34',0,0,NULL,NULL,NULL),(114,1,'2020-05-18 19:36:42','2020-05-19 12:32:29',0,0,NULL,NULL,NULL),(115,1,'2020-05-18 19:37:39','2020-05-18 19:44:05',1,0,NULL,NULL,NULL),(116,1,'2020-05-18 19:42:53','2020-05-18 19:44:02',1,0,NULL,NULL,NULL),(117,1,'2020-05-18 19:44:08','2020-05-18 19:51:33',1,0,NULL,NULL,NULL),(118,1,'2020-05-18 19:47:19','2020-05-18 19:51:35',1,0,NULL,NULL,NULL),(119,1,'2020-05-18 19:49:03','2020-05-18 19:51:28',1,0,NULL,NULL,NULL),(120,1,'2020-05-18 19:49:58','2020-05-18 19:51:31',1,0,NULL,NULL,NULL),(121,1,'2020-05-18 19:51:02','2020-05-18 19:51:25',1,0,NULL,NULL,NULL),(122,1,'2020-05-18 19:51:52','2020-05-19 12:32:31',0,0,NULL,NULL,NULL),(123,1,'2020-05-18 19:54:30','2020-05-18 20:09:14',1,0,NULL,NULL,NULL),(124,1,'2020-05-18 19:54:56','2020-05-19 12:30:52',1,0,NULL,NULL,NULL),(125,1,'2020-05-18 19:55:20','2020-05-19 12:32:33',0,0,NULL,NULL,NULL),(126,1,'2020-05-18 19:57:08','2020-05-19 12:30:55',1,0,NULL,NULL,NULL),(127,1,'2020-05-18 19:58:49','2020-05-19 11:31:56',1,0,NULL,NULL,NULL),(128,1,'2020-05-18 19:59:59','2020-05-19 12:30:58',1,0,NULL,NULL,NULL),(129,1,'2020-05-18 20:00:54','2020-05-18 20:02:25',1,0,NULL,NULL,NULL),(130,1,'2020-05-18 20:02:53','2020-05-19 12:32:37',0,0,NULL,NULL,NULL),(131,1,'2020-05-18 20:05:55','2020-05-19 12:31:03',1,0,NULL,NULL,NULL),(132,1,'2020-05-18 20:07:11','2020-05-18 20:11:15',1,0,NULL,NULL,NULL),(133,1,'2020-05-18 20:07:58','2020-05-19 12:32:42',0,0,NULL,NULL,NULL),(134,1,'2020-05-18 20:09:37','2020-05-19 12:31:07',1,0,NULL,NULL,NULL),(135,1,'2020-05-19 11:29:47','2020-05-19 12:31:10',1,0,NULL,NULL,NULL),(136,1,'2020-05-19 11:30:46','2020-05-19 12:31:12',1,0,NULL,NULL,NULL),(137,1,'2020-05-19 11:31:37','2020-05-19 11:32:01',1,0,NULL,NULL,NULL),(138,1,'2020-05-19 11:51:10','2020-05-19 12:31:15',1,0,NULL,NULL,NULL),(139,1,'2020-05-19 11:51:25','2020-05-19 12:31:17',1,0,NULL,NULL,NULL),(140,1,'2020-05-19 11:58:08','2020-05-19 12:31:20',1,0,NULL,NULL,NULL),(141,1,'2020-05-19 11:58:36','2020-05-19 12:31:22',1,0,NULL,NULL,NULL),(142,1,'2020-05-19 12:29:02','2020-05-19 12:31:24',1,0,NULL,NULL,NULL),(143,1,'2020-05-19 12:29:15','2020-05-19 12:31:26',1,0,NULL,NULL,NULL),(144,1,'2020-05-19 12:37:27','2020-05-19 12:46:17',0,0,NULL,NULL,NULL),(145,1,'2020-05-19 13:36:52','2020-05-19 14:02:16',0,0,NULL,NULL,NULL),(146,1,'2020-05-19 14:03:06','2020-05-19 16:13:05',0,0,NULL,NULL,NULL),(147,1,'2020-05-19 14:37:46','2020-05-19 16:16:04',1,0,NULL,NULL,NULL),(148,1,'2020-05-19 14:45:17','2020-05-19 16:16:06',1,0,NULL,NULL,NULL),(149,1,'2020-05-19 14:45:38','2020-05-19 16:15:59',1,0,NULL,NULL,NULL),(150,1,'2020-05-19 15:00:47','2020-05-19 16:16:01',1,0,NULL,NULL,NULL),(151,1,'2020-05-19 15:03:54','2020-05-19 15:04:51',0,0,NULL,NULL,NULL),(152,1,'2020-05-19 15:04:02','2020-05-19 15:04:19',1,0,NULL,NULL,NULL),(153,1,'2020-05-19 15:04:22','2020-05-19 16:15:57',1,0,NULL,NULL,NULL),(154,1,'2020-05-19 16:23:28','2020-05-19 16:23:48',0,0,NULL,NULL,NULL),(155,1,'2020-05-19 16:40:12',NULL,0,0,NULL,NULL,NULL),(156,1,'2020-05-19 16:41:44',NULL,1,0,NULL,NULL,NULL),(157,1,'2020-05-19 16:45:24',NULL,1,0,NULL,NULL,NULL);
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
INSERT INTO `productattributes` VALUES (58,1),(58,2),(58,3),(58,4);
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
) ENGINE=InnoDB AUTO_INCREMENT=149 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'½ Tábua de Affettati Italiani– 6,80€',33,0,6.8,'Salame Picante, Salame Milano, Presunto (Fiambre Italiano), Presunto Parma D.O.P'),(2,'Tábua de Affettati Italiani– 11,80€',33,0,11.8,'Salame Picante, Salame Milano, Presunto (Fiambre Italiano), Presunto Parma D.O.P'),(3,'½ Tábua Formaggi Italiani – 6,60€',33,0,6.6,'Queijo Parmegiano Reggiano, Queijo Provolone, Queijo Gorgonzola, Queijo Scamorza'),(4,'Tábua Formaggi Italiani – 11,60€',33,0,11.6,'Queijo Parmegiano Reggiano, Queijo Provolone, Queijo Gorgonzola, Queijo Scamorza, Queijo Pecorino Romano'),(5,'Bufala Mia – 6,90€',33,0,6.9,'Mozzarella de Bufala D.O.P, Tomate cherry, Azeitonas pretas. Pode ser servido com Creme adocicado de Vinagre Balsamico ou Azeite Virgem Extra de Trufa. Servido com Grissini.'),(6,'Involtini Delizia – 6,80€',33,0,6.8,'Rolinhos de Speck (fiambre italiano levemente fumado) com mozzarela de bufala e ameixa seca. Servido com Vinagre Balsâmico adocicado e Grissini'),(7,'Pane Foccaccia – 3,80€',33,0,3.8,'Massa de pizza, Oregãos, Azeite Extra Virgem'),(8,'Pane Focaccia Aglio – 4,30€',33,0,4.3,'Massa de pizza, Oregãos, Alho, Azeite Extra Virgem'),(9,'Pane Foccaccia Aglio e Parmigiano – 5,30€',33,0,5.3,'Massa de pizza, Oregãos, Alho, Queijo Parmesão Ralado, Azeite Extra Virgem'),(10,'Olive – 1,80€',33,0,1.8,'Azeitonas temperadas'),(11,'2 Grissini – 1€',33,0,1,NULL),(12,'Tropicale – 6,90€',9,0,6.9,'Alface, Rucola, Tomate Cherry, Queijo Mozzarella, Milho, Ananas'),(13,'Sfiziosa – 7,20€',9,0,7.2,'Alface, Rucola, Tomate seco, Queijo Parmesão, Manjericão, Azeitonas pretas'),(14,'A Modo Mio – 7,30€',9,0,7.3,'Alface, Rucola, Tomate Cherry, Atum, Azeitonas pretas, Queijo Mozzarella, Manjericão'),(15,'Saporita – 8,20€',9,0,8.2,'Agrião, Alface, Rucola, Grão de Bico, Pepino, Camarão, Nozes, Tomate Cherry, Cebola Roxa'),(16,'Stuzzicante – 8.80€',9,0,8.8,'Rucola, Alface, Agrião, Beringela Grelhada, Salmão Fumado, Uvas Passas,Tomate Cherry'),(17,'Tortellini Recheado com Ricotta – 9,50€',34,0,9.5,NULL),(18,'Tortellini Recheado com Presunto– 10,60€',34,0,10.6,NULL),(19,'Nhoque aos 4 Queijos – 9,60€',34,0,9.6,NULL),(20,'Spaghetti ou Penne al Pesto (caseiro) – 9,50€',34,0,9.5,NULL),(21,'Spaghetti a Bolonhesa – 9,20€',34,0,9.2,NULL),(22,'Penne all’Arrabbiata – 8,90€',34,0,8.9,'azeite, pimenta malagueta, alho, queijo pecorino, molho de tomate e salsa'),(23,'Lasagna al Forno – 10,90€',34,0,10.9,NULL),(24,'Carbonara  – 9,70€',34,0,9.7,'gema de ovo, guanciale italiano, pecorino romano, pimenta preta'),(25,'Risotto de Funghi Porcini com Queijo Parmigiano – 10,50€',35,0,10.5,NULL),(26,'Marinara – 7,50€',14,0,7.5,'Molho de tomate, Alho, Oregãos, Azeite Virgem Extra'),(27,'Margherita – 8,70€',14,0,8.7,'Molho de tomate, Mozzarella, Mangericão'),(28,'Napoli – 11,80€',14,0,11.8,'Molho de tomate, Mozzarella, Anchovas, Oregãos, Azeitonas pretas'),(29,'Salame – 10,80€',14,0,10.8,'Molho de tomate, Mozzarella, Salame'),(30,'Tonno – 11,70€',14,0,11.7,'Molho de tomate, Mozzarella, Atum, Azeitonas pretas, Azeite Extra Virgem Opção com cebola roxa e rucola + 2€'),(31,'Vegetariana – 10,90€',14,0,10.9,'Molho de Tomate, Mozzarella, Beringela e Courgette grelhada, Pimentos'),(32,'Vegana – 9,70€',14,0,9.7,'Humus de lentilha, Tomate seco, Salada, Vinagre Balsâmico adocicado'),(33,'Provola – 12,90€',14,0,12.9,'Molho de tomate, Ricotta, Queijo Provolone, Presunto Cozido  D.O.P (fiambre italiano)'),(34,'Tricolore – 10,90€',14,0,10.9,'Molho de Tomate, Mozzarella, Pesto caseiro, Manjericão'),(35,'Bufala – 13,30€',14,0,13.3,'Molho de tomate, Tomate Cherry, Azeite, Manjericão, Mozzarella de Bufala Napolitana'),(36,'Bufalina – 13,70€',14,0,13.7,'Molho de Tomate, Tomate Cherry, Bufalina fresca, Manjericão, Speck (fiambre italiano levemente fumado), Azeite Virgem extra'),(37,'Pera e Zola – 11,90€',14,0,11.9,'Mozzarella, Pêra, Gorgonzola D.O.P (opcional mel)'),(38,'Parma – 13,90€',14,0,13.9,'Molho de tomate, Mozzarella, Queijo Parmesão, Presunto de Parma D.O.P.'),(39,'Prosciutto e Funghi – 12,90€',14,0,12.9,'Molho de tomate, Mozzarella, Cogumelos, Presunto cozido D.O.P (fiambre italiano)'),(40,'Hawaii – 12,20€',14,0,12.2,'Molho de tomate, Mozzarella, Ananas, Presunto cozido D.O.P (fiambre italiano)'),(41,'Diavola– 11,80€',14,0,11.8,'Molho de tomate, Mozzarella, Pepperoni, Azeitonas pretas'),(42,'Parmigiana – 11,90€',14,0,11.9,'Molho de tomate,  Mozzarella, Beringela grelhada, Queijo Parmesão, Manjericão'),(43,'Agrigento – 11,90€',14,0,11.9,'Molho de tomate, Queijo Scamorza defumado, Salame picante'),(44,'Calzone – 13,60€',14,0,13.6,'Molho de tomate, Mozzarella, Salame picante, Cogumelos, Presunto Cozido D.O.P (fiambre italiano)'),(45,'4 Formaggi – 13,50€',14,0,13.5,'Mozzarella, Queijo Scamorza defumado, Queijo Provolone, Gorgonzola Opção com cebola caramelizada + 1,30€'),(46,'Alla Portoghese - 13,30€',14,0,13.3,'Molho de Tomate, Mozzarella, Bacon, Ovo Estrelado, Presunto cozido D.O.P (fiambre italiano)'),(47,'Popeye – 10,90€',14,0,10.9,'Queijo Emmental, Queijo Parmesão, Espinafres, Azeite com Alho, Pimenta do Reino'),(48,'Amalfi  - 13,80€',14,0,13.8,'Molho de Tomate, Queijo Crescenza, Camarão, Tomate Seco, Rucola, Azeite, Creme Adocicado de Vinagre Balsamico'),(49,'Gourmet Reloaded– 13,70€',14,0,13.7,'Mozzarella, Provolone, Queijo de Capra, Figo Fresco, Speck (fiambre italiano levemenmte fumado), Nozes Caramelizadas'),(50,'Portofino – 13,50€',14,0,13.5,'Molho de Tomate, Mozzarella, Salmão Fumado, Rucola, Azeite Virgem Extra de Manjericão ou Azeite Virgem Extra'),(51,'Azeitona, Cebola, Milho, Ovo, Tomate, Rucola - 1,30€',15,0,1.3,NULL),(52,'Verduras, Cogumelos, Anchovas, Frutas, Bacon– 1,50€',15,0,1.5,NULL),(53,'Atum, Mozzarella, Queijo de Cabra – 2,50€',15,0,2.5,NULL),(54,'Queijos, Chouriço Pepperoni – 3€',15,0,3,NULL),(55,'Mozzarella de Bufala – 3,50€',15,0,3.5,'Presunto, Salame, Speck, Camarão, Salmão'),(56,'Presunto Parma – 3,80€',15,0,3.8,NULL),(57,'Farinha sem glúten, Mozzarella Vegana – 2€',15,0,2,NULL),(58,'Até 2 ingredientes – 6,80€',13,0,6.8,'excepto Parma, Bufala, Salmão, Figo, Nozes, Speck, Camarão, Gorgonzola'),(59,'Tiramisù (caseiro) – 4,30€',7,0,4.3,NULL),(60,'Panna Cotta (caseiro) – 4,20€',7,0,4.2,NULL),(61,'Mousse de Chocolate (caseiro) – 3,90€',7,0,3.9,NULL),(62,'Morango fresco com creme de Framboesa caseiro  – 4,50€',7,0,4.5,NULL),(63,'Tartufo de chocolate servido com chocolate belga – 4,30€',7,0,4.3,NULL),(64,'Ciocconella– 4,90€',12,0,4.9,'Recheio de Chocolate preto, Banana e Canela. Cobertura de Creme de Framboesa Caseiro e Açucar em pó'),(65,'Pizzella – 4,90€',12,0,4.9,'Nutella, Coco ralado / Nutella, Banana, Coco ralado'),(66,'Pizzella – 5,50€',12,0,5.5,'Nutella, Morango'),(67,'Coca Cola- 1,80€',18,0,1.8,NULL),(68,'Coca Zero- 1,80€',18,0,1.8,NULL),(69,'Ice Tea Lypton (Manga, Pessego, Limão) - 1,80€',18,0,1.8,NULL),(70,'Sumol de Laranja ou Abacaxi- 1,80€',18,0,1.8,NULL),(71,'7UP- 1,80€',18,0,1.8,NULL),(72,'Guaraná- 1,80€',18,0,1.8,NULL),(73,'Ginger Ale - 1,80€',18,0,1.8,NULL),(74,'Manga– 2,80€',16,0,2.8,NULL),(75,'Goiaba– 2,80€',16,0,2.8,NULL),(76,'Abacaxi– 2,80€',16,0,2.8,NULL),(77,'Morango– 2,80€',16,0,2.8,NULL),(78,'Maracujá – 2,80€',16,0,2.8,NULL),(79,'Água Mineral 0,5L - 1,40€',17,0,1.4,NULL),(80,'Água Mineral 1L – 2,30€',17,0,2.3,NULL),(81,'Água das Pedras – 1,70€',17,0,1.7,NULL),(82,'Água Frize sabores – 1,70€',17,0,1.7,NULL),(83,'Água Tonica - 1,70€',17,0,1.7,NULL),(84,'Sagres 0,33 ml sem álcool – 2,70€',19,0,2.7,NULL),(85,'Camomila - 1,60€',20,0,1.6,NULL),(86,'Cidreira - 1,60€',20,0,1.6,NULL),(87,'Verde - 1,60€',20,0,1.6,NULL),(88,'Preto - 1,60€',20,0,1.6,NULL),(89,'Frutos vermelhos - 1,60€',20,0,1.6,NULL),(90,'Expresso / Descafeinado – 1,30€',21,0,1.3,NULL),(91,'Expresso / Descafeinado (pingado) – 1,40€',21,0,1.4,NULL),(92,'Abatanado – 1,50€',21,0,1.5,NULL),(93,'Abatanado com leite – 1,70€',21,0,1.7,NULL),(94,'Sagres Média 0,33 ml - 1,80€',22,0,1.8,NULL),(95,'Franziskaner Weissbier 0,50 ml – 4,50€',22,0,4.5,NULL),(96,'Bandida do Pomar 0,33 ml – 2,60€',22,0,2.6,NULL),(97,'Cachaça – 4,30€',23,0,4.3,NULL),(98,'Vodka – 4€',23,0,4,NULL),(99,'Copinho de Limoncello – 1,90€',24,0,1.9,NULL),(100,'Licor Beirão, Porto, Martini – 3,30€',25,0,3.3,NULL),(101,'Macieira Brandy – 3,50',25,0,3.5,NULL),(102,'Moscatel – 3€',25,0,3,NULL),(103,'J&B (5cl)  –  2,80€',26,0,2.8,NULL),(104,'J&B (10cl) -  4,30€',26,0,4.3,NULL),(105,'Jamenson (5cl) – 3€',26,0,3,NULL),(106,'Jamenson (10cl) – 4,60€',26,0,4.6,NULL),(107,'Copo (branco ou tinto) – 2€',27,0,2,NULL),(108,'Jarro (branco ou tinto) 0,50 ml – 4€',27,0,4,NULL),(109,'Jarro (branco ou tinto) 1 L – 8€',27,0,8,NULL),(110,'Copo Sangria – 3,70€',28,0,3.7,NULL),(111,'Jarro Sangria 0,50 ml – 6,80€',28,0,6.8,NULL),(112,'Jarro Sangria 1 L – 10,80€',28,0,10.8,NULL),(113,'Jarro Sangria 1,5 L – 13,80€',28,0,13.8,NULL),(114,'Jarro 1 L – 13,50€',29,0,13.5,NULL),(115,'Jarro 1,5 L – 16,90€',29,0,16.9,NULL),(116,'Menu Executivo',30,0,15,'Prato + Bebida + Café + Creme ou Doce do dia'),(117,'Menu Almoço',31,0,10,'Prato + Bebida + Café'),(118,'Vinho a Copo Tinto ou Branco  - 4€',28,0,4,''),(119,'Montepulciano – 15,90€ (Tinto Garrafa)',28,0,15.9,'Abbruzzo- Montepulciano'),(120,'Chianti La Vinha  – 13,50€ (Tinto Garrafa)',28,0,13.5,'Toscana- Sangiovese, Canaiolo, Malvasia del Chianti'),(121,'Merlot Delle Venezie  13,30€ (Tinto Garrafa)',28,0,13.3,'Veneto– 100% Merlot'),(122,'Nero d’Avola – 13,90€ (Tinto Garrafa)',28,0,13.9,'Sicilia- Nero d’Avola'),(123,'Pinot Grigio – 12,90€ (Branco Garrafa)',28,0,12.9,'Friuli- Pinot Grigio'),(124,'Norico Vinheti delle Dolomiti -  15,80€ (Branco Garrafa)',28,0,15.8,'Trentino- Chardonnay, Sauvignon blanc, Nosiola'),(125,'Prosecco – 21,90€ (Branco Garrafa)',28,0,21.9,''),(126,'Vinho a copo Tinto ou Branco - 3,50€',29,0,3.5,'null'),(127,'Tiago Cabaço.com - 11,80€ (Tinto Garrafa)',29,0,11.8,'Alentejo- Touriga Nacional, Aragonez, Trincadeira e Alicante Bouschet'),(128,'Subsidio Lima Mayer – 12,90€ (Tinto Garrafa)',29,0,12.9,'Alentejo- Aragonez, Syrah, Cabernet Sauvignon, Alicante Bouschet'),(129,'Duas Danças – 12,90€ (Tinto Garrafa)',29,0,12.9,'Alentejo- Aragonez, Alicante Bouschet, Syrah'),(130,'Xaino – 12,90€ (Tinto Garrafa)',29,0,12.9,'Douro- Touriga Nacional, Touriga Franca, Tint Roriz'),(131,'Foral de Meda – 11,20€ (Tinto Garrafa)',29,0,11.2,'Douro- Touriga Nacional, Tinto Cão, Touriga Franca'),(132,'Cadão  – 11,50€ (Tinto Garrafa)',29,0,11.5,'Douro- Touriga Franca, Touriga Nacional, Tinta Roriz'),(133,'Terras Santo Antonio Colheita  – 11,90€ (Tinto Garrafa)',29,0,11.9,'Dão- 100% Touriga Nacional'),(134,'Quinta dos Termos Doc  – 12,50€ (Tinto Garrafa)',29,0,12.5,'Beira Interior- Touriga Nacional, Trincadeira, Tinta Roriz e Jaen'),(135,'Quinta dos Termos Doc Vinhas Velhas–14,50€ (Tinto Garrafa)',29,0,14.5,'Beira Interior- vinhas velhas das castas Trincadeira, Jaen, Rufete, Marufo e Syrah'),(136,'Cadão - 11,50€ (Branco Garrafa)',29,0,11.5,'Douro- Viosinho, Rabigato, Gouveio, Moscatel Galego'),(137,'Foral de Meda – 11,20€ (Branco Garrafa)',29,0,11.2,'Douro- Viosinho, Rabigato e Gouveio'),(138,'Quinta do Casal Branco Alvarinho  – 10,90€ (Branco Garrafa)',29,0,10.9,'Tejo- 100% Alvarinho'),(139,'Tiago Cabaço.com  – 11,80€ (Branco Garrafa)',29,0,11.8,'Alentejo- Antão Vaz, Verdelho e Viognier'),(140,'Duas Danças  – 12,90€ (Branco Garrafa)',29,0,12.9,'Alentejo- Antão Vaz, Gouveio e Viognier'),(141,'Quinta dos Termos Doc Reserva  – 12,90€ (Branco Garrafa)',29,0,12.9,'Beira Interior- Fonte Cal, Síria, Arínto e Verdelho'),(142,'Quinta dos Termos Doc Reserva Fonte Cal– 3,90€ (Branco Garrafa)',29,0,13.9,'Beira Interior- 100% Fonte Cal'),(143,'1808 Portugal Doc - 10,80€ (Vinho Verde)',29,0,10.8,'Minho– Loureiro, Arinto, Avesso'),(145,'Nhoque a Bolonhesa - 9,30€',34,0,9.3,NULL),(146,'Menu Executivo',32,0,15,'Prato + Bebida + Café + Creme ou Doce do dia'),(147,'Menu Almoço',33,0,10,'Prato + Bebida + Café'),(148,'Sangria',36,0,NULL,NULL);
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
  `nif` int(11) DEFAULT NULL,
  `location` varchar(200) DEFAULT NULL,
  `postalCode` varchar(8) DEFAULT NULL,
  `contact` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `systemproperties`
--

LOCK TABLES `systemproperties` WRITE;
/*!40000 ALTER TABLE `systemproperties` DISABLE KEYS */;
INSERT INTO `systemproperties` VALUES (1,'Sauvage','/static/images/Logo Sauvage.jpeg',12345612,'Rua do Campo Pequeno, n9','1602-690','212356772');
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

-- Dump completed on 2020-05-19 16:55:52
