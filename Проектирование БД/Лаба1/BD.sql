-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: std-mysql
-- Время создания: Сен 11 2023 г., 19:18
-- Версия сервера: 5.7.26-0ubuntu0.16.04.1
-- Версия PHP: 8.1.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `std_2228_horse`
--

-- --------------------------------------------------------

--
-- Структура таблицы `Hippos`
--

CREATE TABLE `Hippos` (
  `id` int(11) NOT NULL,
  `name` varchar(150) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `Hippos`
--

INSERT INTO `Hippos` (`id`, `name`, `address`) VALUES
(1, 'Имя1', 'Адрес1'),
(2, 'Имя2', 'Адрес2'),
(3, 'Имя3', 'Адрес3'),
(4, 'Имя4', 'Адрес4'),
(5, 'Имя5', 'Адрес5');

-- --------------------------------------------------------

--
-- Структура таблицы `Horses`
--

CREATE TABLE `Horses` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `id_owner` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `Horses`
--

INSERT INTO `Horses` (`id`, `name`, `age`, `id_owner`) VALUES
(1, 'Василиск', 20, 1),
(2, 'Имя1', 15, 1),
(3, 'Имя2', 18, 3),
(4, 'Имя3', 25, 5),
(5, 'Имя4', 10, 4);

-- --------------------------------------------------------

--
-- Структура таблицы `Jokeys`
--

CREATE TABLE `Jokeys` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `Jokeys`
--

INSERT INTO `Jokeys` (`id`, `name`, `age`, `address`, `rating`) VALUES
(1, 'Имя1', 25, 'Адрес1', 5),
(2, 'Имя2', 24, 'Адрес2', 7),
(3, 'Имя3', 26, 'Адрес3', 3),
(4, 'Имя4', 27, 'Адрес4', 4),
(5, 'Имя5', 30, 'Адрес5', 1),
(6, 'Имя6', 23, 'Адрес6', 8);

-- --------------------------------------------------------

--
-- Структура таблицы `Owners`
--

CREATE TABLE `Owners` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `Owners`
--

INSERT INTO `Owners` (`id`, `name`, `phone`, `address`) VALUES
(1, 'Имя1', 'номер1', 'Адрес1'),
(2, 'Имя2', 'номер2', 'Адрес2'),
(3, 'Имя3', 'номер3', 'Адрес3'),
(4, 'Имя4', 'номер4', 'Адрес4'),
(5, 'Имя5', 'номер5', 'Адрес5');

-- --------------------------------------------------------

--
-- Структура таблицы `Races`
--

CREATE TABLE `Races` (
  `id` int(11) NOT NULL,
  `id_horse` int(11) DEFAULT NULL,
  `id_jokey` int(11) DEFAULT NULL,
  `id_rallys` int(11) DEFAULT NULL,
  `place` int(11) DEFAULT NULL,
  `time` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `Races`
--

INSERT INTO `Races` (`id`, `id_horse`, `id_jokey`, `id_rallys`, `place`, `time`) VALUES
(13, 2, 1, 1, 1, '00:05:30'),
(14, 3, 3, 1, 2, '00:05:45'),
(15, 2, 1, 1, 1, '00:04:30'),
(16, 3, 3, 1, 2, '00:04:50'),
(17, 4, 2, 2, 2, '00:04:30'),
(18, 5, 5, 2, 1, '00:04:50'),
(19, 4, 2, 2, 1, '00:04:29'),
(20, 5, 5, 2, 2, '00:04:31'),
(21, 2, 1, 3, 1, '00:05:30'),
(22, 5, 6, 3, 2, '00:05:50'),
(23, 2, 1, 3, 1, '00:04:50'),
(24, 5, 6, 3, 2, '00:05:00');

-- --------------------------------------------------------

--
-- Структура таблицы `Rallys`
--

CREATE TABLE `Rallys` (
  `id` int(11) NOT NULL,
  `date` varchar(50) DEFAULT NULL,
  `time` varchar(50) DEFAULT NULL,
  `id_hippo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `Rallys`
--

INSERT INTO `Rallys` (`id`, `date`, `time`, `id_hippo`) VALUES
(1, '15.07.2023', '17:40', 1),
(2, '16.07.2023', '17:40', 2),
(3, '17.07.2023', '17:40', 3),
(4, '14.07.2023', '17:25', 1);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `Hippos`
--
ALTER TABLE `Hippos`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `Horses`
--
ALTER TABLE `Horses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_owner` (`id_owner`);

--
-- Индексы таблицы `Jokeys`
--
ALTER TABLE `Jokeys`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `Owners`
--
ALTER TABLE `Owners`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `Races`
--
ALTER TABLE `Races`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_horse` (`id_horse`),
  ADD KEY `id_jokey` (`id_jokey`),
  ADD KEY `id_rallys` (`id_rallys`);

--
-- Индексы таблицы `Rallys`
--
ALTER TABLE `Rallys`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_hippo` (`id_hippo`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `Hippos`
--
ALTER TABLE `Hippos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `Horses`
--
ALTER TABLE `Horses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `Jokeys`
--
ALTER TABLE `Jokeys`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT для таблицы `Owners`
--
ALTER TABLE `Owners`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `Races`
--
ALTER TABLE `Races`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT для таблицы `Rallys`
--
ALTER TABLE `Rallys`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `Horses`
--
ALTER TABLE `Horses`
  ADD CONSTRAINT `Horses_ibfk_1` FOREIGN KEY (`id_owner`) REFERENCES `Owners` (`id`);

--
-- Ограничения внешнего ключа таблицы `Races`
--
ALTER TABLE `Races`
  ADD CONSTRAINT `Races_ibfk_4` FOREIGN KEY (`id_horse`) REFERENCES `Horses` (`id`),
  ADD CONSTRAINT `Races_ibfk_5` FOREIGN KEY (`id_jokey`) REFERENCES `Jokeys` (`id`),
  ADD CONSTRAINT `Races_ibfk_6` FOREIGN KEY (`id_rallys`) REFERENCES `Rallys` (`id`);

--
-- Ограничения внешнего ключа таблицы `Rallys`
--
ALTER TABLE `Rallys`
  ADD CONSTRAINT `Rallys_ibfk_1` FOREIGN KEY (`id_hippo`) REFERENCES `Hippos` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
