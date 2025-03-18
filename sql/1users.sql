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
-- AUTO_INCREMENT för tabell `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
