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
-- Tabellstruktur `room_booking`
--

CREATE TABLE `room_booking` (
  `id` int(11) NOT NULL,
  `booking_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `person_name` varchar(100) NOT NULL,
  `type` varchar(50) NOT NULL,
  `bed_configuration` varchar(100) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `aid` varchar(100) DEFAULT NULL,
  `check_in_date` date NOT NULL,
  `check_out_date` date NOT NULL,
  `capacity` int(11) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumpning av Data i tabell `room_booking`
--

INSERT INTO `room_booking` (`id`, `booking_id`, `name`, `person_name`, `type`, `bed_configuration`, `description`, `aid`, `check_in_date`, `check_out_date`, `capacity`, `price`, `created_at`, `updated_at`) VALUES
(2, 1, 'Stuga 1', 'Elina', 'Stuga', 'Three Queen beds', 'Fancy Suite next to the lake', 'Taklift', '2025-03-21', '2025-03-24', 3, 2000.00, '2025-03-17 11:36:13', '2025-03-17 11:36:13'),
(3, 1, 'Stuga 2', 'Robin', 'Stuga', '2 Queen Sized beds', 'Fancy Suite next to lake', 'Taklift', '2025-03-21', '2025-03-29', 2, 2005.00, '2025-03-17 11:38:43', '2025-03-17 11:38:43');

--
-- Index för dumpade tabeller
--

--
-- Index för tabell `room_booking`
--
ALTER TABLE `room_booking`
  ADD PRIMARY KEY (`id`),
  ADD KEY `booking_id` (`booking_id`);

--
-- AUTO_INCREMENT för dumpade tabeller
--

--
-- AUTO_INCREMENT för tabell `room_booking`
--
ALTER TABLE `room_booking`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restriktioner för dumpade tabeller
--

--
-- Restriktioner för tabell `room_booking`
--
ALTER TABLE `room_booking`
  ADD CONSTRAINT `room_booking_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
