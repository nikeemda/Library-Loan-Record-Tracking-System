-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: library
-- ------------------------------------------------------
-- Server version	8.3.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `audiotape`
--

DROP TABLE IF EXISTS `audiotape`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audiotape` (
  `itemID` int NOT NULL,
  `author` varchar(100) NOT NULL,
  `duration` int NOT NULL,
  PRIMARY KEY (`itemID`),
  CONSTRAINT `audiotape_libraryitem_FK` FOREIGN KEY (`itemID`) REFERENCES `libraryitem` (`itemID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audiotape`
--

LOCK TABLES `audiotape` WRITE;
/*!40000 ALTER TABLE `audiotape` DISABLE KEYS */;
INSERT INTO `audiotape` VALUES (12,'Led Zeppelin',44),(13,'Pink Floyd',42);
/*!40000 ALTER TABLE `audiotape` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book` (
  `itemID` int NOT NULL,
  `author` varchar(100) NOT NULL,
  `genre` varchar(50) NOT NULL,
  `bookType` varchar(50) DEFAULT NULL,
  `recommendedAge` varchar(50) DEFAULT NULL,
  `isbn` varchar(50) NOT NULL,
  PRIMARY KEY (`itemID`),
  CONSTRAINT `book_libraryitem_FK` FOREIGN KEY (`itemID`) REFERENCES `libraryitem` (`itemID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book`
--

LOCK TABLES `book` WRITE;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
INSERT INTO `book` VALUES (1,'John Steinbeck','Classic',NULL,'16+','1234567890'),(4,'J.R.R. Tolkien','Fantasy',NULL,'12+','2345678901'),(7,'F. Scott Fitzgerald','Classic','Adult','18+','3456789012'),(8,'Margaret Wise Brown','Children','Children','3+','4567890123'),(9,'Beverly Cleary','Fiction','Children','8+','5678901234'),(10,'Harper Lee','Classic',NULL,'14+','6789012345'),(11,'George Orwell','Dystopian','Adult','18+','7890123456');
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compactdisc`
--

DROP TABLE IF EXISTS `compactdisc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compactdisc` (
  `itemID` int NOT NULL,
  `artist` varchar(100) NOT NULL,
  `genre` varchar(50) NOT NULL,
  `numberOfTracks` int NOT NULL,
  `duration` int NOT NULL,
  PRIMARY KEY (`itemID`),
  CONSTRAINT `compactdisc_libraryitem_FK` FOREIGN KEY (`itemID`) REFERENCES `libraryitem` (`itemID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compactdisc`
--

LOCK TABLES `compactdisc` WRITE;
/*!40000 ALTER TABLE `compactdisc` DISABLE KEYS */;
INSERT INTO `compactdisc` VALUES (14,'Michael Jackson','Pop',9,42),(15,'AC/DC','Rock',10,41);
/*!40000 ALTER TABLE `compactdisc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fees`
--

DROP TABLE IF EXISTS `fees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fees` (
  `feeID` int NOT NULL AUTO_INCREMENT,
  `libraryCardNumber` int NOT NULL,
  `loanID` int NOT NULL,
  `itemID` int NOT NULL,
  `fineDate` date NOT NULL,
  `paymentDate` date DEFAULT NULL,
  `fineAmount` decimal(10,2) NOT NULL,
  `reason` varchar(150) NOT NULL,
  PRIMARY KEY (`feeID`),
  KEY `fees_libraryitem_FK` (`itemID`),
  KEY `fees_patron_FK` (`libraryCardNumber`),
  KEY `fees_loanrecord_FK` (`loanID`),
  CONSTRAINT `fees_loanrecord_FK` FOREIGN KEY (`loanID`) REFERENCES `loanrecord` (`loanID`),
  CONSTRAINT `fees_patron_FK` FOREIGN KEY (`libraryCardNumber`) REFERENCES `patron` (`libraryCardNumber`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fees`
--

LOCK TABLES `fees` WRITE;
/*!40000 ALTER TABLE `fees` DISABLE KEYS */;
INSERT INTO `fees` VALUES (1,1,1,1,'2023-05-16',NULL,15.00,'Late return'),(2,2,2,2,'2023-05-18',NULL,10.00,'Lost item'),(3,3,3,3,'2023-05-20',NULL,5.00,'Damaged item'),(4,4,4,4,'2023-05-21',NULL,8.00,'Late return'),(5,5,5,5,'2023-05-22',NULL,12.00,'Lost item'),(6,6,6,6,'2023-05-23',NULL,7.00,'Late return'),(7,7,7,7,'2023-05-24',NULL,3.00,'Damaged item'),(8,1,1,1,'2014-04-05','2014-04-10',25.00,'Late return'),(9,2,2,1,'2014-04-15','2014-04-20',15.00,'Damaged item'),(10,3,3,2,'2014-05-10','2014-05-15',30.00,'Lost item'),(11,4,4,2,'2014-06-07',NULL,20.00,'Late return'),(12,5,5,3,'2014-07-22','2014-08-01',5.00,'Late return'),(13,6,6,4,'2014-09-15','2014-09-25',50.00,'Lost item'),(14,7,7,5,'2014-09-29','2014-10-10',100.00,'Lost item');
/*!40000 ALTER TABLE `fees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `itemrequests`
--

DROP TABLE IF EXISTS `itemrequests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `itemrequests` (
  `requestID` int NOT NULL AUTO_INCREMENT,
  `itemID` int NOT NULL,
  `libraryCardNumber` int NOT NULL,
  `requestDate` date NOT NULL,
  `status` varchar(50) NOT NULL,
  PRIMARY KEY (`requestID`),
  KEY `itemrequests_patron_FK` (`libraryCardNumber`),
  KEY `itemrequests_libraryitem_FK` (`itemID`),
  CONSTRAINT `itemrequests_libraryitem_FK` FOREIGN KEY (`itemID`) REFERENCES `libraryitem` (`itemID`),
  CONSTRAINT `itemrequests_patron_FK` FOREIGN KEY (`libraryCardNumber`) REFERENCES `patron` (`libraryCardNumber`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `itemrequests`
--

LOCK TABLES `itemrequests` WRITE;
/*!40000 ALTER TABLE `itemrequests` DISABLE KEYS */;
INSERT INTO `itemrequests` VALUES (1,1,2,'2023-05-02','Pending'),(2,2,3,'2023-05-04','Pending'),(3,3,4,'2023-05-06','Fulfilled'),(4,4,5,'2023-05-08','Pending'),(5,5,6,'2023-05-10','Cancelled'),(6,6,7,'2023-05-12','Pending'),(7,7,1,'2023-05-14','Fulfilled'),(8,1,2,'2014-04-02','Pending'),(9,2,3,'2014-04-11','Pending'),(10,3,4,'2014-05-02','Fulfilled'),(11,4,5,'2014-06-02','Pending'),(12,5,6,'2014-07-02','Cancelled'),(13,6,7,'2014-08-02','Pending'),(14,7,1,'2014-09-02','Fulfilled'),(15,1,4,'2024-05-08','Pending');
/*!40000 ALTER TABLE `itemrequests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `libraryitem`
--

DROP TABLE IF EXISTS `libraryitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `libraryitem` (
  `itemID` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `itemType` varchar(100) NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`itemID`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `libraryitem`
--

LOCK TABLES `libraryitem` WRITE;
/*!40000 ALTER TABLE `libraryitem` DISABLE KEYS */;
INSERT INTO `libraryitem` VALUES (1,'The Grapes of Wrath','Book',5),(2,'Inception','Movie',3),(3,'Time Magazine May 2023','Magazine',10),(4,'The Lord of the Rings','Book',7),(5,'Interstellar','Movie',4),(6,'National Geographic June 2023','Magazine',8),(7,'The Great Gatsby','Book',6),(8,'Goodnight Moon','Book',10),(9,'Ramona the Brave','Book',8),(10,'To Kill a Mockingbird','Book',9),(11,'1984','Book',11),(12,'Led Zeppelin IV','Audio Tape',5),(13,'The Dark Side of the Moon','Audio Tape',3),(14,'Thriller by Michael Jackson','Compact Disc',7),(15,'Back in Black by AC/DC','Compact Disc',4);
/*!40000 ALTER TABLE `libraryitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loanrecord`
--

DROP TABLE IF EXISTS `loanrecord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loanrecord` (
  `loanID` int NOT NULL AUTO_INCREMENT,
  `libraryCardNumber` int NOT NULL,
  `itemID` int NOT NULL,
  `checkoutDate` date NOT NULL,
  `dueDate` date NOT NULL,
  `returnDate` date DEFAULT NULL,
  `fine` decimal(10,2) DEFAULT NULL,
  `renewalStatus` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`loanID`),
  KEY `loanrecord_libraryitem_FK` (`itemID`),
  KEY `loanrecord_patron_FK` (`libraryCardNumber`),
  CONSTRAINT `loanrecord_libraryitem_FK` FOREIGN KEY (`itemID`) REFERENCES `libraryitem` (`itemID`),
  CONSTRAINT `loanrecord_patron_FK` FOREIGN KEY (`libraryCardNumber`) REFERENCES `patron` (`libraryCardNumber`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loanrecord`
--

LOCK TABLES `loanrecord` WRITE;
/*!40000 ALTER TABLE `loanrecord` DISABLE KEYS */;
INSERT INTO `loanrecord` VALUES (1,1,1,'2023-05-01','2023-05-15','2023-05-16',15.00,0),(2,2,2,'2023-05-03','2023-05-17',NULL,0.00,1),(3,3,3,'2023-05-05','2023-05-19','2023-05-20',5.00,0),(4,4,4,'2023-05-06','2023-05-20',NULL,0.00,1),(5,5,5,'2023-05-07','2023-05-21','2023-05-21',0.00,1),(6,6,6,'2023-05-08','2023-05-22','2023-05-23',10.00,0),(7,7,7,'2023-05-09','2023-05-23','2023-05-23',0.00,1),(8,1,1,'2014-04-01','2014-04-15','2014-04-16',15.00,0),(9,2,2,'2014-04-10','2014-04-24',NULL,0.00,1),(10,3,3,'2014-05-01','2014-05-15','2014-05-17',5.00,0),(11,4,4,'2014-06-01','2014-06-15',NULL,0.00,1),(12,5,5,'2014-07-01','2014-07-15','2014-07-15',0.00,1),(13,6,6,'2014-08-01','2014-08-15','2014-08-17',10.00,0),(14,7,7,'2014-09-01','2014-09-15','2014-09-15',0.00,1);
/*!40000 ALTER TABLE `loanrecord` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `magazine`
--

DROP TABLE IF EXISTS `magazine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `magazine` (
  `itemID` int NOT NULL,
  `issueNumber` varchar(50) DEFAULT NULL,
  `issueDate` date NOT NULL,
  PRIMARY KEY (`itemID`),
  CONSTRAINT `magazine_libraryitem_FK` FOREIGN KEY (`itemID`) REFERENCES `libraryitem` (`itemID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `magazine`
--

LOCK TABLES `magazine` WRITE;
/*!40000 ALTER TABLE `magazine` DISABLE KEYS */;
INSERT INTO `magazine` VALUES (3,'2023-05','2023-05-01'),(6,'2023-06','2023-06-01');
/*!40000 ALTER TABLE `magazine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movie`
--

DROP TABLE IF EXISTS `movie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movie` (
  `itemID` int NOT NULL,
  `director` varchar(100) DEFAULT NULL,
  `rating` varchar(20) NOT NULL,
  `genre` varchar(50) NOT NULL,
  `releaseYear` year NOT NULL,
  PRIMARY KEY (`itemID`),
  CONSTRAINT `movie_libraryitem_FK` FOREIGN KEY (`itemID`) REFERENCES `libraryitem` (`itemID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movie`
--

LOCK TABLES `movie` WRITE;
/*!40000 ALTER TABLE `movie` DISABLE KEYS */;
INSERT INTO `movie` VALUES (2,'Christopher Nolan','PG-13','Sci-Fi',2010),(5,'Christopher Nolan','PG-13','Sci-Fi',2014);
/*!40000 ALTER TABLE `movie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patron`
--

DROP TABLE IF EXISTS `patron`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patron` (
  `libraryCardNumber` int NOT NULL AUTO_INCREMENT,
  `patronName` varchar(100) NOT NULL,
  `address` varchar(100) NOT NULL,
  `phoneNumber` varchar(100) NOT NULL,
  `dateOfBirth` date NOT NULL,
  PRIMARY KEY (`libraryCardNumber`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patron`
--

LOCK TABLES `patron` WRITE;
/*!40000 ALTER TABLE `patron` DISABLE KEYS */;
INSERT INTO `patron` VALUES (1,'John Doe','123 Maple St, Anytown','555-1234','1980-06-15'),(2,'Jane Smith','456 Oak St, Othertown','555-5678','1992-11-30'),(3,'Alice Johnson','789 Pine St, Sometown','555-2468','1975-09-23'),(4,'Bob Lee','321 Elm St, Yourtown','555-1357','1988-03-14'),(5,'Charlie Brown','654 Fir St, Theirtown','555-8642','1990-12-17'),(6,'Diana Prince','987 Cedar St, Heretown','555-9753','1984-07-20'),(7,'Bruce Wayne','213 Birch St, Gotham','555-2024','1979-04-07');
/*!40000 ALTER TABLE `patron` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'library'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-27  0:30:33
