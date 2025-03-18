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
-- Tabellstruktur `bookings`
--

CREATE TABLE `bookings` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `booking_date` date NOT NULL,
  `check_in_date` date NOT NULL,
  `check_out_date` date NOT NULL,
  `booking_type` varchar(20) DEFAULT 'regular',
  `booking_name` varchar(200) DEFAULT NULL,
  `status` varchar(20) DEFAULT 'pending',
  `amount_of_guests` int(11) DEFAULT NULL,
  `total_price` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumpning av Data i tabell `bookings`
--

INSERT INTO `bookings` (`id`, `user_id`, `booking_date`, `check_in_date`, `check_out_date`, `booking_type`, `booking_name`, `status`, `amount_of_guests`, `total_price`, `created_at`, `updated_at`) VALUES
(1, 1, '2025-03-15', '2025-03-16', '2025-03-17', 'regular', 'Elina', 'pending', 1, 2000.00, '2025-03-14 11:54:12', '2025-03-14 11:54:12'),
(2, 4, '2025-03-20', '2025-03-24', '2025-03-25', 'regular', 'Robin', 'pending', 1, 2004.00, '2025-03-14 11:54:46', '2025-03-14 11:54:46'),
(3, 5, '2025-03-27', '2025-03-28', '2025-03-29', 'regular', 'Annabel', 'pending', 1, 2003.00, '2025-03-14 11:55:13', '2025-03-14 11:55:13'),
(4, 5, '2025-03-16', '2025-04-07', '2025-04-10', 'regular', 'Annabel', 'pending', 1, 2004.00, '2025-03-17 11:52:58', '2025-03-17 11:52:58');

--
-- Index för dumpade tabeller
--

--
-- Index för tabell `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT för dumpade tabeller
--

--
-- AUTO_INCREMENT för tabell `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restriktioner för dumpade tabeller
--

--
-- Restriktioner för tabell `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
