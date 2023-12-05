-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: July 2, 2023 at 11:20 AM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 8.0.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

-- Database: `car_rental_system`

-- --------------------------------------------------------

-- Table structure for table `admin`

CREATE TABLE `admin` (
  `Fname` varchar(30) NOT NULL,
  `Mname` varchar(30) DEFAULT NULL,
  `Lname` varchar(30) DEFAULT NULL,
  `adminId` int(11) NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

-- Table structure for table `availablevehicle`

CREATE TABLE `availablevehicle` (
  `vehicle_name` varchar(30),
  `vehicleModel` varchar(30),
  `vehicleId` int(11),
  `vehicle_type` varchar(30)
);

-- --------------------------------------------------------

-- Table structure for table `billing`

CREATE TABLE `billing` (
  `bill_number` int(11) NOT NULL,
  `amount` float NOT NULL,
  `dueDate` date NOT NULL,
  `cusId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

-- Table structure for table `billinginformation`

CREATE TABLE `billinginformation` (
  `startdate` date,
  `enddate` date,
  `cusId` int(11),
  `amount` float,
  `bill_number` int(11),
  `discount_amount` float
);

-- --------------------------------------------------------

-- Table structure for table `booking`

CREATE TABLE `booking` (
  `startdate` date NOT NULL,
  `enddate` date NOT NULL,
  `cusId` int(11) NOT NULL,
  `discountId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

-- Table structure for table `customer`

CREATE TABLE `customer` (
  `Fname` varchar(30) NOT NULL,
  `Mname` varchar(30) DEFAULT NULL,
  `Lname` varchar(30) NOT NULL,
  `customerId` int(11) NOT NULL,
  `house_number` varchar(20) DEFAULT NULL,
  `street` varchar(30) DEFAULT NULL,
  `city` varchar(30) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

-- Table structure for table `customerinformation`

CREATE TABLE `customerinformation` (
  `customerId` int(11),
  `fName` varchar(30),
  `Mname` varchar(30),
  `lName` varchar(30),
  `email` varchar(50),
  `phone_number` varchar(20),
  `house_number` varchar(20),
  `street` varchar(30),
  `city` varchar(30),
  `startDate` date,
  `endDate` date,
  `vehicleId` int(11),
  `bill_number` int(11),
  `bookingId` int(11),
  `adminId` int(11)
);

-- --------------------------------------------------------

-- Table structure for table `discount`

CREATE TABLE `discount` (
  `discountId` int(11) NOT NULL,
  `discount_percentage` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

-- Table structure for table `vehicle`

CREATE TABLE `vehicle` (
  `vehicleId` int(11) NOT NULL,
  `vehicle_name` varchar(30) NOT NULL,
  `vehicleModel` varchar(30) NOT NULL,
  `vehicle_type` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`adminId`);

--
-- Indexes for table `billing`
--
ALTER TABLE `billing`
  ADD PRIMARY KEY (`bill_number`),
  ADD KEY `cusId` (`cusId`);

--
-- Indexes for table `billinginformation`
--
ALTER TABLE `billinginformation`
  ADD KEY `cusId` (`cusId`),
  ADD KEY `bill_number` (`bill_number`);

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`startdate`,`enddate`,`cusId`),
  ADD KEY `discountId` (`discountId`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customerId`);

--
-- Indexes for table `customerinformation`
--
ALTER TABLE `customerinformation`
  ADD KEY `customerId` (`customerId`),
  ADD KEY `vehicleId` (`vehicleId`),
  ADD KEY `bill_number` (`bill_number`),
  ADD KEY `bookingId` (`bookingId`),
  ADD KEY `adminId` (`adminId`);

--
-- Indexes for table `discount`
--
ALTER TABLE `discount`
  ADD PRIMARY KEY (`discountId`);

--
-- Indexes for table `vehicle`
--
ALTER TABLE `vehicle`
  ADD PRIMARY KEY (`vehicleId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `billing`
--
ALTER TABLE `billing`
  MODIFY `bill_number` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `customerId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT for table `discount`
--
ALTER TABLE `discount`
  MODIFY `discountId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `billing`
--
ALTER TABLE `billing`
  ADD CONSTRAINT `billing_ibfk_1` FOREIGN KEY (`cusId`) REFERENCES `customer` (`customerId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `billinginformation`
--
ALTER TABLE `billinginformation`
  ADD CONSTRAINT `billinginformation_ibfk_1` FOREIGN KEY (`cusId`) REFERENCES `customer` (`customerId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `billinginformation_ibfk_2` FOREIGN KEY (`bill_number`) REFERENCES `billing` (`bill_number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `booking`
--
ALTER TABLE `booking`
  ADD CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`cusId`) REFERENCES `customer` (`customerId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `booking_ibfk_2` FOREIGN KEY (`discountId`) REFERENCES `discount` (`discountId`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `customerinformation`
--
ALTER TABLE `customerinformation`
  ADD CONSTRAINT `customerinformation_ibfk_1` FOREIGN KEY (`customerId`) REFERENCES `customer` (`customerId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `customerinformation_ibfk_2` FOREIGN KEY (`vehicleId`) REFERENCES `vehicle` (`vehicleId`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `customerinformation_ibfk_3` FOREIGN KEY (`bill_number`) REFERENCES `billing` (`bill_number`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `customerinformation_ibfk_4` FOREIGN KEY (`bookingId`) REFERENCES `booking` (`startdate`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `customerinformation_ibfk_5` FOREIGN KEY (`adminId`) REFERENCES `admin` (`adminId`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `vehicle`
--
ALTER TABLE `vehicle`
  ADD CONSTRAINT `vehicle_ibfk_1` FOREIGN KEY (`vehicleId`) REFERENCES `availablevehicle` (`vehicleId`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
