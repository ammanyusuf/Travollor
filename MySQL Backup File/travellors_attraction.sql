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
-- Table structure for table `attraction`
--

DROP TABLE IF EXISTS `attraction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attraction` (
  `attraction_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `interesting_fact` varchar(250) NOT NULL,
  `attraction_description` varchar(300) NOT NULL,
  `city_id` int NOT NULL,
  `business_license_number` int NOT NULL,
  PRIMARY KEY (`attraction_id`),
  KEY `city_id_idx` (`city_id`),
  KEY `business_license_number_attraction` (`business_license_number`),
  CONSTRAINT `business_license_number_attraction` FOREIGN KEY (`business_license_number`) REFERENCES `local_business` (`business_license_number`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `city_id_attraction` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attraction`
--

LOCK TABLES `attraction` WRITE;
/*!40000 ALTER TABLE `attraction` DISABLE KEYS */;
INSERT INTO `attraction` VALUES (1,'Miami Beach','Home to 1000 real life dolphins!','This is the most famous beach in the state of Florida.  \n		The sunny weather and warm sand welcomes you to try out the Florida waters!',2,1),(2,'Palm Bay','Has so many palms it rivals the Palm Tree Parl!  It also doubles as a cool beach','This is a beach with a view!\n			A view fo 999 Palm Trees',2,1),(3,'Soccer Stadium Barcellona','Messi played here once!','One of the most famouse statiums in the world.  Housed greatest\n		that has ever played.',2,5),(4,'Seafood and More!','The best seafood and more to come!  Including but not limited to food from the sea','Fresh sea food out of the sea yes!',2,8),(5,'Seafood and And Litte Bit More!','Seafood straight from the sea!  As fresh as it can get','Fresh sea food out of the sea yes!',2,8),(6,'The Miami Louvre','Forged 10 paintings straight out of the actual Louvre','This is Miamis attempt to emulate the Louvre from Paris',2,5),(7,'Palm Tree Park','Imported 100 species of palm trees from Madagascar','Take a walk through the palm tree park and endulge in the views',2,2),(8,'Club Groovay','A time travel back to the 80s','The hotest club in Miami is straight out of the 80s',2,6),(9,'Drive In Movie Inn','Houses space for 100 cars per viewing!','Old school drive in movies for the family',2,8),(10,'Ice Cold Smoothies','Smoothies are slightly below ice cold','Refresh yourself from the hot Miami weather with some cool smoothies',2,3),(11,'8 Ball Pool','Fast Paced Round of 8 Ball Pool!','You want to play pool by the beach? Come over to 8 Ball Bool\n		to get your fix',2,1);
/*!40000 ALTER TABLE `attraction` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-04-25 18:17:04
