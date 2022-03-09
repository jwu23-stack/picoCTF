CREATE DATABASE  IF NOT EXISTS `picoctf` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `picoctf`;
-- MySQL dump 10.13  Distrib 8.0.27, for macos11 (x86_64)
--
-- Host: localhost    Database: picoctf
-- ------------------------------------------------------
-- Server version	8.0.27

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
-- Table structure for table `author`
--

DROP TABLE IF EXISTS `author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `author` (
  `id` int NOT NULL AUTO_INCREMENT,
  `firstName` varchar(100) NOT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `author`
--

LOCK TABLES `author` WRITE;
/*!40000 ALTER TABLE `author` DISABLE KEYS */;
/*!40000 ALTER TABLE `author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category-challenge`
--

DROP TABLE IF EXISTS `category-challenge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category-challenge` (
  `categoryId` int NOT NULL,
  `challengeId` int NOT NULL,
  PRIMARY KEY (`categoryId`,`challengeId`),
  KEY `fromCategoryChallengeToChallenge` (`challengeId`),
  CONSTRAINT `fromCategoryChallengeToCategory` FOREIGN KEY (`categoryId`) REFERENCES `category` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fromCategoryChallengeToChallenge` FOREIGN KEY (`challengeId`) REFERENCES `challenge` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category-challenge`
--

LOCK TABLES `category-challenge` WRITE;
/*!40000 ALTER TABLE `category-challenge` DISABLE KEYS */;
/*!40000 ALTER TABLE `category-challenge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `challenge`
--

DROP TABLE IF EXISTS `challenge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `challenge` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `points` int NOT NULL,
  `solved` tinyint(1) DEFAULT '0',
  `bookmark` tinyint(1) DEFAULT '0',
  `attemptsMade` int DEFAULT '0',
  `rating` decimal(5,2) DEFAULT NULL,
  `solution` varchar(256) DEFAULT NULL,
  `description` json DEFAULT NULL,
  `userId` int NOT NULL,
  `eventlistId` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fromChallengeToEventlist_idx` (`eventlistId`),
  KEY `fromChallengeToUser` (`userId`),
  CONSTRAINT `fromChallengeToEventlist` FOREIGN KEY (`eventlistId`) REFERENCES `eventlist` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fromChallengeToUser` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `challenge`
--

LOCK TABLES `challenge` WRITE;
/*!40000 ALTER TABLE `challenge` DISABLE KEYS */;
/*!40000 ALTER TABLE `challenge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `challenge-author`
--

DROP TABLE IF EXISTS `challenge-author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `challenge-author` (
  `challengeId` int NOT NULL,
  `authorId` int NOT NULL,
  PRIMARY KEY (`challengeId`,`authorId`),
  KEY `fromChallengeAuthorToAuthor_idx` (`authorId`),
  CONSTRAINT `fromChallengeAuthorToAuthor` FOREIGN KEY (`authorId`) REFERENCES `author` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fromChallengeAuthorToChallenge` FOREIGN KEY (`challengeId`) REFERENCES `challenge` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `challenge-author`
--

LOCK TABLES `challenge-author` WRITE;
/*!40000 ALTER TABLE `challenge-author` DISABLE KEYS */;
/*!40000 ALTER TABLE `challenge-author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classroom`
--

DROP TABLE IF EXISTS `classroom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `classroom` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `inviteCode` varchar(45) NOT NULL,
  `setting` json DEFAULT NULL,
  `userId` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fromClassroomToUser` (`userId`),
  CONSTRAINT `fromClassroomToUser` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classroom`
--

LOCK TABLES `classroom` WRITE;
/*!40000 ALTER TABLE `classroom` DISABLE KEYS */;
/*!40000 ALTER TABLE `classroom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eventlist`
--

DROP TABLE IF EXISTS `eventlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `eventlist` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `classroomId` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fromEventlistToClassroom` (`classroomId`),
  CONSTRAINT `fromEventlistToClassroom` FOREIGN KEY (`classroomId`) REFERENCES `classroom` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eventlist`
--

LOCK TABLES `eventlist` WRITE;
/*!40000 ALTER TABLE `eventlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `eventlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hint`
--

DROP TABLE IF EXISTS `hint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hint` (
  `id` int NOT NULL AUTO_INCREMENT,
  `description` varchar(500) NOT NULL,
  `challengeProblem` varchar(100) DEFAULT NULL,
  `challengeId` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fromHintToChallenge` (`challengeId`),
  CONSTRAINT `fromHintToChallenge` FOREIGN KEY (`challengeId`) REFERENCES `challenge` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hint`
--

LOCK TABLES `hint` WRITE;
/*!40000 ALTER TABLE `hint` DISABLE KEYS */;
/*!40000 ALTER TABLE `hint` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `race`
--

DROP TABLE IF EXISTS `race`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `race` (
  `id` int NOT NULL AUTO_INCREMENT,
  `group` varchar(100) NOT NULL,
  `userId` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fromRaceToUser` (`userId`),
  CONSTRAINT `fromRaceToUser` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `race`
--

LOCK TABLES `race` WRITE;
/*!40000 ALTER TABLE `race` DISABLE KEYS */;
/*!40000 ALTER TABLE `race` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report`
--

DROP TABLE IF EXISTS `report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `report` (
  `id` int NOT NULL AUTO_INCREMENT,
  `eventType` varchar(100) DEFAULT NULL,
  `dateCreated` timestamp NULL DEFAULT NULL,
  `problemsAssigned` int DEFAULT NULL,
  `userId` int NOT NULL,
  `classroomId` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fromReportToUser` (`userId`),
  KEY `fromReportToClassroom` (`classroomId`),
  CONSTRAINT `fromReportToClassroom` FOREIGN KEY (`classroomId`) REFERENCES `classroom` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fromReportToUser` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report`
--

LOCK TABLES `report` WRITE;
/*!40000 ALTER TABLE `report` DISABLE KEYS */;
/*!40000 ALTER TABLE `report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `ageGroup` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `countryOfResidence` varchar(100) DEFAULT NULL,
  `gender` varchar(45) DEFAULT NULL,
  `profileAvatar` varchar(500) DEFAULT NULL,
  `schoolInfo` json DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user-classroom`
--

DROP TABLE IF EXISTS `user-classroom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user-classroom` (
  `userId` int NOT NULL,
  `classroomId` int NOT NULL,
  `role` varchar(45) NOT NULL,
  PRIMARY KEY (`userId`,`classroomId`),
  KEY `fromUserClassroomToClassroom` (`classroomId`),
  CONSTRAINT `fromUserClassroomToClassroom` FOREIGN KEY (`classroomId`) REFERENCES `classroom` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fromUserClassroomToUser` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user-classroom`
--

LOCK TABLES `user-classroom` WRITE;
/*!40000 ALTER TABLE `user-classroom` DISABLE KEYS */;
/*!40000 ALTER TABLE `user-classroom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'picoctf'
--

--
-- Dumping routines for database 'picoctf'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-02-06 16:01:26
