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
-- Table structure for table `recommendation`
--

DROP TABLE IF EXISTS `recommendation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recommendation` (
  `title` varchar(255) NOT NULL,
  `creation_date` date DEFAULT NULL,
  `posting_time` time DEFAULT NULL,
  `post_rating` int DEFAULT NULL,
  `tips` varchar(255) DEFAULT NULL,
  `description` varchar(10000) DEFAULT NULL,
  `attraction_id` int DEFAULT NULL,
  `city_id` int DEFAULT NULL,
  `local_uid` int DEFAULT NULL,
  `tour_guide_uid` int DEFAULT NULL,
  `tourist_id` int DEFAULT NULL,
  PRIMARY KEY (`title`),
  KEY `attraction_id_recommendation` (`attraction_id`),
  KEY `city_id_recommendation` (`city_id`),
  KEY `tourist_id_recommendation` (`tourist_id`),
  KEY `tour_guide_recommendation` (`tour_guide_uid`),
  KEY `local_uid_recommendation` (`local_uid`),
  CONSTRAINT `attraction_id_recommendation` FOREIGN KEY (`attraction_id`) REFERENCES `attraction` (`attraction_id`),
  CONSTRAINT `city_id_recommendation` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`),
  CONSTRAINT `local_uid_recommendation` FOREIGN KEY (`local_uid`) REFERENCES `local` (`user_id`),
  CONSTRAINT `tour_guide_recommendation` FOREIGN KEY (`tour_guide_uid`) REFERENCES `tour_guide` (`tour_guide_id`),
  CONSTRAINT `tourist_id_recommendation` FOREIGN KEY (`tourist_id`) REFERENCES `tourist` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recommendation`
--

LOCK TABLES `recommendation` WRITE;
/*!40000 ALTER TABLE `recommendation` DISABLE KEYS */;
INSERT INTO `recommendation` VALUES ('Movie Night','2020-01-01','20:30:10',10,'The back left row has the best view! Plus direct access to the popcorn.','Whats better than a movie? A drive in movie! This gem has the best of both world;\n        the comfortableness and convenience of your own car plus all you can eat popcorn.  This\n        is a true gem!',9,2,2,1,7),('Night at the Museum','2020-02-01','22:30:10',10,'Watch out for the one of a kind T-rex exhibit straight from Drumheller Canada!','Have you watched night at the museum 2?? We\'ll if you have, you know that the museum really comes\n        to life at night!  So does our speical Miami Louvre!  One of a kind merging of classical counterfeit\n        art with ancient pre-historical exhibits!  Fun for the whole family.',6,3,2,4,8),('Refreshing Smoothies','2020-02-01','18:30:45',9,'Super refreshing and lots of flavour! The strawberry with milk was the best!','After a long day at the beach, what\'s better than taking in a cool yummy smoothie?! What are you waiting for? Go get your smoothie!',9,2,2,3,9),('The Day At The Beach','2020-01-01','19:30:10',8,'Avoid the snapping seaguls, they are very mean :(','It was a wonderful day at the Miami Beach today.  Sunny sunshine\n        and wet water! Got to play beach volleyball, had a hot dog\n        at the nearby stand beach stand 10/10 by itself.\n        There is one spot at the beach that no one goes to\n        and is super peaceful.  We call it the \'seaguls pirate island\'\n        rummored to be haunted by seaguls.  Most of this is a local myth, but\n        there are stories of seaguls following the beach goer back to their\n        house.  Quite a scary folk-tale.\n        Update: Seagul ate my hot dog :(',1,2,1,1,6);
/*!40000 ALTER TABLE `recommendation` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-04-25 18:17:00
