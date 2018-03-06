CREATE DATABASE  IF NOT EXISTS `logistics` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `logistics`;
-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host: localhost    Database: logistics
-- ------------------------------------------------------
-- Server version	5.7.19

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ADMIN`
--

DROP TABLE IF EXISTS `ADMIN`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ADMIN` (
  `ID` varchar(10) NOT NULL,
  `PASS_HASH` varchar(300) DEFAULT NULL,
  `NAME` varchar(50) DEFAULT NULL,
  `LOCATION` varchar(30) DEFAULT NULL,
  `IS_SUPERUSER` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ADMIN`
--

LOCK TABLES `ADMIN` WRITE;
/*!40000 ALTER TABLE `ADMIN` DISABLE KEYS */;
INSERT INTO `ADMIN` VALUES ('USER_001','$2b$12$uRhS1P9WCb7Y/q1rFHj57.8lETrKdFIcNE3xhxBcL27GR9wc1F6PG','Martin Hanzo','New Mexico',1),('USER_002','$2b$12$uRhS1P9WCb7Y/q1rFHj57.8lETrKdFIcNE3xhxBcL27GR9wc1F6PG','Peter Parker','Brooklyn',0),('USER_003','$2b$12$lhtq5dNFOqBAflUa9D7JlOoj5bpWpEHepigs7rlZTpeG5ZEHet182','Amogh G','Bengaluru',1),('USER_004','$2b$12$Gyfe.yH1.Nz/t7cz58650ucxMWYvVoOSJv9uKBuYk.wo1IxJivfJm','John Doe','Korea',1);
/*!40000 ALTER TABLE `ADMIN` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CURR_EVENT`
--

DROP TABLE IF EXISTS `CURR_EVENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CURR_EVENT` (
  `EID` int(11) NOT NULL AUTO_INCREMENT,
  `_status` tinyint(1) DEFAULT NULL,
  `location` varchar(60) DEFAULT NULL,
  `_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`EID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CURR_EVENT`
--

LOCK TABLES `CURR_EVENT` WRITE;
/*!40000 ALTER TABLE `CURR_EVENT` DISABLE KEYS */;
INSERT INTO `CURR_EVENT` VALUES (1,0,'INDIRA GANDHI AIRPORT, DELHI','2017-11-05 13:55:01'),(2,1,'Mumbai Intl Airport','2017-11-08 17:43:33'),(3,0,'Bengaluru','2017-11-29 17:32:40'),(4,0,'Bengaluru','2017-11-30 19:10:57'),(5,0,'New Mexico','2017-12-01 15:00:09');
/*!40000 ALTER TABLE `CURR_EVENT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DESTINATION`
--

DROP TABLE IF EXISTS `DESTINATION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DESTINATION` (
  `DID` int(11) NOT NULL AUTO_INCREMENT,
  `cust_name` varchar(45) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `country` varchar(20) DEFAULT NULL,
  `state` varchar(20) DEFAULT NULL,
  `pin_code` int(7) DEFAULT NULL,
  `phone` varchar(10) DEFAULT NULL,
  `email` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`DID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DESTINATION`
--

LOCK TABLES `DESTINATION` WRITE;
/*!40000 ALTER TABLE `DESTINATION` DISABLE KEYS */;
INSERT INTO `DESTINATION` VALUES (1,'JANE DOE','16 MAPLE AVENUE SAN PEDRO, CA ','USA','CALIFORNIA',90731,'8356427189','janedoe@somemail.com'),(5,'John','Downtown','USA','New York',56784,'7386486334','johndoe@smtn.com'),(6,'BBB','MKL street','Zambia','Wakanda',56476,'7865439872','xyz@xyz.com'),(7,'Megha G','Downtown','Korea','Seol',536784,'7638906470','megha@gmail.com');
/*!40000 ALTER TABLE `DESTINATION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ORIGIN`
--

DROP TABLE IF EXISTS `ORIGIN`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ORIGIN` (
  `OID` int(11) NOT NULL AUTO_INCREMENT,
  `cust_name` varchar(45) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `country` varchar(20) DEFAULT NULL,
  `state` varchar(20) DEFAULT NULL,
  `pin_code` int(7) DEFAULT NULL,
  `phone` varchar(10) DEFAULT NULL,
  `email` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`OID`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ORIGIN`
--

LOCK TABLES `ORIGIN` WRITE;
/*!40000 ALTER TABLE `ORIGIN` DISABLE KEYS */;
INSERT INTO `ORIGIN` VALUES (1,'JOHN DOE','36 8TH CROSS, YELAHANKA, BENGALURU','INDIA','KARNATAKA',560064,'8745637654','johndoe@somemail.com'),(11,'Amogh G','Bengaluru','India','Karnataka',560064,'8765365437','amoghsk279@gmail.com'),(12,'AAA','Chinatown','UK','Manchester',67854,'6754398765','abc@abc.com'),(13,'Amogh G','Taiwan','China','Xiaomi',764387,'7653648790','amoghsk279@gmail.com');
/*!40000 ALTER TABLE `ORIGIN` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PACKAGE`
--

DROP TABLE IF EXISTS `PACKAGE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PACKAGE` (
  `PID` int(11) NOT NULL AUTO_INCREMENT,
  `details` varchar(60) DEFAULT NULL,
  `type` varchar(30) DEFAULT NULL,
  `OID` int(11) DEFAULT NULL,
  `DID` int(11) DEFAULT NULL,
  `via` varchar(5) DEFAULT NULL,
  `priority` tinyint(1) DEFAULT NULL,
  `EID` int(11) DEFAULT NULL,
  PRIMARY KEY (`PID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PACKAGE`
--

LOCK TABLES `PACKAGE` WRITE;
/*!40000 ALTER TABLE `PACKAGE` DISABLE KEYS */;
INSERT INTO `PACKAGE` VALUES (1,'DIGITAL WRIST WATCH','ELECTRONICS',1,1,'AIR',0,1),(2,'Doodh ke pede','Food',11,5,'Air',1,3),(3,'Shirt','Clothing',12,6,'AIR',0,4),(4,'Sweets','Food',13,7,'AIR',1,5);
/*!40000 ALTER TABLE `PACKAGE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TRACK`
--

DROP TABLE IF EXISTS `TRACK`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TRACK` (
  `TID` varchar(10) NOT NULL,
  `pass_hash` varchar(300) DEFAULT NULL,
  `PID` int(11) DEFAULT NULL,
  PRIMARY KEY (`TID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TRACK`
--

LOCK TABLES `TRACK` WRITE;
/*!40000 ALTER TABLE `TRACK` DISABLE KEYS */;
INSERT INTO `TRACK` VALUES ('3VQG0CE','',2),('5CFAF6U','',3),('KACA001','$2b$12$VQKwlzNmUCZBpqDE1U6p3ug1PE2ibAXHFgvCUaZLawc3365Yd5yqS',1),('SAVLT8G','',4);
/*!40000 ALTER TABLE `TRACK` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'logistics'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_addadmin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_addadmin`(
	IN a_id VARCHAR(10),
	IN a_pass VARCHAR(300),
	IN a_name VARCHAR(50),
	IN a_loc VARCHAR(30),
	IN a_su BOOLEAN
)
BEGIN
	INSERT INTO admin(
		id,
		pass_hash,
		name,
		location,
		is_superuser
	)
	VALUES
	(
		a_id,
		a_pass,
		a_name,
		a_loc,
		a_su
	);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-12-02 22:13:27
