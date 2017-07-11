CREATE DATABASE  IF NOT EXISTS `leavedb` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `leavedb`;
-- MySQL dump 10.13  Distrib 5.6.24, for Win64 (x86_64)
--
-- Host: localhost    Database: leavedb
-- ------------------------------------------------------
-- Server version	5.6.27-log

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
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin` (
  `adminid` varchar(10) DEFAULT NULL,
  `pass` varchar(50) DEFAULT NULL,
  `adm_name` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES ('12345','12345',NULL),('admin','admin123',NULL);
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emp_leave`
--

DROP TABLE IF EXISTS `emp_leave`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `emp_leave` (
  `leave_id` varchar(200) NOT NULL,
  `leavetype` varchar(90) DEFAULT NULL,
  `startdate` varchar(10) DEFAULT NULL,
  `enddate` varchar(10) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `EmpID` varchar(10) DEFAULT NULL,
  `comment` varchar(500) DEFAULT NULL,
  `days` int(10) DEFAULT NULL,
  PRIMARY KEY (`leave_id`),
  KEY `EmpID` (`EmpID`),
  CONSTRAINT `emp_leave_ibfk_1` FOREIGN KEY (`EmpID`) REFERENCES `emp_register` (`EmpID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emp_leave`
--

LOCK TABLES `emp_leave` WRITE;
/*!40000 ALTER TABLE `emp_leave` DISABLE KEYS */;
INSERT INTO `emp_leave` VALUES ('11Bhw-SJkD.9rkKs1C0vES','Planned Leave','2016-04-21','2016-04-25','Rejecte','1234','Friends Marriage',NULL),('4ueowX0Z4C6aO5cVj327Ey','Planned Leave','05/06/2017','05/06/2017','Pending','111111','leave',1),('4uxxlj1d4pibgBpE3tq.gB','Planned Leave','04/04/2017','04/04/2017','Pending','111111','Test',NULL),('5NmbTX5VQZpaPnYGSDUESr','Sick/Casual leave','01/04/2017','12/04/2017','Pending','111111','Test',NULL),('6hj92oCkATwbw5cnUE.Zso','Sick/Casual leave','01/04/2017','05/04/2017','Pending','111111','Test leave Deduction.',5),('7aNDTopVkq5ah0eVaFR1fO','Planned Leave','03/06/2017','03/06/2017','Pending','111111','leave',1),('8tfok09CA2tbI.VCSm7aYL','Planned Leave','21/06/2017','24/06/2017','Pending','222222','Leave',4),('9HS5j1ZwQlO8qEn27NpOnQ','Planned Leave','21/06/2017','22/06/2017','Pending','111111','sick',2),('b9kXvYuZQFN9XfkW-9gqTX','Sick/Casual leave','20/06/2017','22/06/2017','Pending','222222','sick',3),('dbsMjVkWk-hbqy2eAJ.wg9','Sick/Casual leave','01/04/2017','12/04/2017','Pending','111111','aa',12),('eDZLfL3fACWaB58Dyh3u.P','Planned Leave','03/06/2017','03/06/2017','Pending','111111','leave',1),('fa1tFQv.kkM8MHy.ajbZoH','Planned Leave','05/06/2017','05/06/2017','Pending','111111','leave',1),('fPfla0y34HbbNjcMeb60Gp','Sick/Casual leave','12/04/2017','12/04/2017','Pending','111111','test',NULL);
/*!40000 ALTER TABLE `emp_leave` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emp_register`
--

DROP TABLE IF EXISTS `emp_register`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `emp_register` (
  `EmpID` varchar(10) NOT NULL,
  `EmpName` char(50) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `pass` varchar(50) DEFAULT NULL,
  `leave_deposit_date` date DEFAULT NULL,
  `sick_cas_leave` int(11) DEFAULT NULL,
  `planned_leave` int(11) DEFAULT NULL,
  PRIMARY KEY (`EmpID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emp_register`
--

LOCK TABLES `emp_register` WRITE;
/*!40000 ALTER TABLE `emp_register` DISABLE KEYS */;
INSERT INTO `emp_register` VALUES ('111111','Sumit','sumit@mail.com','111111','2017-03-27',6,5),('1234','example','example@gmail.com','1234',NULL,NULL,NULL),('12345','sumit','12345@mail.com','12345',NULL,NULL,NULL),('222222','222222','22@22','222222','2017-04-19',9,11),('60071005','VijayBalaji','vijay-kumar@hp','asdf',NULL,NULL,NULL),('60071010','Vijyadra Patil','patil@patya.com','12345',NULL,NULL,NULL),('60071036','SHAILESH','timime687@gmail.com','a',NULL,NULL,NULL),('sdas','asda','dasda','dasdsa',NULL,NULL,NULL);
/*!40000 ALTER TABLE `emp_register` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-07-11 15:19:22
