-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Värd: s687.loopia.se
-- Tid vid skapande: 21 mars 2025 kl 12:57
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

-- --------------------------------------------------------

--
-- Tabellstruktur `guests`
--

CREATE TABLE `guests` (
  `id` int(11) NOT NULL,
  `personnummer` varchar(100) NOT NULL,
  `first_name` varchar(200) NOT NULL,
  `last_name` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  `phone` varchar(200) NOT NULL,
  `street_address` varchar(200) NOT NULL,
  `post_address` varchar(200) NOT NULL,
  `spec_kost` varchar(200) DEFAULT NULL,
  `assistants` int(11) DEFAULT NULL,
  `aid` varchar(255) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `type_of_guest` varchar(200) DEFAULT NULL,
  `room_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `addon_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumpning av Data i tabell `guests`
--

INSERT INTO `guests` (`id`, `personnummer`, `first_name`, `last_name`, `email`, `phone`, `street_address`, `post_address`, `spec_kost`, `assistants`, `aid`, `notes`, `type_of_guest`, `room_id`, `user_id`, `addon_id`) VALUES
(5, '20040731-4525', 'Elina', 'Wimo Söderlund ', 'elinawimo@hotmail.com', '0891729172', 'Sickla Kanalgata 13A', '12067 Stockholm', 'Laktosintolerant', 1, 'Turner vid förflyttningar till säng och toalett', 'Tomt', 'Natt gäst', 2, 1, 1),
(6, '20080623-2518', 'Robin', 'Johnsen ', 'Kimjohnsen31@msn.com', '817287128126', 'G Övägen 7b', '60345 Norrköping', 'Glutenfritt, mixad mat', 2, 'Tomt', 'Tomt', 'Dag gäst', 3, 4, 2);

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

-- --------------------------------------------------------

--
-- Tabellstruktur `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `street_address` varchar(255) NOT NULL,
  `post_address` varchar(255) NOT NULL,
  `organization` varchar(100) DEFAULT NULL,
  `cardnummer` varchar(40) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumpning av Data i tabell `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `street_address`, `post_address`, `organization`, `cardnummer`, `created_at`, `updated_at`) VALUES
(1, 'Elina', 'Wimo Söderlund', 'elinawimo@hotmail.com', 'Telefon Nummer', 'Sickla Kanalgata 13A', '12067 Stockholm', 'NTI Södertorn', '6456456', '2025-03-14 10:51:42', '2025-03-14 11:10:23'),
(4, 'Robin ', 'Johnsen ', 'Kimjohnsen31@msn.com', '2365728356', 'G Övägen 7b', '60345 Norrköping', 'NTI Södertorn', '9728372764', '2025-03-14 11:11:48', '2025-03-14 11:11:48'),
(5, 'Annabel ', 'Muller', 'thomasfranzmuller@gmail.com', '232376274527', 'Solviksvägen 39', '13237 Saltsjö Boo', 'NTI Södertorn', '08483746353', '2025-03-14 11:13:05', '2025-03-14 11:13:05');

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
-- Index för tabell `booking_addons`
--
ALTER TABLE `booking_addons`
  ADD PRIMARY KEY (`id`),
  ADD KEY `booking_id` (`booking_id`),
  ADD KEY `room_id` (`room_id`);

--
-- Index för tabell `guests`
--
ALTER TABLE `guests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `room_id` (`room_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `addon_id` (`addon_id`);

--
-- Index för tabell `room_booking`
--
ALTER TABLE `room_booking`
  ADD PRIMARY KEY (`id`),
  ADD KEY `booking_id` (`booking_id`);

--
-- Index för tabell `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phone` (`phone`),
  ADD UNIQUE KEY `post_address` (`post_address`),
  ADD UNIQUE KEY `cardnummer` (`cardnummer`);

--
-- AUTO_INCREMENT för dumpade tabeller
--

--
-- AUTO_INCREMENT för tabell `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT för tabell `booking_addons`
--
ALTER TABLE `booking_addons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT för tabell `guests`
--
ALTER TABLE `guests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT för tabell `room_booking`
--
ALTER TABLE `room_booking`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT för tabell `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restriktioner för dumpade tabeller
--

--
-- Restriktioner för tabell `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Restriktioner för tabell `booking_addons`
--
ALTER TABLE `booking_addons`
  ADD CONSTRAINT `booking_addons_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`),
  ADD CONSTRAINT `booking_addons_ibfk_2` FOREIGN KEY (`room_id`) REFERENCES `room_booking` (`id`);

--
-- Restriktioner för tabell `guests`
--
ALTER TABLE `guests`
  ADD CONSTRAINT `guests_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `room_booking` (`id`),
  ADD CONSTRAINT `guests_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `guests_ibfk_3` FOREIGN KEY (`addon_id`) REFERENCES `booking_addons` (`id`);

--
-- Restriktioner för tabell `room_booking`
--
ALTER TABLE `room_booking`
  ADD CONSTRAINT `room_booking_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
