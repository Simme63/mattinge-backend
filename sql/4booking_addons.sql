-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Värd: s687.loopia.se
-- Tid vid skapande: 17 mars 2025 kl 13:18
-- Serverversion: 10.11.9-MariaDB-log
-- PHP-version: 8.1.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Databas: `mattinge_se`
--

-- --------------------------------------------------------

--
-- Tabellstruktur `booking_addons`
--

CREATE TABLE `booking_addons` (
  `id` int(11) NOT NULL,
  `booking_id` int(11) NOT NULL,
  `room_id` int(11) DEFAULT NULL,
  `addon_type` varchar(50) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `price` decimal(10,2) NOT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumpning av Data i tabell `booking_addons`
--

INSERT INTO `booking_addons` (`id`, `booking_id`, `room_id`, `addon_type`, `quantity`, `price`, `start_time`, `end_time`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 'Bastu', 1, 800.00, '2025-03-21 12:38:48', '2025-03-21 14:38:48', '2025-03-17 11:39:40', '2025-03-17 11:39:40'),
(2, 1, 3, 'Pool', 1, 800.00, '2025-03-22 14:39:41', '2025-03-17 17:39:41', '2025-03-17 11:41:19', '2025-03-17 11:41:19');

--
-- Index för dumpade tabeller
--

--
-- Index för tabell `booking_addons`
--
ALTER TABLE `booking_addons`
  ADD PRIMARY KEY (`id`),
  ADD KEY `booking_id` (`booking_id`),
  ADD KEY `room_id` (`room_id`);

--
-- AUTO_INCREMENT för dumpade tabeller
--

--
-- AUTO_INCREMENT för tabell `booking_addons`
--
ALTER TABLE `booking_addons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restriktioner för dumpade tabeller
--

--
-- Restriktioner för tabell `booking_addons`
--
ALTER TABLE `booking_addons`
  ADD CONSTRAINT `booking_addons_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`),
  ADD CONSTRAINT `booking_addons_ibfk_2` FOREIGN KEY (`room_id`) REFERENCES `room_booking` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
