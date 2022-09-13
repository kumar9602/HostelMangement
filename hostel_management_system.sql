-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 16, 2021 at 10:34 AM
-- Server version: 10.4.20-MariaDB
-- PHP Version: 8.0.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hostel_management_system`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_branch_year` (IN `category` NVARCHAR(30), IN `hos_id` INT)  BEGIN

if(category='branch') then
	SELECT dept as Department, count(*) as total_student
     from Student where Hostel_id=hos_id
     group by dept
     order by total_student desc;
     
     end if;

if(category='year') then
	SELECT GetYearName(cast(Year_of_study as unsigned)),count(*) as total_student
		 from Student where Hostel_id=hos_id
		 group by Year_of_study
		 order by total_student desc;
end if;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `GetYearName` (`yearnumber` INT) RETURNS VARCHAR(30) CHARSET latin1 BEGIN

   DECLARE yearName varchar(30);
   
   if yearnumber=1 then
   set yearName='First';
   end if;
   
   if yearnumber=2 then
   set yearName='Second';
   end if;
   
   if yearnumber=3 then
   set yearName='Third';
   end if;
   
   if yearnumber=4 then
   set yearName='Fourth';
   end if;
   
   
   RETURN yearName;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `application`
--

CREATE TABLE `application` (
  `Application_id` int(100) NOT NULL,
  `Student_id` varchar(255) NOT NULL,
  `Hostel_id` int(10) NOT NULL,
  `Application_status` tinyint(1) DEFAULT NULL,
  `Room_No` int(10) DEFAULT NULL,
  `Message` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `application`
--

INSERT INTO `application` (`Application_id`, `Student_id`, `Hostel_id`, `Application_status`, `Room_No`, `Message`) VALUES
(17, '1', 1, 0, 4, ''),
(19, '4', 2, 0, 1, ''),
(20, '2', 2, 0, 2, ''),
(21, '1911603', 2, 1, NULL, '');

-- --------------------------------------------------------

--
-- Table structure for table `application_mess`
--

CREATE TABLE `application_mess` (
  `Application_id` int(100) NOT NULL,
  `Student_id` varchar(255) NOT NULL,
  `Mess_id` int(10) NOT NULL,
  `Application_status` tinyint(1) DEFAULT NULL,
  `Mess_card_No` int(10) DEFAULT NULL,
  `Message` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `application_mess`
--

INSERT INTO `application_mess` (`Application_id`, `Student_id`, `Mess_id`, `Application_status`, `Mess_card_No`, `Message`) VALUES
(14, '2', 1, 0, 4, 'fadsfsdfads');

-- --------------------------------------------------------

--
-- Table structure for table `hostel`
--

CREATE TABLE `hostel` (
  `Hostel_id` int(10) NOT NULL,
  `Hostel_name` varchar(255) DEFAULT NULL,
  `current_no_of_rooms` int(15) DEFAULT 0,
  `No_of_rooms` int(15) DEFAULT 5,
  `No_of_students` int(10) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `hostel`
--

INSERT INTO `hostel` (`Hostel_id`, `Hostel_name`, `current_no_of_rooms`, `No_of_rooms`, `No_of_students`) VALUES
(1, 'A', 4, 5, 4),
(2, 'B', 2, 5, 2),
(3, 'C', 1, 5, 1),
(4, 'D', 1, 5, 1),
(5, 'E', 1, 5, 1),
(6, 'F', 1, 5, 1);

-- --------------------------------------------------------

--
-- Table structure for table `hostel_manager`
--

CREATE TABLE `hostel_manager` (
  `Hostel_man_id` int(10) NOT NULL,
  `Username` varchar(255) NOT NULL,
  `Fname` varchar(255) NOT NULL,
  `Lname` varchar(255) NOT NULL,
  `Mob_no` varchar(255) NOT NULL,
  `Hostel_id` int(10) NOT NULL,
  `Mess_id` int(10) NOT NULL,
  `Pwd` longtext NOT NULL,
  `Isadmin` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `hostel_manager`
--

INSERT INTO `hostel_manager` (`Hostel_man_id`, `Username`, `Fname`, `Lname`, `Mob_no`, `Hostel_id`, `Mess_id`, `Pwd`, `Isadmin`) VALUES
(1, 'mainadmin', 'Admin', 'IIIDMJ', '987654321', 1, 1, 'trial', 1),
(2, 'hostelA', 'Hostel', 'A', '987654321', 1, 1, '$2y$10$QImNrErR0Bj5Ns9Gm/CKbulEPWNj9YBpihk6JWg4Ipx.pcEev6gHq', 0),
(3, 'hostelB', 'Hostel', 'B', '987654321', 2, 2, '$2y$10$Xdfrgvx5EvVWMzfzwIyTb./igun.DZMp5XxBXWnME5s0IjtGgovDu', 0),
(4, 'hostelC', 'Hostel', 'C', '987654321', 3, 3, '$2y$10$7gpP8Q.krVUgulRBgxNOVejLPZN5PEEIoQr9xijdgDzeu9jvcpu5G', 0),
(5, 'hostelD', 'Hostel', 'D', '987654321', 4, 4, '$2y$10$inWxU5AcKQ8fLeufr6dYaeeLuvnhlh.N67XzqM4rZtg.xOsDWcBHu', 0),
(6, 'hostelE', 'Hostel', 'E', '987654321', 5, 5, '$2y$10$SpCXnzzahlCPOIVl2Eh1fePaUPtrpdAkvtrUXzF7W0xyusZS7nx/q', 0),
(7, 'hostelF', 'Hostel', 'F', '987654321', 6, 6, '$2y$10$8b849FWoiZkfa5uRK52jYulD0llS6hOdkw7Srh0TQJO/JoVQvmLSi', 0);

-- --------------------------------------------------------

--
-- Stand-in structure for view `hostel_manager_profile`
-- (See below for the actual view)
--
CREATE TABLE `hostel_manager_profile` (
`Hostel_man_id` int(10)
,`Username` varchar(255)
,`Fname` varchar(255)
,`Lname` varchar(255)
,`Mob_no` varchar(255)
,`Hostel_name` varchar(255)
,`Mess_name` varchar(255)
,`Hostel_Occupancy` decimal(19,1)
,`Mess_Occupancy` decimal(20,1)
);

-- --------------------------------------------------------

--
-- Table structure for table `mess`
--

CREATE TABLE `mess` (
  `Mess_id` int(10) NOT NULL,
  `Mess_name` varchar(255) NOT NULL,
  `Mess_type` varchar(255) NOT NULL,
  `Vacancy` int(15) DEFAULT 5,
  `Size` int(15) DEFAULT 5
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mess`
--

INSERT INTO `mess` (`Mess_id`, `Mess_name`, `Mess_type`, `Vacancy`, `Size`) VALUES
(1, 'A', 'Veg', 1, 5),
(2, 'B', 'Veg', 3, 5),
(3, 'C', 'Veg', 5, 5),
(4, 'D', 'Non-veg', 4, 5),
(5, 'E', 'Non-veg', 4, 5),
(6, 'F', 'Non-veg', 4, 5);

-- --------------------------------------------------------

--
-- Table structure for table `mess_allocation`
--

CREATE TABLE `mess_allocation` (
  `Mess_card_id` int(10) NOT NULL,
  `Mess_id` int(10) NOT NULL,
  `Mess_card_No` int(10) NOT NULL,
  `Allocated` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mess_allocation`
--

INSERT INTO `mess_allocation` (`Mess_card_id`, `Mess_id`, `Mess_card_No`, `Allocated`) VALUES
(1, 1, 1, 1),
(2, 1, 2, 1),
(3, 1, 3, 1),
(4, 1, 4, 1),
(5, 1, 5, 0),
(6, 2, 1, 1),
(7, 2, 2, 1),
(8, 2, 3, 0),
(9, 2, 4, 0),
(10, 2, 5, 0),
(11, 3, 1, 0),
(12, 3, 2, 0),
(13, 3, 3, 0),
(14, 3, 4, 0),
(15, 3, 5, 0),
(16, 4, 1, 1),
(17, 4, 2, 0),
(18, 4, 3, 0),
(19, 4, 4, 0),
(20, 4, 5, 0),
(21, 5, 1, 1),
(22, 5, 2, 0),
(23, 5, 3, 0),
(24, 5, 4, 0),
(25, 5, 5, 0),
(26, 6, 1, 1),
(27, 6, 2, 0),
(28, 6, 3, 0),
(29, 6, 4, 0),
(30, 6, 5, 0);

--
-- Triggers `mess_allocation`
--
DELIMITER $$
CREATE TRIGGER `mess_allocation_update` AFTER UPDATE ON `mess_allocation` FOR EACH ROW IF NEW.Allocated =1 and OLD.Allocated!=NEW.Allocated THEN 
		update Mess set Vacancy=Vacancy-1 where Mess_id = NEW.Mess_id  ;
	else 
		if NEW.Allocated=0 and OLD.Allocated!=NEW.Allocated THEN
			update Mess set Vacancy = Vacancy +1 where Mess_id= NEW.Mess_id;
		END IF;
	END IF
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `Student_id` varchar(255) NOT NULL,
  `Status` tinyint(1) DEFAULT 0,
  `Amount` int(10) DEFAULT 75000
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`Student_id`, `Status`, `Amount`) VALUES
('181IT127', 1, 75000),
('181IT128', 1, 75000),
('181IT129', 1, 75000),
('181IT130', 1, 75000),
('181IT131', 1, 75000),
('181IT132', 1, 75000),
('181IT206', 1, 75000),
('181IT133', 1, 75000),
('181IT207', 1, 75000),
('181IT208', 1, 75000),
('1', 1, 75000),
('2', 1, 75000),
('4', 1, 75000),
('1911603', 1, 75000);

-- --------------------------------------------------------

--
-- Table structure for table `room`
--

CREATE TABLE `room` (
  `Room_id` int(10) NOT NULL,
  `Hostel_id` int(10) NOT NULL,
  `Room_No` int(10) NOT NULL,
  `Allocated` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `room`
--

INSERT INTO `room` (`Room_id`, `Hostel_id`, `Room_No`, `Allocated`) VALUES
(1, 1, 1, 1),
(2, 1, 2, 1),
(3, 1, 3, 1),
(4, 1, 4, 1),
(5, 1, 5, 0),
(6, 2, 1, 1),
(7, 2, 2, 1),
(8, 2, 3, 0),
(9, 2, 4, 0),
(10, 2, 5, 0),
(11, 3, 1, 1),
(12, 3, 2, 0),
(13, 3, 3, 0),
(14, 3, 4, 0),
(15, 3, 5, 0),
(16, 4, 1, 1),
(17, 4, 2, 0),
(18, 4, 3, 0),
(19, 4, 4, 0),
(20, 4, 5, 0),
(21, 5, 1, 1),
(22, 5, 2, 0),
(23, 5, 3, 0),
(24, 5, 4, 0),
(25, 5, 5, 0),
(26, 6, 1, 1),
(27, 6, 2, 0),
(28, 6, 3, 0),
(29, 6, 4, 0),
(30, 6, 5, 0);

--
-- Triggers `room`
--
DELIMITER $$
CREATE TRIGGER `allocation_update` AFTER UPDATE ON `room` FOR EACH ROW IF NEW.allocated =1 and OLD.allocated!=NEW.allocated THEN 
	update Hostel set current_no_of_rooms=current_no_of_rooms+1, No_of_students = No_of_students+1 where Hostel_id=NEW.Hostel_id;
else 
	if NEW.allocated=0 and OLD.allocated!=NEW.allocated THEN
		update Hostel set current_no_of_rooms = current_no_of_rooms-1, 
        No_of_students = No_of_students-1 where Hostel_id=NEW.Hostel_id;
	END IF;
END IF
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `Student_id` varchar(255) NOT NULL,
  `Fname` varchar(255) NOT NULL,
  `Lname` varchar(255) NOT NULL,
  `Mob_no` varchar(255) NOT NULL,
  `Dept` varchar(255) NOT NULL,
  `Year_of_study` varchar(255) NOT NULL,
  `Pwd` longtext NOT NULL,
  `Hostel_id` int(10) DEFAULT NULL,
  `Room_id` int(10) DEFAULT NULL,
  `Mess_id` int(10) DEFAULT NULL,
  `Mess_card_id` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`Student_id`, `Fname`, `Lname`, `Mob_no`, `Dept`, `Year_of_study`, `Pwd`, `Hostel_id`, `Room_id`, `Mess_id`, `Mess_card_id`) VALUES
('1', 'Dinesh', 'Kumar', '93522926216', 'cse', '2', '$2y$10$oYHg7.6fNzkNN0jBFPEaMOWbGtbEVUZEABLIciZND5r/OsqXL8Yl.', 1, 4, NULL, NULL),
('181IT127', 'Meghna', 'Kashyap', '9880921333', 'IT', '2', '$2y$10$ZCjLQHt.LgDyaUfrIfa2AObpPYXTYwxQ59FcHoM66K7J1PETUiiL.', 1, 1, 1, 1),
('181IT128', 'Mansi', 'Saxena', '9880921333', 'IT', '2', '$2y$10$AO9Ffk4G..fkX1LvEChZDewF5Gh/D6iAQIY0TZHWsa2vzzdFhkBLW', NULL, NULL, 2, 1),
('181IT129', 'Mohit', 'M', '9880921333', 'IT', '4', '$2y$10$hcUD0a5lNyEdx.TOhh1KpemwBhKrRs6tKHT.EcbeMqSDLQzRXcwjS', 3, 1, NULL, NULL),
('181IT130', 'Nivedhya', 'Girish', '9880921333', 'IT', '1', '$2y$10$soAPlxnvKXAY7FJzFM7NPeaMk74RYU71iGrgyCvnFL3zho9Sc/POW', 4, 1, 4, 1),
('181IT131', 'Janavi', 'N', '9880921333', 'ECE', '2', '$2y$10$59WQd4lgBJOXQ4pCrmKDeePCCdrEAi1eg8Rz.3saKuTBrTAdWuD5K', 5, 1, 5, 1),
('181IT132', 'Jiffy', 'Patrick', '9880921333', 'Civil', '3', '$2y$10$xxYP7aOEe.SVkgO0VPXhie8g8UzJDi5sspRunPD3VxlogPJ0zfd.G', 6, 1, 6, 1),
('181IT133', 'Fidha', 'P', '9880921333', 'EEE', '2', '$2y$10$JbdyCLiYQn7.8UhXyqEkTeP0Kb5Lqh6X75CRXYFdEvmGW6aHrkmJW', NULL, NULL, 2, 2),
('181IT206', 'Aniruddh', 'Sujish', '9880921333', 'ECE', '3', '$2y$10$LLmQJb7moIL2AAETKZ.cUe7Cwxfj/31Lt1GVktlfbAI72qBqxxKCu', 1, 2, 1, 2),
('181IT207', 'Darini', 'Raman', '9880921333', 'CS', '4', '$2y$10$Lsjw2Qesdb/YEH0u9y/tNe8DOH64Ievuh8hyivY9BdWY6LieXEBAG', 1, 3, 1, 3),
('181IT208', 'Rea', 'Jacob', '9880921333', 'Mechanical', '4', '$2y$10$3ayzQhemDWUQTR5osk.SPOoZNppa2vte.p2brk86aSTC0t9DWaXKq', NULL, NULL, NULL, NULL),
('1911603', 'poornima', 'singh', '9352292616', 'cse', '2', '$2y$10$l01oZqeFuQ0qRyhsxpqM9ObpYTRjLQZMV1n.hhhl3XGjacUfpexza', NULL, NULL, NULL, NULL),
('2', 'Dinesh', 'Kumar', '9352292616', 'cse', '2', '$2y$10$v5crGzpxe1vpAiskwLxztOK78EoLpG5o9K1UK0RjLedDNw91IyZHe', 2, 2, 1, 4),
('4', 'Dinesh', 'Dinesh', '579234759', 'cse', '2', '$2y$10$i/AdKQXsmsMo/PLbgvVvied9xuXCw8mJMZ9LyucsJAIBtURHTMfoK', 2, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure for view `hostel_manager_profile`
--
DROP TABLE IF EXISTS `hostel_manager_profile`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `hostel_manager_profile`  AS SELECT `hm`.`Hostel_man_id` AS `Hostel_man_id`, `hm`.`Username` AS `Username`, `hm`.`Fname` AS `Fname`, `hm`.`Lname` AS `Lname`, `hm`.`Mob_no` AS `Mob_no`, `h`.`Hostel_name` AS `Hostel_name`, `m`.`Mess_name` AS `Mess_name`, round(`h`.`current_no_of_rooms` / `h`.`No_of_rooms` * 100,1) AS `Hostel_Occupancy`, round((`m`.`Size` - `m`.`Vacancy`) / `m`.`Size` * 100,1) AS `Mess_Occupancy` FROM ((`hostel_manager` `hm` join `hostel` `h` on(`hm`.`Hostel_id` = `h`.`Hostel_id`)) join `mess` `m` on(`m`.`Mess_id` = `hm`.`Mess_id`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `application`
--
ALTER TABLE `application`
  ADD PRIMARY KEY (`Application_id`),
  ADD KEY `Student_id` (`Student_id`),
  ADD KEY `Hostel_id` (`Hostel_id`);

--
-- Indexes for table `application_mess`
--
ALTER TABLE `application_mess`
  ADD PRIMARY KEY (`Application_id`),
  ADD KEY `Student_id` (`Student_id`),
  ADD KEY `Mess_id` (`Mess_id`);

--
-- Indexes for table `hostel`
--
ALTER TABLE `hostel`
  ADD PRIMARY KEY (`Hostel_id`);

--
-- Indexes for table `hostel_manager`
--
ALTER TABLE `hostel_manager`
  ADD PRIMARY KEY (`Hostel_man_id`),
  ADD UNIQUE KEY `Username` (`Username`),
  ADD KEY `Hostel_id` (`Hostel_id`),
  ADD KEY `Mess_id` (`Mess_id`);

--
-- Indexes for table `mess`
--
ALTER TABLE `mess`
  ADD PRIMARY KEY (`Mess_id`);

--
-- Indexes for table `mess_allocation`
--
ALTER TABLE `mess_allocation`
  ADD PRIMARY KEY (`Mess_card_id`),
  ADD KEY `Mess_id` (`Mess_id`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD KEY `Student_id` (`Student_id`);

--
-- Indexes for table `room`
--
ALTER TABLE `room`
  ADD PRIMARY KEY (`Room_id`),
  ADD KEY `Hostel_id` (`Hostel_id`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`Student_id`),
  ADD KEY `Hostel_id` (`Hostel_id`),
  ADD KEY `Room_id` (`Room_id`),
  ADD KEY `Mess_id` (`Mess_id`),
  ADD KEY `Mess_card_id` (`Mess_card_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `application`
--
ALTER TABLE `application`
  MODIFY `Application_id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `application_mess`
--
ALTER TABLE `application_mess`
  MODIFY `Application_id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `hostel`
--
ALTER TABLE `hostel`
  MODIFY `Hostel_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `hostel_manager`
--
ALTER TABLE `hostel_manager`
  MODIFY `Hostel_man_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `mess`
--
ALTER TABLE `mess`
  MODIFY `Mess_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `mess_allocation`
--
ALTER TABLE `mess_allocation`
  MODIFY `Mess_card_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `room`
--
ALTER TABLE `room`
  MODIFY `Room_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `application`
--
ALTER TABLE `application`
  ADD CONSTRAINT `Application_ibfk_1` FOREIGN KEY (`Student_id`) REFERENCES `student` (`Student_id`),
  ADD CONSTRAINT `Application_ibfk_2` FOREIGN KEY (`Hostel_id`) REFERENCES `hostel` (`Hostel_id`);

--
-- Constraints for table `application_mess`
--
ALTER TABLE `application_mess`
  ADD CONSTRAINT `Application_mess_ibfk_1` FOREIGN KEY (`Student_id`) REFERENCES `student` (`Student_id`),
  ADD CONSTRAINT `Application_mess_ibfk_2` FOREIGN KEY (`Mess_id`) REFERENCES `mess` (`Mess_id`);

--
-- Constraints for table `hostel_manager`
--
ALTER TABLE `hostel_manager`
  ADD CONSTRAINT `Hostel_Manager_ibfk_1` FOREIGN KEY (`Hostel_id`) REFERENCES `hostel` (`Hostel_id`),
  ADD CONSTRAINT `Hostel_Manager_ibfk_2` FOREIGN KEY (`Mess_id`) REFERENCES `mess` (`Mess_id`);

--
-- Constraints for table `mess_allocation`
--
ALTER TABLE `mess_allocation`
  ADD CONSTRAINT `Mess_ibfk_1` FOREIGN KEY (`Mess_id`) REFERENCES `mess` (`Mess_id`);

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`Student_id`) REFERENCES `student` (`Student_id`);

--
-- Constraints for table `room`
--
ALTER TABLE `room`
  ADD CONSTRAINT `Room_ibfk_1` FOREIGN KEY (`Hostel_id`) REFERENCES `hostel` (`Hostel_id`);

--
-- Constraints for table `student`
--
ALTER TABLE `student`
  ADD CONSTRAINT `Student_ibfk_1` FOREIGN KEY (`Hostel_id`) REFERENCES `hostel` (`Hostel_id`),
  ADD CONSTRAINT `Student_ibfk_2` FOREIGN KEY (`Room_id`) REFERENCES `room` (`Room_id`),
  ADD CONSTRAINT `Student_ibfk_3` FOREIGN KEY (`Mess_id`) REFERENCES `mess` (`Mess_id`),
  ADD CONSTRAINT `Student_ibfk_4` FOREIGN KEY (`Mess_card_id`) REFERENCES `mess_allocation` (`Mess_card_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
