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

--
-- Index för dumpade tabeller
--

--
-- Index för tabell `guests`
--
ALTER TABLE `guests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `room_id` (`room_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `addon_id` (`addon_id`);

--
-- AUTO_INCREMENT för dumpade tabeller
--

--
-- AUTO_INCREMENT för tabell `guests`
--
ALTER TABLE `guests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Restriktioner för dumpade tabeller
--

--
-- Restriktioner för tabell `guests`
--
ALTER TABLE `guests`
  ADD CONSTRAINT `guests_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `room_booking` (`id`),
  ADD CONSTRAINT `guests_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `guests_ibfk_3` FOREIGN KEY (`addon_id`) REFERENCES `booking_addons` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
