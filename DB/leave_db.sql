-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: leavedb
-- ------------------------------------------------------
-- Server version	5.7.17-log

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
INSERT INTO `emp_leave` VALUES ('11Bhw-SJkD.9rkKs1C0vES','Planned Leave','2016-04-21','2016-04-25','Rejecte','1234','Friends Marriage',NULL),('1UMt94ZVQfW9KjIuXgQlyG','Sick/Casual leave','17/07/2017','17/07/2017','Rejected','111111','test',1),('4uxxlj1d4pibgBpE3tq.gB','Planned Leave','04/04/2017','04/04/2017','Pending','111111','Test',NULL),('5NmbTX5VQZpaPnYGSDUESr','Sick/Casual leave','01/04/2017','12/04/2017','Approved','111111','Test',NULL),('5X9rbZCuQJ8buVPa1b1zTy','Planned Leave','18/07/2017','18/07/2017','Pending','111111','A',1),('5y8lkzCbkiu8TojTwEgVhw','Planned Leave','17/07/2017','18/07/2017','CancelPending','111111','tesy',2),('6hj92oCkATwbw5cnUE.Zso','Sick/Casual leave','01/04/2017','05/04/2017','CancelApproved','111111','Test leave Deduction.',5),('8vBeuMXp4Ci8NvIASUSwNz','Planned Leave','18/07/2017','18/07/2017','Pending','111111','A',1),('cEz6xM4.AvN8.e760mGg3L','Planned Leave','17/07/2017','17/07/2017','Pending','111111','ytsy',1),('dbsMjVkWk-hbqy2eAJ.wg9','Sick/Casual leave','01/04/2017','12/04/2017','CancelRejected','111111','aa',12),('fPfla0y34HbbNjcMeb60Gp','Sick/Casual leave','12/04/2017','12/04/2017','Pending','111111','test',NULL),('YAbOkv34978hgMGwSk9Nj','Sick/Casual leave','17/07/2017','17/07/2017','Pending','111111','test',1);
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
INSERT INTO `emp_register` VALUES ('111111','Sumit','sumit@mail.com','111111','2017-03-27',5,10),('1234','example','example@gmail.com','1234',NULL,NULL,NULL),('12345','sumit','12345@mail.com','12345',NULL,NULL,NULL),('222222','222222','22@22','222222','2017-04-19',12,15),('60071005','VijayBalaji','vijay-kumar@hp','asdf',NULL,NULL,NULL),('60071010','Vijyadra Patil','patil@patya.com','12345',NULL,NULL,NULL),('60071036','SHAILESH','timime687@gmail.com','a',NULL,NULL,NULL),('sdas','asda','dasda','dasdsa',NULL,NULL,NULL);
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

-- Dump completed on 2017-07-18 13:03:37
