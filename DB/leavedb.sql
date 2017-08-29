DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `adminid` int(10) NOT NULL,
  `pass` varchar(50) NOT NULL,
  `adm_name` char(20) NOT NULL,
  PRIMARY KEY (`adminid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
LOCK TABLES `admin` WRITE;
INSERT INTO `admin` VALUES (12345,'12345','Sumit'),(171717,'passwd','Raj'),(179817,'passwd','Sumit'),(179825,'123456','Admin'),(456789,'admin123','Sumit');
UNLOCK TABLES;
DROP TABLE IF EXISTS `adminsumit`;
CREATE TABLE `adminsumit` (
  `adminid` int(10) NOT NULL,
  `pass` varchar(50) NOT NULL,
  `adm_name` char(20) NOT NULL,
  PRIMARY KEY (`adminid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
LOCK TABLES `adminsumit` WRITE;
UNLOCK TABLES;
DROP TABLE IF EXISTS `emp_leave`;
CREATE TABLE `emp_leave` (
  `leave_id` varchar(200) NOT NULL,
  `leavetype` varchar(50) NOT NULL,
  `startdate` varchar(10) NOT NULL,
  `enddate` varchar(10) NOT NULL,
  `status` varchar(20) NOT NULL,
  `EmpID` int(10) NOT NULL,
  `comment` varchar(500) DEFAULT NULL,
  `days` int(10) DEFAULT NULL,
  PRIMARY KEY (`leave_id`),
  KEY `EmpID` (`EmpID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
LOCK TABLES `emp_leave` WRITE;
INSERT INTO `emp_leave` VALUES ('1UMt94ZVQfW9KjIuXgQlyG','Sick/Casual leave','17/07/2017','17/07/2017','Rejected',111111,'test',1),('4CAVYGdj44WaNSSpd-BMGx','Planned Leave','26/07/2017','27/07/2017','Cancelled',12345,'A',2),('4ktKZ-sG4PvaqMmvPqjjuF','Planned Leave','22/07/2017','22/07/2017','Cancelled',12345,'B',1),('4uxxlj1d4pibgBpE3tq.gB','Planned Leave','04/04/2017','04/04/2017','Cancelled',111111,'Test',NULL),('5h2uSV94kHhblZnCuAIJAq','Planned Leave','26/07/2017','26/07/2017','Cancelled',12345,'A',1),('5iPmv0QoQoB9eJegt0NIe7','Sick/Casual leave','25/07/2017','25/07/2017','CancelRejected',12345,'A',1),('5NmbTX5VQZpaPnYGSDUESr','Sick/Casual leave','01/04/2017','12/04/2017','CancelPending',111111,'Test',NULL),('5SbaZDoIQ1ObRx6AoQxVVF','Planned Leave','20/07/2017','20/07/2017','CancelApproved',111111,'A',1),('5X9rbZCuQJ8buVPa1b1zTy','Planned Leave','18/07/2017','18/07/2017','Cancelled',111111,'A',1),('5y8lkzCbkiu8TojTwEgVhw','Planned Leave','17/07/2017','18/07/2017','CancelApproved',111111,'tesy',2),('6hj92oCkATwbw5cnUE.Zso','Sick/Casual leave','01/04/2017','05/04/2017','CancelApproved',111111,'Test leave Deduction.',5),('8j-4uQgzAwObLD4rpdPLAU','Sick/Casual leave','22/07/2017','22/07/2017','Rejected',111111,'Sumit',1),('8vBeuMXp4Ci8NvIASUSwNz','Planned Leave','18/07/2017','18/07/2017','Cancelled',111111,'A',1),('96YE-G.Qk5NbW-2g6AeDgp','Sick/Casual leave','22/07/2017','22/07/2017','Pending',12345,'\\\\\\\\\\\\\\',1),('9hXCx9CMA4n82fT8YxqL3j','Planned Leave','23/07/2017','23/07/2017','Approved',12345,'A',1),('9xr3h-YNQ329c00LyU95rR','Sick/Casual leave','23/07/2017','23/07/2017','Rejected',100000,'Requesting Sick leave as I have got high fever.',1),('aPbqxDP5k0t8ozgsNIReAJ','Sick/Casual leave','20/07/2017','20/07/2017','Cancelled',111111,'A',1),('ayxSMKuOkqibuerucqjvr4','Planned Leave','23/07/2017','23/07/2017','Cancelled',159809,'Test Leave',1),('b-oCQd8SknD92kRIXxOeCW','Planned Leave','22/07/2017','22/07/2017','Cancelled',12345,'A',1),('cEz6xM4.AvN8.e760mGg3L','Planned Leave','17/07/2017','17/07/2017','Approved',111111,'ytsy',1),('cSGzdpkYACf861kjogtUxb','Sick/Casual leave','28/07/2017','30/07/2017','CancelApproved',12345,'Test Leave',3),('cXsDs-5UQsnakS.I3rV2oQ','Planned Leave','22/07/2017','22/07/2017','Rejected',12345,'n',1),('d9H6l6s9kF08O0vNsem4V3','Sick/Casual leave','26/07/2017','26/07/2017','Rejected',12345,'S',1),('dbsMjVkWk-hbqy2eAJ.wg9','Sick/Casual leave','01/04/2017','12/04/2017','CancelRejected',111111,'aa',12),('dRa5HdW3kCEbNOIbvHQ4do','Sick/Casual leave','11/08/2017','11/08/2017','CancelRejected',12345,'Test of Cancel Approval',1),('eh-N3Fi5AIY8WaCV.UKE.x','Planned Leave','24/07/2017','24/07/2017','CancelApproved',12345,'A',1),('fPfla0y34HbbNjcMeb60Gp','Sick/Casual leave','12/04/2017','12/04/2017','Approved',111111,'test',NULL),('YAbOkv34978hgMGwSk9Nj','Sick/Casual leave','17/07/2017','17/07/2017','Approved',111111,'test',1);
UNLOCK TABLES;
DROP TABLE IF EXISTS `emp_register`;
CREATE TABLE `emp_register` (
  `EmpID` int(10) NOT NULL,
  `EmpName` char(50) NOT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `pass` varchar(50) NOT NULL,
  `leave_deposit_date` date DEFAULT NULL,
  `sick_cas_leave` int(10) DEFAULT NULL,
  `planned_leave` int(10) DEFAULT NULL,
  PRIMARY KEY (`EmpID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
LOCK TABLES `emp_register` WRITE;
INSERT INTO `emp_register` VALUES (1234,'example','example@gmail.com','1234','2017-07-10',10,15),(12345,'sumit','12345@mail.com','12345','2017-07-05',22,17),(100000,'Sumit','sumitsaiwal@gmail.com','sumit','2017-07-23',11,15),(111111,'Sumit','sumit@mail.com','111111','2017-03-27',4,15),(159809,'Sam','Sam@sam.com','159809','2017-07-23',12,15),(222222,'222222','22@22','222222','2017-04-19',10,15);
UNLOCK TABLES;
