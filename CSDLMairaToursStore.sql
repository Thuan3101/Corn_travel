-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               11.3.2-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.6.0.6765
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for toursstores
CREATE DATABASE IF NOT EXISTS `toursstores` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `toursstores`;

-- Dumping structure for table toursstores.bookings
CREATE TABLE IF NOT EXISTS `bookings` (
  `BookingId` int(11) NOT NULL AUTO_INCREMENT,
  `UserId` varchar(255) DEFAULT NULL,
  `TourId` int(11) NOT NULL,
  `BookingDate` datetime(6) DEFAULT current_timestamp(6),
  `Status` varchar(50) NOT NULL,
  `TotalPrice` decimal(18,2) NOT NULL,
  PRIMARY KEY (`BookingId`),
  KEY `IX_Bookings_Status` (`Status`),
  KEY `IX_Bookings_TourId` (`TourId`),
  KEY `IX_Bookings_UserId` (`UserId`),
  CONSTRAINT `FK_Bookings_Tours_TourId` FOREIGN KEY (`TourId`) REFERENCES `tours` (`TourId`),
  CONSTRAINT `FK_Bookings_Users_UserId` FOREIGN KEY (`UserId`) REFERENCES `users` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table toursstores.bookings: ~0 rows (approximately)

-- Dumping structure for table toursstores.payments
CREATE TABLE IF NOT EXISTS `payments` (
  `PaymentId` int(11) NOT NULL AUTO_INCREMENT,
  `BookingId` int(11) NOT NULL,
  `PaymentDate` datetime(6) NOT NULL DEFAULT current_timestamp(6),
  `Amount` decimal(18,2) NOT NULL,
  `PaymentMethod` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`PaymentId`),
  KEY `IX_Payments_BookingId` (`BookingId`),
  CONSTRAINT `FK_Payments_Bookings_BookingId` FOREIGN KEY (`BookingId`) REFERENCES `bookings` (`BookingId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table toursstores.payments: ~0 rows (approximately)

-- Dumping structure for table toursstores.refreshtoken
CREATE TABLE IF NOT EXISTS `refreshtoken` (
  `Id` char(36) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
  `UserId` varchar(255) NOT NULL,
  `Token` longtext DEFAULT NULL,
  `JwtId` longtext DEFAULT NULL,
  `IsUsed` tinyint(1) NOT NULL,
  `IsRevoked` tinyint(1) NOT NULL,
  `IssuedAt` datetime(6) NOT NULL,
  `ExpiredAt` datetime(6) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_RefreshToken_UserId` (`UserId`),
  CONSTRAINT `FK_RefreshToken_Users_UserId` FOREIGN KEY (`UserId`) REFERENCES `users` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table toursstores.refreshtoken: ~19 rows (approximately)
INSERT INTO `refreshtoken` (`Id`, `UserId`, `Token`, `JwtId`, `IsUsed`, `IsRevoked`, `IssuedAt`, `ExpiredAt`) VALUES
	('0b513943-149a-48d4-82ef-0071a07b4684', '150b8eb1-ccb3-46d9-ae35-1a3427fcd63e', 'WQYOW7qIx4op+DR1hACQNWDmJdtIeOIQL9yPGcUJmkg=', '5421d9a1-75d1-4a38-ada9-dde46deb523e', 0, 0, '2024-11-08 06:52:32.971620', '2024-11-08 07:52:32.971620'),
	('22ef4551-1d50-4495-9d79-e422e9a43e70', '150b8eb1-ccb3-46d9-ae35-1a3427fcd63e', '9DXNY+FSVxAwV0DDlv8vmn4HmH0FfXDxKx4PRNdrPFQ=', 'c0c00367-dcf6-44a3-b783-fede19a9e953', 0, 0, '2024-11-06 04:47:08.762662', '2024-11-06 05:47:08.762694'),
	('38d8fcaf-cf5e-44b3-9e43-a294662d5bdf', '150b8eb1-ccb3-46d9-ae35-1a3427fcd63e', 'A1oIgEM8B9763dG6KrE/3jNI0B4nElaIzwcitXUef6w=', 'd5f5c984-9c99-4f2b-9e0a-cb3b93d29049', 0, 0, '2024-11-04 03:19:48.905212', '2024-11-04 04:19:48.905238'),
	('3f5a7100-60f9-40ac-b0a6-c29a7dd93bea', '4a50f929-8b3d-4e09-85e6-25684606fcaf', 'IHvfmV4bweV/eAlq0tpqG1hDRJD7VKKRrL4/Eort+Q4=', 'e1711df3-b131-4f78-9e0f-ba6079239857', 0, 0, '2024-11-08 07:18:32.229503', '2024-11-08 08:18:32.229535'),
	('5474f4cb-4277-4a9c-ab9a-af2ffdfeeda1', '150b8eb1-ccb3-46d9-ae35-1a3427fcd63e', 'r1nMAzfq2IP/a+jo0THr6dINYP6/ew8hAGkwXYs+3jk=', '4e32686b-58c3-4918-b475-14b6243d8e12', 0, 0, '2024-11-05 03:40:13.090833', '2024-11-05 04:40:13.090833'),
	('585c5538-b21e-4dc5-8bd8-9bf2e22b1d6f', '150b8eb1-ccb3-46d9-ae35-1a3427fcd63e', 'PBq5jcVORigjnaMIXs7mO1jRn2Z8yFVNWu/FmCA43tg=', '7ed5cd10-2485-4c00-8dcc-284856c0a063', 0, 0, '2024-11-05 03:20:47.413595', '2024-11-05 04:20:47.413622'),
	('59cfb84f-9397-4dec-b305-0c059b77b474', '150b8eb1-ccb3-46d9-ae35-1a3427fcd63e', 'BhIho5p68yKK5tV64TkfDWhZ7BcZjbxNYMneCcccmS4=', 'b9c33bf6-5e06-44e1-bb88-27e370212719', 0, 0, '2024-11-04 04:49:50.253580', '2024-11-04 05:49:50.253622'),
	('731f5d21-e528-4839-8a04-296f67601b69', '150b8eb1-ccb3-46d9-ae35-1a3427fcd63e', 'HCO5OdmRgJpzPALo2QBZi0nNPLa7wlI2wyH0fQmcKNg=', 'af81be36-d574-49d0-906e-50740d55f763', 0, 0, '2024-11-03 10:45:29.605608', '2024-11-03 11:45:29.605640'),
	('73dde9f9-fd6e-43d5-9276-13dc9d030980', '150b8eb1-ccb3-46d9-ae35-1a3427fcd63e', 'tub2l43RuCffwJD85hWnPI1hXgkDtZigknYVuPmXtig=', '6f3f28d5-d712-47b1-8111-2fcb3fe255fc', 0, 0, '2024-11-03 10:47:03.195874', '2024-11-03 11:47:03.195874'),
	('7d703b70-e492-4420-9ce3-2bd42d608e08', '150b8eb1-ccb3-46d9-ae35-1a3427fcd63e', 'xYYlKItjgJequ7o28v6CJWBkzDqUormEzfihMJNbtBQ=', 'fb89e59b-ac63-4278-bf30-10a11bf75752', 0, 0, '2024-11-08 03:06:37.822592', '2024-11-08 04:06:37.822614'),
	('8c042cd4-6662-41a4-a804-9e12cb441cee', '150b8eb1-ccb3-46d9-ae35-1a3427fcd63e', 'oUApN7A0omH4abXR+99a6p/sR++5TpTk1qaYt3qy01c=', '52e1b480-cdcd-46f5-bfca-f2bb68dd3e78', 0, 0, '2024-11-07 05:14:58.378455', '2024-11-07 06:14:58.378492'),
	('a9686415-9676-4f0f-ac4e-cafb184902cd', 'bc91e04d-ecdf-42f7-8c70-161df9bae924', '0zOuOQJZ/J/T/Rl9//QL0Ed2kbOavjFz2Sp5VFVtOoI=', '26e76a1c-21ec-447a-a5aa-052427381ffa', 0, 0, '2024-11-08 06:41:05.986833', '2024-11-08 07:41:05.986833'),
	('ac359520-4cd3-4bd0-b595-55a782c0de42', '150b8eb1-ccb3-46d9-ae35-1a3427fcd63e', 'SoprXdD9lscC1AJIofJ1uerQiHXvdx7vhmT6Zw+LfbQ=', 'f772ebe7-8558-443a-9c21-7bf33a77043e', 0, 0, '2024-11-11 09:42:50.134898', '2024-11-11 10:42:50.134932'),
	('b9bcf9ad-f9cf-4711-963f-224c6f282a31', '150b8eb1-ccb3-46d9-ae35-1a3427fcd63e', 'CP8Iwau7sz37OsTyyBnE3KRUsxrFATGkLUSyJl43YTA=', '104bfe12-ab5a-4369-899c-fe3bf40c5c6a', 0, 0, '2024-11-08 05:24:20.257499', '2024-11-08 06:24:20.257538'),
	('c671b417-8a5a-49c3-a74d-9705eacdd8c3', '150b8eb1-ccb3-46d9-ae35-1a3427fcd63e', 'SWhrBRaT4kiJa30SHlUW8d6h//wzkIi5ytSUEWoqHQw=', '820cb295-2741-4d6e-a7b3-b12bc4436e06', 0, 0, '2024-11-09 05:11:13.567751', '2024-11-09 06:11:13.567781'),
	('d018f02a-d0e3-42e4-a5ec-ad85a3025822', '150b8eb1-ccb3-46d9-ae35-1a3427fcd63e', '6nqH6wau7WklQmmjEnCIJhGwsfixRt3gtaLUcVjfznc=', '14c52955-3731-4ada-98fd-ac80326a9ab2', 0, 0, '2024-11-05 03:37:46.015845', '2024-11-05 04:37:46.015845'),
	('d84ccac0-4296-49f4-86d9-50ccc436e2a8', '150b8eb1-ccb3-46d9-ae35-1a3427fcd63e', 'WxJ1fYyKKtxbkGq8IMBFf5UcVnZFgiILrAlH/GNHJhI=', 'a4925f07-4cc2-412a-ba92-4d08ceb18bf2', 0, 0, '2024-11-08 06:50:21.342455', '2024-11-08 07:50:21.342482'),
	('e08652b2-d88b-44f9-99e4-a568329b4b39', '150b8eb1-ccb3-46d9-ae35-1a3427fcd63e', 'S9pMkTwC27EZw/zUJjHaj+XpvSUzf3lDY8gy9QtUUoo=', '8ef3a31d-2603-490b-af95-b836a10cd871', 0, 0, '2024-11-06 03:30:32.313534', '2024-11-06 04:30:32.313564'),
	('e163f47d-29fe-415b-9da0-3bd2ba6be465', '4a50f929-8b3d-4e09-85e6-25684606fcaf', 'FgdzuN70Dw/im6xVl9MBPMUrhvwERjBLdu0++ZgFmTg=', 'f3c8a69b-a465-48d8-8fc9-5904a9aee712', 0, 0, '2024-11-05 03:32:59.369299', '2024-11-05 04:32:59.369337'),
	('f35ced4b-5a8e-4b3a-a096-2e63e80aa1c0', '150b8eb1-ccb3-46d9-ae35-1a3427fcd63e', 'jfkVHLn2yoI2nRp3S4s3TMhk+KrlBpo0LXaeKr1du9o=', '6860c41b-514b-4b16-b25e-4f5b17248b47', 0, 0, '2024-11-08 07:20:44.345870', '2024-11-08 08:20:44.345870');

-- Dumping structure for table toursstores.reviews
CREATE TABLE IF NOT EXISTS `reviews` (
  `ReviewId` int(11) NOT NULL AUTO_INCREMENT,
  `UserId` varchar(255) NOT NULL,
  `TourId` int(11) NOT NULL,
  `Rating` int(11) NOT NULL,
  `Comment` varchar(500) NOT NULL,
  `CreatedAt` datetime(6) NOT NULL DEFAULT current_timestamp(6),
  `UpdatedAt` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`ReviewId`),
  KEY `IX_Reviews_TourId` (`TourId`),
  KEY `IX_Reviews_UserId` (`UserId`),
  CONSTRAINT `FK_Reviews_Tours_TourId` FOREIGN KEY (`TourId`) REFERENCES `tours` (`TourId`),
  CONSTRAINT `FK_Reviews_Users_UserId` FOREIGN KEY (`UserId`) REFERENCES `users` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table toursstores.reviews: ~0 rows (approximately)

-- Dumping structure for table toursstores.roleclaims
CREATE TABLE IF NOT EXISTS `roleclaims` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `RoleId` varchar(255) NOT NULL,
  `ClaimType` longtext DEFAULT NULL,
  `ClaimValue` longtext DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_RoleClaims_RoleId` (`RoleId`),
  CONSTRAINT `FK_RoleClaims_Roles_RoleId` FOREIGN KEY (`RoleId`) REFERENCES `roles` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table toursstores.roleclaims: ~0 rows (approximately)

-- Dumping structure for table toursstores.roles
CREATE TABLE IF NOT EXISTS `roles` (
  `Id` varchar(255) NOT NULL,
  `Name` varchar(256) DEFAULT NULL,
  `NormalizedName` varchar(256) DEFAULT NULL,
  `ConcurrencyStamp` longtext DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `RoleNameIndex` (`NormalizedName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table toursstores.roles: ~2 rows (approximately)
INSERT INTO `roles` (`Id`, `Name`, `NormalizedName`, `ConcurrencyStamp`) VALUES
	('398bda4e-ff62-40f9-832d-330840e6c63c', 'Customer', 'CUSTOMER', NULL),
	('40591235-a4fa-4699-a095-6255d8e9cb49', 'Manage', 'MANAGE', NULL),
	('6f263eb1-54a1-4b33-b39d-f11b01f6937c', 'Admin', 'ADMIN', NULL);

-- Dumping structure for table toursstores.tourdepartures
CREATE TABLE IF NOT EXISTS `tourdepartures` (
  `DepartureId` int(11) NOT NULL AUTO_INCREMENT,
  `TourId` int(11) NOT NULL,
  `Code` varchar(50) NOT NULL,
  `DepartureDate` datetime(6) NOT NULL,
  `ReturnDate` datetime(6) NOT NULL,
  `Price` decimal(18,2) NOT NULL,
  `ChildPrice` decimal(18,2) NOT NULL,
  `AvailableSeats` int(11) NOT NULL,
  `Status` varchar(50) NOT NULL,
  `CreatedAt` datetime(6) NOT NULL DEFAULT current_timestamp(6),
  `UpdatedAt` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`DepartureId`),
  UNIQUE KEY `IX_TourDepartures_Code` (`Code`),
  KEY `IX_TourDepartures_Status` (`Status`),
  KEY `IX_TourDepartures_TourId_DepartureDate` (`TourId`,`DepartureDate`),
  CONSTRAINT `FK_TourDepartures_Tours_TourId` FOREIGN KEY (`TourId`) REFERENCES `tours` (`TourId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table toursstores.tourdepartures: ~28 rows (approximately)
INSERT INTO `tourdepartures` (`DepartureId`, `TourId`, `Code`, `DepartureDate`, `ReturnDate`, `Price`, `ChildPrice`, `AvailableSeats`, `Status`, `CreatedAt`, `UpdatedAt`) VALUES
	(1, 1, 'DRLE651310', '2024-11-15 08:00:00.000000', '2024-11-17 18:00:00.000000', 3000000.00, 1500000.00, 20, 'Available', '2024-11-03 08:51:03.508000', '2024-11-03 08:51:03.508000'),
	(2, 2, 'LPWF430247', '2024-12-05 06:00:00.000000', '2024-12-07 19:00:00.000000', 3800000.00, 1900000.00, 15, 'Available', '2024-11-03 09:01:03.207000', '2024-11-03 09:01:03.207000'),
	(3, 3, 'QQGB391823', '2024-12-20 07:00:00.000000', '2024-12-21 20:00:00.000000', 2500000.00, 1250000.00, 15, 'string', '2024-11-04 03:23:31.467000', '2024-11-04 03:23:31.467000'),
	(4, 4, 'BIZY286218', '2024-12-25 05:00:00.000000', '2024-12-28 20:00:00.000000', 8500000.00, 4250000.00, 25, 'string', '2024-11-04 07:20:51.265000', '2024-11-04 07:20:51.265000'),
	(5, 5, 'IEZK254528', '2024-11-30 07:00:00.000000', '2024-12-02 18:00:00.000000', 4500000.00, 2250000.00, 18, 'string', '2024-11-04 07:27:50.107000', '2024-11-04 07:27:50.107000'),
	(6, 6, 'CTJY323763', '2024-12-10 06:00:00.000000', '2024-12-12 19:00:00.000000', 3500000.00, 1750000.00, 22, 'Available', '2024-11-04 07:36:24.721000', '2024-11-04 07:36:24.721000'),
	(7, 7, 'PXAL210361', '2024-12-01 06:00:00.000000', '2024-12-04 19:00:00.000000', 4000000.00, 2000000.00, 25, 'Available', '2024-11-04 07:55:58.277000', '2024-11-04 07:55:58.277000'),
	(8, 8, 'FPLY654538', '2025-02-15 06:00:00.000000', '2025-02-19 19:00:00.000000', 8500000.00, 4250000.00, 25, 'Available', '2024-11-04 08:03:48.452000', '2024-11-04 08:03:48.452000'),
	(9, 9, 'KUSJ731115', '2025-03-05 06:00:00.000000', '2025-03-08 19:00:00.000000', 4500000.00, 2250000.00, 18, 'Available', '2024-11-04 08:10:54.507000', '2024-11-04 08:10:54.507000'),
	(10, 10, 'DYVB279591', '2025-07-01 06:00:00.000000', '2025-07-03 19:00:00.000000', 4500000.00, 2250000.00, 20, 'Available', '2024-11-04 08:17:08.406000', '2024-11-04 08:17:08.406000'),
	(11, 11, 'BWJJ169475', '2025-03-01 06:00:00.000000', '2025-03-05 19:00:00.000000', 55000000.00, 27500000.00, 30, 'Available', '2024-11-04 08:22:56.478000', '2024-11-04 08:22:56.478000'),
	(12, 12, 'JWYF572717', '2025-05-01 06:00:00.000000', '2025-05-04 19:00:00.000000', 58000000.00, 25000000.00, 25, 'Available', '2024-11-04 08:52:22.928000', '2024-11-04 08:52:22.928000'),
	(13, 13, 'WDJG933454', '2025-06-01 06:00:00.000000', '2025-06-04 19:00:00.000000', 12000000.00, 6500000.00, 25, 'Available', '2024-11-04 09:03:05.417000', '2024-11-04 09:03:05.417000'),
	(14, 14, 'HPUT228903', '2025-08-01 06:00:00.000000', '2025-08-04 19:00:00.000000', 60000000.00, 30000000.00, 20, 'Available', '2024-11-04 09:10:27.300000', '2024-11-04 09:10:27.300000'),
	(15, 15, 'IENI262638', '2025-09-01 06:00:00.000000', '2025-09-04 19:00:00.000000', 70000000.00, 35000000.00, 15, 'Available', '2024-11-04 09:18:39.295000', '2024-11-04 09:18:39.295000'),
	(16, 16, 'PHSP748935', '2025-10-01 06:00:00.000000', '2025-10-04 19:00:00.000000', 65000000.00, 32500000.00, 20, 'Available', '2024-11-04 09:24:36.721000', '2024-11-04 09:24:36.721000'),
	(17, 17, 'NRUZ493018', '2025-01-10 06:00:00.000000', '2025-01-13 19:00:00.000000', 29000000.00, 15000000.00, 15, 'Available', '2024-11-04 09:40:06.311000', '2024-11-04 09:40:06.311000'),
	(18, 18, 'QVDG417126', '2025-03-01 06:00:00.000000', '2025-03-05 19:00:00.000000', 80000000.00, 40000000.00, 20, 'Available', '2024-11-04 09:45:53.987000', '2024-11-04 09:45:53.987000'),
	(19, 19, 'UEBI658618', '2025-04-10 06:00:00.000000', '2025-04-13 19:00:00.000000', 80000000.00, 35000000.00, 30, 'Available', '2024-11-04 09:52:39.784000', '2024-11-04 09:52:39.784000'),
	(20, 20, 'YIPN678053', '2025-09-01 06:00:00.000000', '2025-09-07 19:00:00.000000', 45000000.00, 25000000.00, 20, 'Available', '2024-11-04 10:00:03.110000', '2024-11-04 10:00:03.110000'),
	(21, 21, 'RRPN415200', '2025-04-01 06:00:00.000000', '2025-04-07 19:00:00.000000', 75000000.00, 37500000.00, 30, 'Available', '2024-11-04 10:12:00.604000', '2024-11-04 10:12:00.604000'),
	(22, 22, 'KYJM129951', '2025-05-15 06:00:00.000000', '2025-05-20 19:00:00.000000', 88000000.00, 44000000.00, 25, 'Available', '2024-11-04 10:30:47.888000', '2024-11-04 10:30:47.888000'),
	(23, 23, 'WIJL688486', '2025-07-20 06:00:00.000000', '2025-07-27 19:00:00.000000', 25000000.00, 13000000.00, 25, 'Available', '2024-11-04 10:46:50.052000', '2024-11-04 10:46:50.052000'),
	(24, 24, 'JPSK820372', '2025-07-20 06:00:00.000000', '2025-07-27 19:00:00.000000', 65000000.00, 33000000.00, 25, 'Available', '2024-11-04 10:59:07.881000', '2024-11-04 10:59:07.881000'),
	(25, 25, 'CCZG961225', '2025-07-05 06:00:00.000000', '2025-07-11 19:00:00.000000', 7200000.00, 3600000.00, 20, 'Available', '2024-11-04 11:06:50.074000', '2024-11-04 11:06:50.074000'),
	(26, 26, 'XUMP755934', '2025-08-20 06:00:00.000000', '2025-08-25 19:00:00.000000', 45000000.00, 22500000.00, 30, 'Available', '2024-11-04 11:13:10.591000', '2024-11-04 11:13:10.591000'),
	(27, 27, 'QJGH804099', '2025-09-10 06:00:00.000000', '2025-09-16 19:00:00.000000', 74000000.00, 37000000.00, 25, 'Available', '2024-11-04 13:47:31.107000', '2024-11-04 13:47:31.107000'),
	(28, 28, 'LOMB553675', '2025-04-01 06:00:00.000000', '2025-04-10 19:00:00.000000', 80000000.00, 35000000.00, 20, 'Available', '2024-11-04 13:55:54.644000', '2024-11-04 13:55:54.644000'),
	(29, 29, 'SANF639211', '2025-06-01 06:00:00.000000', '2025-06-08 19:00:00.000000', 78000000.00, 34000000.00, 25, 'Available', '2024-11-04 14:03:28.002000', '2024-11-04 14:03:28.002000'),
	(30, 30, 'OKZN324644', '2025-08-15 06:00:00.000000', '2025-08-23 19:00:00.000000', 80000000.00, 40000000.00, 15, 'Available', '2024-11-04 14:09:32.143000', '2024-11-04 14:09:32.143000');

-- Dumping structure for table toursstores.tourimages
CREATE TABLE IF NOT EXISTS `tourimages` (
  `ImageId` int(11) NOT NULL AUTO_INCREMENT,
  `TourId` int(11) NOT NULL,
  `ImageUrl` varchar(255) NOT NULL,
  `Caption` varchar(255) DEFAULT NULL,
  `CreatedAt` datetime(6) NOT NULL DEFAULT current_timestamp(6),
  PRIMARY KEY (`ImageId`),
  KEY `IX_TourImages_TourId` (`TourId`),
  CONSTRAINT `FK_TourImages_Tours_TourId` FOREIGN KEY (`TourId`) REFERENCES `tours` (`TourId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=181 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table toursstores.tourimages: ~169 rows (approximately)
INSERT INTO `tourimages` (`ImageId`, `TourId`, `ImageUrl`, `Caption`, `CreatedAt`) VALUES
	(1, 1, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fha_long_1.jpg?alt=media&token=2849ffd4-823e-4528-a31b-015dc888c54c', 'Hạ Long', '2024-11-03 08:52:38.421000'),
	(2, 1, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fha_long_2_1.jpg?alt=media&token=344e7a99-4f1d-4441-8eea-abba2149a438', 'Hạ Long 2', '2024-11-03 08:52:38.421000'),
	(3, 1, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fcung_ca_heo_1.jpg?alt=media&token=71c778c3-9a16-4e53-85fc-a43a5f8c831c', 'Cung Cá Heo', '2024-11-03 08:52:38.421000'),
	(4, 1, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fcong_vien_dragon-park_1.jpg?alt=media&token=8b5effa3-1e86-449e-a3d3-7543d4f9ceb5', 'Công viên Dragon-park', '2024-11-03 08:52:38.421000'),
	(5, 1, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fdu_khach_cheo_thuyen_kayak_o_vinh_lan-ha_1.jpg?alt=media&token=418f244b-82fe-4b29-90ab-cd387fcd4e6a', 'Du khách chèo thuyền Kayak ở vịnh Lan-Ha', '2024-11-03 08:52:38.421000'),
	(6, 1, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fhang_sung_sot_ve_%C4%91ep_bi_an_1.png?alt=media&token=94cd621c-f6bd-48bc-8974-54f64a6f4fd9', 'Hang sửng sốt vẻ đẹp bí ẩn', '2024-11-03 08:52:38.421000'),
	(7, 2, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fcau_rong_phun_lua_1.jpg?alt=media&token=a2a48360-8057-4fb6-8e0c-b747f5e62277', 'Cầu rồng phun lửa', '2024-11-03 09:01:53.623000'),
	(8, 2, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fbai_tam_hoang_hau_1.jpg?alt=media&token=a44cd076-255a-4e55-a8f7-162dec2f0b21', 'Bãi tắm Hoàng Hậu', '2024-11-03 09:01:53.623000'),
	(9, 2, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fcau_rong_%C4%91a_nang_1.jpg?alt=media&token=02fdfd8d-8464-4003-b77b-2031637c2e23', 'Cầu rồng Đà Nẵng', '2024-11-03 09:01:53.623000'),
	(10, 2, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fcay_cau_%C4%91a_nang_1.jpg?alt=media&token=aa944a70-f00a-40d4-8711-83b0494af47c', 'Cây cầu Đà Nẵng', '2024-11-03 09:01:53.623000'),
	(11, 2, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fganh_%C4%91a_%C4%91ia_1.jpg?alt=media&token=963d93b2-f806-42f7-b42a-0dc6b0b26fbc', 'Gành Đá Đĩa', '2024-11-03 09:01:53.623000'),
	(12, 2, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fphu_yen_1.jpg?alt=media&token=e278ce5d-5cc1-4432-8dd3-5ccfc2c220ce', 'Phú Yên', '2024-11-03 09:01:53.623000'),
	(13, 3, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Ffansipan_1.jpg?alt=media&token=9968da3b-362a-4641-aa51-696b05edf839', 'Fansipan', '2024-11-04 03:24:08.196000'),
	(14, 3, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fsan_may_fansipan_1.jpg?alt=media&token=3831f0a8-856c-4841-b85d-1a3674c0648b', 'Săn mây Fansipan', '2024-11-04 03:24:08.196000'),
	(15, 3, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fho_guom_1.jpg?alt=media&token=1b05739d-13d6-453c-8f5f-8f19584fb1bb', 'Hồ Gươm', '2024-11-04 03:24:08.196000'),
	(16, 3, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fmua_he_sapa_%C4%91ep_nhat_1.jpg?alt=media&token=15d633a9-fe9e-4276-be6e-b8cacc0f737e', 'Mùa hè Sapa đẹp nhất', '2024-11-04 03:24:08.196000'),
	(17, 3, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Flang_bac_1.jpg?alt=media&token=9f386269-3b2e-4247-886f-f5700bb3f4b0', 'Lăng Bác', '2024-11-04 03:24:08.196000'),
	(18, 3, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fchua_mot_cot_1.jpg?alt=media&token=9eb19028-c212-4889-8104-778a3dbb1db8', 'Chùa một cột', '2024-11-04 03:24:08.196000'),
	(19, 3, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fhoang_thanh_thang_long_1.jpg?alt=media&token=749ddb38-0ad0-4197-b926-d18e050431f6', 'Hoàng Thành Thăng Long', '2024-11-04 03:24:08.196000'),
	(21, 4, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fphu_quoc_1.jpg?alt=media&token=fa37be6d-bce2-4968-b27b-8aea68fe675e', 'Phú Quốc', '2024-11-04 07:21:20.459000'),
	(22, 4, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fgrand-world_phu_quoc_1.jpg?alt=media&token=3288781b-249c-4631-9e8c-fc19b47440b0', 'grand-world Phú Quốc', '2024-11-04 07:21:20.459000'),
	(23, 4, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fngam_nhin_phu_quoc_tu_cap_treo_vuot_bien_hon_thom_1.jpg?alt=media&token=4c8262d4-8099-450d-8910-5ffee850f7d7', 'Ngắm nhìn Phú Quốc từ cáp treo vượt biển Hòn Thơm', '2024-11-04 07:21:20.459000'),
	(24, 4, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fphu_quoc_1.jpg?alt=media&token=96031149-c1a3-49ab-a9ed-fb65b465b498', 'Phú Quốc', '2024-11-04 07:21:20.459000'),
	(25, 4, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fphu_quoc_cac_hon_%C4%91ao_1.jpg?alt=media&token=0472a263-18ed-4826-bacf-125cad26646b', 'Phú Quốc các hòn đảo', '2024-11-04 07:21:20.459000'),
	(26, 4, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fphu_quoc_vinwonder_1.jpg?alt=media&token=84a5388f-5a0c-4f45-988d-5e42fd71d851', 'Phú Quốc VinWonder', '2024-11-04 07:21:20.459000'),
	(27, 4, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fthanh_pho_khong_ngu_grand_world_phu_quoc_1.jpg?alt=media&token=a14e4121-d37a-4ced-91bc-e17df56e7083', 'Thành phố không ngủ Grand World Phú Quốc', '2024-11-04 07:21:20.459000'),
	(28, 5, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2F%C4%91a_nang_1.jpg?alt=media&token=b0700c75-65ad-461b-ace1-5691580b5bd2', 'Đà Nẵng', '2024-11-04 07:28:16.659000'),
	(29, 5, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fcau_rong_%C4%91a_nang_xem_phun_nuoc%2C_phun_lua_toi_1.jpg?alt=media&token=44a4b552-ed5c-4aba-84ee-ae6e8456d87d', 'Cầu Rồng Đà Nẵng xem phun nước, phun lửa tối', '2024-11-04 07:28:16.659000'),
	(30, 5, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fhoang_thanh_hue_1.jpg?alt=media&token=7b0aa25c-9a0f-4197-9d62-e7b131d54a35', 'Hoàng Thành Huế', '2024-11-04 07:28:16.659000'),
	(31, 5, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fhue_thuyen_rong_nghe_ca_xu__1.jpg?alt=media&token=6e0509ff-3226-4d2c-96a4-1f67c7f13320', 'Huế thuyền rồng nghe ca xứ ', '2024-11-04 07:28:16.659000'),
	(32, 5, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fkinh_thanh_hue_nhin_tu_tren_cao_1.jpg?alt=media&token=d9694e8c-440f-4fdf-9d06-b9e077d183cf', 'Kinh thành Huế nhìn từ trên cao', '2024-11-04 07:28:16.659000'),
	(33, 5, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Flang_khai_%C4%91inh_%28ung_lang%29_%C4%91uoc_xay_dung_tren_trien_nui_chau_chu_1.jpg?alt=media&token=cc3eeea8-f32a-4b9d-91db-ba5776e5df47', 'Lăng Khải Định (Ứng Lăng) được xây dựng trên triền núi Châu Chữ', '2024-11-04 07:28:16.659000'),
	(34, 6, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2F%C4%91a_lat_thanh_pho_mong_mo_1.jpg?alt=media&token=6a998ed9-3eed-46cd-9934-fd2b06073ef4', 'Đà Lạt thành phố mộng mơ', '2024-11-04 07:36:59.779000'),
	(35, 6, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2F%C4%91a_lat_thanh_pho_tinh_yeu_1.jpg?alt=media&token=cffde478-f8ef-4c8d-8c06-1b2ab356a350', 'Đà Lạt thành phố tình yêu', '2024-11-04 07:36:59.779000'),
	(36, 6, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fcay_thong_co_%C4%91on_%C4%91a_lat_1.jpg?alt=media&token=1e385356-8986-4879-bcca-f33d773e1b86', 'Cây thông cô đơn Đà Lạt', '2024-11-04 07:36:59.779000'),
	(37, 6, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2F%C4%91oi_thong_hai_mo_gan_lien_voi_nhung_cau_chuyen_ly_ky_va_bi_an_o_%C4%91a_lat_1.jpg?alt=media&token=eb63b009-403e-454f-991a-68c25fa462ee', 'Đồi thông Hai Mộ gắn liền với những câu chuyện ly kỳ và bí ẩn ở Đà Lạt', '2024-11-04 07:36:59.779000'),
	(38, 6, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fho_suoi_vang_so_huu_ve_%C4%91ep_tho_mong__1.jpg?alt=media&token=6aca4ccc-c821-4721-8c0a-3f5621353474', 'Hồ Suối Vàng sở hữu vẻ đẹp thơ mộng ', '2024-11-04 07:36:59.779000'),
	(39, 6, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fho_tuyen_lam_%C4%91a_lat_1.jpg?alt=media&token=65469261-6796-45ab-984b-257c95aa6ca6', 'Hồ Tuyền Lâm Đà Lạt', '2024-11-04 07:36:59.779000'),
	(40, 7, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fhoi_an_1.jpg?alt=media&token=61f454b7-9850-4dbf-9a5f-d578999b985f', 'Hội An', '2024-11-04 07:57:20.152000'),
	(41, 7, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fhoi_an_1.jpg?alt=media&token=c25474ac-b384-4336-b5fd-9b07f48ce1e9', 'Hội An', '2024-11-04 07:57:20.152000'),
	(42, 7, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fpho_co_hoi_an_1.jpg?alt=media&token=cfe306fb-0589-4d80-a3a0-a2aa1a675a16', 'Phố cổ Hội An', '2024-11-04 07:57:20.152000'),
	(43, 7, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fpho_co_hoi_an_1.jpg?alt=media&token=e7126f4c-a2a7-41de-a905-7c921a1aacf1', 'Phố cổ Hội An', '2024-11-04 07:57:20.152000'),
	(44, 7, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2F%C4%91em_hoi_an_1.jpg?alt=media&token=f7b5454e-91ab-44e1-b50e-5e3a1635b8fa', 'Đêm Hội An', '2024-11-04 07:57:20.152000'),
	(45, 7, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fvinwonders_nam_hoi_an_1.jpg?alt=media&token=767af5b0-b451-48a3-852d-8f36ab91b17f', 'VinWonders Nam Hội An', '2024-11-04 07:57:20.152000'),
	(46, 8, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fphu_quoc_1.jpg?alt=media&token=ad3b71c4-c17c-436c-bff0-3124c8c2d3c3', 'Phú Quốc', '2024-11-04 08:04:34.579000'),
	(47, 8, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fgrand-world_phu_quoc_1.jpg?alt=media&token=a6212caf-5b27-4cd6-9ba0-a53c53e40201', 'Grand-world Phú Quốc', '2024-11-04 08:04:34.579000'),
	(48, 8, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fngam_nhin_phu_quoc_tu_cap_treo_vuot_bien_hon_thom_1.jpg?alt=media&token=b010a152-135d-4704-a493-17ad0b0d26c7', 'Ngắm nhìn Phú Quốc từ cáp treo vượt biển Hòn Thơm', '2024-11-04 08:04:34.579000'),
	(49, 8, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fphu_quoc_cac_hon_%C4%91ao_1.jpg?alt=media&token=a4d803c1-b718-4b4d-94cb-ea451292f58d', 'Phú Quốc các hòn đảo', '2024-11-04 08:04:34.579000'),
	(50, 8, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fphu_quoc_vinwonder_1.jpg?alt=media&token=96c5fd59-8817-400c-b709-225541cbc6c8', 'Phú Quốc VinWonder', '2024-11-04 08:04:34.579000'),
	(51, 9, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fha_giang_1.jpg?alt=media&token=9f62889e-dc20-4e68-ab72-8d21e8f97add', 'Hà Giang', '2024-11-04 08:11:28.573000'),
	(52, 9, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fha_giang_nhung_canh_%C4%91ong_1.jpg?alt=media&token=14de617a-1b82-447e-afbc-f339bbad9225', 'Hà Giang những cánh đồng', '2024-11-04 08:11:28.573000'),
	(53, 9, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fcanh_%C4%91ep_ha_giang__1.jpg?alt=media&token=ee172aba-7483-42ad-b684-aef1565c525a', 'Cảnh đẹp Hà Giang ', '2024-11-04 08:11:28.573000'),
	(54, 9, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fcong_troi_quan_ba_1.jpg?alt=media&token=22e58459-893d-4e58-9d7f-157c3cfa65a2', 'cổng trời Quản Bạ', '2024-11-04 08:11:28.573000'),
	(55, 9, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fcanh_cong_troi_quan_ba_khong_xa_la_nui_%C4%91oi_co_tien_1.jpg?alt=media&token=c1baaf4d-456c-4f7f-8a25-9aaf11564697', 'Cạnh cổng trời Quản Bạ không xa là Núi Đôi Cô Tiên', '2024-11-04 08:11:28.573000'),
	(56, 9, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fcanh_cong_troi_quan_ba_khong_xa_la_nui_%C4%91oi_co_tien__1.jpg?alt=media&token=424027b7-5d97-4f13-8913-af7d1903b6db', 'Cạnh cổng trời Quản Bạ không xa là Núi Đôi Cô Tiên ', '2024-11-04 08:11:28.573000'),
	(57, 10, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fvung_tau_1.jpg?alt=media&token=3c3507a2-cb22-4c78-9d25-e5e80c3fb17b', 'Vũng Tàu', '2024-11-04 08:17:30.645000'),
	(58, 10, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fbien_bai_truoc_vung_tau_1.jpg?alt=media&token=f521a185-fc0a-4d51-8060-2b767d8ec745', 'Biển bãi trước Vũng Tàu', '2024-11-04 08:17:30.645000'),
	(59, 10, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fbien_bai_sauvung_tau_1.jpg?alt=media&token=d248e218-4833-4614-bb71-db002a38cb19', 'Biển bãi sauVũng Tàu', '2024-11-04 08:17:30.645000'),
	(60, 10, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Ftuong_chua_giang_tay_vung_tau_1.jpg?alt=media&token=c4df3e74-5653-4869-a690-226ac06c5398', 'Tượng chúa giang tay Vũng Tàu', '2024-11-04 08:17:30.645000'),
	(61, 10, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2F%C4%91oi_con_heo__1.jpg?alt=media&token=6e1c2b0b-fd16-4754-bc40-05a302b200af', 'Đồi con heo ', '2024-11-04 08:17:30.645000'),
	(62, 10, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fhon_ba_vung_tau_1.jpg?alt=media&token=4140a4d6-fb0f-4022-9d1f-0880fcf61982', 'Hòn Ba Vũng Tàu', '2024-11-04 08:17:30.645000'),
	(63, 11, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fparis_thien_%C4%91uong_1.jpg?alt=media&token=13fc5856-ed5f-4eff-b629-2932a7898756', 'Paris thiên đường', '2024-11-04 08:24:39.332000'),
	(64, 11, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fparis_ve_%C4%91em_tuyet_%C4%91ep_1.jpg?alt=media&token=91ba5356-c924-4374-af03-2dcf1823641b', 'Paris về đêm tuyệt đẹp', '2024-11-04 08:24:39.332000'),
	(65, 11, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fthanh_pho_paris__1.jpg?alt=media&token=f8dde89e-94ee-46ea-9028-fe42d456adcb', 'Thành phố Paris ', '2024-11-04 08:24:39.332000'),
	(66, 11, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fmontmartre_%C4%91ep_nhu_tranh_ve-france_1.jpg?alt=media&token=609999d6-ca09-4834-8235-7fb1e0dd16a2', 'Montmartre đẹp như tranh vẽ-France', '2024-11-04 08:24:39.332000'),
	(67, 11, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Ftrai_tim_paris_%E2%80%93_tu_nha_tho_%C4%91uc_ba_%C4%91en_bao_tang_louvre_1.jpg?alt=media&token=0a092698-cb45-4501-9b3b-3b001945ade9', 'Trái tim Paris – Từ nhà thờ Đức Bà đến bảo tàng Louvre', '2024-11-04 08:24:39.332000'),
	(68, 11, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fnhung_%C4%91ieu_ki_dieu_o_ta_ngan_%E2%80%93_saint_germain_va_thap_eiffel_1.jpg?alt=media&token=04204691-ff0c-4ad3-b749-c625c4c91e06', 'Những điều kì diệu ở Tả Ngạn – Saint Germain và Tháp Eiffel', '2024-11-04 08:24:39.332000'),
	(69, 12, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fthanh_pho_singapore_1.jpg?alt=media&token=82a13369-785b-47cc-a391-a452bf5e077e', 'Thành phố Singapore', '2024-11-04 08:53:12.162000'),
	(70, 12, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fsingapore_-_%E2%80%9C%C4%91ao_quoc_su_tu%E2%80%9D_xanh_1.jpg?alt=media&token=386c1962-5242-4e67-b365-e40c04e0d504', 'Singapore - “Đảo quốc sư tử” xanh', '2024-11-04 08:53:12.162000'),
	(71, 12, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fsingapore-bai_bien-sentosa_1.jpg?alt=media&token=1e5137b5-be3a-441d-9616-4fcd2303074b', 'Singapore-Bãi biển-Sentosa', '2024-11-04 08:53:12.162000'),
	(72, 12, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fgarden_by_the_bay_%C4%91uoc_menh_danh_la_mot_trong_nhung_khu_vuc_check-in%2C_ngam_canh_%C4%91ep_nhat__1.jpg?alt=media&token=6622e6c6-6c70-47ed-ac45-11c0b10a7674', 'Garden by the Bay được mệnh danh là một trong những khu vực check-in, ngắm cảnh đẹp nhất ', '2024-11-04 08:53:12.162000'),
	(73, 12, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fsingapore_%C4%91uoc_menh_danh_la_thien_%C4%91uong_mua_sam_noi_bat_tai_khu_vuc_chau_a_1.jpg?alt=media&token=3173065a-03e1-4960-a6cf-e2dc4deb4ba5', 'Singapore được mệnh danh là thiên đường mua sắm nổi bật tại khu vực Châu Á', '2024-11-04 08:53:12.162000'),
	(74, 12, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fsingapore_flyer_la_vong_%C4%91u_quay_ngam_canh_cao_nhat_tai_chau_a_1.jpg?alt=media&token=7fa777c0-d6b5-42d8-934b-103bdcb772a8', 'Singapore Flyer là vòng đu quay ngắm cảnh cao nhất tại Châu Á', '2024-11-04 08:53:12.162000'),
	(75, 13, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fthai_lan_bangkok_1.jpg?alt=media&token=7c866eb4-3b2a-41df-b887-72050f8bfa79', 'Thái Lan BangKok', '2024-11-04 09:04:13.410000'),
	(76, 13, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fnui_phat_vang_hay_con_goi_la_khau_chee_chan_%28tran_bao_phat_son%29_la_mot_ngon_nui_thuoc_tinh_chon_buri_1.jpg?alt=media&token=34f0695c-a8de-4983-8c8b-f91fe3e00f6f', 'Núi Phật Vàng hay còn gọi là Khau Chee Chan (Trân Bảo Phật Sơn) là một ngọn núi thuộc tỉnh Chon Buri', '2024-11-04 09:04:13.410000'),
	(77, 13, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fchua_wat_arun_bieu_tuong_ton_tho_thieng_lieng_o_thai_lan_1.jpg?alt=media&token=73c310d8-b828-49a4-a6b0-820162b28d9c', 'Chùa Wat Arun biểu tượng tôn thờ thiêng liêng ở Thái Lan', '2024-11-04 09:04:13.410000'),
	(78, 13, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2F%C4%91ao_coral_thai_lan_hon_%C4%91ao_thien_%C4%91uong_cua_ran_san_ho_duoi_long_%C4%91ai_duong_1.jpg?alt=media&token=c12d9e97-0357-4cc1-a37d-8abf357284f0', 'Đảo Coral Thái Lan Hòn đảo thiên đường của rạn san hô dưới lòng đại dương', '2024-11-04 09:04:13.410000'),
	(79, 13, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fchua_thuyen_wat-yannawa_1.jpg?alt=media&token=f70a25bf-dbd6-4f70-922e-f951b787276d', 'Chùa thuyền Wat-Yannawa', '2024-11-04 09:04:13.410000'),
	(80, 13, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fphat_bon_mat_thai_lan_1.jpg?alt=media&token=be532bb7-c163-4c77-85ca-71f189257c92', 'Phật bốn mặt Thái Lan', '2024-11-04 09:04:13.410000'),
	(81, 14, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fkuala_lumpur_%C4%91uoc_menh_danh_la_thanh_pho_%C4%91a_sac_mau_1.jpg?alt=media&token=5d17903e-c16d-46a4-8627-8b8077b76b34', 'Kuala Lumpur được mệnh danh là thành phố đa sắc màu', '2024-11-04 09:10:58.440000'),
	(82, 14, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2F%C4%91en_sri_maha_mariamman%2C_ngoi_%C4%91en_hindu_lau_%C4%91oi_nhat_cua_malaysia_1.jpg?alt=media&token=3f160595-f41a-482d-9179-5915874f820d', 'đền Sri Maha Mariamman, ngôi đền Hindu lâu đời nhất của Malaysia', '2024-11-04 09:10:58.440000'),
	(83, 14, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2F%C4%91ong_batu_co_le_la_%C4%91iem_thu_hut_khach_du_lich_noi_tieng_nhat_cua_kuala_lumpur_1.jpg?alt=media&token=1179aebd-4391-47a2-87ef-48368809adde', 'Động Batu có lẽ là điểm thu hút khách du lịch nổi tiếng nhất của Kuala Lumpur', '2024-11-04 09:10:58.440000'),
	(84, 14, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fvuon_bach_thao_perdana_cua_kuala_lumpur%2C_mot_khong_gian_xanh_lon_ngay_tai_trung_tam_thanh_pho_1.jpg?alt=media&token=e6278025-2b63-4af4-8487-1c33417b5337', 'Vườn Bách Thảo Perdana của Kuala Lumpur, một không gian xanh lớn ngay tại trung tâm thành phố', '2024-11-04 09:10:58.440000'),
	(85, 14, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fquang_truong_merdeka%2C_noi_dien_ra_le_tuyen_bo_%C4%91oc_lap_cua_malaysia_vao_nam_1957__1.jpg?alt=media&token=f83f685b-ead4-4489-bf76-4a498d24e56f', 'Quảng trường Merdeka, nơi diễn ra lễ tuyên bố độc lập của Malaysia vào năm 1957 ', '2024-11-04 09:10:58.440000'),
	(86, 15, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fnhat_ban_%C4%91at_nuoc_mat_troi_moc_1.jpg?alt=media&token=0871976f-b709-48d0-8c02-03fcda77b541', 'Nhật Bản đất nước mặt trời mọc', '2024-11-04 09:19:13.182000'),
	(87, 15, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fchua_senso-ji_co_kinh_nhat_tokyo_1.jpg?alt=media&token=fd6c0670-7797-4aec-975c-853dcc9f2aac', 'Chùa Senso-ji cổ kính nhất Tokyo', '2024-11-04 09:19:13.182000'),
	(88, 15, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fcong_vien_tokyo_disneysea_1.jpg?alt=media&token=ab56fae0-9ac0-4deb-9e1a-5958fb293c5e', 'Công viên Tokyo DisneySea', '2024-11-04 09:19:13.182000'),
	(89, 15, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fkhu_pho_%C4%91ien_tu_akihabara_1.jpg?alt=media&token=b587863c-1c9e-4c0e-9873-c05522aa20b2', 'Khu phố điện tử Akihabara', '2024-11-04 09:19:13.182000'),
	(90, 15, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fpho_co_yanaka_1.jpg?alt=media&token=cb6b99ea-7d04-47a5-b834-e71c1fd7ae84', 'Phố cổ Yanaka', '2024-11-04 09:19:13.182000'),
	(91, 15, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fthap_truyen_hinh_tokyo_skytree_1.jpg?alt=media&token=a18b699d-25f1-4077-a002-531f1571075f', 'Tháp truyền hình Tokyo Skytree', '2024-11-04 09:19:13.182000'),
	(92, 16, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fthu_%C4%91o_seoul_han_quoc_xu_so_kim_chi_1.jpg?alt=media&token=ff4b107a-72fb-41ad-a7de-9bf8d7a7535c', 'Thủ đô Seoul Hàn Quốc xứ sở kim chi', '2024-11-04 09:25:14.597000'),
	(93, 16, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fngon_thap_namsan_noi_bat_giua_bau_troi_%C4%91em_seoul_1.jpg?alt=media&token=116dfd04-cd38-4623-ab36-d9babd2bf9ca', 'Ngọn tháp Namsan nổi bật giữa bầu trời đêm Seoul', '2024-11-04 09:25:14.597000'),
	(94, 16, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fgyeongbokgung_%28canh_phuc_cung%29_la_su_ket_hop_hai_hoa_va_tinh_te_giua_ban_tay_con_nguoi_va_thien_nhien_1.jpg?alt=media&token=18142e64-737a-4be0-80ae-5d440e5205e2', 'Gyeongbokgung (Cảnh Phúc Cung) là sự kết hợp hài hòa và tinh tế giữa bàn tay con người và thiên nhiên', '2024-11-04 09:25:14.597000'),
	(95, 16, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fchua_beomeosa_la_mot_trong_nhung_ngoi_chua_lau_%C4%91oi_va_linh_thieng_nhat_tai_busan_1.jpg?alt=media&token=359788a0-b06f-43dd-9894-66734ce702b2', 'Chùa Beomeosa là một trong những ngôi chùa lâu đời và linh thiêng nhất tại Busan', '2024-11-04 09:25:14.597000'),
	(96, 16, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fthanh_pho_busan_1.jpg?alt=media&token=7328a55c-16d5-4e91-a11e-6b11348e6cf6', 'Thành phố Busan', '2024-11-04 09:25:14.597000'),
	(97, 16, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fbai_bien_haeundae__la_bieu_tuong_cua_busan_voi_cat_trang_dai_va_nuoc_bien_xanh_biec_1.jpg?alt=media&token=f02eb515-97ca-4cfa-b58b-7f5d43faf7b8', 'Bãi biển Haeundae  là biểu tượng của Busan với cát trắng dài và nước biển xanh biếc', '2024-11-04 09:25:14.597000'),
	(98, 17, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fsong_hoang_pho_thuong_hai_trung_quoc_1.jpg?alt=media&token=b8139a09-f447-477f-b665-9e63137c54f5', 'Song hoàng phố Thượng Hải Trung Quốc', '2024-11-04 09:40:51.747000'),
	(99, 17, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fbao_tang_nghe_thuat_trung_quoc_-_kho_tang_van_hoa_nghe_thuat_1.jpg?alt=media&token=6208bf99-e27b-4805-8d47-a6cc8c5684cb', 'Bảo tàng nghệ thuật Trung Quốc - Kho tàng văn hoá nghệ thuật', '2024-11-04 09:40:51.747000'),
	(100, 17, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fchua_phat_ngoc_-_chon_yen_binh_trong_long_thuong_hai_1.jpg?alt=media&token=7ba0b832-bef8-4ca9-a4ac-60cc44d608c3', 'Chùa Phật Ngọc - Chốn yên bình trong lòng Thượng Hải', '2024-11-04 09:40:51.747000'),
	(101, 17, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2F%C4%91ai_lo_nam_kinh_-_con_%C4%91uong_phon_thinh_cua_thuong_hai_1.jpg?alt=media&token=c7c6d234-22bf-41c0-9804-be41bccc1ffb', 'Đại lộ Nam Kinh - Con đường phồn thịnh của Thượng Hải', '2024-11-04 09:40:51.747000'),
	(102, 17, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fdu_vien_%28yuyuan%29%2C_nam_tai_trung_tam_cua_thuong_hai_1.jpg?alt=media&token=3981f353-81d6-43cd-8acf-4e08699eb021', 'Dự Viên (Yuyuan), nằm tại trung tâm của Thượng Hải', '2024-11-04 09:40:51.747000'),
	(103, 17, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fphim_truong_thuong_hai_la_mot_trong_nhung_phim_truong_lon_nhat_trung_quoc_1.jpg?alt=media&token=c2e862c7-6dcd-46a6-82f5-f45c5e1f08a2', 'Phim trường Thượng Hải là một trong những phim trường lớn nhất Trung Quốc', '2024-11-04 09:40:51.747000'),
	(104, 18, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fdubai_%C4%91ao_co_thien_%C4%91uong__1.jpg?alt=media&token=a3dfa99e-6f8b-4243-86bc-480addd78e35', 'Dubai đảo cỏ thiên đường ', '2024-11-04 09:46:41.629000'),
	(105, 18, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Ftoa_thap_burj_khalifa_-_%C4%91iem_du_lich_noi_tieng_o_dubai_1.png?alt=media&token=8fb9dbb5-7240-4b36-a685-cfdce40d74a2', 'Tòa tháp Burj Khalifa - Điểm du lịch nổi tiếng ở Dubai', '2024-11-04 09:46:41.629000'),
	(106, 18, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fdinh_thu_tong_thong_qasr_al_watan_cung_la_%C4%91iem_%C4%91en_khong_the_thieu_khi_%C4%91en_dubai_1.jpg?alt=media&token=12e718c1-aff5-4c45-b448-332eed3b65e9', 'Dinh thự tổng thống Qasr Al Watan cũng là điểm đến không thể thiếu khi đến Dubai', '2024-11-04 09:46:41.629000'),
	(107, 18, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fbao_tang_phao_%C4%91ai_dubai_-_noi_luu_giu_lich_su_dubai_1.jpg?alt=media&token=901ea533-c7c6-4be0-b358-6fcfbd067126', 'Bảo tàng pháo đài Dubai - Nơi lưu giữ lịch sử Dubai', '2024-11-04 09:46:41.629000'),
	(108, 18, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fnha_tho_hoi_giao_jumeirah_mosque_dubai_1.png?alt=media&token=4a9c6e89-1eb6-44e2-9578-e35c6ed21b93', 'Nhà thờ hồi giáo Jumeirah Mosque Dubai', '2024-11-04 09:46:41.629000'),
	(109, 18, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fsa_mac_safari_-_%C4%91iem_tham_quan_noi_tieng_khong_the_thieu_trong_chuyen_%C4%91i_dubai_1.png?alt=media&token=aeb040d1-1a36-4155-bc28-86e681c0cc6b', 'Sa mạc Safari - ĐIểm tham quan nổi tiếng không thể thiếu trong chuyên đi Dubai', '2024-11-04 09:46:41.629000'),
	(110, 19, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fphuket_%C4%91uoc_menh_danh_la_%E2%80%9C%C4%91ao_thien_%C4%91uong%E2%80%9D_1.jpg?alt=media&token=c3b9cddc-dd48-4829-b130-1421fe8d33bd', 'Phuket được mệnh danh là “đảo thiên đường”', '2024-11-04 09:53:58.680000'),
	(111, 19, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fbuc_tuong_phat_khong_lo_big_budda_la_mot_trong_nhung_%C4%91ia_danh_noi_tieng_nhat_o_phuket_1.jpg?alt=media&token=361369cb-cb15-47da-85e7-fd9d5de09ae7', 'Bức tượng Phật khổng lồ Big Budda là một trong những địa danh nổi tiếng nhất ở Phuket', '2024-11-04 09:53:58.680000'),
	(112, 19, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2F%C4%91en_wat_chalong_noi_so_huu_nhung_kien_truc_%C4%91oc_%C4%91ao_rieng_co_cua_thai_lan_1.jpg?alt=media&token=38bcf994-d271-40e9-846c-ff171f745bc4', 'Đền Wat Chalong Nơi sở hữu những kiến trúc độc đáo riêng có của Thái Lan', '2024-11-04 09:53:58.680000'),
	(113, 19, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2F%C4%91o_thi_co_o_phuket__1.jpg?alt=media&token=0a4535be-b9a2-47ca-a376-17e4d1bd97ee', 'Đô thị cổ ở Phuket ', '2024-11-04 09:53:58.680000'),
	(114, 19, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fhon_%C4%91ao_phi_phi_chac_chan_phai_%C4%91uoc_ke_%C4%91en_trong__du_lich_phuket_noi_tieng_1.jpg?alt=media&token=01840bba-62dc-4685-8d11-83b98dc4ae61', 'Hòn đảo Phi Phi chắc chắn phải được kể đến trong  du lịch Phuket nổi tiếng', '2024-11-04 09:53:58.680000'),
	(115, 19, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fvinh_phang_nga_se_khien__co_nhung_trai_nghiem_%C4%91ac_biet._1.jpg?alt=media&token=f9164147-5ce4-44c8-b6f9-3fa8338989c4', 'Vịnh Phang Nga sẽ khiến  có những trải nghiệm đặc biệt.', '2024-11-04 09:53:58.680000'),
	(116, 20, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fmadrid_thanh_pho_khong_ngu_1.jpg?alt=media&token=0f54b12f-a115-4356-9ce6-0dbed5d712a3', 'Madrid thành phố không ngủ', '2024-11-04 10:00:58.170000'),
	(117, 20, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fcung_%C4%91ien_hoang_gia_%C4%91a_tung_la_noi_o_chinh_thuc_cua_hoang_gia_tay_ban_nha._1.jpg?alt=media&token=3a448be6-0788-4f8e-99ab-758a95e1952e', 'Cung điện hoàng gia đã từng là nơi ở chính thức của Hoàng Gia Tây Ban Nha.', '2024-11-04 10:00:58.170000'),
	(118, 20, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Ftu_vien_lorenzo_del_escorial_monastery_chinh_la_thu_vien__1.jpg?alt=media&token=7e34a8f7-40b0-480b-b363-73987210ec72', 'Tu Viện Lorenzo del Escorial monastery chính là thư viện ', '2024-11-04 10:00:58.170000'),
	(119, 20, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2F_bao_tang_va_phong_tranh_cua_thanh_pho__%C4%91uoc_menh_danh_la_tam_giac_nghe_thuat__1.jpg?alt=media&token=b8b959d9-4272-469a-a276-009353467de4', ' Bảo tàng và phòng tranh của thành phố  được mệnh danh là Tam Giác Nghệ Thuật ', '2024-11-04 10:00:58.170000'),
	(120, 20, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fgran_via__%C4%91i_du_lich_madrid%2C__metropolis_noi_tieng_toi_quang_truong_plaza_de_espana_1.jpg?alt=media&token=920c1d3a-1d99-4f13-87a0-bf39cca0ca0b', 'Gran Vía  đi du lịch Madrid,  Metrópolis nổi tiếng tới quảng trường Plaza de España', '2024-11-04 10:00:58.170000'),
	(121, 20, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fhay_ghe_tham_khu_cho_el_rastro_neu_ban_%C4%91ang_muon_tim_kiem_mot_mon_qua_luu_niem_%C4%91am_chat_madrid_1.jpg?alt=media&token=fd1c4ffa-6f5f-4cc8-9164-3f9d5fe7a071', 'Hãy ghé thăm khu chợ El Rastro nếu bạn đang muốn tìm kiếm một món quà lưu niệm đậm chất Madrid', '2024-11-04 10:00:58.170000'),
	(122, 21, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2F%C4%91at_nuoc_paris_1.jpg?alt=media&token=fecd784e-85b6-490b-8324-5c116e064bc2', 'Đất nước Paris', '2024-11-04 10:12:39.380000'),
	(123, 21, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2F%C4%91at_nuoc_paris_phap_1.jpg?alt=media&token=5e875588-5f17-4fab-b7d3-3c88070f2a35', 'Đất nước Paris Pháp', '2024-11-04 10:12:39.380000'),
	(124, 21, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Ftrai_tim_paris_%E2%80%93_tu_nha_tho_%C4%91uc_ba_%C4%91en_bao_tang_louvre_1.jpg?alt=media&token=867e4984-dd38-4d73-82b1-780b887ff69f', 'Trái tim Paris – Từ nhà thờ Đức Bà đến bảo tàng Louvre', '2024-11-04 10:12:39.380000'),
	(125, 21, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fthanh_pho_mong_mo_%C4%91a_lat_1.jpg?alt=media&token=c99e2e4c-55db-4d69-b5cb-8e50d4f0b4dc', 'Thành phố mộng mở Đà Lạt', '2024-11-04 10:12:39.380000'),
	(126, 21, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fhoang_hon_suong_mu_%C4%91a_lat_1.jpg?alt=media&token=62578232-da6d-4a53-a908-aa1a3528ea53', 'Hoàng hôn sương mù Đà Lạt', '2024-11-04 10:12:39.380000'),
	(127, 21, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fho_suoi_vang_so_huu_ve_%C4%91ep_tho_mong__1.jpg?alt=media&token=b6c04453-d370-4ec1-bedc-cdf46a2f6dd4', 'Hồ Suối Vàng sở hữu vẻ đẹp thơ mộng ', '2024-11-04 10:12:39.380000'),
	(128, 22, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fsingapore_%C4%91ao_quoc_su_tu_1.jpg?alt=media&token=22605387-686a-4191-86dc-cbe84f3d6de2', 'Singapore Đảo quốc sư tử', '2024-11-04 10:31:56.301000'),
	(129, 22, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fsingapore_%C4%91uoc_menh_danh_la_thien_%C4%91uong_mua_sam_noi_bat_tai_khu_vuc_chau_a_1.jpg?alt=media&token=99b49cab-eca5-4e59-8f89-a7a126c8be26', 'Singapore được mệnh danh là thiên đường mua sắm nổi bật tại khu vực Châu Á', '2024-11-04 10:31:56.301000'),
	(130, 22, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fsingapore_flyer_la_vong_%C4%91u_quay_ngam_canh_cao_nhat_tai_chau_a_1.jpg?alt=media&token=46673c25-e400-4273-8619-c9989e51dd34', 'Singapore Flyer là vòng đu quay ngắm cảnh cao nhất tại Châu Á', '2024-11-04 10:31:56.301000'),
	(131, 22, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fthanh_pho_nha_trang_nhin_tu_tren_cao_1.jpg?alt=media&token=e391b089-f420-453b-9ae4-5f7ed9990f06', 'Thành phố Nha Trang nhìn từ trên cao', '2024-11-04 10:31:56.301000'),
	(132, 22, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fvinpearl_nha_trang_tro_nen_hap_dan_voi_du_khach_boi_tich_hop_nhieu_dich_vu_%C4%91a_dang%2C_%C4%91ang_cap_1.jpg?alt=media&token=6234bd63-4afe-4489-abe6-f37d80149547', 'Vinpearl Nha Trang trở nên hấp dẫn với du khách bởi tích hợp nhiều dịch vụ đa dạng, đẳng cấp', '2024-11-04 10:31:56.301000'),
	(133, 22, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fhap_ba_ponagar_la_mot_trong_nhung_quan_the_kien_truc_van_hoa_champa_an_tuong_tai_viet_nam_1.jpg?alt=media&token=2de07c7b-27a8-45b0-81d2-3dc79423d734', 'háp Bà Ponagar là một trong những quần thể kiến trúc văn hóa Champa ấn tượng tại Việt Nam', '2024-11-04 10:31:56.301000'),
	(134, 23, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fthai_lan_bangkok_%C4%91at_nuoc_thien_lieng_1.jpg?alt=media&token=54b66c8a-a994-447d-94f1-e9ef49642804', 'Thái Lan BangKok đất nước thiên liêng', '2024-11-04 10:47:36.538000'),
	(135, 23, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fchua_wat_arun_bieu_tuong_ton_tho_thieng_lieng_o_thai_lan_1.jpg?alt=media&token=12f9d077-94a0-41f0-81be-2853848b9d09', 'Chùa Wat Arun biểu tượng tôn thờ thiêng liêng ở Thái Lan', '2024-11-04 10:47:36.538000'),
	(136, 23, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fnui_phat_vang_hay_con_goi_la_khau_chee_chan_%28tran_bao_phat_son%29_la_mot_ngon_nui_thuoc_tinh_chon_buri_1.jpg?alt=media&token=7c882eff-4159-443d-bf83-993b2010718f', 'Núi Phật Vàng hay còn gọi là Khau Chee Chan (Trân Bảo Phật Sơn) là một ngọn núi thuộc tỉnh Chon Buri', '2024-11-04 10:47:36.538000'),
	(137, 23, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fcau_%C4%91a_nang_1.jpg?alt=media&token=a31e4ba8-e8de-47f0-8753-a2f9bf7403e6', 'Cầu Đà Nẵng', '2024-11-04 10:47:36.538000'),
	(138, 23, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fcau_rong_phun_lua_%C4%91a_nang_1.jpg?alt=media&token=2148669b-421c-408a-abe3-3e128a53f12a', 'Cầu rồng phun lửa Đà Nẵng', '2024-11-04 10:47:36.538000'),
	(139, 24, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fnhat_ban_%C4%91at_nuoc_mat_troi_moc_1.jpg?alt=media&token=c34c5489-5e92-44a2-8337-5f60f9c81246', 'Nhật Bản đất nước mặt trời mọc', '2024-11-04 10:59:46.700000'),
	(140, 24, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fthap_truyen_hinh_tokyo_skytree_1.jpg?alt=media&token=7ca08613-266d-47c9-a78b-9a28dbc81331', 'Tháp truyền hình Tokyo Skytree', '2024-11-04 10:59:46.700000'),
	(141, 24, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fpho_co_yanaka_1.jpg?alt=media&token=631c7b67-fa7e-4ec6-b1eb-b2573393853e', 'Phố cổ Yanaka', '2024-11-04 10:59:46.700000'),
	(142, 24, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fhoang_thanh_thang_long_1.jpg?alt=media&token=cdc29868-203b-4fd1-82b5-cb23b7780132', 'Hoàng Thành Thăng Long', '2024-11-04 10:59:46.700000'),
	(143, 24, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Flang_bac_1.jpg?alt=media&token=4bea410d-e45a-49c3-933a-9f53f2d6fab7', 'Lăng Bác', '2024-11-04 10:59:46.700000'),
	(144, 24, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fchinh_phuc_fansipan_1.jpg?alt=media&token=a9b998ec-8419-4fab-8de2-ce01dc5bc503', 'Chinh phục Fansipan', '2024-11-04 10:59:46.700000'),
	(145, 25, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Ftrung_quoc_hongkong_1.jpg?alt=media&token=cf7fea22-4ec3-49e7-a797-a029eb50af3d', 'Trung Quốc HongKong', '2024-11-04 11:07:47.809000'),
	(146, 25, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2F%C4%91ai_lo_ngoi_sao_1.jpg?alt=media&token=5cc3918a-238a-46eb-a8b0-5ae5fcc1c932', 'Đại lộ Ngôi Sao', '2024-11-04 11:07:47.809000'),
	(147, 25, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fkhu_vui_choi_giai_tri_disneyland_1.jpg?alt=media&token=e74244e4-ee3e-4f47-a19a-c97cc8ad3456', 'Khu vui chơi giải trí Disneyland', '2024-11-04 11:07:47.809000'),
	(148, 25, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fthanh_pho_tinh_yeu_%C4%91a_lat_1.jpg?alt=media&token=7bc01b66-2a6b-40de-83ba-227ee9c851a7', 'Thành phố tình yêu Đà Lạt', '2024-11-04 11:07:47.809000'),
	(149, 25, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fho_suoi_vang_so_huu_ve_%C4%91ep_tho_mong_1.jpg?alt=media&token=70507d71-2168-42ed-8d6b-c5759a01590d', 'Hồ Suối Vàng sở hữu vẻ đẹp thơ mộng', '2024-11-04 11:07:47.809000'),
	(150, 25, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fho_tuyen_lam_%C4%91a_lat_1.jpg?alt=media&token=c9d5cfee-a271-4e3f-acf7-5544397814a0', 'Hồ Tuyền Lâm Đà Lạt', '2024-11-04 11:07:47.809000'),
	(151, 26, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fkuala_lumpur_1.jpg?alt=media&token=6fd34b2e-06dc-48dd-b60f-f06be88abd8d', 'Kuala_Lumpur', '2024-11-04 11:14:06.799000'),
	(152, 26, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fhay_ngam_nhin_%C4%91en_sri_maha_mariamman__an_%C4%91o_1.jpg?alt=media&token=2959a559-0cdf-4f52-b11a-b7502ea2de04', 'Hãy ngắm nhìn đền Sri Maha Mariamman  Ấn Độ', '2024-11-04 11:14:06.799000'),
	(153, 26, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Ftoi_tham_quang_truong_merdeka_quan_trong_nhat_cua_kuala_lumpur_1.jpg?alt=media&token=635d1fdb-f81b-4049-8444-c3e34e9611e8', 'Tới thăm Quảng trường Merdeka quan trọng nhất của Kuala Lumpur', '2024-11-04 11:14:06.799000'),
	(154, 26, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fphu_quoc_1.jpg?alt=media&token=ca8f35d6-4d73-4fe8-99f6-546f44485f05', 'Phú Quốc', '2024-11-04 11:14:06.799000'),
	(155, 26, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fngam_nhin_phu_quoc_tu_cap_treo_vuot_bien_hon_thom_1.jpg?alt=media&token=91b4bc36-7ed6-4e83-974c-6cd009581391', 'Ngắm nhìn Phú Quốc từ cáp treo vượt biển Hòn Thơm', '2024-11-04 11:14:06.799000'),
	(156, 26, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fgrand-world_phu_quoc_1.jpg?alt=media&token=4074a482-4468-45b4-bd0c-f6e261e06c51', 'grand-world Phú Quốc', '2024-11-04 11:14:06.799000'),
	(157, 27, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fstring_1.jpg?alt=media&token=4c73e4a5-6cce-479a-b864-6874e0f9d120', 'Thành phố Seoul -  Trung tâm kinh tế, văn hóa, địa điểm du lịch nổi tiếng của Hàn Quốc', '2024-11-04 13:49:21.940000'),
	(158, 27, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fstring_1.jpg?alt=media&token=9cf808cd-24af-4d92-ac0f-084fab0dabf9', 'Ngắm nhìn toàn cảnh thành phố Seoul trên đỉnh Tháp Namsan', '2024-11-04 13:49:21.940000'),
	(159, 27, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fstring_1.jpg?alt=media&token=1cb81529-3227-478a-814c-e9983bb95a4c', 'Khám phá vẻ đẹp cổ kính cung điện hoàng gia Gyeongbokgung', '2024-11-04 13:49:21.940000'),
	(160, 27, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fthanh_pho_mong_mo_%C4%91a_lat_1.jpg?alt=media&token=9253cc08-a3ae-4b84-b9d7-17b098d4570f', 'Thành phố mộng mơ Đà Lạt', '2024-11-04 13:49:21.940000'),
	(161, 27, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fhoang_hon_suong_mu_%C4%91a_lat_1.jpg?alt=media&token=68485d2c-7e85-40c3-8bfb-f1b1574e4207', 'Hoàng hôn sương mù Đà Lạt', '2024-11-04 13:49:21.940000'),
	(162, 27, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2F%C4%91oi_thong_hai_mo_gan_lien_voi_nhung_cau_chuyen_ly_ky_va_bi_an_o_%C4%91a_lat_1.jpg?alt=media&token=eb7dd6a4-7e83-443b-b5d8-3f959b09d3c2', 'Đồi thông Hai Mộ gắn liền với những câu chuyện ly kỳ và bí ẩn ở Đà Lạt', '2024-11-04 13:49:21.940000'),
	(163, 28, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fnew-york_1.jpg?alt=media&token=bd4e9d4c-50fa-4b64-ac6a-a8cb355a488a', 'New-York', '2024-11-04 13:57:05.225000'),
	(164, 28, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Ftuong_nu_than_tu_do_co_ten_chinh_thuc_la_%E2%80%9Ctuong_nu_than_tu_do_soi_sang_the_gioi%E2%80%9D_1.jpg?alt=media&token=4aa422af-ebb5-44d2-afb4-42dc64b82985', 'Tượng nữ thần Tự do có tên chính thức là “Tượng Nữ thần Tự do soi sáng thế giới”', '2024-11-04 13:57:05.225000'),
	(165, 28, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fbao_tang_metropolitan_tap_trung_nhieu_tac_pham_nghe_thuat_tranh_anh%2C_%C4%91ieu_khac_1.jpg?alt=media&token=806a1ee0-5fbc-483d-9849-034ff85a0ec6', 'Bảo tàng Metropolitan tập trung nhiều tác phẩm nghệ thuật tranh ảnh, điêu khắc', '2024-11-04 13:57:05.225000'),
	(166, 28, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fcacun_mexico_1.jpg?alt=media&token=1aed14cc-6ab6-4bde-b337-68fb8afe7a65', 'Cacun_Mexico', '2024-11-04 13:57:05.225000'),
	(167, 28, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fkim_tu_thap_chichen_itza_con_goi_la_el_castillo_trong_tieng_tay_ban_nha_la_phe_tich_gay_kinh_ngac_nhat_1.jpg?alt=media&token=c0b3b6a5-57a2-424b-b047-a99217e6c0f6', 'Kim tự tháp Chichen Itza còn gọi là El Castillo trong tiếng Tây Ban Nha là phế tích gây kinh ngạc nhất', '2024-11-04 13:57:05.225000'),
	(168, 28, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fbao_tang_duoi_nuoc_cancun_mexico_bao_tang_la_mot_chuong_trinh_hoat_%C4%91ong_phi_loi_nhuan_1.jpg?alt=media&token=a07beda8-c4b7-473a-a013-9b0af57da375', 'Bảo tàng dưới nước Cancun Mexico Bảo tàng là một chương trình hoạt động phi lợi nhuận', '2024-11-04 13:57:05.225000'),
	(169, 29, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fthanh_pho_sydney_uc.jpg_1.jpg?alt=media&token=0499185e-e646-4568-ae15-b8882b0fba02', 'Thành phố Sydney Úc', '2024-11-04 14:04:14.258000'),
	(170, 29, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fmelbourne_%E2%80%93_thanh_pho_lon_thu_hai_cua_nuoc_uc_1.jpg?alt=media&token=9d4e62b4-d6a6-4ba3-b038-fb83de569048', 'Melbourne – Thành phố lớn thứ hai của nước Úc', '2024-11-04 14:04:14.258000'),
	(171, 29, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fso_thu_melbourne_la_%C4%91iem_tham_quan_cua_nhieu_gia_%C4%91inh_va_du_khach_yeu_thich__1.jpg?alt=media&token=ca69735f-48ca-4ee7-8458-22b02d9d06df', 'Sở thú Melbourne là điểm tham quan của nhiều gia đình và du khách yêu thích ', '2024-11-04 14:04:14.258000'),
	(172, 29, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fthanh_pho_melbourne_tho_mong_va_khong_kem_phan_hien_%C4%91ai%2C_sang_trong_%C4%91a_chinh_phuc__1.jpg?alt=media&token=a21867d9-1dd3-44d3-9994-aab9c1e61296', 'Thành phố Melbourne thơ mộng và không kém phần hiện đại, sang trọng đã chinh phục ', '2024-11-04 14:04:14.258000'),
	(173, 29, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fneu_muon_ngam_thanh_pho_melbourne_voi_goc_360_%C4%91o_thi_ban_phai_%C4%91en_toa_thap_eureka_choc_troi__1.jpg?alt=media&token=e69c601a-1654-41f0-b5d3-447f268f0079', 'Nếu muốn ngắm thành phố Melbourne với góc 360 độ thì bạn phải đến tòa tháp Eureka chọc trời ', '2024-11-04 14:04:14.258000'),
	(174, 29, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fcanh_hung_vi_tai_cong_vien_kakadu_1.jpg?alt=media&token=1bd4bbf6-ef7e-4791-a22b-db4a5b8ca40c', 'Cảnh hùng vĩ tại công viên Kakadu', '2024-11-04 14:04:14.258000'),
	(175, 30, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2F%C4%91ai_phun_nuoc_trevi_%C4%91uoc_xay_dung_vao_nam_1723_1.jpg?alt=media&token=2a221865-5a11-41ed-8b47-20261c2f5542', 'Đài phun nước Trevi được xây dựng vào năm 1723', '2024-11-04 14:10:11.409000'),
	(176, 30, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2F%C4%91au_truong_la_ma_colosseum_la_mot_trong_nhung_bieu_tuong_lich_su_1.jpg?alt=media&token=3a6bff45-52dd-4c72-9a5c-018c94864348', 'Đấu trường La Mã Colosseum là một trong những biểu tượng lịch sử', '2024-11-04 14:10:11.409000'),
	(177, 30, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2F%C4%91en_pantheon_o_rome_la_di_tich_co_kien_truc_ngoai_muc_va_con_kha_nguyen_ven_1.jpg?alt=media&token=5b442791-741a-41df-b3d1-ed1656bc1af3', 'Đền Pantheon ở Rome là di tích có kiến trúc ngoại mục và còn khá nguyên vẹn', '2024-11-04 14:10:11.409000'),
	(178, 30, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Frhodes_%C4%91uoc_biet_toi_la_hon_%C4%91ao_lon_nhat_tu_quan_%C4%91ao_dodecanese__1.jpg?alt=media&token=f03e01cb-e76a-48ef-9e6f-d927a59f70af', 'Rhodes được biết tới là hòn đảo lớn nhất từ quần đảo Dodecanese ', '2024-11-04 14:10:11.409000'),
	(179, 30, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Fthanh_co_acropolis_tai_athens__1.jpg?alt=media&token=619d0c82-d8b7-4aab-9f93-efc16512a0a9', 'Thành cổ Acropolis tại Athens ', '2024-11-04 14:10:11.409000'),
	(180, 30, 'https://firebasestorage.googleapis.com/v0/b/website-tour-1cf29.appspot.com/o/tour_images%2Ftu_vien_meteora_hy_lap_noi_bat_la_mot_di_san_van_hoa_%C4%91oc_%C4%91ao_nam_giua_song_pinios_1.jpg?alt=media&token=f26c472b-0112-4a88-9005-447d91e58d4f', 'Tu viện Meteora Hy Lạp nổi bật là một di sản văn hóa độc đáo nằm giữa sông Pinios', '2024-11-04 14:10:11.409000');

-- Dumping structure for table toursstores.touritineraries
CREATE TABLE IF NOT EXISTS `touritineraries` (
  `ItineraryId` int(11) NOT NULL AUTO_INCREMENT,
  `TourId` int(11) NOT NULL,
  `LanguageCode` varchar(5) NOT NULL,
  `DayNumber` int(11) NOT NULL,
  `Title` varchar(100) NOT NULL,
  `Description` longtext NOT NULL,
  `Destinations` varchar(255) DEFAULT NULL,
  `Activities` varchar(255) DEFAULT NULL,
  `MealInclusions` varchar(100) DEFAULT NULL,
  `Accommodation` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ItineraryId`),
  UNIQUE KEY `IX_TourItineraries_TourId_LanguageCode_DayNumber` (`TourId`,`LanguageCode`,`DayNumber`),
  CONSTRAINT `FK_TourItineraries_Tours_TourId` FOREIGN KEY (`TourId`) REFERENCES `tours` (`TourId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=156 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table toursstores.touritineraries: ~152 rows (approximately)
INSERT INTO `touritineraries` (`ItineraryId`, `TourId`, `LanguageCode`, `DayNumber`, `Title`, `Description`, `Destinations`, `Activities`, `MealInclusions`, `Accommodation`) VALUES
	(1, 1, 'vi', 1, 'Ngày 1: Khởi hành từ Hà Nội', 'Khởi hành từ Hà Nội, đến Hạ Long và nhận phòng khách sạn.', 'Hà Nội - Hạ Long', 'Di chuyển đến Hạ Long, ăn trưa tại nhà hàng địa phương.', 'Bữa trưa, bữa tối', 'Khách sạn 3 sao tại Hạ Long'),
	(2, 1, 'vi', 2, 'Ngày 2: Tham quan vịnh Hạ Long', 'Tham quan vịnh Hạ Long, chèo thuyền kayak và thăm hang động.', 'Vịnh Hạ Long', 'Tham quan vịnh, chèo thuyền kayak, thăm động Thiên Cung.', 'Bữa sáng, bữa trưa, bữa tối', 'Khách sạn 3 sao tại Hạ Long'),
	(3, 1, 'vi', 3, 'Ngày 3: Trở về Hà Nội', 'Tham quan chợ địa phương và quay về Hà Nội.', 'Hạ Long - Hà Nội', 'Tham quan chợ địa phương, di chuyển về Hà Nội.', 'Bữa sáng', 'Không có'),
	(4, 2, 'vi', 1, 'Ngày 1: Khởi hành từ Đà Nẵng', 'Di chuyển đến Phú Yên, tham quan Gành Đá Đĩa.', 'Đà Nẵng - Phú Yên', 'Tham quan Gành Đá Đĩa, ăn tối tại nhà hàng địa phương.', 'Bữa trưa, bữa tối', 'Khách sạn 3 sao tại Phú Yên'),
	(5, 2, 'vi', 2, 'Ngày 2: Khám phá biển Tuy Hòa', 'Tham quan biển Tuy Hòa và các địa điểm nổi bật tại Phú Yên.', 'Biển Tuy Hòa', 'Tắm biển, chụp ảnh tại các địa danh nổi tiếng, khám phá văn hóa địa phương.', 'Bữa sáng, bữa trưa, bữa tối', 'Khách sạn 3 sao tại Phú Yên'),
	(6, 2, 'vi', 3, 'Ngày 3: Mua sắm và trở về Đà Nẵng', 'Tham quan chợ địa phương và mua sắm quà lưu niệm trước khi trở về.', 'Phú Yên - Đà Nẵng', 'Mua sắm quà lưu niệm tại chợ, trở về Đà Nẵng.', 'Bữa sáng', 'Không có'),
	(7, 3, 'vi', 1, 'Ngày 1: Hà Nội - Sapa', 'Di chuyển từ Hà Nội đến Sapa, tham quan bản Cát Cát.', 'Hà Nội - Sapa - Bản Cát Cát', 'Check-in khách sạn, tham quan bản làng, chợ đêm Sapa.', 'Bữa trưa, bữa tối', 'Khách sạn 4 sao tại Sapa'),
	(9, 3, 'vi', 2, 'Ngày 2: Sapa - Hà Nội', 'Chinh phục Fansipan, trở về Hà Nội.', 'Sapa - Fansipan - Hà Nội', 'Leo núi Fansipan, mua sắm đặc sản.', 'Bữa sáng, bữa trưa', 'Không có'),
	(10, 4, 'vi', 1, 'Ngày 1: TP.HCM - Phú Quốc', 'Bay đến Phú Quốc, nhận phòng và tham quan.', 'TP.HCM - Phú Quốc', 'Check-in resort, tắm biển, khám phá chợ đêm.', 'Bữa trưa, bữa tối', 'Resort 5 sao tại Phú Quốc'),
	(11, 4, 'vi', 2, 'Ngày 2: Vinpearl Land', 'Vui chơi tại Vinpearl Land và Safari.', 'Vinpearl Land Phú Quốc', 'Tham quan công viên, xem show diễn.', 'Bữa sáng, bữa trưa, bữa tối', 'Resort 5 sao tại Phú Quốc'),
	(12, 4, 'vi', 3, 'Ngày 3: Tour 4 đảo', 'Khám phá 4 đảo hoang sơ của Phú Quốc.', 'Các đảo phía Nam Phú Quốc', 'Lặn biển, câu cá, tắm biển.', 'Bữa sáng, bữa trưa, bữa tối', 'Resort 5 sao tại Phú Quốc'),
	(13, 4, 'vi', 4, 'Ngày 4: Phú Quốc - TP.HCM', 'Mua sắm và trở về TP.HCM.', 'Phú Quốc - TP.HCM', 'Mua đặc sản, bay về TP.HCM.', 'Bữa sáng', 'Không có'),
	(14, 5, 'vi', 1, 'Ngày 1: Khám phá Đà Nẵng', 'Tham quan các điểm đến nổi tiếng Đà Nẵng.', 'Bà Nà Hills, Cầu Rồng', 'Khám phá Bà Nà Hills, check-in Cầu Rồng.', 'Bữa trưa, bữa tối', 'Khách sạn 4 sao tại Đà Nẵng'),
	(15, 5, 'vi', 2, 'Ngày 2: Hội An - Huế', 'Tham quan phố cổ Hội An và di chuyển đến Huế.', 'Hội An - Huế', 'Tham quan phố cổ, di chuyển đến Huế.', 'Bữa sáng, bữa trưa, bữa tối', 'Khách sạn 4 sao tại Huế'),
	(17, 5, 'vi', 3, 'Ngày 3: Khám phá Huế', 'Tham quan di tích cố đô Huế.', 'Huế', 'Tham quan Đại Nội, chùa Thiên Mụ.', 'Bữa sáng, bữa trưa', 'Không có'),
	(18, 6, 'vi', 1, 'Ngày 1: TP.HCM - Đà Lạt', 'Di chuyển từ TP.HCM đến Đà Lạt.', 'TP.HCM - Đà Lạt', 'Check-in khách sạn, chợ đêm Đà Lạt.', 'Bữa trưa, bữa tối', 'Khách sạn 4 sao tại Đà Lạt'),
	(19, 6, 'vi', 2, 'Ngày 2: Khám phá Đà Lạt', 'Tham quan các điểm đến nổi tiếng.', 'Đà Lạt', 'Vườn hoa, thung lũng tình yêu, thiền viện.', 'Bữa sáng, bữa trưa, bữa tối', 'Khách sạn 4 sao tại Đà Lạt'),
	(20, 6, 'vi', 3, 'Ngày 3: Đà Lạt - TP.HCM', 'Mua sắm và trở về TP.HCM.', 'Đà Lạt - TP.HCM', 'Mua đặc sản, di chuyển về TP.HCM.', 'Bữa sáng', 'Không có'),
	(21, 7, 'vi', 1, 'Ngày 1: Đà Nẵng - Hội An', 'Di chuyển từ Đà Nẵng đến Hội An.', 'Đà Nẵng - Hội An', 'Check-in khách sạn, tham quan phố cổ.', 'Bữa trưa, bữa tối', 'Khách sạn 4 sao tại Hội An'),
	(22, 7, 'vi', 2, 'Ngày 2: Khám phá phố cổ Hội An', 'Tham quan các điểm đến nổi tiếng trong phố cổ.', 'Hội An', 'Tham quan Chùa Cầu, Hội quán Phước Kiến.', 'Bữa sáng, bữa trưa, bữa tối', 'Khách sạn 4 sao tại Hội An'),
	(23, 7, 'vi', 3, 'Ngày 3: Bà Nà Hills', 'Tham quan Bà Nà Hills và cầu Vàng.', 'Đà Nẵng', 'Tham quan Bà Nà Hills, vui chơi giải trí.', 'Bữa sáng, bữa trưa, bữa tối', 'Khách sạn 4 sao tại Hội An'),
	(24, 7, 'vi', 4, 'Ngày 4: Hội An - Đà Nẵng', 'Mua sắm và trở về Đà Nẵng.', 'Hội An - Đà Nẵng', 'Mua sắm quà lưu niệm, di chuyển về Đà Nẵng.', 'Bữa sáng', 'Không có'),
	(25, 8, 'vi', 1, 'Ngày 1: Hà Nội - Phú Quốc', 'Di chuyển từ Hà Nội đến Phú Quốc.', 'Hà Nội - Phú Quốc', 'Check-in khách sạn, tự do khám phá bãi biển.', 'Bữa trưa, bữa tối', 'Khách sạn 4 sao tại Phú Quốc'),
	(26, 8, 'vi', 2, 'Ngày 2: Khám phá Phú Quốc', 'Tham quan Bãi Sao và Vinpearl Safari.', 'Phú Quốc', 'Tắm biển tại Bãi Sao, tham quan Vinpearl Safari.', 'Bữa sáng, bữa trưa, bữa tối', 'Khách sạn 4 sao tại Phú Quốc'),
	(27, 8, 'vi', 3, 'Ngày 3: Lặn biển và tham quan', 'Lặn biển ngắm san hô tại Hòn Móng Tay.', 'Phú Quốc', 'Lặn biển, tham quan các hòn đảo xung quanh.', 'Bữa sáng, bữa trưa, bữa tối', 'Khách sạn 4 sao tại Phú Quốc'),
	(28, 8, 'vi', 4, 'Ngày 4: Dinh Cậu - Chợ Đêm', 'Tham quan Dinh Cậu và chợ đêm Dinh Cậu.', 'Phú Quốc', 'Tham quan Dinh Cậu, mua sắm tại chợ đêm.', 'Bữa sáng, bữa trưa, bữa tối', 'Khách sạn 4 sao tại Phú Quốc'),
	(29, 8, 'vi', 5, 'Ngày 5: Phú Quốc - Hà Nội', 'Mua sắm và trở về Hà Nội.', 'Phú Quốc - Hà Nội', 'Mua sắm quà lưu niệm, di chuyển ra sân bay.', 'Bữa sáng', 'Không có'),
	(30, 9, 'vi', 1, 'Ngày 1: Hà Nội - Hà Giang', 'Di chuyển từ Hà Nội đến Hà Giang.', 'Hà Nội - Hà Giang', 'Check-in khách sạn, tham quan phố cổ Đồng Văn.', 'Bữa trưa, bữa tối', 'Khách sạn 3 sao tại Hà Giang'),
	(31, 9, 'vi', 2, 'Ngày 2: Khám phá Đồng Văn', 'Khám phá các điểm du lịch tại Đồng Văn.', 'Đồng Văn', 'Tham quan chợ phiên Mèo Vạc, Cao nguyên đá.', 'Bữa sáng, bữa trưa, bữa tối', 'Khách sạn 3 sao tại Hà Giang'),
	(32, 9, 'vi', 3, 'Ngày 3: Đèo Mã Pì Lèng', 'Tham quan đèo Mã Pì Lèng và chụp ảnh tại điểm ngắm cảnh.', 'Mã Pì Lèng', 'Chụp ảnh tại điểm ngắm cảnh, khám phá văn hóa địa phương.', 'Bữa sáng, bữa trưa, bữa tối', 'Khách sạn 3 sao tại Hà Giang'),
	(33, 9, 'vi', 4, 'Ngày 4: Hà Giang - Hà Nội', 'Trở về Hà Nội và kết thúc tour.', 'Hà Giang - Hà Nội', 'Mua sắm quà lưu niệm, di chuyển ra sân bay.', 'Bữa sáng', 'Không có'),
	(34, 10, 'vi', 1, 'Ngày 1: TP.HCM - Vũng Tàu', 'Di chuyển từ TP.HCM đến Vũng Tàu.', 'TP.HCM - Vũng Tàu', 'Khởi hành từ TP.HCM lúc 7h00 sáng.,Đến Vũng Tàu, nhận phòng khách sạn.,Tham quan Bãi Sau - nơi có bãi biển đẹp và nhiều hoạt động thể thao nước.', 'Bữa trưa, bữa tối', 'Khách sạn 4 sao tại Vũng Tàu'),
	(35, 10, 'vi', 2, 'Ngày 2: Khám phá Vũng Tàu', 'Tham quan các điểm đến nổi tiếng của Vũng Tàu.', 'Vũng Tàu', 'Bắt đầu ngày mới với bữa sáng tại khách sạn.,Tham quan Núi Nhỏ - leo lên đỉnh núi để ngắm nhìn toàn cảnh Vũng Tàu.,Ghé thăm Đền Thích Ca Phật Đài - nơi có tượng Phật cao lớn và khung cảnh yên bình.', 'Bữa sáng, bữa trưa, bữa tối', 'Khách sạn 4 sao tại Vũng Tàu'),
	(36, 10, 'vi', 3, 'Ngày 3: Vũng Tàu - TP.HCM', 'Mua sắm và trở về TP.HCM.', 'Vũng Tàu - TP.HCM', 'Bữa sáng tại khách sạn và làm thủ tục trả phòng., Tham quan các cửa hàng đặc sản để mua quà về cho gia đình và bạn bè., Tham quan công viên nước Hồ Mây hoặc thư giãn tại bãi biển Di chuyển về TP.HCM vào buổi chiều', 'Bữa sáng', 'Không có'),
	(37, 11, 'vi', 1, 'Ngày 1: TP.HCM - Paris', 'Khởi hành từ TP.HCM đến Paris.', 'TP.HCM - Paris', 'Check-in khách sạn, tự do khám phá Paris vào buổi tối.', 'Bữa tối trên máy bay', 'Khách sạn 4 sao tại Paris'),
	(38, 11, 'vi', 2, 'Ngày 2: Tham quan Paris', 'Tham quan các địa điểm nổi tiếng tại Paris.', 'Paris', 'Tháp Eiffel, bảo tàng Louvre.', 'Bữa sáng, bữa trưa', 'Khách sạn 4 sao tại Paris'),
	(39, 11, 'vi', 3, 'Ngày 3: Khám phá ngoại ô Paris', 'Tham quan các khu vực ngoại ô và các làng cổ gần Paris.', 'Ngoại ô Paris', 'Tham quan làng cổ Montmartre, ngắm cảnh tại Versailles.', 'Bữa sáng, bữa trưa', 'Khách sạn 4 sao tại Paris'),
	(40, 11, 'vi', 4, 'Ngày 4: Mua sắm và giải trí tại Paris', 'Ngày tự do cho mua sắm và giải trí tại Paris.', 'Paris', 'Mua sắm tại Champs-Élysées, khám phá các cửa hàng nổi tiếng.', 'Bữa sáng', 'Khách sạn 4 sao tại Paris'),
	(41, 11, 'vi', 5, 'Ngày 5: Paris - TP.HCM', 'Mua sắm và chuẩn bị trở về Việt Nam.', 'Paris - TP.HCM', 'Mua sắm, di chuyển ra sân bay.', 'Bữa sáng', 'Không có'),
	(42, 12, 'vi', 1, 'Ngày 1: TP.HCM - Singapore', 'Khởi hành từ TP.HCM đến Singapore.', 'TP.HCM - Singapore', 'Check-in khách sạn, tự do khám phá Singapore vào buổi tối.', 'Bữa tối trên máy bay', 'Khách sạn 4 sao tại Singapore'),
	(43, 12, 'vi', 2, 'Ngày 2: Tham quan Singapore', 'Tham quan các địa điểm nổi tiếng tại Singapore.', 'Singapore', 'Marina Bay Sands, Sentosa.', 'Bữa sáng, bữa trưa', 'Khách sạn 4 sao tại Singapore'),
	(44, 12, 'vi', 3, 'Ngày 3: Gardens by the Bay', 'Tham quan Gardens by the Bay và thư giãn tại Sentosa.', 'Singapore', 'Tham quan Gardens by the Bay, thư giãn tại Sentosa.', 'Bữa sáng, bữa trưa', 'Khách sạn 4 sao tại Singapore'),
	(45, 12, 'vi', 4, 'Ngày 4: Singapore - TP.HCM', 'Mua sắm và trở về TP.HCM.', 'Singapore - TP.HCM', 'Mua sắm, di chuyển ra sân bay.', 'Bữa sáng', 'Không có'),
	(46, 13, 'vi', 1, 'Ngày 1: TP.HCM - Bangkok', 'Khởi hành từ TP.HCM đến Bangkok.', 'TP.HCM - Bangkok', 'Check-in khách sạn, tự do khám phá Bangkok vào buổi tối.', 'Bữa tối trên máy bay', 'Khách sạn 4 sao tại Bangkok'),
	(47, 13, 'vi', 2, 'Ngày 2: Tham quan Bangkok', 'Tham quan các địa điểm nổi tiếng tại Bangkok.', 'Bangkok', 'Chùa Wat Arun, Cung điện Hoàng Gia.', 'Bữa sáng, bữa trưa', 'Khách sạn 4 sao tại Bangkok'),
	(48, 13, 'vi', 3, 'Ngày 3: Khaosan Road', 'Tham quan Khaosan Road và mua sắm tại Bangkok.', 'Bangkok', 'Tham quan Khaosan Road, mua sắm quà lưu niệm.', 'Bữa sáng, bữa trưa', 'Khách sạn 4 sao tại Bangkok'),
	(49, 13, 'vi', 4, 'Ngày 4: Bangkok - TP.HCM', 'Mua sắm và trở về TP.HCM.', 'Bangkok - TP.HCM', 'Mua sắm, di chuyển ra sân bay.', 'Bữa sáng', 'Không có'),
	(50, 14, 'vi', 1, 'Ngày 1: TP.HCM - Kuala Lumpur', 'Khởi hành từ TP.HCM đến Kuala Lumpur.', 'TP.HCM - Kuala Lumpur', 'Check-in khách sạn, tham quan khu phố người Hoa.', 'Bữa tối trên máy bay', 'Khách sạn 4 sao tại Kuala Lumpur'),
	(51, 14, 'vi', 2, 'Ngày 2: Tham quan Kuala Lumpur', 'Tham quan các địa điểm nổi tiếng tại Kuala Lumpur.', 'Kuala Lumpur', 'Tháp đôi Petronas, Công viên KLCC.', 'Bữa sáng, bữa trưa', 'Khách sạn 4 sao tại Kuala Lumpur'),
	(52, 14, 'vi', 3, 'Ngày 3: Khám phá Batu Caves', 'Tham quan Batu Caves và các điểm nổi bật khác.', 'Batu Caves', 'Khám phá các hang động tại Batu Caves, tham quan chợ địa phương.', 'Bữa sáng, bữa trưa', 'Khách sạn 4 sao tại Kuala Lumpur'),
	(53, 14, 'vi', 4, 'Ngày 4: Kuala Lumpur - TP.HCM', 'Mua sắm và trở về TP.HCM.', 'Kuala Lumpur - TP.HCM', 'Mua sắm tại Bukit Bintang, di chuyển ra sân bay.', 'Bữa sáng', 'Không có'),
	(54, 15, 'vi', 1, 'Ngày 1: TP.HCM - Tokyo', 'Khởi hành từ TP.HCM đến Tokyo.', 'TP.HCM - Tokyo', 'Check-in khách sạn, khám phá khu Shibuya.', 'Bữa tối trên máy bay', 'Khách sạn 4 sao tại Tokyo'),
	(55, 15, 'vi', 2, 'Ngày 2: Tham quan Tokyo', 'Tham quan các địa điểm nổi tiếng tại Tokyo.', 'Tokyo', 'Tháp Tokyo, Asakusa.', 'Bữa sáng, bữa trưa', 'Khách sạn 4 sao tại Tokyo'),
	(56, 15, 'vi', 3, 'Ngày 3: Khám phá Akihabara', 'Khám phá Akihabara và mua sắm tại các cửa hàng điện tử.', 'Tokyo', 'Tham quan Akihabara, thưởng thức ẩm thực Nhật Bản.', 'Bữa sáng, bữa trưa', 'Khách sạn 4 sao tại Tokyo'),
	(57, 15, 'vi', 4, 'Ngày 4: Tokyo - TP.HCM', 'Mua sắm và trở về TP.HCM.', 'Tokyo - TP.HCM', 'Mua sắm tại Ginza, di chuyển ra sân bay.', 'Bữa sáng', 'Không có'),
	(58, 16, 'vi', 1, 'Ngày 1: TP.HCM - Thượng Hải', 'Khởi hành từ TP.HCM đến Thượng Hải.', 'TP.HCM - Thượng Hải', 'Check-in khách sạn, khám phá khu phố cổ Thượng Hải.', 'Bữa tối trên máy bay', 'Khách sạn 4 sao tại Thượng Hải'),
	(59, 16, 'vi', 2, 'Ngày 2: Tham quan Thượng Hải', 'Tham quan các địa điểm nổi tiếng tại Thượng Hải.', 'Thượng Hải', 'Bến Thượng Hải, Tháp truyền hình Đông Phương.', 'Bữa sáng, bữa trưa', 'Khách sạn 4 sao tại Thượng Hải'),
	(60, 16, 'vi', 3, 'Ngày 3: Khám phá Thượng Hải', 'Khám phá Vườn Yuyuan và các trung tâm mua sắm.', 'Thượng Hải', 'Tham quan Vườn Yuyuan, mua sắm tại Nanjing Road.', 'Bữa sáng, bữa trưa', 'Khách sạn 4 sao tại Thượng Hải'),
	(61, 16, 'vi', 4, 'Ngày 4: Thượng Hải - TP.HCM', 'Mua sắm và trở về TP.HCM.', 'Thượng Hải - TP.HCM', 'Mua sắm tại các chợ địa phương, di chuyển ra sân bay.', 'Bữa sáng', 'Không có'),
	(62, 17, 'vi', 1, 'Ngày 1: TP.HCM - Thượng Hải', 'Khởi hành từ TP.HCM đến Thượng Hải.', 'TP.HCM - Thượng Hải', 'Check-in khách sạn, khám phá khu phố cổ Thượng Hải.', 'Bữa tối trên máy bay', 'Khách sạn 4 sao tại Thượng Hải'),
	(63, 17, 'vi', 2, 'Ngày 2: Tham quan Thượng Hải', 'Tham quan các địa điểm nổi tiếng tại Thượng Hải.', 'Thượng Hải', 'Bến Thượng Hải, Tháp truyền hình Đông Phương.', 'Bữa sáng, bữa trưa', 'Khách sạn 4 sao tại Thượng Hải'),
	(64, 17, 'vi', 3, 'Ngày 3: Khám phá Thượng Hải', 'Khám phá Vườn Yuyuan và các trung tâm mua sắm.', 'Thượng Hải', 'Tham quan Vườn Yuyuan, mua sắm tại Nanjing Road.', 'Bữa sáng, bữa trưa', 'Khách sạn 4 sao tại Thượng Hải'),
	(65, 17, 'vi', 4, 'Ngày 4: Thượng Hải - TP.HCM', 'Mua sắm và trở về TP.HCM.', 'Thượng Hải - TP.HCM', 'Mua sắm tại các chợ địa phương, di chuyển ra sân bay.', 'Bữa sáng', 'Không có'),
	(66, 18, 'vi', 1, 'Ngày 1: TP.HCM - Dubai', 'Khởi hành từ TP.HCM đến Dubai.', 'TP.HCM - Dubai', 'Check-in khách sạn, nghỉ ngơi sau chuyến bay.', 'Bữa tối trên máy bay', 'Khách sạn 4 sao tại Dubai'),
	(67, 18, 'vi', 2, 'Ngày 2: Tham quan Dubai', 'Tham quan các địa điểm nổi tiếng tại Dubai.', 'Dubai', 'Burj Khalifa, Dubai Mall.', 'Bữa sáng, bữa trưa', 'Khách sạn 4 sao tại Dubai'),
	(68, 18, 'vi', 3, 'Ngày 3: Khám phá văn hóa', 'Tham quan Cung điện Al Fahidi và các bảo tàng.', 'Dubai', 'Tham quan Bảo tàng Dubai, chợ vàng và chợ gia vị.', 'Bữa sáng, bữa trưa', 'Khách sạn 4 sao tại Dubai'),
	(69, 18, 'vi', 4, 'Ngày 4: Safari sa mạc', 'Khám phá sa mạc với các hoạt động thú vị.', 'Sa mạc Dubai', 'Safari sa mạc, cưỡi lạc đà, thưởng thức bữa tối BBQ và show múa bụng.', 'Bữa sáng, bữa tối', 'Khách sạn 4 sao tại Dubai'),
	(70, 18, 'vi', 5, 'Ngày 5: Dubai - TP.HCM', 'Mua sắm và trở về TP.HCM.', 'Dubai - TP.HCM', 'Mua sắm tại các trung tâm thương mại, di chuyển ra sân bay.', 'Bữa sáng', 'Không có'),
	(71, 19, 'vi', 1, 'Ngày 1: TP.HCM - Phuket', 'Khởi hành từ TP.HCM đến Phuket.', 'TP.HCM - Phuket', 'Check-in khách sạn, tự do khám phá Phuket vào buổi tối.', 'Bữa tối trên máy bay', 'Khách sạn 4 sao tại Phuket'),
	(72, 19, 'vi', 2, 'Ngày 2: Tham quan đảo Phi Phi', 'Khám phá vẻ đẹp của đảo Phi Phi.', 'Đảo Phi Phi', 'Đi tàu đến đảo Phi Phi, tắm biển, snorkeling.', 'Bữa sáng, bữa trưa', 'Khách sạn 4 sao tại Phuket'),
	(73, 19, 'vi', 3, 'Ngày 3: Khám phá Phuket', 'Tham quan các điểm nổi bật ở Phuket.', 'Phuket', 'Tham quan Chùa Wat Chalong, Bãi biển Patong.', 'Bữa sáng, bữa trưa', 'Khách sạn 4 sao tại Phuket'),
	(74, 19, 'vi', 4, 'Ngày 4: Phuket - TP.HCM', 'Mua sắm và trở về TP.HCM.', 'Phuket - TP.HCM', 'Mua sắm quà lưu niệm, di chuyển ra sân bay.', 'Bữa sáng', 'Không có'),
	(75, 20, 'vi', 1, 'Ngày 1: TP.HCM - Madrid', 'Khởi hành từ TP.HCM đến Madrid.', 'TP.HCM - Madrid', 'Check-in khách sạn, tự do khám phá Madrid vào buổi tối.', 'Bữa tối trên máy bay', 'Khách sạn 4 sao tại Madrid'),
	(76, 20, 'vi', 2, 'Ngày 2: Tham quan Madrid', 'Khám phá các điểm nổi bật tại Madrid.', 'Madrid', 'Tham quan Bảo tàng Prado, Cung điện Hoàng gia.', 'Bữa sáng, bữa trưa', 'Khách sạn 4 sao tại Madrid'),
	(77, 20, 'vi', 3, 'Ngày 3: Madrid - Barcelona', 'Di chuyển từ Madrid đến Barcelona.', 'Madrid - Barcelona', 'Check-in khách sạn, tham quan La Rambla.', 'Bữa sáng, bữa tối', 'Khách sạn 4 sao tại Barcelona'),
	(78, 20, 'vi', 4, 'Ngày 4: Khám phá Barcelona', 'Tham quan các điểm nổi bật tại Barcelona.', 'Barcelona', 'Sagrada Familia, Công viên Guell.', 'Bữa sáng, bữa trưa', 'Khách sạn 4 sao tại Barcelona'),
	(79, 20, 'vi', 5, 'Ngày 5: Barcelona - Granada', 'Di chuyển từ Barcelona đến Granada.', 'Barcelona - Granada', 'Check-in khách sạn, tham quan Alhambra.', 'Bữa sáng, bữa tối', 'Khách sạn 4 sao tại Granada'),
	(80, 20, 'vi', 6, 'Ngày 6: Khám phá Granada', 'Tham quan các điểm nổi bật tại Granada.', 'Granada', 'Tham quan khu phố Albayzín, ăn trưa tại nhà hàng địa phương.', 'Bữa sáng, bữa trưa', 'Khách sạn 4 sao tại Granada'),
	(81, 20, 'vi', 7, 'Ngày 7: Granada - TP.HCM', 'Mua sắm và trở về TP.HCM.', 'Granada - Madrid - TP.HCM', 'Mua sắm quà lưu niệm, di chuyển ra sân bay.', 'Bữa sáng', 'Không có'),
	(82, 21, 'vi', 1, 'Ngày 1: TP.HCM - Paris', 'Khởi hành từ TP.HCM đến Paris.', 'TP.HCM - Paris', 'Check-in khách sạn, tự do khám phá Paris vào buổi tối.', 'Bữa tối trên máy bay', 'Khách sạn 4 sao tại Paris'),
	(83, 21, 'vi', 2, 'Ngày 2: Tham quan Paris', 'Tham quan các địa điểm nổi tiếng tại Paris.', 'Paris', 'Tháp Eiffel, bảo tàng Louvre.', 'Bữa sáng, bữa trưa', 'Khách sạn 4 sao tại Paris'),
	(84, 21, 'vi', 3, 'Ngày 3: Khám phá Paris tự do', 'Thời gian tự do khám phá Paris.', 'Paris', 'Tự do tham quan các địa điểm yêu thích hoặc mua sắm.', 'Bữa sáng', 'Khách sạn 4 sao tại Paris'),
	(85, 21, 'vi', 4, 'Ngày 4: Paris - Đà Lạt', 'Di chuyển từ Paris về Việt Nam, nghỉ ngơi tại Đà Lạt.', 'Paris - Đà Lạt', 'Nghỉ ngơi và khám phá Đà Lạt vào buổi tối.', 'Bữa sáng, bữa tối', 'Khách sạn 4 sao tại Đà Lạt'),
	(86, 21, 'vi', 5, 'Ngày 5: Tham quan Đà Lạt', 'Tham quan các điểm đến nổi tiếng tại Đà Lạt.', 'Đà Lạt', 'Tham quan Đồi chè Cầu Đất, Hồ Xuân Hương.', 'Bữa sáng, bữa trưa, bữa tối', 'Khách sạn 4 sao tại Đà Lạt'),
	(87, 21, 'vi', 6, 'Ngày 6: Khám phá Đà Lạt tự do', 'Ngày tự do để khám phá Đà Lạt theo sở thích cá nhân.', 'Đà Lạt', 'Tự do tham quan các địa điểm mới hoặc nghỉ ngơi.', 'Bữa sáng, bữa tối', 'Khách sạn 4 sao tại Đà Lạt'),
	(88, 21, 'vi', 7, 'Ngày 7: Đà Lạt - TP.HCM', 'Trở về TP.HCM.', 'Đà Lạt - TP.HCM', 'Mua sắm, di chuyển ra sân bay.', 'Bữa sáng', 'Không có'),
	(90, 22, 'vi', 1, 'Ngày 1: TP.HCM - Singapore', 'Khởi hành từ TP.HCM đến Singapore.', 'TP.HCM - Singapore', 'Check-in khách sạn, tự do khám phá Singapore vào buổi tối.', 'Bữa tối trên máy bay', 'Khách sạn 4 sao tại Singapore'),
	(91, 22, 'vi', 2, 'Ngày 2: Tham quan Singapore', 'Tham quan các địa điểm nổi tiếng tại Singapore.', 'Singapore', 'Gardens by the Bay, Marina Bay Sands, đảo Sentosa.', 'Bữa sáng, bữa trưa', 'Khách sạn 4 sao tại Singapore'),
	(92, 22, 'vi', 3, 'Ngày 3: Khám phá Singapore tự do', 'Ngày tự do để khám phá các khu vực mua sắm và địa điểm nổi tiếng tại Singapore.', 'Singapore', 'Tham quan Orchard Road, Clarke Quay, hoặc tham gia các hoạt động giải trí tự chọn.', 'Bữa sáng', 'Khách sạn 4 sao tại Singapore'),
	(93, 22, 'vi', 4, 'Ngày 4: Singapore - Nha Trang', 'Di chuyển từ Singapore đến Nha Trang.', 'Singapore - Nha Trang', 'Check-in khách sạn, tự do khám phá Nha Trang.', 'Bữa sáng, bữa tối', 'Khách sạn 4 sao tại Nha Trang'),
	(94, 22, 'vi', 5, 'Ngày 5: Tham quan Nha Trang', 'Tham quan các địa điểm nổi tiếng tại Nha Trang.', 'Nha Trang', 'Vinpearl Land, Bãi biển Nha Trang.', 'Bữa sáng, bữa trưa, bữa tối', 'Khách sạn 4 sao tại Nha Trang'),
	(95, 22, 'vi', 6, 'Ngày 6: Nha Trang - TP.HCM', 'Trở về TP.HCM.', 'Nha Trang - TP.HCM', 'Mua sắm, di chuyển ra sân bay.', 'Bữa sáng', 'Không có'),
	(96, 23, 'vi', 1, 'Ngày 1: TP.HCM - Bangkok', 'Khởi hành từ TP.HCM đến Bangkok.', 'TP.HCM - Bangkok', 'Check-in khách sạn, tự do khám phá Bangkok vào buổi tối.', 'Bữa tối trên máy bay', 'Khách sạn 4 sao tại Bangkok'),
	(97, 23, 'vi', 2, 'Ngày 2: Tham quan Bangkok', 'Tham quan các địa điểm nổi tiếng tại Bangkok.', 'Bangkok', 'Hoàng cung Thái Lan, chùa Phật Ngọc.', 'Bữa sáng, bữa trưa', 'Khách sạn 4 sao tại Bangkok'),
	(98, 23, 'vi', 3, 'Ngày 3: Bangkok - Đà Nẵng', 'Di chuyển từ Bangkok về Việt Nam, nghỉ ngơi tại Đà Nẵng.', 'Bangkok - Đà Nẵng', 'Check-in khách sạn, tự do khám phá Đà Nẵng.', 'Bữa sáng, bữa tối', 'Khách sạn 4 sao tại Đà Nẵng'),
	(99, 23, 'vi', 4, 'Ngày 4: Tham quan Đà Nẵng', 'Tham quan các điểm đến nổi tiếng tại Đà Nẵng.', 'Đà Nẵng', 'Bà Nà Hills, Cầu Vàng.', 'Bữa sáng, bữa trưa, bữa tối', 'Khách sạn 4 sao tại Đà Nẵng'),
	(100, 23, 'vi', 5, 'Ngày 5: Đà Nẵng - TP.HCM', 'Trở về TP.HCM.', 'Đà Nẵng - TP.HCM', 'Mua sắm, di chuyển ra sân bay.', 'Bữa sáng', 'Không có'),
	(101, 24, 'vi', 1, 'Ngày 1: TP.HCM - Tokyo', 'Khởi hành từ TP.HCM đến Tokyo.', 'TP.HCM - Tokyo', 'Check-in khách sạn, tự do khám phá Tokyo vào buổi tối.', 'Bữa tối trên máy bay', 'Khách sạn 4 sao tại Tokyo'),
	(102, 24, 'vi', 2, 'Ngày 2: Tham quan Tokyo', 'Tham quan các địa điểm nổi tiếng tại Tokyo.', 'Tokyo', 'Tháp Tokyo Skytree, khu phố cổ Asakusa.', 'Bữa sáng, bữa trưa', 'Khách sạn 4 sao tại Tokyo'),
	(103, 24, 'vi', 4, 'Ngày 4: Tokyo - Hà Nội', 'Di chuyển từ Tokyo về Việt Nam, nghỉ ngơi tại Hà Nội.', 'Tokyo - Hà Nội', 'Check-in khách sạn, tự do khám phá Hà Nội.', 'Bữa sáng, bữa tối', 'Khách sạn 4 sao tại Hà Nội'),
	(104, 24, 'vi', 5, 'Ngày 5: Tham quan Hà Nội', 'Tham quan các điểm đến nổi tiếng tại Hà Nội.', 'Hà Nội', 'Hồ Gươm, Lăng Chủ tịch.', 'Bữa sáng, bữa trưa, bữa tối', 'Khách sạn 4 sao tại Hà Nội'),
	(105, 24, 'vi', 8, 'Ngày 8: Hà Nội - TP.HCM', 'Trở về TP.HCM.', 'Hà Nội - TP.HCM', 'Mua sắm, di chuyển ra sân bay.', 'Bữa sáng', 'Không có'),
	(106, 24, 'vi', 3, 'Ngày 3: Khám phá Tokyo', 'Ngày tự do để khám phá Tokyo.', 'Tokyo', 'Tham quan Akihabara, Shibuya và thưởng thức ẩm thực địa phương.', 'Bữa sáng, bữa trưa', 'Khách sạn 4 sao tại Tokyo'),
	(107, 24, 'vi', 6, 'Ngày 6: Khám phá Hà Nội', 'Tiếp tục khám phá Hà Nội và tham quan các điểm du lịch khác.', 'Hà Nội', 'Thăm Văn Miếu - Quốc Tử Giám, chợ Đồng Xuân.', 'Bữa sáng, bữa trưa', 'Khách sạn 4 sao tại Hà Nội'),
	(108, 24, 'vi', 7, 'Ngày 7: Nghỉ ngơi tại Hà Nội', 'Ngày nghỉ ngơi tại Hà Nội, tự do khám phá hoặc mua sắm.', 'Hà Nội', 'Tham quan các quán cà phê, mua sắm tại phố cổ.', 'Bữa sáng', 'Khách sạn 4 sao tại Hà Nội'),
	(109, 25, 'vi', 1, 'Ngày 1: TP.HCM - Hồng Kông', 'Khởi hành từ TP.HCM đến Hồng Kông.', 'TP.HCM - Hồng Kông', 'Check-in khách sạn, tự do khám phá Hồng Kông.', 'Bữa tối trên máy bay', 'Khách sạn 4 sao tại Hồng Kông'),
	(110, 25, 'vi', 2, 'Ngày 2: Tham quan Hồng Kông', 'Tham quan các địa điểm nổi tiếng tại Hồng Kông.', 'Hồng Kông', 'Đỉnh núi Thái Bình, Disneyland.', 'Bữa sáng, bữa trưa', 'Khách sạn 4 sao tại Hồng Kông'),
	(111, 25, 'vi', 3, 'Ngày 3: Khám phá Hồng Kông', 'Tiếp tục khám phá Hồng Kông với những trải nghiệm văn hóa.', 'Hồng Kông', 'Tham quan Đại lộ Ngôi Sao, khám phá chợ đêm Temple Street.', 'Bữa sáng, bữa trưa', 'Khách sạn 4 sao tại Hồng Kông'),
	(112, 25, 'vi', 4, 'Ngày 4: Hồng Kông - Đà Lạt', 'Di chuyển từ Hồng Kông đến Đà Lạt.', 'Hồng Kông - Đà Lạt', 'Check-in khách sạn, tham quan chợ đêm Đà Lạt.', 'Bữa sáng, bữa tối', 'Khách sạn 4 sao tại Đà Lạt'),
	(113, 25, 'vi', 5, 'Ngày 5: Tham quan Đà Lạt', 'Khám phá các điểm du lịch nổi tiếng tại Đà Lạt.', 'Đà Lạt', 'Hồ Xuân Hương, thung lũng Tình Yêu.', 'Bữa sáng, bữa trưa, bữa tối', 'Khách sạn 4 sao tại Đà Lạt'),
	(114, 25, 'vi', 6, 'Ngày 6: Khám phá Đà Lạt', 'Ngày tự do để khám phá thêm các điểm du lịch tại Đà Lạt.', 'Đà Lạt', 'Tham quan Vườn Hoa Thành Phố, Nhà thờ Domaine de Marie.', 'Bữa sáng, bữa trưa', 'Khách sạn 4 sao tại Đà Lạt'),
	(115, 25, 'vi', 7, 'Ngày 7: Đà Lạt - TP.HCM', 'Trở về TP.HCM.', 'Đà Lạt - TP.HCM', 'Mua sắm, di chuyển ra sân bay.', 'Bữa sáng', 'Không có'),
	(116, 26, 'vi', 1, 'Ngày 1: TP.HCM - Kuala Lumpur', 'Khởi hành từ TP.HCM đến Kuala Lumpur.', 'TP.HCM - Kuala Lumpur', 'Check-in khách sạn, tham quan phố Bukit Bintang.', 'Bữa tối trên máy bay', 'Khách sạn 4 sao tại Kuala Lumpur'),
	(117, 26, 'vi', 2, 'Ngày 2: Tham quan Kuala Lumpur', 'Tham quan các điểm nổi tiếng tại Kuala Lumpur.', 'Kuala Lumpur', 'Tháp đôi Petronas, chùa Batu.', 'Bữa sáng, bữa trưa', 'Khách sạn 4 sao tại Kuala Lumpur'),
	(118, 26, 'vi', 3, 'Ngày 3: Khám phá Kuala Lumpur', 'Tiếp tục khám phá những điểm đến thú vị tại Kuala Lumpur.', 'Kuala Lumpur', 'Tham quan công viên KLCC, mua sắm tại Suria KLCC.', 'Bữa sáng, bữa trưa', 'Khách sạn 4 sao tại Kuala Lumpur'),
	(119, 26, 'vi', 4, 'Ngày 4: Kuala Lumpur - Phú Quốc', 'Di chuyển từ Kuala Lumpur đến Phú Quốc.', 'Kuala Lumpur - Phú Quốc', 'Check-in khách sạn, tự do nghỉ ngơi tại Phú Quốc.', 'Bữa sáng, bữa tối', 'Khách sạn 4 sao tại Phú Quốc'),
	(120, 26, 'vi', 5, 'Ngày 5: Tham quan Phú Quốc', 'Khám phá hòn đảo Phú Quốc.', 'Phú Quốc', 'Vinpearl Safari, Bãi Sao.', 'Bữa sáng, bữa trưa, bữa tối', 'Khách sạn 4 sao tại Phú Quốc'),
	(121, 26, 'vi', 6, 'Ngày 6: Phú Quốc - TP.HCM', 'Trở về TP.HCM.', 'Phú Quốc - TP.HCM', 'Mua sắm, di chuyển ra sân bay.', 'Bữa sáng', 'Không có'),
	(122, 27, 'vi', 1, 'Ngày 1: TP.HCM - Seoul', 'Khởi hành từ TP.HCM đến Seoul.', 'TP.HCM - Seoul', 'Check-in khách sạn, tự do khám phá Seoul.', 'Bữa tối trên máy bay', 'Khách sạn 4 sao tại Seoul'),
	(123, 27, 'vi', 2, 'Ngày 2: Tham quan Seoul', 'Tham quan các địa điểm nổi tiếng tại Seoul.', 'Seoul', 'Lotte World, cung điện Gyeongbokgung.', 'Bữa sáng, bữa trưa', 'Khách sạn 4 sao tại Seoul'),
	(124, 27, 'vi', 3, 'Ngày 3: Khám phá Seoul', 'Tiếp tục khám phá những địa điểm hấp dẫn khác tại Seoul.', 'Seoul', 'Tháp N Seoul, chợ Dongdaemun.', 'Bữa sáng, bữa trưa', 'Khách sạn 4 sao tại Seoul'),
	(125, 27, 'vi', 4, 'Ngày 4: Seoul - Đà Lạt', 'Di chuyển từ Seoul về Việt Nam, nghỉ ngơi tại Đà Lạt.', 'Seoul - Đà Lạt', 'Check-in khách sạn, tham quan Đồi chè Cầu Đất.', 'Bữa sáng, bữa tối', 'Khách sạn 4 sao tại Đà Lạt'),
	(126, 27, 'vi', 5, 'Ngày 5: Tham quan Đà Lạt', 'Khám phá các điểm du lịch nổi tiếng tại Đà Lạt.', 'Đà Lạt', 'Thác Pongour, thung lũng Tình Yêu.', 'Bữa sáng, bữa trưa, bữa tối', 'Khách sạn 4 sao tại Đà Lạt'),
	(127, 27, 'vi', 6, 'Ngày 6: Khám phá Đà Lạt', 'Tiếp tục tham quan các điểm hấp dẫn tại Đà Lạt.', 'Đà Lạt', 'Biệt thự Hằng Nga, nhà thờ Domain de Marie.', 'Bữa sáng, bữa trưa', 'Khách sạn 4 sao tại Đà Lạt'),
	(128, 27, 'vi', 7, 'Ngày 7: Đà Lạt - TP.HCM', 'Trở về TP.HCM.', 'Đà Lạt - TP.HCM', 'Mua sắm, di chuyển ra sân bay.', 'Bữa sáng', 'Không có'),
	(129, 28, 'vi', 1, 'Ngày 1: TP.HCM - New York', 'Khởi hành từ TP.HCM đến New York.', 'TP.HCM - New York', 'Check-in khách sạn, tự do tham quan New York vào buổi tối.', 'Bữa tối trên máy bay', 'Khách sạn 4 sao tại New York'),
	(130, 28, 'vi', 2, 'Ngày 2: Tham quan New York', 'Tham quan Tượng Nữ thần Tự do và Công viên Trung tâm.', 'New York', 'Chụp ảnh tại Tượng Nữ thần Tự do, tham quan Central Park.', 'Bữa sáng, bữa trưa, bữa tối', 'Khách sạn 4 sao tại New York'),
	(131, 28, 'vi', 3, 'Ngày 3: Khám phá New York', 'Tiếp tục khám phá các địa danh nổi tiếng khác tại New York.', 'New York', 'Thăm bảo tàng MET, tham quan Quảng trường Thời Đại.', 'Bữa sáng, bữa trưa, bữa tối', 'Khách sạn 4 sao tại New York'),
	(132, 28, 'vi', 4, 'Ngày 4: New York - Cancun', 'Di chuyển từ New York đến Cancun.', 'New York - Cancun', 'Check-in khách sạn, nghỉ ngơi và thư giãn tại bãi biển.', 'Bữa sáng, bữa trưa', 'Resort 5 sao tại Cancun'),
	(133, 28, 'vi', 5, 'Ngày 5: Nghỉ dưỡng tại Cancun', 'Thư giãn tại resort và các hoạt động biển.', 'Cancun', 'Tắm biển, tham gia các hoạt động nước như lặn biển, chèo thuyền kayak.', 'Bữa sáng, bữa trưa, bữa tối', 'Resort 5 sao tại Cancun'),
	(134, 28, 'vi', 6, 'Ngày 6: Tham quan thành phố Cancun', 'Khám phá trung tâm thành phố Cancun và các địa điểm du lịch nổi bật.', 'Cancun', 'Tham quan bảo tàng Cancun, mua sắm tại khu phố cổ.', 'Bữa sáng, bữa trưa, bữa tối', 'Resort 5 sao tại Cancun'),
	(135, 28, 'vi', 7, 'Ngày 7: Khám phá thiên nhiên Cancun', 'Tham quan rừng nhiệt đới và tham gia tour sinh thái tại Cancun.', 'Cancun', 'Khám phá rừng nhiệt đới, đi bộ đường dài, ngắm động vật hoang dã.', 'Bữa sáng, bữa trưa, bữa tối', 'Resort 5 sao tại Cancun'),
	(136, 28, 'vi', 8, 'Ngày 8: Tự do nghỉ dưỡng tại Cancun', 'Ngày tự do nghỉ dưỡng và thư giãn trên bãi biển.', 'Cancun', 'Tắm biển, thưởng thức spa, thư giãn tại resort.', 'Bữa sáng, bữa tối', 'Resort 5 sao tại Cancun'),
	(137, 28, 'vi', 9, 'Ngày 9: Mua sắm tại Cancun', 'Tham quan các khu mua sắm lớn và mua quà lưu niệm.', 'Cancun', 'Mua sắm quà lưu niệm, tự do tham quan thành phố.', 'Bữa sáng, bữa tối', 'Resort 5 sao tại Cancun'),
	(138, 28, 'vi', 10, 'Ngày 10: Cancun - TP.HCM', 'Chuẩn bị trở về TP.HCM.', 'Cancun - TP.HCM', 'Tự do mua sắm, di chuyển ra sân bay.', 'Bữa sáng', 'Không có'),
	(139, 29, 'vi', 1, 'Ngày 1: TP.HCM - Sydney', 'Khởi hành từ TP.HCM đến Sydney.', 'TP.HCM - Sydney', 'Check-in khách sạn, tự do khám phá Sydney vào buổi tối.', 'Bữa tối trên máy bay', 'Khách sạn 4 sao tại Sydney'),
	(140, 29, 'vi', 2, 'Ngày 2: Khám phá Sydney', 'Tham quan Nhà hát Opera và Cầu cảng Sydney.', 'Sydney', 'Tham quan Nhà hát Opera, đi dạo cầu cảng Sydney.', 'Bữa sáng, bữa trưa, bữa tối', 'Khách sạn 4 sao tại Sydney'),
	(141, 29, 'vi', 3, 'Ngày 3: Khám phá thành phố Sydney', 'Tham quan các địa danh nổi tiếng khác tại Sydney.', 'Sydney', 'Tham quan Taronga Zoo, ngắm cảnh từ tháp Sydney Tower.', 'Bữa sáng, bữa trưa, bữa tối', 'Khách sạn 4 sao tại Sydney'),
	(142, 29, 'vi', 4, 'Ngày 4: Sydney - Melbourne', 'Di chuyển từ Sydney đến Melbourne.', 'Sydney - Melbourne', 'Check-in khách sạn, tự do khám phá Melbourne.', 'Bữa sáng, bữa trưa', 'Khách sạn 4 sao tại Melbourne'),
	(143, 29, 'vi', 5, 'Ngày 5: Tham quan Melbourne', 'Khám phá các địa danh nổi tiếng của Melbourne.', 'Melbourne', 'Tham quan Quảng trường Liên bang, Vườn thực vật Hoàng gia.', 'Bữa sáng, bữa trưa, bữa tối', 'Khách sạn 4 sao tại Melbourne'),
	(144, 29, 'vi', 6, 'Ngày 6: Đại lộ Great Ocean Road', 'Tham quan Đại lộ Great Ocean Road.', 'Great Ocean Road', 'Ngắm cảnh dọc đại lộ, chụp ảnh tại 12 Apostles.', 'Bữa sáng, bữa trưa, bữa tối', 'Khách sạn 4 sao tại Melbourne'),
	(145, 29, 'vi', 7, 'Ngày 7: Khám phá Melbourne', 'Tham quan và mua sắm tại trung tâm thành phố Melbourne.', 'Melbourne', 'Mua sắm tại Queen Victoria Market, tham quan các quán cà phê địa phương.', 'Bữa sáng, bữa trưa, bữa tối', 'Khách sạn 4 sao tại Melbourne'),
	(146, 29, 'vi', 8, 'Ngày 8: Melbourne - TP.HCM', 'Mua sắm và trở về TP.HCM.', 'Melbourne - TP.HCM', 'Tự do mua sắm, di chuyển ra sân bay.', 'Bữa sáng', 'Không có'),
	(147, 30, 'vi', 1, 'Ngày 1: TP.HCM - Rome', 'Khởi hành từ TP.HCM đến Rome.', 'TP.HCM - Rome', 'Check-in khách sạn, tự do tham quan Rome vào buổi tối.', 'Bữa tối trên máy bay', 'Khách sạn 4 sao tại Rome'),
	(148, 30, 'vi', 2, 'Ngày 2: Khám phá Rome', 'Tham quan các địa danh nổi tiếng tại Rome.', 'Rome', 'Tham quan Đấu trường Colosseum, Đài phun nước Trevi.', 'Bữa sáng, bữa trưa, bữa tối', 'Khách sạn 4 sao tại Rome'),
	(149, 30, 'vi', 3, 'Ngày 3: Tham quan Vatican', 'Khám phá Vatican và các di sản tôn giáo.', 'Rome - Vatican', 'Tham quan Nhà thờ St. Peter, Bảo tàng Vatican.', 'Bữa sáng, bữa trưa, bữa tối', 'Khách sạn 4 sao tại Rome'),
	(150, 30, 'vi', 4, 'Ngày 4: Khám phá các địa danh khác tại Rome', 'Tham quan những điểm đến nổi tiếng còn lại tại Rome.', 'Rome', 'Tham quan Quảng trường Tây Ban Nha, phố cổ Rome.', 'Bữa sáng, bữa trưa, bữa tối', 'Khách sạn 4 sao tại Rome'),
	(151, 30, 'vi', 5, 'Ngày 5: Rome - Athens', 'Di chuyển từ Rome đến Athens.', 'Rome - Athens', 'Check-in khách sạn, khám phá các di sản văn hóa Athens.', 'Bữa sáng, bữa tối', 'Khách sạn 4 sao tại Athens'),
	(152, 30, 'vi', 6, 'Ngày 6: Khám phá Athens', 'Tham quan các di tích lịch sử tại Athens.', 'Athens', 'Tham quan Đền Parthenon, Quảng trường Syntagma.', 'Bữa sáng, bữa trưa, bữa tối', 'Khách sạn 4 sao tại Athens'),
	(153, 30, 'vi', 7, 'Ngày 7: Khám phá Athens và vùng lân cận', 'Tham quan các khu vực lịch sử khác tại Athens.', 'Athens', 'Khám phá Đền Olympian Zeus, Bảo tàng Acropolis.', 'Bữa sáng, bữa trưa, bữa tối', 'Khách sạn 4 sao tại Athens'),
	(154, 30, 'vi', 8, 'Ngày 8: Khám phá và mua sắm tại Athens', 'Mua sắm và khám phá Athens.', 'Athens', 'Tham quan các chợ địa phương, mua sắm đồ lưu niệm.', 'Bữa sáng, bữa trưa, bữa tối', 'Khách sạn 4 sao tại Athens'),
	(155, 30, 'vi', 9, 'Ngày 9: Athens - TP.HCM', 'Tham quan và trở về TP.HCM.', 'Athens - TP.HCM', 'Tham quan mua sắm, di chuyển ra sân bay.', 'Bữa sáng', 'Không có');

-- Dumping structure for table toursstores.tours
CREATE TABLE IF NOT EXISTS `tours` (
  `TourId` int(11) NOT NULL AUTO_INCREMENT,
  `Code` varchar(50) NOT NULL,
  `StartPlace` longtext NOT NULL,
  `EndPlace` longtext NOT NULL,
  `TourTypeId` int(11) NOT NULL,
  `IsActive` tinyint(1) NOT NULL,
  `CreatedAt` datetime(6) NOT NULL DEFAULT current_timestamp(6),
  `UpdatedAt` datetime(6) DEFAULT NULL,
  `CreatedBy` longtext DEFAULT NULL,
  `UpdatedBy` longtext DEFAULT NULL,
  PRIMARY KEY (`TourId`),
  UNIQUE KEY `IX_Tours_Code` (`Code`),
  KEY `IX_Tours_IsActive` (`IsActive`),
  KEY `IX_Tours_TourTypeId` (`TourTypeId`),
  CONSTRAINT `FK_Tours_TourTypes_TourTypeId` FOREIGN KEY (`TourTypeId`) REFERENCES `tourtypes` (`TourTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table toursstores.tours: ~29 rows (approximately)
INSERT INTO `tours` (`TourId`, `Code`, `StartPlace`, `EndPlace`, `TourTypeId`, `IsActive`, `CreatedAt`, `UpdatedAt`, `CreatedBy`, `UpdatedBy`) VALUES
	(1, 'DRLE651310', 'Hà Nội', 'Hạ Long', 1, 1, '2024-11-03 08:50:03.489000', '2024-11-04 16:00:43.000000', NULL, NULL),
	(2, 'LPWF430247', 'Đà Nẵng', 'Phú Yên', 1, 1, '2024-11-03 09:00:35.734000', '2024-11-04 16:00:46.000000', NULL, NULL),
	(3, 'QQGB391823', 'Hà Nội', 'Sapa', 1, 1, '2024-11-04 03:23:08.161000', '2024-11-04 16:00:47.000000', NULL, NULL),
	(4, 'BIZY286218', 'Hồ Chí Minh', 'Phú Quốc', 1, 1, '2024-11-04 07:20:14.255000', '2024-11-04 16:00:48.000000', NULL, NULL),
	(5, 'IEZK254528', 'Đà Nẵng', 'Huế', 1, 1, '2024-11-04 07:27:16.527000', '2024-11-04 16:00:49.000000', NULL, NULL),
	(6, 'CTJY323763', 'Hồ Chí Minh', 'Đà Lạt', 1, 1, '2024-11-04 07:36:02.043000', '2024-11-04 16:00:50.000000', NULL, NULL),
	(7, 'PXAL210361', 'Đà Nẵng', 'Hội An', 1, 1, '2024-11-04 07:55:42.311000', '2024-11-04 16:00:50.000000', NULL, NULL),
	(8, 'FPLY654538', 'Hà Nội', 'Phú Quốc', 1, 1, '2024-11-04 08:03:28.984000', '2024-11-04 16:00:52.000000', NULL, NULL),
	(9, 'KUSJ731115', 'Hà Nội', 'Hà Giang', 1, 1, '2024-11-04 08:10:31.731000', '2024-11-04 16:00:51.000000', NULL, NULL),
	(10, 'DYVB279591', 'TP.HCM', 'Vũng Tàu', 1, 1, '2024-11-04 08:16:55.408000', '2024-11-04 16:00:53.000000', NULL, NULL),
	(11, 'BWJJ169475', 'Hồ Chí Minh', 'Paris', 2, 1, '2024-11-04 08:22:34.265000', '2024-11-04 16:00:54.000000', NULL, NULL),
	(12, 'JWYF572717', 'Hồ Chí Minh', 'Singapore', 2, 1, '2024-11-04 08:52:05.902000', '2024-11-04 16:00:54.000000', NULL, NULL),
	(13, 'WDJG933454', 'Hồ Chí Minh', 'Bangkok', 2, 1, '2024-11-04 09:02:47.357000', '2024-11-04 16:09:48.000000', NULL, NULL),
	(14, 'HPUT228903', 'Hồ Chí Minh', 'Kuala Lumpur', 2, 1, '2024-11-04 09:10:13.542000', '2024-11-04 16:24:26.000000', NULL, NULL),
	(15, 'IENI262638', 'Hồ Chí Minh', 'Tokyo', 2, 1, '2024-11-04 09:18:26.393000', '2024-11-04 16:24:27.000000', NULL, NULL),
	(16, 'PHSP748935', 'Hồ Chí Minh', 'Seoul', 2, 1, '2024-11-04 09:24:12.975000', '2024-11-04 16:24:28.000000', NULL, NULL),
	(17, 'NRUZ493018', 'Hồ Chí Minh', 'Thượng Hải', 2, 1, '2024-11-04 09:39:36.686000', '2024-11-08 10:07:24.000000', NULL, NULL),
	(18, 'QVDG417126', 'Hồ Chí Minh', 'Dubai', 2, 1, '2024-11-04 09:45:36.711000', '2024-11-08 10:07:25.000000', NULL, NULL),
	(19, 'UEBI658618', 'Hồ Chí Minh', 'Phuket', 2, 1, '2024-11-04 09:52:22.472000', '2024-11-08 10:07:26.000000', NULL, NULL),
	(20, 'YIPN678053', 'Hồ Chí Minh', 'Madrid', 2, 1, '2024-11-04 09:59:44.184000', '2024-11-08 10:07:27.000000', NULL, NULL),
	(21, 'RRPN415200', 'Hồ Chí Minh', 'Paris-Đà Lạt', 3, 1, '2024-11-04 10:11:39.842000', '2024-11-08 10:07:27.000000', NULL, NULL),
	(22, 'KYJM129951', 'Hồ Chí Minh', 'Singapore- Nha Trang', 3, 1, '2024-11-04 10:30:27.457000', '2024-11-08 10:07:28.000000', NULL, NULL),
	(23, 'WIJL688486', 'Hồ Chí Minh', 'Bangkok- Đà Nẵng', 3, 1, '2024-11-04 10:46:15.999000', '2024-11-08 10:07:29.000000', NULL, NULL),
	(24, 'JPSK820372', 'Hồ Chí Minh', 'Tokyo- Hà Nội', 3, 1, '2024-11-04 10:58:45.281000', '2024-11-08 10:07:30.000000', NULL, NULL),
	(25, 'CCZG961225', 'Hồ Chí Minh', 'Hồng Kông- Đà Lạt', 3, 1, '2024-11-04 11:06:29.958000', '2024-11-08 10:07:31.000000', NULL, NULL),
	(26, 'XUMP755934', 'Hồ Chí Minh', 'Kuala Lumpur- Phú Quốc', 3, 1, '2024-11-04 11:12:56.794000', '2024-11-08 10:07:32.000000', NULL, NULL),
	(27, 'QJGH804099', 'Hồ Chí Minh', 'Seoul- Đà Lạt', 3, 1, '2024-11-04 13:47:02.025000', '2024-11-08 10:07:33.000000', NULL, NULL),
	(28, 'LOMB553675', 'Hồ Chí Minh', 'New York- Cancun', 3, 1, '2024-11-04 13:55:42.395000', '2024-11-08 10:07:35.000000', NULL, NULL),
	(29, 'SANF639211', 'Hồ Chí Minh', 'Sydney- Melbourne', 3, 1, '2024-11-04 14:03:15.666000', '2024-11-08 10:07:36.000000', NULL, NULL),
	(30, 'OKZN324644', 'Hồ Chí Minh', 'Rome - Athens', 3, 1, '2024-11-04 14:09:18.499000', '2024-11-08 10:07:37.000000', NULL, NULL);

-- Dumping structure for table toursstores.tourtranslations
CREATE TABLE IF NOT EXISTS `tourtranslations` (
  `TranslationId` int(11) NOT NULL AUTO_INCREMENT,
  `TourId` int(11) NOT NULL,
  `LanguageCode` varchar(5) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Description` longtext NOT NULL,
  `Highlights` longtext DEFAULT NULL,
  `Includes` longtext DEFAULT NULL,
  `Excludes` longtext DEFAULT NULL,
  `Notes` longtext DEFAULT NULL,
  `CreatedAt` datetime(6) NOT NULL DEFAULT current_timestamp(6),
  `UpdatedAt` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`TranslationId`),
  UNIQUE KEY `IX_TourTranslations_TourId_LanguageCode` (`TourId`,`LanguageCode`),
  CONSTRAINT `FK_TourTranslations_Tours_TourId` FOREIGN KEY (`TourId`) REFERENCES `tours` (`TourId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table toursstores.tourtranslations: ~27 rows (approximately)
INSERT INTO `tourtranslations` (`TranslationId`, `TourId`, `LanguageCode`, `Name`, `Description`, `Highlights`, `Includes`, `Excludes`, `Notes`, `CreatedAt`, `UpdatedAt`) VALUES
	(1, 1, 'vi', 'Tour Hạ Long 3 ngày 2 đêm', 'Khám phá Vịnh Hạ Long với cảnh đẹp thiên nhiên hùng vĩ.', 'Tham quan vịnh, chèo thuyền kayak, thăm động Thiên Cung', 'Vé tham quan, khách sạn, bữa sáng', 'Chi phí cá nhân, bảo hiểm du lịch', 'Mang theo đồ cá nhân cần thiết, và thuốc cá nhân nếu có.', '2024-11-03 09:56:36.152000', '2024-11-03 09:56:36.152000'),
	(2, 2, 'vi', 'Tour Phú Yên 3 ngày 2 đêm', 'Khám phá vẻ đẹp hoang sơ của Phú Yên.', 'Tham quan Gành Đá Đĩa, biển Tuy Hòa', 'Vé xe, khách sạn, bữa ăn', 'Chi phí cá nhân', 'Mang theo đồ bơi và kem chống nắng.', '2024-11-03 09:56:36.152000', '2024-11-03 09:56:36.152000'),
	(3, 3, 'vi', 'Tour Sapa 2 ngày 1 đêm', 'Khám phá vẻ đẹp núi rừng Tây Bắc và văn hóa dân tộc thiểu số.', 'Chinh phục đỉnh Fansipan, thăm bản Cát Cát, chợ đêm Sapa', 'Vé tham quan, khách sạn, bữa ăn chính', 'Chi phí cá nhân, vé cáp treo Fansipan', 'Nên mang theo áo ấm và giày đi bộ thoải mái.', '2024-11-04 03:37:16.155000', '2024-11-04 03:37:16.155000'),
	(4, 4, 'vi', 'Tour Phú Quốc 4 ngày 3 đêm', 'Khám phá thiên đường biển đảo Phú Quốc.', 'Vinpearl Land, Safari, câu cá, lặn biển', 'Vé máy bay, resort, ăn uống, vé tham quan', 'Đồ uống, chi phí cá nhân', 'Mang theo đồ bơi và kem chống nắng.', '2024-11-04 07:25:43.578000', '2024-11-04 07:25:43.578000'),
	(5, 5, 'vi', 'Tour Đà Nẵng - Huế 3 ngày 2 đêm', 'Khám phá di sản văn hóa miền Trung.', 'Phố cổ Hội An, Cố đô Huế, Bà Nà Hills', 'Xe đưa đón, khách sạn, vé tham quan', 'Chi phí cá nhân, vé máy bay', 'Trang phục lịch sự khi vào các điểm tâm linh.', '2024-11-04 07:32:01.105000', '2024-11-04 07:32:01.105000'),
	(6, 6, 'vi', 'Tour Đà Lạt 3 ngày 2 đêm', 'Khám phá thành phố ngàn hoa Đà Lạt.', 'Vườn hoa, thung lũng tình yêu, cáp treo', 'Xe đưa đón, khách sạn, vé tham quan', 'Chi phí cá nhân, đồ uống', 'Mang theo áo ấm vì thời tiết Đà Lạt lạnh.', '2024-11-04 07:40:30.975000', '2024-11-04 07:40:30.975000'),
	(7, 7, 'vi', 'Tour Hội An - Đà Nẵng 4 ngày 3 đêm', 'Khám phá di sản văn hóa và ẩm thực Hội An.', 'Phố cổ Hội An, Bà Nà Hills, cầu Vàng.', 'Xe đưa đón, khách sạn, vé tham quan.', 'Chi phí cá nhân, đồ uống.', 'Mang theo giày thể thao để dễ di chuyển.', '2024-11-04 08:01:14.197000', '2024-11-04 08:01:14.197000'),
	(8, 8, 'vi', 'Tour Phú Quốc 5 ngày 4 đêm', 'Tham quan hòn đảo thiên đường với bãi biển đẹp và hải sản ngon.', 'Bãi Sao, Vinpearl Safari, Dinh Cậu.', 'Xe đưa đón, khách sạn, vé tham quan.', 'Chi phí cá nhân, đồ uống.', 'Mang theo đồ bơi và kính râm.', '2024-11-04 08:08:39.690000', '2024-11-04 08:08:39.690000'),
	(9, 9, 'vi', 'Tour Hà Giang 4 ngày 3 đêm', 'Khám phá vẻ đẹp hoang sơ và văn hóa độc đáo của vùng cao Hà Giang.', 'Cao nguyên đá Đồng Văn, đèo Mã Pì Lèng, chợ phiên Mèo Vạc.', 'Xe đưa đón, khách sạn, vé tham quan.', 'Chi phí cá nhân, đồ uống.', 'Mang theo quần áo ấm, giày đi bộ.', '2024-11-04 08:15:06.534000', '2024-11-04 08:15:06.534000'),
	(10, 10, 'vi', 'Tour Vũng Tàu 3 ngày 2 đêm', 'Khám phá vẻ đẹp biển xanh và bãi cát trắng của Vũng Tàu.', 'Bãi Sau, Núi Nhỏ, Đền Thích Ca Phật Đài, Hải Đăng Vũng Tàu.', 'Xe đưa đón, khách sạn, vé tham quan.', 'Chi phí cá nhân, đồ uống.', 'Mang theo đồ bơi và kem chống nắng.', '2024-11-04 08:21:45.383000', '2024-11-04 08:21:45.383000'),
	(11, 11, 'vi', 'Tour Paris 5 ngày 4 đêm', 'Khám phá kinh đô ánh sáng Paris.', 'Tháp Eiffel, bảo tàng Louvre, cung điện Versailles', 'Vé máy bay, khách sạn, vé tham quan', 'Chi phí cá nhân, đồ uống', 'Chuẩn bị trang phục phù hợp với thời tiết Paris.', '2024-11-04 08:30:00.544000', '2024-11-04 08:30:00.544000'),
	(12, 12, 'vi', 'Tour Singapore 4 ngày 3 đêm', 'Khám phá thành phố sư tử Singapore.', 'Marina Bay Sands, Sentosa, Gardens by the Bay', 'Vé máy bay, khách sạn, vé tham quan', 'Chi phí cá nhân, đồ uống', 'Chuẩn bị giấy tờ cần thiết khi đi Singapore.', '2024-11-04 08:57:18.072000', '2024-11-04 08:57:18.072000'),
	(13, 13, 'vi', 'Tour Bangkok 4 ngày 3 đêm', 'Khám phá Thủ đô Thái Lan năng động và sôi động.', 'Chùa Wat Arun, Cung điện Hoàng Gia, Khaosan Road', 'Vé máy bay, khách sạn, vé tham quan', 'Chi phí cá nhân, đồ uống', 'Chuẩn bị giấy tờ cần thiết khi đi Bangkok.', '2024-11-04 09:07:56.734000', '2024-11-04 09:07:56.734000'),
	(14, 14, 'vi', 'Tour Kuala Lumpur 4 ngày 3 đêm', 'Khám phá thủ đô Malaysia đầy sắc màu và văn hóa đa dạng.', 'Tháp đôi Petronas, Batu Caves, Bukit Bintang', 'Vé máy bay, khách sạn, vé tham quan', 'Chi phí cá nhân, đồ uống', 'Chuẩn bị giấy tờ cần thiết khi đi Kuala Lumpur.', '2024-11-04 09:16:40.301000', '2024-11-04 09:16:40.301000'),
	(15, 15, 'vi', 'Tour Tokyo 4 ngày 3 đêm', 'Khám phá thủ đô Nhật Bản với văn hóa và công nghệ hiện đại.', 'Tháp Tokyo, Asakusa, Akihabara', 'Vé máy bay, khách sạn, vé tham quan', 'Chi phí cá nhân, đồ uống', 'Chuẩn bị giấy tờ cần thiết khi đi Tokyo.', '2024-11-04 09:23:04.354000', '2024-11-04 09:23:04.354000'),
	(16, 16, 'vi', 'Tour Seoul 4 ngày 3 đêm', 'Khám phá thủ đô Hàn Quốc với văn hóa truyền thống và hiện đại.', 'Cung điện Gyeongbokgung, N Seoul Tower, Myeongdong', 'Vé máy bay, khách sạn, vé tham quan', 'Chi phí cá nhân, đồ uống', 'Chuẩn bị giấy tờ cần thiết khi đi Seoul.', '2024-11-04 09:35:17.537000', '2024-11-04 09:35:17.537000'),
	(17, 17, 'vi', 'Tour Thượng Hải 4 ngày 3 đêm', 'Khám phá thành phố Thượng Hải hiện đại và văn hóa đặc sắc.', 'Bến Thượng Hải, Vườn Yuyuan, Tháp truyền hình Đông Phương', 'Vé máy bay, khách sạn, vé tham quan', 'Chi phí cá nhân, đồ uống', 'Chuẩn bị giấy tờ cần thiết khi đi Thượng Hải.', '2024-11-04 09:44:15.480000', '2024-11-04 09:44:15.480000'),
	(18, 18, 'vi', 'Tour Dubai 5 ngày 4 đêm', 'Khám phá thành phố xa hoa và hiện đại của Dubai.', 'Burj Khalifa, Cung điện Al Fahidi, Thảo Cầm Viên Dubai', 'Vé máy bay, khách sạn, vé tham quan', 'Chi phí cá nhân, đồ uống', 'Mang theo giấy tờ cần thiết khi đi Dubai.', '2024-11-04 09:50:36.461000', '2024-11-04 09:50:36.461000'),
	(19, 19, 'vi', 'Tour Phuket 4 ngày 3 đêm', 'Khám phá hòn đảo thiên đường Phuket xinh đẹp.', 'Bãi biển Patong, Đảo Phi Phi, Chùa Wat Chalong', 'Vé máy bay, khách sạn, vé tham quan', 'Chi phí cá nhân, đồ uống', 'Mang theo đồ bơi và kem chống nắng.', '2024-11-04 09:58:28.530000', '2024-11-04 09:58:28.531000'),
	(20, 20, 'vi', 'Tour Tây Ban Nha 7 ngày 6 đêm', 'Khám phá vẻ đẹp và văn hóa của Tây Ban Nha.', 'Sagrada Familia, Alhambra, La Rambla', 'Vé máy bay, khách sạn, vé tham quan, bữa ăn', 'Chi phí cá nhân, đồ uống', 'Mang theo giày thoải mái để tham quan.', '2024-11-04 10:06:46.628000', '2024-11-04 10:06:46.628000'),
	(21, 21, 'vi', 'Tour Kết Hợp Paris - Đà Lạt 7 ngày 6 đêm', 'Hành trình khám phá Paris và Đà Lạt.', 'Tháp Eiffel, bảo tàng Louvre, cung điện Versailles, Đồi chè Cầu Đất', 'Vé máy bay, khách sạn, vé tham quan', 'Chi phí cá nhân, đồ uống', 'Chuẩn bị trang phục phù hợp cho cả Paris và Đà Lạt.', '2024-11-04 10:18:07.073000', '2024-11-04 10:18:07.073000'),
	(22, 22, 'vi', 'Tour Kết Hợp Singapore - Nha Trang 6 ngày 5 đêm', 'Hành trình khám phá thành phố hiện đại Singapore và bãi biển Nha Trang.', 'Gardens by the Bay, Marina Bay Sands, đảo Sentosa, Vinpearl Land Nha Trang', 'Vé máy bay, khách sạn, vé tham quan', 'Chi phí cá nhân, đồ uống', 'Chuẩn bị trang phục phù hợp cho thời tiết tại Singapore và Nha Trang.', '2024-11-04 10:37:33.956000', '2024-11-04 10:37:33.956000'),
	(23, 23, 'vi', 'Tour Kết Hợp Bangkok - Đà Nẵng 5 ngày 4 đêm', 'Khám phá thủ đô Bangkok náo nhiệt và thành phố biển Đà Nẵng.', 'Hoàng cung Thái Lan, chùa Phật Ngọc, Bà Nà Hills, Cầu Vàng', 'Vé máy bay, khách sạn, vé tham quan', 'Chi phí cá nhân, đồ uống', 'Chuẩn bị trang phục phù hợp cho thời tiết tại Bangkok và Đà Nẵng.', '2024-11-04 10:55:53.640000', '2024-11-04 10:55:53.640000'),
	(24, 24, 'vi', 'Tour Kết Hợp Tokyo - Hà Nội 8 ngày 7 đêm', 'Hành trình khám phá thủ đô Tokyo hiện đại và thủ đô Hà Nội cổ kính.', 'Tháp Tokyo Skytree, khu phố cổ Asakusa, Hồ Gươm, Lăng Chủ tịch', 'Vé máy bay, khách sạn, vé tham quan', 'Chi phí cá nhân, đồ uống', 'Chuẩn bị trang phục phù hợp cho thời tiết tại Tokyo và Hà Nội.', '2024-11-04 11:04:18.127000', '2024-11-04 11:04:18.127000'),
	(27, 26, 'vi', 'Tour Kết Hợp Kuala Lumpur - Phú Quốc 6 ngày 5 đêm', 'Khám phá thủ đô Kuala Lumpur hiện đại và hòn đảo ngọc Phú Quốc.', 'Tháp đôi Petronas, phố cổ Bukit Bintang, Vinpearl Safari Phú Quốc, bãi Sao', 'Vé máy bay, khách sạn, vé tham quan', 'Chi phí cá nhân, đồ uống', 'Chuẩn bị trang phục phù hợp cho thời tiết tại Kuala Lumpur và Phú Quốc.', '2024-11-04 11:17:33.637000', '2024-11-04 11:17:33.637000'),
	(28, 25, 'vi', 'Tour Kết Hợp Hồng Kông - Đà Lạt 7 ngày 6 đêm', 'Hành trình khám phá thành phố sầm uất Hồng Kông và cao nguyên thơ mộng Đà Lạt.', 'Đỉnh núi Thái Bình, Disneyland Hồng Kông, Hồ Xuân Hương, thung lũng Tình Yêu', 'Vé máy bay, khách sạn, vé tham quan', 'Chi phí cá nhân, đồ uống', 'Chuẩn bị trang phục phù hợp cho thời tiết tại Hồng Kông và Đà Lạt.', '2024-11-04 13:03:22.691000', '2024-11-04 13:03:22.691000'),
	(29, 27, 'vi', 'Tour Kết Hợp Seoul - Đà Lạt 7 ngày 6 đêm', 'Hành trình khám phá thủ đô Seoul hiện đại và cao nguyên Đà Lạt thơ mộng.', 'Lotte World, cung điện Gyeongbokgung, Đồi chè Cầu Đất, thác Pongour', 'Vé máy bay, khách sạn, vé tham quan', 'Chi phí cá nhân, đồ uống', 'Chuẩn bị trang phục phù hợp cho thời tiết tại Seoul và Đà Lạt.', '2024-11-04 13:54:48.790000', '2024-11-04 13:54:48.790000'),
	(30, 28, 'vi', 'Tour Kết Hợp New York - Cancun 10 ngày 9 đêm', 'Khám phá thành phố không ngủ New York và nghỉ dưỡng trên bãi biển Cancun.', 'Tượng Nữ thần Tự do, Central Park, bãi biển Cancun', 'Vé máy bay, khách sạn, vé tham quan', 'Chi phí cá nhân, đồ uống', 'Chuẩn bị trang phục phù hợp với thời tiết New York và Cancun.', '2024-11-04 14:01:52.407000', '2024-11-04 14:01:52.407000'),
	(31, 29, 'vi', 'Tour Kết Hợp Sydney - Melbourne 8 ngày 7 đêm', 'Tham quan các thành phố nổi tiếng nhất của Úc, từ Sydney đến Melbourne.', 'Nhà hát Opera Sydney, cầu cảng Sydney, Đại lộ Great Ocean Road', 'Vé máy bay, khách sạn, vé tham quan', 'Chi phí cá nhân, đồ uống', 'Chuẩn bị trang phục phù hợp với thời tiết Sydney và Melbourne.', '2024-11-04 14:08:29.653000', '2024-11-04 14:08:29.653000'),
	(32, 30, 'vi', 'Tour Kết Hợp Rome - Athens 9 ngày 8 đêm', 'Tham quan các di sản lịch sử của Rome và Athens.', 'Đấu trường Colosseum, Vatican, Đền Parthenon', 'Vé máy bay, khách sạn, vé tham quan', 'Chi phí cá nhân, đồ uống', 'Chuẩn bị trang phục phù hợp với thời tiết Rome và Athens.', '2024-11-04 14:14:49.428000', '2024-11-04 14:14:49.428000');

-- Dumping structure for table toursstores.tourtypes
CREATE TABLE IF NOT EXISTS `tourtypes` (
  `TourTypeId` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`TourTypeId`),
  UNIQUE KEY `IX_TourTypes_Name` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table toursstores.tourtypes: ~3 rows (approximately)
INSERT INTO `tourtypes` (`TourTypeId`, `Name`) VALUES
	(3, 'Kết Hợp'),
	(2, 'Ngoài Nước'),
	(1, 'Trong Nước');

-- Dumping structure for table toursstores.userclaims
CREATE TABLE IF NOT EXISTS `userclaims` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `UserId` varchar(255) NOT NULL,
  `ClaimType` longtext DEFAULT NULL,
  `ClaimValue` longtext DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_UserClaims_UserId` (`UserId`),
  CONSTRAINT `FK_UserClaims_Users_UserId` FOREIGN KEY (`UserId`) REFERENCES `users` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table toursstores.userclaims: ~0 rows (approximately)

-- Dumping structure for table toursstores.userlogins
CREATE TABLE IF NOT EXISTS `userlogins` (
  `LoginProvider` varchar(255) NOT NULL,
  `ProviderKey` varchar(255) NOT NULL,
  `ProviderDisplayName` longtext DEFAULT NULL,
  `UserId` varchar(255) NOT NULL,
  PRIMARY KEY (`LoginProvider`,`ProviderKey`),
  KEY `IX_UserLogins_UserId` (`UserId`),
  CONSTRAINT `FK_UserLogins_Users_UserId` FOREIGN KEY (`UserId`) REFERENCES `users` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table toursstores.userlogins: ~0 rows (approximately)

-- Dumping structure for table toursstores.userroles
CREATE TABLE IF NOT EXISTS `userroles` (
  `UserId` varchar(255) NOT NULL,
  `RoleId` varchar(255) NOT NULL,
  PRIMARY KEY (`UserId`,`RoleId`),
  KEY `IX_UserRoles_RoleId` (`RoleId`),
  CONSTRAINT `FK_UserRoles_Roles_RoleId` FOREIGN KEY (`RoleId`) REFERENCES `roles` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_UserRoles_Users_UserId` FOREIGN KEY (`UserId`) REFERENCES `users` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table toursstores.userroles: ~3 rows (approximately)
INSERT INTO `userroles` (`UserId`, `RoleId`) VALUES
	('bc91e04d-ecdf-42f7-8c70-161df9bae924', '398bda4e-ff62-40f9-832d-330840e6c63c'),
	('4a50f929-8b3d-4e09-85e6-25684606fcaf', '40591235-a4fa-4699-a095-6255d8e9cb49'),
	('150b8eb1-ccb3-46d9-ae35-1a3427fcd63e', '6f263eb1-54a1-4b33-b39d-f11b01f6937c');

-- Dumping structure for table toursstores.users
CREATE TABLE IF NOT EXISTS `users` (
  `Id` varchar(255) NOT NULL,
  `FirstName` longtext DEFAULT NULL,
  `LastName` longtext DEFAULT NULL,
  `PhoneNumber` longtext DEFAULT NULL,
  `Address` varchar(400) NOT NULL,
  `BirthDate` datetime(6) NOT NULL,
  `Gender` longtext NOT NULL,
  `CreatedAt` datetime(6) NOT NULL DEFAULT current_timestamp(6),
  `UserName` varchar(256) DEFAULT NULL,
  `NormalizedUserName` varchar(256) DEFAULT NULL,
  `Email` varchar(256) DEFAULT NULL,
  `NormalizedEmail` varchar(256) DEFAULT NULL,
  `EmailConfirmed` tinyint(1) NOT NULL,
  `PasswordHash` longtext DEFAULT NULL,
  `SecurityStamp` longtext DEFAULT NULL,
  `ConcurrencyStamp` longtext DEFAULT NULL,
  `PhoneNumberConfirmed` tinyint(1) NOT NULL,
  `TwoFactorEnabled` tinyint(1) NOT NULL,
  `LockoutEnd` datetime(6) DEFAULT NULL,
  `LockoutEnabled` tinyint(1) NOT NULL,
  `AccessFailedCount` int(11) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UserNameIndex` (`NormalizedUserName`),
  KEY `EmailIndex` (`NormalizedEmail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table toursstores.users: ~3 rows (approximately)
INSERT INTO `users` (`Id`, `FirstName`, `LastName`, `PhoneNumber`, `Address`, `BirthDate`, `Gender`, `CreatedAt`, `UserName`, `NormalizedUserName`, `Email`, `NormalizedEmail`, `EmailConfirmed`, `PasswordHash`, `SecurityStamp`, `ConcurrencyStamp`, `PhoneNumberConfirmed`, `TwoFactorEnabled`, `LockoutEnd`, `LockoutEnabled`, `AccessFailedCount`) VALUES
	('150b8eb1-ccb3-46d9-ae35-1a3427fcd63e', 'Admin', 'Ad', '0969724519', '2276 QL1A', '2000-11-20 00:00:00.000000', 'Nam', '2024-11-03 17:45:12.215300', 'admin@gmail.com', 'ADMIN@GMAIL.COM', 'admin@gmail.com', 'ADMIN@GMAIL.COM', 0, '$2a$12$Y0VhbV64eQPfeODluRAcqeaw6n7xhZNJ3vmEJ0mk5eVYn/5nWds3O', 'CWXRESFANAS2BNAP46PBY5FVMEZLF6BO', 'c9f33258-c569-4814-b227-0707f4914496', 0, 0, NULL, 1, 0),
	('4a50f929-8b3d-4e09-85e6-25684606fcaf', 'Manage', 'Ma', '0969724519', '1034 Tay ninh', '1995-10-24 00:00:00.000000', 'Nam', '2024-11-05 10:22:31.264766', 'manage@gmail.com', 'MANAGE@GMAIL.COM', 'manage@gmail.com', 'MANAGE@GMAIL.COM', 0, '$2a$11$0qcSXSpF3xzk.mGhlToHfuTCXlDxiSmo2iqn8/jykZNOh9Jd5Z48O', '4HDLFNLXV65SEM4M77UOJMZDDNTLKR2V', '06bf444e-8d08-4ba1-8ecb-4a98b197142b', 0, 0, NULL, 1, 0),
	('bc91e04d-ecdf-42f7-8c70-161df9bae924', 'Customer', 'Cus', '0969724519', '16 Cửu Long', '1995-10-28 00:00:00.000000', 'Nam', '2024-11-05 10:41:23.962235', 'customer@gmail.com', 'CUSTOMER@GMAIL.COM', 'customer@gmail.com', 'CUSTOMER@GMAIL.COM', 0, '$2a$12$fREnpC0Qc5F7fZV5sRaXbeIDrK0LOEHr8XYGa15aGJ8UE6yG97K9y', 'M54B6ET7MWEN7TSXYD26PUAXAC4YOIN4', 'df09f078-0f75-46e3-9d18-2680ab20d65f', 0, 0, NULL, 1, 0);

-- Dumping structure for table toursstores.usertokens
CREATE TABLE IF NOT EXISTS `usertokens` (
  `UserId` varchar(255) NOT NULL,
  `LoginProvider` varchar(255) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Value` longtext DEFAULT NULL,
  PRIMARY KEY (`UserId`,`LoginProvider`,`Name`),
  CONSTRAINT `FK_UserTokens_Users_UserId` FOREIGN KEY (`UserId`) REFERENCES `users` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table toursstores.usertokens: ~0 rows (approximately)

-- Dumping structure for table toursstores.__efmigrationshistory
CREATE TABLE IF NOT EXISTS `__efmigrationshistory` (
  `MigrationId` varchar(150) NOT NULL,
  `ProductVersion` varchar(32) NOT NULL,
  PRIMARY KEY (`MigrationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table toursstores.__efmigrationshistory: ~4 rows (approximately)
INSERT INTO `__efmigrationshistory` (`MigrationId`, `ProductVersion`) VALUES
	('20241029043718_DbTours', '8.0.8'),
	('20241120050654_HotelsTable', '8.0.8'),
	('20241120053001_LocationHotelsTable', '8.0.8'),
	('20241120053617_DataLocationHotelsTable', '8.0.8'),
	('20250104084357_UpdateTables', '8.0.8');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
