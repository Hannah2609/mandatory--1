-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Vært: mysql
-- Genereringstid: 17. 12 2024 kl. 19:45:36
-- Serverversion: 8.0.40
-- PHP-version: 8.2.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `company`
--

DELIMITER $$
--
-- Procedurer
--
CREATE DEFINER=`root`@`%` PROCEDURE `SoftDeleteUser` (IN `UserID` CHAR(36))   BEGIN
    UPDATE users
    SET user_deleted_at = UNIX_TIMESTAMP()
    WHERE user_pk = UserID;
END$$

CREATE DEFINER=`root`@`%` PROCEDURE `UpdateItemPrice` (IN `ItemId` BIGINT UNSIGNED, IN `NewItemPrice` DECIMAL(10,2))   BEGIN
    UPDATE items
    SET item_price = NewItemPrice
    WHERE item_pk = ItemId;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in-struktur for visning `customer_order_history_view`
-- (Se nedenfor for det aktuelle view)
--
CREATE TABLE `customer_order_history_view` (
`average_order_spent` decimal(9,6)
,`customer` varchar(20)
,`total_orders` bigint
,`total_spent` decimal(27,2)
);

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `deleted_users_log`
--

CREATE TABLE `deleted_users_log` (
  `log_id` bigint UNSIGNED NOT NULL,
  `user_pk` bigint UNSIGNED NOT NULL,
  `user_name` varchar(20) DEFAULT NULL,
  `user_last_name` varchar(20) DEFAULT NULL,
  `user_email` varchar(100) DEFAULT NULL,
  `deleted_at` int UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Data dump for tabellen `deleted_users_log`
--

INSERT INTO `deleted_users_log` (`log_id`, `user_pk`, `user_name`, `user_last_name`, `user_email`, `deleted_at`) VALUES
(1, 1, 'A', 'Aa', 'a@example.com', 1734427199);

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `items`
--

CREATE TABLE `items` (
  `item_pk` bigint UNSIGNED NOT NULL,
  `user_fk` bigint UNSIGNED NOT NULL,
  `item_title` varchar(50) NOT NULL,
  `item_price` decimal(5,2) NOT NULL,
  `item_image` varchar(50) DEFAULT NULL,
  `item_created_at` int UNSIGNED DEFAULT NULL,
  `item_deleted_at` int UNSIGNED DEFAULT NULL,
  `item_blocked_at` int UNSIGNED DEFAULT NULL,
  `item_updated_at` int UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Data dump for tabellen `items`
--

INSERT INTO `items` (`item_pk`, `user_fk`, `item_title`, `item_price`, `item_image`, `item_created_at`, `item_deleted_at`, `item_blocked_at`, `item_updated_at`) VALUES
(1, 4, 'Pizza', 12.99, 'dish_1.jpg', 1734426523, 0, 0, 0),
(2, 4, 'Burger', 30.00, 'dish_2.jpg', 1734426523, 0, 0, 0),
(3, 4, 'Sushi', 15.99, 'dish_3.jpg', 1734426523, 0, 0, 0),
(4, 4, 'Pasta', 11.99, 'dish_4.jpg', 1734426523, 0, 0, 0);

-- --------------------------------------------------------

--
-- Stand-in-struktur for visning `items_statistics_view`
-- (Se nedenfor for det aktuelle view)
--
CREATE TABLE `items_statistics_view` (
`item_price` decimal(5,2)
,`item_title` varchar(50)
,`times_ordered` bigint
);

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `orders`
--

CREATE TABLE `orders` (
  `order_pk` bigint UNSIGNED NOT NULL,
  `user_fk` bigint UNSIGNED NOT NULL,
  `delivery_address` varchar(255) NOT NULL,
  `restaurant_name` varchar(50) NOT NULL,
  `order_total_price` decimal(5,2) NOT NULL,
  `order_status` varchar(20) DEFAULT 'pending',
  `order_created_at` int UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Data dump for tabellen `orders`
--

INSERT INTO `orders` (`order_pk`, `user_fk`, `delivery_address`, `restaurant_name`, `order_total_price`, `order_status`, `order_created_at`) VALUES
(1, 2, 'Street 2, City B', 'Restaurant D', 32.00, 'delivered', 1734426523);

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `order_items`
--

CREATE TABLE `order_items` (
  `order_fk` bigint UNSIGNED NOT NULL,
  `item_fk` bigint UNSIGNED NOT NULL,
  `item_quantity` int NOT NULL,
  `item_price` decimal(5,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Data dump for tabellen `order_items`
--

INSERT INTO `order_items` (`order_fk`, `item_fk`, `item_quantity`, `item_price`) VALUES
(1, 1, 2, 12.99),
(1, 2, 1, 9.99);

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `phones`
--

CREATE TABLE `phones` (
  `user_fk` bigint UNSIGNED NOT NULL,
  `phone_number` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Data dump for tabellen `phones`
--

INSERT INTO `phones` (`user_fk`, `phone_number`) VALUES
(2, '+4523456789'),
(3, '+4534567890'),
(4, '+4545678901');

-- --------------------------------------------------------

--
-- Stand-in-struktur for visning `restaurant_menu_view`
-- (Se nedenfor for det aktuelle view)
--
CREATE TABLE `restaurant_menu_view` (
`item_price` decimal(5,2)
,`item_title` varchar(50)
,`restaurant_name` varchar(20)
,`times_ordered` bigint
);

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `roles`
--

CREATE TABLE `roles` (
  `role_pk` bigint UNSIGNED NOT NULL,
  `role_name` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Data dump for tabellen `roles`
--

INSERT INTO `roles` (`role_pk`, `role_name`) VALUES
(1, 'admin'),
(2, 'customer'),
(3, 'partner'),
(4, 'restaurant');

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `users`
--

CREATE TABLE `users` (
  `user_pk` bigint UNSIGNED NOT NULL,
  `user_name` varchar(20) NOT NULL,
  `user_last_name` varchar(20) NOT NULL,
  `user_email` varchar(100) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `user_created_at` int UNSIGNED DEFAULT NULL,
  `user_deleted_at` int UNSIGNED DEFAULT NULL,
  `user_blocked_at` int UNSIGNED DEFAULT NULL,
  `user_updated_at` int UNSIGNED DEFAULT NULL,
  `user_verified_at` int UNSIGNED DEFAULT NULL,
  `user_verification_key` char(36) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Data dump for tabellen `users`
--

INSERT INTO `users` (`user_pk`, `user_name`, `user_last_name`, `user_email`, `user_password`, `user_created_at`, `user_deleted_at`, `user_blocked_at`, `user_updated_at`, `user_verified_at`, `user_verification_key`) VALUES
(2, 'B', 'Bb', 'b@example.com', 'password2', 1734426523, 0, 0, 0, 1734426523, '83c39522-bc56-11ef-85f8-0242ac130004'),
(3, 'C', 'Cc', 'c@example.com', 'password3', 1734426523, 0, 0, 0, 1734426523, '83c39720-bc56-11ef-85f8-0242ac130004'),
(4, 'D', 'Dd', 'd@example.com', 'password4', 1734426523, 0, 0, 0, 1734426523, '83c397cc-bc56-11ef-85f8-0242ac130004');

--
-- Triggers/udløsere `users`
--
DELIMITER $$
CREATE TRIGGER `after_user_delete` AFTER DELETE ON `users` FOR EACH ROW INSERT INTO deleted_users_log (user_pk, user_name, user_last_name, user_email, deleted_at)
VALUES (OLD.user_pk, OLD.user_name, OLD.user_last_name, OLD.user_email, UNIX_TIMESTAMP())
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_user_update` BEFORE UPDATE ON `users` FOR EACH ROW SET NEW.user_updated_at = UNIX_TIMESTAMP()
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `users_addresses`
--

CREATE TABLE `users_addresses` (
  `user_fk` bigint UNSIGNED NOT NULL,
  `address_line` varchar(255) NOT NULL,
  `postal_code` varchar(20) NOT NULL,
  `primary_address` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Data dump for tabellen `users_addresses`
--

INSERT INTO `users_addresses` (`user_fk`, `address_line`, `postal_code`, `primary_address`) VALUES
(2, 'Street 2, City B', '2000', 1),
(3, 'Street 3, City C', '3000', 1),
(4, 'Street 4, City D', '4000', 1);

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `users_roles`
--

CREATE TABLE `users_roles` (
  `user_role_user_fk` bigint UNSIGNED NOT NULL,
  `user_role_role_fk` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Data dump for tabellen `users_roles`
--

INSERT INTO `users_roles` (`user_role_user_fk`, `user_role_role_fk`) VALUES
(2, 2),
(3, 3),
(4, 4);

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `users_vehicles`
--

CREATE TABLE `users_vehicles` (
  `user_fk` bigint UNSIGNED NOT NULL,
  `vehicle_fk` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Data dump for tabellen `users_vehicles`
--

INSERT INTO `users_vehicles` (`user_fk`, `vehicle_fk`) VALUES
(2, 2),
(3, 3),
(4, 1);

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `vehicles`
--

CREATE TABLE `vehicles` (
  `vehicle_pk` bigint UNSIGNED NOT NULL,
  `vehicle_name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Data dump for tabellen `vehicles`
--

INSERT INTO `vehicles` (`vehicle_pk`, `vehicle_name`) VALUES
(1, 'Bicycle'),
(3, 'Car'),
(2, 'Scooter');

-- --------------------------------------------------------

--
-- Struktur for visning `customer_order_history_view`
--
DROP TABLE IF EXISTS `customer_order_history_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `customer_order_history_view`  AS SELECT `u`.`user_name` AS `customer`, count(`o`.`order_pk`) AS `total_orders`, avg(`o`.`order_total_price`) AS `average_order_spent`, sum(`o`.`order_total_price`) AS `total_spent` FROM (((`users` `u` join `users_roles` `ur` on((`u`.`user_pk` = `ur`.`user_role_user_fk`))) join `roles` `r` on((`ur`.`user_role_role_fk` = `r`.`role_pk`))) left join `orders` `o` on((`u`.`user_pk` = `o`.`user_fk`))) WHERE (`r`.`role_name` = 'customer') GROUP BY `u`.`user_name` HAVING (`total_orders` > 0) ;

-- --------------------------------------------------------

--
-- Struktur for visning `items_statistics_view`
--
DROP TABLE IF EXISTS `items_statistics_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `items_statistics_view`  AS SELECT `i`.`item_title` AS `item_title`, `i`.`item_price` AS `item_price`, count(`oi`.`item_fk`) AS `times_ordered` FROM (`items` `i` left join `order_items` `oi` on((`i`.`item_pk` = `oi`.`item_fk`))) GROUP BY `i`.`item_title`, `i`.`item_price` ;

-- --------------------------------------------------------

--
-- Struktur for visning `restaurant_menu_view`
--
DROP TABLE IF EXISTS `restaurant_menu_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `restaurant_menu_view`  AS SELECT `u`.`user_name` AS `restaurant_name`, `i`.`item_title` AS `item_title`, `i`.`item_price` AS `item_price`, count(`oi`.`item_fk`) AS `times_ordered` FROM ((`users` `u` join `items` `i` on((`u`.`user_pk` = `i`.`user_fk`))) left join `order_items` `oi` on((`i`.`item_pk` = `oi`.`item_fk`))) GROUP BY `u`.`user_name`, `i`.`item_title`, `i`.`item_price` ;

--
-- Begrænsninger for dumpede tabeller
--

--
-- Indeks for tabel `deleted_users_log`
--
ALTER TABLE `deleted_users_log`
  ADD PRIMARY KEY (`log_id`),
  ADD UNIQUE KEY `log_id` (`log_id`);

--
-- Indeks for tabel `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`item_pk`),
  ADD UNIQUE KEY `item_pk` (`item_pk`),
  ADD KEY `user_fk` (`user_fk`),
  ADD KEY `idx_item_title` (`item_title`);

--
-- Indeks for tabel `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_pk`),
  ADD UNIQUE KEY `order_pk` (`order_pk`),
  ADD KEY `user_fk` (`user_fk`);

--
-- Indeks for tabel `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`order_fk`,`item_fk`),
  ADD KEY `item_fk` (`item_fk`);

--
-- Indeks for tabel `phones`
--
ALTER TABLE `phones`
  ADD PRIMARY KEY (`user_fk`,`phone_number`),
  ADD UNIQUE KEY `phone_number` (`phone_number`);

--
-- Indeks for tabel `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`role_pk`),
  ADD UNIQUE KEY `role_pk` (`role_pk`),
  ADD UNIQUE KEY `role_name` (`role_name`);

--
-- Indeks for tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_pk`),
  ADD UNIQUE KEY `user_pk` (`user_pk`),
  ADD UNIQUE KEY `user_email` (`user_email`);

--
-- Indeks for tabel `users_addresses`
--
ALTER TABLE `users_addresses`
  ADD PRIMARY KEY (`user_fk`,`address_line`,`postal_code`),
  ADD UNIQUE KEY `user_fk` (`user_fk`);

--
-- Indeks for tabel `users_roles`
--
ALTER TABLE `users_roles`
  ADD PRIMARY KEY (`user_role_user_fk`,`user_role_role_fk`),
  ADD KEY `user_role_role_fk` (`user_role_role_fk`);

--
-- Indeks for tabel `users_vehicles`
--
ALTER TABLE `users_vehicles`
  ADD PRIMARY KEY (`user_fk`,`vehicle_fk`),
  ADD UNIQUE KEY `user_fk` (`user_fk`),
  ADD KEY `vehicle_fk` (`vehicle_fk`);

--
-- Indeks for tabel `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`vehicle_pk`),
  ADD UNIQUE KEY `vehicle_pk` (`vehicle_pk`),
  ADD UNIQUE KEY `vehicle_name` (`vehicle_name`);

--
-- Brug ikke AUTO_INCREMENT for slettede tabeller
--

--
-- Tilføj AUTO_INCREMENT i tabel `deleted_users_log`
--
ALTER TABLE `deleted_users_log`
  MODIFY `log_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Tilføj AUTO_INCREMENT i tabel `items`
--
ALTER TABLE `items`
  MODIFY `item_pk` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Tilføj AUTO_INCREMENT i tabel `orders`
--
ALTER TABLE `orders`
  MODIFY `order_pk` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Tilføj AUTO_INCREMENT i tabel `roles`
--
ALTER TABLE `roles`
  MODIFY `role_pk` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Tilføj AUTO_INCREMENT i tabel `users`
--
ALTER TABLE `users`
  MODIFY `user_pk` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Tilføj AUTO_INCREMENT i tabel `users_addresses`
--
ALTER TABLE `users_addresses`
  MODIFY `user_fk` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Tilføj AUTO_INCREMENT i tabel `users_vehicles`
--
ALTER TABLE `users_vehicles`
  MODIFY `user_fk` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Tilføj AUTO_INCREMENT i tabel `vehicles`
--
ALTER TABLE `vehicles`
  MODIFY `vehicle_pk` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Begrænsninger for dumpede tabeller
--

--
-- Begrænsninger for tabel `items`
--
ALTER TABLE `items`
  ADD CONSTRAINT `items_ibfk_1` FOREIGN KEY (`user_fk`) REFERENCES `users` (`user_pk`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Begrænsninger for tabel `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_fk`) REFERENCES `users` (`user_pk`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Begrænsninger for tabel `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_fk`) REFERENCES `orders` (`order_pk`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`item_fk`) REFERENCES `items` (`item_pk`) ON DELETE RESTRICT;

--
-- Begrænsninger for tabel `phones`
--
ALTER TABLE `phones`
  ADD CONSTRAINT `phones_ibfk_1` FOREIGN KEY (`user_fk`) REFERENCES `users` (`user_pk`) ON DELETE CASCADE;

--
-- Begrænsninger for tabel `users_addresses`
--
ALTER TABLE `users_addresses`
  ADD CONSTRAINT `users_addresses_ibfk_1` FOREIGN KEY (`user_fk`) REFERENCES `users` (`user_pk`) ON DELETE CASCADE;

--
-- Begrænsninger for tabel `users_roles`
--
ALTER TABLE `users_roles`
  ADD CONSTRAINT `users_roles_ibfk_1` FOREIGN KEY (`user_role_user_fk`) REFERENCES `users` (`user_pk`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `users_roles_ibfk_2` FOREIGN KEY (`user_role_role_fk`) REFERENCES `roles` (`role_pk`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Begrænsninger for tabel `users_vehicles`
--
ALTER TABLE `users_vehicles`
  ADD CONSTRAINT `users_vehicles_ibfk_1` FOREIGN KEY (`user_fk`) REFERENCES `users` (`user_pk`) ON DELETE CASCADE,
  ADD CONSTRAINT `users_vehicles_ibfk_2` FOREIGN KEY (`vehicle_fk`) REFERENCES `vehicles` (`vehicle_pk`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
