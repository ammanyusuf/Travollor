-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: travellors
-- ------------------------------------------------------
-- Server version	8.0.19

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
-- Table structure for table `rides_on`
--

DROP TABLE IF EXISTS `rides_on`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rides_on` (
  `transport_uid` int NOT NULL,
  `tourist_uid` int NOT NULL,
  `departure_address` varchar(255) DEFAULT NULL,
  `distance_travelled` int DEFAULT NULL,
  `destination_address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`transport_uid`,`tourist_uid`),
  KEY `tourist_uid_rides_on` (`tourist_uid`),
  CONSTRAINT `tourist_uid_rides_on` FOREIGN KEY (`tourist_uid`) REFERENCES `tourist` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `transport_uid_rides_on` FOREIGN KEY (`transport_uid`) REFERENCES `transportation` (`transportation_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rides_on`
--

LOCK TABLES `rides_on` WRITE;
/*!40000 ALTER TABLE `rides_on` DISABLE KEYS */;
INSERT INTO `rides_on` VALUES (1,6,'162 Miami Road SW',30,'9000 Sunset Beach Road'),(1,9,'162 Miami Road SW',30,'9000 Sunset Beach Road'),(1,10,'162 Miami Road SW',30,'9000 Sunset Beach Road'),(2,6,'85 Miami Louvre',30,'80 Palm Parks'),(2,7,'85 Miami Louvre',30,'80 Palm Parks');
/*!40000 ALTER TABLE `rides_on` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-04-25 18:17:05
