-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 21 Apr 2015 la 21:57
-- Versiune server: 5.6.21
-- PHP Version: 5.6.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `k9_test`
--

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `boarding_payments`
--

CREATE TABLE IF NOT EXISTS `boarding_payments` (
`id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `pet_id` int(11) NOT NULL,
  `r_boarding_id` int(11) NOT NULL,
  `payment_status_id` int(11) NOT NULL,
  `payment_type_id` int(11) NOT NULL,
  `required` float NOT NULL,
  `paid` float NOT NULL,
  `change` float NOT NULL,
  `unpaid` float NOT NULL,
  `information` text NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_modified` datetime NOT NULL,
  `created_user_id` int(11) NOT NULL,
  `modified_user_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `boarding_payments`
--

INSERT INTO `boarding_payments` (`id`, `client_id`, `pet_id`, `r_boarding_id`, `payment_status_id`, `payment_type_id`, `required`, `paid`, `change`, `unpaid`, `information`, `date_created`, `date_modified`, `created_user_id`, `modified_user_id`) VALUES
(1, 1, 2, 10, 1, 1, 12.1, 20, 7.9, 0, '{"id":10,"status_id":1,"client_id":1,"pet_id":2,"stay_reason_id":1,"luggage":"","deposit":0,"did_deposit":0,"charge_type":"charge_by_petsize","charge_type_id":4,"is_handle_carefully":0,"is_extra_pet":1,"in_out":"out","date_in":"2015-04-16","time_in":"14:03:55","date_out":"2015-04-16","time_out":null,"date_checkout":null,"time_checkout":null,"$$hashKey":"06B"}', '2015-04-16 12:51:32', '2015-04-16 17:23:20', 1, 1),
(2, 1, 2, 11, 1, 1, 12.1, 13, 0.9, 0, '{"in_out":"out","pet_id":2,"client_id":1,"charge_type":"charge_by_petsize","deposit":0,"date_in":"2015-04-16","time_in":"17:30:37","date_out":"2015-04-16","records_boarding":{"id":3,"status_id":1,"client_id":1,"pet_id":2,"charge_type":"charge_by_runtype","charge_type_id":4,"is_handle_carefully":0,"is_extra_pet":1,"stay_reason_id":1},"charge_type_id":4,"stay_reason_id":1,"is_extra_pet":1,"is_handle_carefully":0,"id":11,"$$hashKey":"07D"}', '2015-04-16 14:30:49', '2015-04-16 17:30:49', 1, 1),
(3, 1, 2, 1, 1, 1, 12.1, 20, 7.9, 0, '{"in_out":"in","pet_id":2,"client_id":1,"charge_type":"charge_by_petsize","deposit":0,"date_in":"2015-04-16","time_in":"17:49:08","date_out":"2015-04-16","records_boarding":{"id":3,"status_id":1,"client_id":1,"pet_id":2,"charge_type":"charge_by_runtype","charge_type_id":4,"is_handle_carefully":0,"is_extra_pet":1,"stay_reason_id":1},"charge_type_id":4,"stay_reason_id":1,"is_extra_pet":1,"is_handle_carefully":0,"id":1,"$$hashKey":"074"}', '2015-04-16 14:49:21', '2015-04-16 17:50:30', 1, 1),
(4, 1, 2, 1, 1, 1, 15.2, 50, 34.8, 0, '{"in_out":"in","pet_id":2,"client_id":1,"charge_type":"charge_by_petsize","deposit":0,"date_in":"2015-04-16","time_in":"15:44","date_out":"2015-04-16","records_boarding":{"id":3,"status_id":1,"client_id":1,"pet_id":2,"charge_type":"charge_by_runtype","charge_type_id":4,"is_handle_carefully":0,"is_extra_pet":1,"stay_reason_id":1},"charge_type_id":4,"stay_reason_id":1,"is_extra_pet":1,"is_handle_carefully":0,"time_out":"15:45","id":1,"$$hashKey":"074"}', '2015-04-16 18:45:12', '2015-04-16 21:45:12', 1, 1),
(5, 1, 2, 4, 1, 1, 12.1, 50, 37.9, 0, '{"id":4,"status_id":1,"client_id":1,"pet_id":2,"stay_reason_id":3,"luggage":"asdad","deposit":0,"did_deposit":0,"charge_type":"charge_by_petsize","charge_type_id":3,"is_handle_carefully":1,"is_extra_pet":0,"in_out":"out","is_halfday":2,"date_in":"2015-04-21","time_in":"11:54:53","date_out":"2015-04-21","time_out":"11:54:53","date_checkout":null,"time_checkout":null,"$$hashKey":"06W"}', '2015-04-21 09:01:58', '2015-04-21 12:01:58', 1, 1);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `boarding_petsizes`
--

CREATE TABLE IF NOT EXISTS `boarding_petsizes` (
`id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `v` varchar(255) NOT NULL,
  `limits` int(11) NOT NULL DEFAULT '0',
  `full_day` float NOT NULL DEFAULT '0',
  `half_day` float NOT NULL DEFAULT '0',
  `from_weight` float NOT NULL DEFAULT '0',
  `to_weight` float NOT NULL DEFAULT '0',
  `override` tinyint(4) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `boarding_petsizes`
--

INSERT INTO `boarding_petsizes` (`id`, `status_id`, `v`, `limits`, `full_day`, `half_day`, `from_weight`, `to_weight`, `override`) VALUES
(1, 1, 'Miniature', 10, 15.2, 12.1, 0, 0, 0),
(2, 1, 'Small', 10, 15.2, 12.1, 0, 0, 0),
(3, 1, 'Medium', 10, 15.2, 12.1, 0, 0, 0),
(4, 1, 'Big', 10, 15.2, 12.1, 0, 0, 0),
(5, 1, 'Large', 10, 15.2, 12.1, 0, 0, 0),
(6, 1, 'Extraordinary', 10, 15.2, 12.1, 0, 0, 0),
(7, 2, 'Superb', 10, 15.2, 12.1, 0, 0, 0);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `boarding_runtypes`
--

CREATE TABLE IF NOT EXISTS `boarding_runtypes` (
`id` int(11) NOT NULL,
  `status_id` tinyint(4) NOT NULL DEFAULT '1',
  `v` varchar(255) NOT NULL,
  `limits` int(11) NOT NULL DEFAULT '0',
  `full_day` float NOT NULL DEFAULT '0',
  `half_day` float NOT NULL DEFAULT '0',
  `override` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `boarding_runtypes`
--

INSERT INTO `boarding_runtypes` (`id`, `status_id`, `v`, `limits`, `full_day`, `half_day`, `override`) VALUES
(1, 2, 'No Charge', 5, 20.5, 13.2, 0),
(2, 1, 'VIP', 10, 20.5, 13.2, 0),
(3, 1, 'Special runtype', 16, 20.5, 13.2, 0),
(4, 1, 'Special offer', 12, 20.5, 13.2, 0),
(5, 3, '', 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `boarding_settings`
--

CREATE TABLE IF NOT EXISTS `boarding_settings` (
`id` int(11) NOT NULL,
  `n` varchar(255) NOT NULL,
  `v` text NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `boarding_settings`
--

INSERT INTO `boarding_settings` (`id`, `n`, `v`) VALUES
(1, 'charge_type_id', '2'),
(2, 'stay_reason_id', '2'),
(3, 'is_handle_carefully', ''),
(4, 'is_extra_pet', '0'),
(5, 'commissions_new_customers_board', '0'),
(6, 'check_out_time', '18:00'),
(7, 'check_in_time', '10:00'),
(8, 'charge_hour_after_checkout_fee', '50'),
(9, 'charge_after_checkout_option', 'charge_no_hours_for_half_day'),
(10, 'charge_aditional_for_holidays_fee', '20'),
(11, 'charge_half_day_checkout_fee', '15'),
(12, 'available_for_saturdays', '1'),
(13, 'available_for_sundays', '1'),
(14, 'half_day_from', '10:00'),
(15, 'half_day_to', '14:00'),
(16, 'full_day_from', '10:00'),
(17, 'full_half_day_to', '16:00'),
(18, 'charge_type', 'charge_by_runtype'),
(19, 'charge_meds_diets', 'charge_by_administration'),
(20, 'charge_fee_per_diets_diet', '20'),
(21, 'charge_amount_per_hour_v', '12.52'),
(22, 'charge_no_hours_for_half_day_v', '2'),
(23, 'charge_aditional_amount_for_holidays', '25.2'),
(24, 'available_for_holidays', '0'),
(25, 'full_day_to', '17:00');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `clients`
--

CREATE TABLE IF NOT EXISTS `clients` (
`id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `client_status_id` int(11) NOT NULL DEFAULT '1',
  `image_id` int(11) DEFAULT NULL,
  `first_name` varchar(120) DEFAULT NULL,
  `last_name` varchar(120) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `contact_phone` varchar(120) DEFAULT NULL,
  `contact_work_phone` varchar(120) NOT NULL,
  `contact_cell` varchar(120) DEFAULT NULL,
  `emergency_name` varchar(120) DEFAULT NULL,
  `emergency_phone` varchar(120) DEFAULT NULL,
  `preffered_phone_id` int(11) NOT NULL,
  `address_street` varchar(255) DEFAULT NULL,
  `address_city` varchar(120) DEFAULT NULL,
  `address_state` varchar(120) DEFAULT NULL,
  `address_zip` varchar(120) DEFAULT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `clients`
--

INSERT INTO `clients` (`id`, `status_id`, `client_status_id`, `image_id`, `first_name`, `last_name`, `email`, `contact_phone`, `contact_work_phone`, `contact_cell`, `emergency_name`, `emergency_phone`, `preffered_phone_id`, `address_street`, `address_city`, `address_state`, `address_zip`, `date_created`) VALUES
(1, 1, 2, NULL, 'Todorescu', 'Tudor', NULL, '(123) 456-7890', '', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, '2015-03-18 10:59:20'),
(2, 1, 1, NULL, 'Testul', 'Cel Frumos', 'testing@testin.com', '(123) 456-7890', '', NULL, NULL, NULL, 0, 'East American Avenue', 'Sanger', 'CA', '123748', '2015-03-18 10:59:20'),
(3, 3, 1, NULL, 'Test', 'Test', NULL, '(123) 456-7890', '', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, '2015-04-08 11:58:46');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `clients_membership`
--

CREATE TABLE IF NOT EXISTS `clients_membership` (
`id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `membership` varchar(255) NOT NULL,
  `valability` date NOT NULL,
  `print_photo_client` tinyint(4) NOT NULL DEFAULT '0',
  `print_photo_pet` tinyint(4) NOT NULL DEFAULT '0',
  `add_pet_name` tinyint(4) NOT NULL DEFAULT '0',
  `barcode` varchar(255) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `clients_membership`
--

INSERT INTO `clients_membership` (`id`, `client_id`, `membership`, `valability`, `print_photo_client`, `print_photo_pet`, `add_pet_name`, `barcode`) VALUES
(1, 2, '', '2016-03-18', 0, 0, 0, '6642966044');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `clients_private`
--

CREATE TABLE IF NOT EXISTS `clients_private` (
`id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `drivers_license` varchar(255) NOT NULL,
  `dob` date NOT NULL,
  `is_senior` varchar(255) NOT NULL DEFAULT '0',
  `is_military` varchar(255) NOT NULL DEFAULT '0',
  `is_tax_exempt` varchar(255) NOT NULL DEFAULT '0',
  `exclude_from_mailing_list` varchar(255) NOT NULL DEFAULT '0',
  `default_retail_level_id` int(11) NOT NULL,
  `cc_holder_name` varchar(255) NOT NULL,
  `cc_number` varchar(255) NOT NULL,
  `cc_type_id` int(11) NOT NULL,
  `cc_exp_month_id` int(11) NOT NULL,
  `cc_exp_year` varchar(255) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `clients_private`
--

INSERT INTO `clients_private` (`id`, `client_id`, `drivers_license`, `dob`, `is_senior`, `is_military`, `is_tax_exempt`, `exclude_from_mailing_list`, `default_retail_level_id`, `cc_holder_name`, `cc_number`, `cc_type_id`, `cc_exp_month_id`, `cc_exp_year`) VALUES
(1, 1, '', '1979-03-15', '1', '1', '0', '0', 3, 'Todorescu Todorescu', '5.6498798798799E+15', 1, 3, '2016');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `clients_rewards`
--

CREATE TABLE IF NOT EXISTS `clients_rewards` (
`id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `points` float NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `clients_rewards`
--

INSERT INTO `clients_rewards` (`id`, `client_id`, `points`) VALUES
(6, 1, 9.6);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `clients_survey`
--

CREATE TABLE IF NOT EXISTS `clients_survey` (
`id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `client_id` int(11) DEFAULT NULL,
  `reffered_id` int(11) DEFAULT NULL,
  `client_survey_income_id` int(11) DEFAULT NULL,
  `client_survey_findout_id` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `clients_survey`
--

INSERT INTO `clients_survey` (`id`, `status_id`, `client_id`, `reffered_id`, `client_survey_income_id`, `client_survey_findout_id`) VALUES
(1, 1, 1, 1, 2, 5);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `client_status`
--

CREATE TABLE IF NOT EXISTS `client_status` (
`id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `v` tinytext NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `client_status`
--

INSERT INTO `client_status` (`id`, `status_id`, `v`) VALUES
(1, 1, 'New'),
(2, 1, 'Refuse'),
(3, 1, 'VIP'),
(4, 1, 'No show'),
(5, 1, 'Low'),
(6, 1, 'Mid'),
(7, 1, 'High');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `client_survey_findout`
--

CREATE TABLE IF NOT EXISTS `client_survey_findout` (
`id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `is_refferal` int(11) NOT NULL DEFAULT '0',
  `refferal_table` varchar(255) NOT NULL,
  `v` varchar(255) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `client_survey_findout`
--

INSERT INTO `client_survey_findout` (`id`, `status_id`, `is_refferal`, `refferal_table`, `v`) VALUES
(1, 1, 0, '', 'Animal Clinic'),
(2, 1, 0, '', 'Coupon Book'),
(3, 1, 0, '', 'Drive by'),
(4, 1, 0, '', 'Flyer'),
(5, 1, 1, 'clients', 'Friend referral'),
(6, 1, 0, '', 'Internet search'),
(7, 1, 0, '', 'Mascott dog on 41'),
(8, 1, 0, '', 'Newspaper'),
(9, 1, 0, '', 'No answer given'),
(10, 1, 0, '', 'Other'),
(11, 1, 0, '', 'Party in the park'),
(12, 1, 0, '', 'Radio'),
(13, 1, 0, '', 'Rescue event'),
(14, 1, 1, 'vets', 'Veterinarian'),
(15, 1, 0, '', 'Yellow Pages');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `client_survey_income`
--

CREATE TABLE IF NOT EXISTS `client_survey_income` (
`id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `v` varchar(255) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `client_survey_income`
--

INSERT INTO `client_survey_income` (`id`, `status_id`, `v`) VALUES
(1, 1, '$250,000 and higher'),
(2, 1, '$150,000 to $250,000'),
(3, 1, '$100,000 to $150,000'),
(4, 1, '$75,000 to $100,000'),
(5, 1, '$60,000 to $75,000'),
(6, 1, '$45,000 to $60,000'),
(7, 1, '$30,000 to $45,000'),
(8, 1, 'Less than $30,000');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `cp`
--

CREATE TABLE IF NOT EXISTS `cp` (
`id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `pet_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `cp`
--

INSERT INTO `cp` (`id`, `client_id`, `pet_id`) VALUES
(1, 1, 1),
(3, 2, 3),
(4, 1, 2),
(5, 3, 4);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `daycare_groups`
--

CREATE TABLE IF NOT EXISTS `daycare_groups` (
`id` int(11) NOT NULL,
  `status_id` tinyint(4) NOT NULL DEFAULT '1',
  `v` varchar(25) NOT NULL,
  `limits` int(11) NOT NULL,
  `full_day` float NOT NULL,
  `half_day` float NOT NULL,
  `override` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `daycare_groups`
--

INSERT INTO `daycare_groups` (`id`, `status_id`, `v`, `limits`, `full_day`, `half_day`, `override`) VALUES
(1, 1, 'Daycare group', 10, 25, 15, 0),
(2, 1, 'None', 7, 20, 12, 1);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `daycare_settings`
--

CREATE TABLE IF NOT EXISTS `daycare_settings` (
`id` int(11) NOT NULL,
  `n` varchar(255) NOT NULL,
  `v` text NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `daycare_settings`
--

INSERT INTO `daycare_settings` (`id`, `n`, `v`) VALUES
(1, 'halfday_rate_type', 'before_hour'),
(2, 'before_hour_value', '08:55'),
(3, 'less_than_nr_hours_value', '2'),
(4, 'fast_checkin', '1'),
(5, 'default_to_charge_per_hour', '0'),
(6, 'hours_rounding', '3'),
(7, 'over_1_day_penalty', '20'),
(8, 'default_daycare_group', '2'),
(9, 'r_halfday_rate_type', 'less_than_nr_hours'),
(10, 'rvt_before_hour', '12:00'),
(11, 'rvs_less_than_nr_hours', '4'),
(12, 'c_fast_checkin', '1'),
(13, 'c_default_to_charge_per_hour', '1'),
(14, 'sh_hours_rounding', '3'),
(15, 't_over_1_day_penalty', '25'),
(17, 'sh_check_groups_limit', '1'),
(18, 'c_print_collar_automatically', '1'),
(19, 'se_prefered_group', '1');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `deposits`
--

CREATE TABLE IF NOT EXISTS `deposits` (
`id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `plus_minus` varchar(255) NOT NULL,
  `payment_type_id` int(11) NOT NULL,
  `payment_amount` float NOT NULL,
  `is_a_tip` tinyint(255) NOT NULL DEFAULT '0',
  `tip_user_id` int(11) NOT NULL,
  `language` varchar(255) NOT NULL,
  `print_type` varchar(255) NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_user_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `deposits`
--

INSERT INTO `deposits` (`id`, `client_id`, `plus_minus`, `payment_type_id`, `payment_amount`, `is_a_tip`, `tip_user_id`, `language`, `print_type`, `date_created`, `created_user_id`) VALUES
(1, 1, 'plus', 1, 12, 0, 0, 'en', 'screen', '2015-03-24 11:22:53', 1),
(2, 1, 'plus', 1, 500, 0, 0, 'en', 'screen', '2015-04-16 14:31:26', 1);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `diets`
--

CREATE TABLE IF NOT EXISTS `diets` (
`id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `v` varchar(255) NOT NULL,
  `price` float NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `diets`
--

INSERT INTO `diets` (`id`, `status_id`, `v`, `price`) VALUES
(1, 1, 'Allpo canned', 10),
(2, 1, 'Allpo dry', 10),
(3, 1, 'Beneful dry', 10),
(4, 1, 'bil-jac dry', 10),
(5, 1, 'bil-jac frozen', 10),
(6, 3, 'asdas', 12);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `diets_type`
--

CREATE TABLE IF NOT EXISTS `diets_type` (
`id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `v` varchar(255) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `diets_type`
--

INSERT INTO `diets_type` (`id`, `status_id`, `v`) VALUES
(1, 1, 'liquid'),
(2, 1, 'solid'),
(3, 1, 'can'),
(4, 1, 'own food'),
(5, 1, 'dry');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `discounts_boarding_long_term`
--

CREATE TABLE IF NOT EXISTS `discounts_boarding_long_term` (
  `id` int(11) NOT NULL,
  `nr_days` int(11) NOT NULL,
  `modifier_id` int(11) NOT NULL,
  `amount` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `discounts_boarding_long_term`
--

INSERT INTO `discounts_boarding_long_term` (`id`, `nr_days`, `modifier_id`, `amount`) VALUES
(1, 30, 1, 0),
(2, 45, 1, 0);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `discounts_boarding_multiple_pet`
--

CREATE TABLE IF NOT EXISTS `discounts_boarding_multiple_pet` (
  `id` int(11) NOT NULL,
  `boarding_runtype_id` int(11) NOT NULL,
  `is_percentage` tinyint(4) NOT NULL DEFAULT '0',
  `1_pet_discount` float NOT NULL,
  `2_pet_discount` float NOT NULL,
  `3_pet_discount` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `discounts_boarding_multiple_pet`
--

INSERT INTO `discounts_boarding_multiple_pet` (`id`, `boarding_runtype_id`, `is_percentage`, `1_pet_discount`, `2_pet_discount`, `3_pet_discount`) VALUES
(1, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `discounts_boarding_new_client`
--

CREATE TABLE IF NOT EXISTS `discounts_boarding_new_client` (
  `id` int(11) NOT NULL,
  `modifier_id` tinyint(4) NOT NULL DEFAULT '1',
  `amount` float NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `discounts_boarding_new_client`
--

INSERT INTO `discounts_boarding_new_client` (`id`, `modifier_id`, `amount`) VALUES
(1, 1, 0);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `discounts_boarding_priority_club`
--

CREATE TABLE IF NOT EXISTS `discounts_boarding_priority_club` (
  `id` int(11) NOT NULL,
  `in_use` int(11) NOT NULL DEFAULT '0',
  `nr_visits` int(11) NOT NULL,
  `discount_amount` float NOT NULL,
  `v` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `discounts_boarding_priority_club`
--

INSERT INTO `discounts_boarding_priority_club` (`id`, `in_use`, `nr_visits`, `discount_amount`, `v`) VALUES
(1, 0, 10, 1, 'Priority club'),
(2, 0, 20, 2, 'Priority club VIP'),
(3, 0, 30, 2, 'Great customer'),
(4, 0, 40, 2, 'VIP Customer');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `files`
--

CREATE TABLE IF NOT EXISTS `files` (
`id` int(11) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `path_thumb` varchar(255) DEFAULT NULL,
  `source` blob,
  `source_thumb` blob,
  `width` int(11) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `width_thumb` int(11) DEFAULT NULL,
  `height_thumb` int(11) DEFAULT NULL,
  `mime_type` varchar(255) DEFAULT NULL,
  `file_type` enum('static','facebook') NOT NULL DEFAULT 'static',
  `delete_code` varchar(255) DEFAULT NULL,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `files`
--

INSERT INTO `files` (`id`, `path`, `path_thumb`, `source`, `source_thumb`, `width`, `height`, `width_thumb`, `height_thumb`, `mime_type`, `file_type`, `delete_code`, `status_id`, `date_created`) VALUES
(1, 'files/images/547615fb69b45.jpg', 'files/images/547615fb69b45_thumb.jpg', NULL, NULL, 189, 48, 984, 250, 'image/jpeg', 'static', NULL, 1, '2014-11-26 18:03:39'),
(2, 'files/images/547e4aab31c44.jpg', 'files/images/547e4aab31c44_thumb.jpg', NULL, NULL, 189, 48, 984, 250, 'image/jpeg', 'static', NULL, 1, '2014-12-02 23:26:35'),
(3, 'files/images/547f967ecd127.jpg', 'files/images/547f967ecd127_thumb.jpg', NULL, NULL, 600, 4800, 300, 2400, 'image/jpeg', 'static', NULL, 1, '2014-12-03 23:02:22'),
(4, 'files/images/548af4b41b4a0.jpg', 'files/images/548af4b41b4a0_thumb.jpg', NULL, NULL, 637, 960, 300, 452, 'image/jpeg', 'static', NULL, 1, '2014-12-12 13:59:16'),
(5, 'files/images/54bbdb457d485.jpg', 'files/images/54bbdb457d485_thumb.jpg', NULL, NULL, 300, 168, 400, 224, 'image/jpeg', 'static', NULL, 3, '2015-01-18 16:11:49'),
(6, 'files/images/54bbdb9ab8812.jpg', 'files/images/54bbdb9ab8812_thumb.jpg', NULL, NULL, 300, 168, 400, 224, 'image/jpeg', 'static', NULL, 1, '2015-01-18 16:13:14'),
(7, 'files/images/54bbdbe8069d8.jpg', 'files/images/54bbdbe8069d8_thumb.jpg', NULL, NULL, 300, 168, 446, 250, 'image/jpeg', 'static', NULL, 1, '2015-01-18 16:14:32'),
(8, 'files/images/54d36e333e6ec.jpg', 'files/images/54d36e333e6ec_thumb.jpg', NULL, NULL, 405, 338, 300, 250, 'image/jpeg', 'static', NULL, 3, '2015-02-05 13:20:51'),
(9, 'files/images/54dceda7dcb46.png', 'files/images/54dceda7dcb46_thumb.png', NULL, NULL, 400, 70, 400, 70, 'image/png', 'static', NULL, 1, '2015-02-12 18:15:03'),
(10, 'files/images/54dcf3d57e7ab.png', 'files/images/54dcf3d57e7ab_thumb.png', NULL, NULL, 400, 70, 400, 70, 'image/png', 'static', NULL, 1, '2015-02-12 18:41:25'),
(11, 'files/images/54e6575cb4d85.png', 'files/images/54e6575cb4d85_thumb.png', NULL, NULL, 276, 453, 200, 328, 'image/png', 'static', NULL, 3, '2015-02-19 21:36:28'),
(12, 'files/images/550880913d54c.png', 'files/images/550880913d54c_thumb.png', NULL, NULL, 276, 453, 200, 328, 'image/png', 'static', NULL, 1, '2015-03-17 19:29:21'),
(13, 'files/images/55088e5e1b2cc.png', 'files/images/55088e5e1b2cc_thumb.png', NULL, NULL, 276, 453, 200, 328, 'image/png', 'static', NULL, 3, '2015-03-17 20:28:14'),
(14, 'files/images/55088fc814398.jpg', 'files/images/55088fc814398_thumb.jpg', NULL, NULL, 500, 375, 200, 150, 'image/jpeg', 'static', NULL, 1, '2015-03-17 20:34:16'),
(15, 'files/images/5508950b5de53.jpg', 'files/images/5508950b5de53_thumb.jpg', NULL, NULL, 500, 375, 200, 150, 'image/jpeg', 'static', NULL, 1, '2015-03-17 20:56:43'),
(16, 'files/images/5508abc661e06.jpg', 'files/images/5508abc661e06_thumb.jpg', NULL, NULL, 500, 375, 200, 150, 'image/jpeg', 'static', NULL, 1, '2015-03-17 22:33:42'),
(17, 'files/images/55096e6f1e925.png', 'files/images/55096e6f1e925_thumb.png', NULL, NULL, 1310, 792, 400, 242, 'image/png', 'static', NULL, 1, '2015-03-18 12:24:15'),
(18, 'files/images/55096e7237ce5.png', 'files/images/55096e7237ce5_thumb.png', NULL, NULL, 400, 70, 400, 70, 'image/png', 'static', NULL, 1, '2015-03-18 12:24:18'),
(19, 'files/images/55098592bc9e2.png', 'files/images/55098592bc9e2_thumb.png', NULL, NULL, 1310, 792, 248, 150, 'image/png', 'static', NULL, 3, '2015-03-18 14:02:59'),
(20, 'files/images/550996cd2fb8f.png', 'files/images/550996cd2fb8f_thumb.png', NULL, NULL, 1152, 648, 267, 150, 'image/png', 'static', NULL, 1, '2015-03-18 15:16:29'),
(21, 'files/images/550996d4e4844.png', 'files/images/550996d4e4844_thumb.png', NULL, NULL, 276, 453, 200, 328, 'image/png', 'static', NULL, 1, '2015-03-18 15:16:37'),
(22, 'files/images/550996dd30494.jpg', 'files/images/550996dd30494_thumb.jpg', NULL, NULL, 500, 375, 200, 150, 'image/jpeg', 'static', NULL, 3, '2015-03-18 15:16:45'),
(23, 'files/images/550996ebc012e.gif', 'files/images/550996ebc012e_thumb.gif', NULL, NULL, 350, 350, 200, 200, 'image/gif', 'static', NULL, 1, '2015-03-18 15:16:59'),
(24, 'files/images/550996ee13976.png', 'files/images/550996ee13976_thumb.png', NULL, NULL, 200, 150, 200, 150, 'image/png', 'static', NULL, 1, '2015-03-18 15:17:02'),
(25, 'files/images/550996ef733b8.gif', 'files/images/550996ef733b8_thumb.gif', NULL, NULL, 240, 300, 200, 250, 'image/gif', 'static', NULL, 1, '2015-03-18 15:17:03'),
(26, 'files/images/55099701b2f75.png', 'files/images/55099701b2f75_thumb.png', NULL, NULL, 276, 453, 200, 328, 'image/png', 'static', NULL, 1, '2015-03-18 15:17:21'),
(27, 'files/images/55099704bf23f.png', 'files/images/55099704bf23f_thumb.png', NULL, NULL, 1310, 792, 248, 150, 'image/png', 'static', NULL, 1, '2015-03-18 15:17:25'),
(28, 'files/images/5509970c94798.png', 'files/images/5509970c94798_thumb.png', NULL, NULL, 276, 453, 200, 328, 'image/png', 'static', NULL, 1, '2015-03-18 15:17:32'),
(29, 'files/images/55099714bf58a.png', 'files/images/55099714bf58a_thumb.png', NULL, NULL, 1310, 792, 248, 150, 'image/png', 'static', NULL, 1, '2015-03-18 15:17:41'),
(30, 'files/images/5509977d77c6b.png', 'files/images/5509977d77c6b_thumb.png', NULL, NULL, 276, 453, 400, 657, 'image/png', 'static', NULL, 1, '2015-03-18 15:19:25'),
(31, 'files/images/5509978230259.png', 'files/images/5509978230259_thumb.png', NULL, NULL, 1152, 648, 400, 225, 'image/png', 'static', NULL, 1, '2015-03-18 15:19:30'),
(32, 'files/images/550997a6164f6.png', 'files/images/550997a6164f6_thumb.png', NULL, NULL, 400, 70, 400, 70, 'image/png', 'static', NULL, 1, '2015-03-18 15:20:06'),
(33, 'files/images/550c4159630d5.jpg', 'files/images/550c4159630d5_thumb.jpg', NULL, NULL, 2338, 1700, 206, 150, 'image/jpeg', 'static', NULL, 1, '2015-03-20 15:48:41'),
(34, 'files/images/55251c719b18c.jpg', 'files/images/55251c719b18c_thumb.jpg', NULL, NULL, 960, 927, 200, 193, 'image/jpeg', 'static', NULL, 3, '2015-04-08 12:17:53');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `general_features`
--

CREATE TABLE IF NOT EXISTS `general_features` (
`id` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `n` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `v` varchar(255) NOT NULL DEFAULT 'false'
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `general_features`
--

INSERT INTO `general_features` (`id`, `type`, `n`, `title`, `v`) VALUES
(1, 'features', 'boarding', 'Boarding', 'true'),
(2, 'features', 'daycare', 'Daycare', 'true'),
(3, 'features', 'rewards_program', 'Rewards program', 'true'),
(4, 'features', 'grooming', 'Grooming', 'true'),
(5, 'features', 'training', 'Training', 'true'),
(6, 'features', 'outside_services', 'Outside services', 'true'),
(7, 'general_features', 'allow_refunds_in_pos', 'Allow refunds in POS', 'true'),
(8, 'general_features', 'allow_coupons_in_pos', 'Allow coupons in POS', 'true'),
(10, 'grooming', 'display_grooming_vacancy', 'Display grooming vacancy', 'true'),
(11, 'grooming', 'display_groomers_schedule', 'Display groomer`s scheduler', 'true'),
(12, 'communication_features', 'send_email_reminders', 'Send email reminders automatically for boarding and grooming reservations', 'true'),
(13, 'communication_features', 'send_email_reminders_days', 'Also send email reminder before appointment within no. days ', '4'),
(14, 'features', 'meds', 'Meds', 'true'),
(15, 'features', 'diets', 'Diets', 'true'),
(16, 'general_features', 'vaccinations', 'Vaccinations', 'true'),
(17, 'general_features', 'pet_records', 'Pet records', 'true'),
(18, 'general_features', 'sticky', 'Sticky notes', 'true'),
(19, 'general_features', 'notepads', 'Notepads', 'true'),
(20, 'search_options', 'client_membership', 'Client membership', 'true'),
(21, 'search_options', 'pet_id', 'Pet ID', 'true'),
(22, 'search_options', 'pet_breed', 'Pet breed', '1'),
(23, 'search_options', 'default_search', 'Default search', '1'),
(24, 'side_menu', 'points_of_sale', 'Points of sale', 'true'),
(25, 'side_menu', 'manager', 'Manager', 'true'),
(26, 'side_menu', 'reports', 'Reports', 'true'),
(27, 'side_menu', 'vacancies', 'Vacancies', 'true'),
(28, 'side_menu', 'deposits', 'Deposits', 'true'),
(29, 'side_menu', 'layout', 'Layout', 'true');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `grooming_commissions`
--

CREATE TABLE IF NOT EXISTS `grooming_commissions` (
`id` int(11) NOT NULL,
  `groomer_id` int(11) NOT NULL,
  `percentage` float NOT NULL,
  `if_1` tinyint(4) NOT NULL DEFAULT '0',
  `if_value_1` float NOT NULL,
  `if_modifier_1` tinyint(4) NOT NULL DEFAULT '1',
  `if_modifier_value_1` float NOT NULL,
  `if_2` tinyint(4) NOT NULL DEFAULT '0',
  `if_value_2` float NOT NULL,
  `if_modifier_2` tinyint(4) NOT NULL DEFAULT '1',
  `if_modifier_value_2` float NOT NULL,
  `if_3` tinyint(4) NOT NULL DEFAULT '0',
  `if_value_3` float NOT NULL,
  `if_modifier_3` tinyint(4) NOT NULL DEFAULT '1',
  `if_modifier_value_3` float NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `grooming_commissions`
--

INSERT INTO `grooming_commissions` (`id`, `groomer_id`, `percentage`, `if_1`, `if_value_1`, `if_modifier_1`, `if_modifier_value_1`, `if_2`, `if_value_2`, `if_modifier_2`, `if_modifier_value_2`, `if_3`, `if_value_3`, `if_modifier_3`, `if_modifier_value_3`) VALUES
(2, 5, 10, 1, 2000, 1, 5, 1, 3000, 2, 250.5, 0, 0, 1, 0);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `grooming_options`
--

CREATE TABLE IF NOT EXISTS `grooming_options` (
`id` int(11) NOT NULL,
  `n` varchar(255) NOT NULL,
  `v` varchar(255) NOT NULL DEFAULT 'false'
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `grooming_options`
--

INSERT INTO `grooming_options` (`id`, `n`, `v`) VALUES
(1, 'recommended_next_groom', '1'),
(2, 'recommended_next_groom_no_weeks', '6'),
(3, 'enable_virtual_grooming_receptionist', '0'),
(4, 'groomer_limits', 'as_no_pets'),
(5, 'base_type_1', 'Bath'),
(6, 'base_type_2', 'Hair Cut'),
(7, 'base_type_1_hours', '1'),
(8, 'base_type_2_hours', '2'),
(9, 'suggest_automatically_base_price', '1'),
(10, 'grooming_work_hour_rate', '10.00'),
(11, 'last_nonzero_base_price', '1');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `grooming_priority`
--

CREATE TABLE IF NOT EXISTS `grooming_priority` (
`id` int(11) NOT NULL,
  `status_id` tinyint(4) NOT NULL DEFAULT '1',
  `groomer_id` int(11) NOT NULL,
  `pet_breed_id` int(11) NOT NULL,
  `priority` tinyint(4) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `grooming_priority`
--

INSERT INTO `grooming_priority` (`id`, `status_id`, `groomer_id`, `pet_breed_id`, `priority`) VALUES
(1, 1, 5, 13, 3),
(2, 3, 5, 17, 1),
(3, 1, 5, 17, 1),
(4, 1, 5, 15, 2);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `grooming_rates`
--

CREATE TABLE IF NOT EXISTS `grooming_rates` (
`id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `v` varchar(255) NOT NULL,
  `multiplier` float NOT NULL DEFAULT '0',
  `change_price` tinyint(4) NOT NULL DEFAULT '1'
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `grooming_rates`
--

INSERT INTO `grooming_rates` (`id`, `status_id`, `v`, `multiplier`, `change_price`) VALUES
(1, 1, 'Bad shape', 2, 0),
(2, 1, 'Good shape', 0.5, 1),
(3, 1, 'Heavily matted', 1.5, 1),
(4, 1, 'Tidy up', 2.3, 0),
(5, 1, 'Shave', 0.7, 0),
(6, 1, 'Full groom', 0.2, 0),
(7, 1, 'Special', 0.3, 1),
(8, 1, 'De-matting', 1, 1),
(9, 3, '', 0, 1),
(10, 3, 'asdadas', 0.5, 1);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `grooming_services`
--

CREATE TABLE IF NOT EXISTS `grooming_services` (
`id` int(11) NOT NULL,
  `status_id` tinyint(4) NOT NULL DEFAULT '1',
  `v` varchar(255) NOT NULL,
  `miniature` float NOT NULL,
  `small` float NOT NULL,
  `medium` float NOT NULL,
  `med_lg` float NOT NULL,
  `large` float NOT NULL,
  `giant` float NOT NULL,
  `cat` float NOT NULL,
  `sand` float NOT NULL,
  `other` float NOT NULL,
  `hcp` float NOT NULL,
  `in_use` tinyint(4) NOT NULL DEFAULT '1',
  `base_type_id` tinyint(4) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `grooming_services`
--

INSERT INTO `grooming_services` (`id`, `status_id`, `v`, `miniature`, `small`, `medium`, `med_lg`, `large`, `giant`, `cat`, `sand`, `other`, `hcp`, `in_use`, `base_type_id`) VALUES
(1, 1, 'Nails', 10, 10, 10, 10, 12, 15, 12, 0, 0, 10, 1, 1),
(2, 1, 'Ears', 5, 5, 5, 5, 5, 5, 0, 0, 0, 10, 1, 1),
(3, 1, 'Front line flea', 10, 9.99, 9.99, 9.99, 9.99, 9.99, 0, 0, 0, 10, 1, 1),
(4, 1, 'Conditioner', 3, 3, 5, 5, 5, 5, 0, 0, 0, 10, 0, 1),
(5, 1, 'Hypo-alergenic', 5, 5, 5, 5, 5, 5, 0, 0, 0, 10, 0, 1),
(6, 1, 'Flea & tic dip', 5, 5, 5, 5, 5, 5, 0, 0, 0, 0, 0, 2),
(7, 1, 'Furminator shampo', 5, 5, 5, 5, 5, 5, 0, 0, 0, 0, 1, 2),
(8, 1, 'De-sheding', 15, 15, 20, 20, 25, 30, 0, 0, 0, 0, 1, 2),
(9, 1, 'De-matting', 5, 5, 5, 5, 5, 5, 0, 0, 0, 0, 1, 2);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `holiday`
--

CREATE TABLE IF NOT EXISTS `holiday` (
  `id` int(11) NOT NULL,
  `v` varchar(255) NOT NULL,
  `date` date NOT NULL,
  `open` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `holiday`
--

INSERT INTO `holiday` (`id`, `v`, `date`, `open`) VALUES
(1, 'Birthday of MLK', '2015-01-17', 1),
(2, 'President Day', '2015-02-21', 1),
(3, 'Memorial Day', '2015-05-26', 1),
(4, 'Independence Day', '2014-04-07', 0),
(5, 'Labor Day', '2015-06-09', 1),
(6, 'Thanksgiving Day', '2015-11-09', 0),
(7, 'Columbus Day', '2015-10-13', 1),
(8, 'Veterans Day', '2015-11-11', 1),
(9, 'Christmas Eve', '2015-01-24', 1),
(10, 'Christmas Day', '2015-12-25', 0),
(11, 'New Year', '2015-12-31', 1);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `languages`
--

CREATE TABLE IF NOT EXISTS `languages` (
`id` int(11) NOT NULL,
  `k` varchar(255) NOT NULL,
  `en` text NOT NULL,
  `fr` text NOT NULL,
  `de` text NOT NULL,
  `it` text NOT NULL,
  `pt` text NOT NULL,
  `ro` text NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `languages`
--

INSERT INTO `languages` (`id`, `k`, `en`, `fr`, `de`, `it`, `pt`, `ro`) VALUES
(1, 'billing_details', 'Billing details', '', '', '', '', 'Detalii de livrare'),
(2, 'date', 'Date', '', '', '', '', ''),
(3, 'customer', 'Customer', '', '', '', '', ''),
(4, 'in', 'In', '', '', '', '', ''),
(5, 'out', 'Out', '', '', '', '', ''),
(6, 'boarding', 'Boarding', '', '', '', '', ''),
(7, 'no_days', 'No. days', '', '', '', '', ''),
(8, 'day', 'day', '', '', '', '', ''),
(9, 'services', 'Services', '', '', '', '', ''),
(10, 'medication', 'Medication', '', '', '', '', ''),
(11, 'morning', 'morning', '', '', '', '', ''),
(12, 'afternoon', 'afternoon', '', '', '', '', ''),
(13, 'evening', 'evening', '', '', '', '', ''),
(14, 'as_needed', 'as needed', '', '', '', '', ''),
(15, 'everyday', 'everyday', '', '', '', '', ''),
(16, 'days', 'days', '', '', '', '', ''),
(17, 'diets', 'Diets', '', '', '', '', ''),
(18, 'sub_total', 'Sub-total', '', '', '', '', ''),
(19, 'tax', 'Tax', '', '', '', '', ''),
(20, 'deposits', 'Deposits', '', '', '', '', ''),
(21, 'pending', 'Pending', '', '', '', '', ''),
(22, 'total', 'Total', 'Totalul', '', '', '', ''),
(23, 'pp_thank_you_for_boarding', 'Thank you for boarding with us, <br /> Come back again !', '', '', '', '', ''),
(24, 'pet_name', 'Pet name', '', '', '', '', ''),
(26, 'name', 'Name', '', '', '', '', ''),
(27, 'qty', 'Qty', '', '', '', '', ''),
(28, 'price', 'Price', '', '', '', '', ''),
(29, 'adaos', 'Adaos', '', '', '', '', ''),
(30, 'disc', 'Disc', '', '', '', '', ''),
(31, 'coupon', 'Coupon', '', '', '', '', ''),
(33, 'o_tax', 'O Tax', '', '', '', '', ''),
(35, 'walk_in_client', 'Walk in client', '', '', '', '', ''),
(36, 'client_information', 'Client information', '', '', '', '', ''),
(37, 'email', 'Email', '', '', '', '', ''),
(38, 'paid', 'Paid', 'Platit', '', '', '', ''),
(39, 'change', 'Change', 'Restul', '', '', '', ''),
(40, 'unpaid', 'Unpaid', 'Neplatit', '', '', '', ''),
(41, 'billing_information', 'Billing information', '', '', '', '', 'Detalii de livrare'),
(42, 'language', 'Language', 'Limba', '', '', '', ''),
(43, 'payment_type', 'Payment type', 'Tipul de plata', '', '', '', ''),
(44, 'rewards', 'Rewards', '', '', '', '', ''),
(45, 'points_per_dollar', 'Points per dollar', '', '', '', '', ''),
(46, 'discount', 'Discount', '', '', '', '', ''),
(47, 'address', 'Address', 'Adresa', '', '', '', ''),
(48, 'phone', 'Phone', '', '', '', '', ''),
(49, 'contact', 'Contact', '', '', '', '', ''),
(51, 'contact_phone', 'Contact phone', '', '', '', '', ''),
(52, 'date_created', 'Date created', '', '', '', '', ''),
(53, 'date_modified', 'Date modified', '', '', '', '', ''),
(54, 'payment_status', 'Payment status', '', '', '', '', ''),
(55, 'is_tip', 'Is tip', '', '', '', '', ''),
(56, 'tipped_user', 'Tipped user', '', '', '', '', ''),
(57, 'refund_report', 'Refund report', '', '', '', '', ''),
(58, 'point_of_sale_report', 'Point of sale report', '', '', '', '', ''),
(59, 'deposit_report', 'Deposit report', '', '', '', '', ''),
(60, 'paid_from_deposit_report', 'Paid from deposit report', '', '', '', '', ''),
(61, 'reward_points_to_date', 'REWARD points to date', '', '', '', '', ''),
(62, 'contact_tel', 'Contact tel', '', '', '', '', ''),
(63, 'boarding_report', 'Boarding report', '', '', '', '', ''),
(64, 'date_in', 'Date in', '', '', '', '', ''),
(65, 'time_in', 'Time in', '', '', '', '', ''),
(66, 'time_out', 'Time out', '', '', '', '', ''),
(67, 'date_out', 'Date out', '', '', '', '', ''),
(68, 'customer_name', 'Customer name', '', '', '', '', ''),
(70, 'stay_reason', 'Stay reason', '', '', '', '', ''),
(71, 'luggage', 'Luggage', '', '', '', '', ''),
(72, 'is_handle_carefully', 'Is handle carefully', '', '', '', '', ''),
(73, 'is_extra_pet', 'Is extra pet', '', '', '', '', ''),
(74, 'charge_by_petsize', 'Charge by petsize', '', '', '', '', ''),
(75, 'charge_by_runtype', 'Charge by runtype', '', '', '', '', ''),
(76, 'type', 'Type', '', '', '', '', ''),
(78, 'price_fullday', 'Price fullday', '', '', '', '', ''),
(79, 'price_halfday', 'Price halfday', '', '', '', '', ''),
(80, 'nr_days', 'Nr. days', '', '', '', '', ''),
(81, 'pet_type', 'Pet type', '', '', '', '', ''),
(82, 'pet_breed', 'Pet breed', '', '', '', '', ''),
(83, 'schedule_services', 'Schedule services', '', '', '', '', ''),
(84, 'service', 'Service', '', '', '', '', ''),
(85, 'instructions', 'Instructions', '', '', '', '', ''),
(86, 'exclude_on_checkin', 'Exclude on checkin', '', '', '', '', ''),
(87, 'exclude_on_checkout', 'Exclude on checkout', '', '', '', '', ''),
(88, 'meds', 'Medications', '', '', '', '', ''),
(89, 'subtotal', 'Sub-total', '', '', '', '', '');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `layout_runs`
--

CREATE TABLE IF NOT EXISTS `layout_runs` (
`id` int(11) NOT NULL,
  `status_id` tinyint(4) NOT NULL DEFAULT '1',
  `run_number` varchar(255) NOT NULL,
  `run_description` text NOT NULL,
  `charge_type` enum('charge_by_runtype','charge_by_petsizes') NOT NULL,
  `charge_type_id` int(11) NOT NULL,
  `layout_section_id` int(11) NOT NULL,
  `position_layout_screen` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `layout_runs`
--

INSERT INTO `layout_runs` (`id`, `status_id`, `run_number`, `run_description`, `charge_type`, `charge_type_id`, `layout_section_id`, `position_layout_screen`) VALUES
(3, 1, 'A1', 'Some long and borring description', 'charge_by_runtype', 2, 1, 1),
(4, 1, 'A2', '', 'charge_by_runtype', 3, 1, 2),
(5, 1, 'A3', '', 'charge_by_petsizes', 2, 1, 3);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `layout_sections`
--

CREATE TABLE IF NOT EXISTS `layout_sections` (
  `id` int(11) NOT NULL,
  `in_use` tinyint(4) NOT NULL DEFAULT '0',
  `v` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `layout_sections`
--

INSERT INTO `layout_sections` (`id`, `in_use`, `v`) VALUES
(1, 1, 'Main'),
(2, 1, 'Cats'),
(3, 0, ''),
(4, 0, ''),
(5, 0, '');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `md_dosage`
--

CREATE TABLE IF NOT EXISTS `md_dosage` (
`id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `v` varchar(255) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `md_dosage`
--

INSERT INTO `md_dosage` (`id`, `status_id`, `v`) VALUES
(1, 1, '0.25'),
(2, 1, '0.50'),
(3, 1, '0.75'),
(4, 1, '1.00'),
(5, 1, '1.25'),
(6, 1, '1.50'),
(7, 1, '1.75'),
(8, 1, '2.00'),
(9, 1, '2.25'),
(10, 1, '2.50'),
(11, 1, '2.75'),
(12, 1, '3.00'),
(13, 1, '3.25'),
(14, 1, '3.50'),
(15, 1, '3.75'),
(16, 1, '4.00'),
(17, 1, '4.25'),
(18, 1, '4.50'),
(19, 1, '4.75'),
(20, 1, '5.00'),
(21, 1, '5.25'),
(22, 1, '5.50'),
(23, 1, '5.75'),
(24, 1, '6.00'),
(25, 1, '6.25'),
(26, 1, '6.50'),
(27, 1, '6.75'),
(28, 1, '7.00');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `md_dose_type`
--

CREATE TABLE IF NOT EXISTS `md_dose_type` (
`id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `v` varchar(255) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `md_dose_type`
--

INSERT INTO `md_dose_type` (`id`, `status_id`, `v`) VALUES
(1, 1, 'cc'),
(2, 1, 'cup'),
(3, 1, 'day'),
(4, 1, 'drop'),
(5, 1, 'ml'),
(6, 1, 'pck'),
(7, 1, 'pill'),
(8, 1, 'pinch'),
(9, 1, 'spn'),
(10, 1, 'strip');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `meds`
--

CREATE TABLE IF NOT EXISTS `meds` (
`id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `v` varchar(255) NOT NULL,
  `price` float NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `meds`
--

INSERT INTO `meds` (`id`, `status_id`, `v`, `price`) VALUES
(1, 1, 'Ace', 50.2),
(2, 1, 'Advantage', 0),
(3, 1, 'Alcohol', 0),
(4, 1, 'Aller-G3', 0),
(5, 1, 'Amforal', 0),
(6, 1, 'Aminophyline', 15),
(7, 1, 'Amitriptyline', 25),
(56, 3, 'Something good', 12),
(57, 3, 'asas', 20),
(58, 3, 'asdda', 12.25),
(59, 3, 'asd', 12.2),
(60, 3, '', 0),
(61, 3, 'asda', 123);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `meds_type`
--

CREATE TABLE IF NOT EXISTS `meds_type` (
`id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `v` varchar(255) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `meds_type`
--

INSERT INTO `meds_type` (`id`, `status_id`, `v`) VALUES
(1, 1, 'pill'),
(2, 1, 'ointment'),
(3, 1, 'drop'),
(4, 1, 'liquid'),
(5, 1, 'injection'),
(6, 3, 'qwe');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `messages`
--

CREATE TABLE IF NOT EXISTS `messages` (
`id` int(11) NOT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT '0',
  `is_read` tinyint(4) NOT NULL DEFAULT '0',
  `sent_user_id` int(11) NOT NULL,
  `inbox_user_id` int(11) NOT NULL,
  `color_hex` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `messages`
--

INSERT INTO `messages` (`id`, `is_deleted`, `is_read`, `sent_user_id`, `inbox_user_id`, `color_hex`, `message`, `date_created`) VALUES
(1, 1, 1, 1, 5, '#f28585', 'Ma muie can iesim ?', '2015-03-20 15:49:26'),
(2, 1, 1, 5, 1, '#f2c585', 'wqeq', '2015-03-20 15:49:55'),
(3, 1, 1, 5, 1, '', 'asdasd', '2015-03-20 15:50:10'),
(4, 0, 0, 5, 2, '', 'asdasd', '2015-03-20 15:50:10'),
(5, 0, 0, 5, 8, '', 'asdasd', '2015-03-20 15:50:10'),
(6, 1, 1, 5, 1, '#85e9f2', 'asdqweqwe', '2015-03-20 15:50:18'),
(7, 0, 0, 5, 2, '#85e9f2', 'asdqweqwe', '2015-03-20 15:50:18'),
(8, 0, 0, 5, 8, '#85e9f2', 'asdqweqwe', '2015-03-20 15:50:18');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `notepads`
--

CREATE TABLE IF NOT EXISTS `notepads` (
`id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `created_user_id` int(11) NOT NULL,
  `v` text NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `notepads`
--

INSERT INTO `notepads` (`id`, `status_id`, `created_user_id`, `v`, `date_created`, `date_modified`) VALUES
(1, 3, 0, 'asdasd', '2015-04-08 12:19:09', '2015-04-08 12:19:09');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `payments`
--

CREATE TABLE IF NOT EXISTS `payments` (
`id` int(11) NOT NULL,
  `payment_type_id` int(11) NOT NULL,
  `payment_status_id` int(11) NOT NULL DEFAULT '1',
  `payment_amount` float NOT NULL,
  `payment` varchar(255) NOT NULL,
  `client_id` int(11) NOT NULL,
  `report_id` int(11) NOT NULL,
  `information` text NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `payments`
--

INSERT INTO `payments` (`id`, `payment_type_id`, `payment_status_id`, `payment_amount`, `payment`, `client_id`, `report_id`, `information`, `date_created`, `date_modified`) VALUES
(1, 0, 1, 0, 'boarding', 0, 3, '{"price":"140","deposit":"20","days":"1"}', '2014-07-14 10:12:38', '0000-00-00 00:00:00'),
(2, 0, 1, 0, 'boarding', 0, 4, '{"price":"640","deposit":"15","days":"32"}', '2014-07-14 10:34:35', '0000-00-00 00:00:00'),
(3, 0, 1, 0, 'boarding', 0, 5, '{"price":"40","deposit":"0","days":"2"}', '2014-07-25 13:40:11', '0000-00-00 00:00:00'),
(4, 0, 1, 0, 'boarding', 0, 7, '{"price":"420","deposit":"0","days":"21"}', '2014-08-27 11:41:55', '0000-00-00 00:00:00'),
(5, 3, 1, 50, 'pos', 2, 0, '{"client":{"id":"2","status_id":"1","client_status_id":"1","image_id":"3","pet_id":"2","first_name":"Voicu","last_name":"Radu","email":"gvoics@gmail.com","contact_phone":"0740216478","contact_cell":"","emergency_name":"","emergency_phone":"","address_street":"","address_city":"","address_state":"","address_zip":"","$$hashKey":"00D"},"o":{"print_to_screen":true,"details":false,"email_copy":false,"payment_type_id":"3","language":"en","subtotal":85.5,"tax":5.984999999999999,"balance":91.485,"unpaid":91.485,"payment_amount":50},"oo":[{"id":"1","status_id":"1","product_code":"12312534-15747","product_name":"Ear cleaning (cat)","price":"5","quantity":3,"at":"0","to":"0","tax":0.35000000000000003,"class_id":"4","$$hashKey":"01G","discount":0,"d_price":"5","total":16.049999999999997},{"id":"3","status_id":"1","product_code":"134968997","product_name":"CocaCola","price":"23.5","quantity":3,"at":"0","to":"0","tax":1.645,"class_id":"6","$$hashKey":"01I","discount":0,"d_price":"23.5","total":75.435}]}', '2014-10-16 09:11:51', '0000-00-00 00:00:00'),
(6, 3, 1, 41.49, 'pos', 2, 0, '{"client":{"id":"2","status_id":"1","client_status_id":"1","image_id":"3","pet_id":"2","first_name":"Voicu","last_name":"Radu","email":"gvoics@gmail.com","contact_phone":"0740216478","contact_cell":"","emergency_name":"","emergency_phone":"","address_street":"","address_city":"","address_state":"","address_zip":"","$$hashKey":"00D"},"o":{"print_to_screen":true,"details":false,"email_copy":false,"payment_type_id":"3","language":"en","subtotal":85.5,"tax":5.984999999999999,"balance":91.485,"unpaid":41.485,"payment_amount":41.49},"oo":[{"id":"1","status_id":"1","product_code":"12312534-15747","product_name":"Ear cleaning (cat)","price":"5","quantity":3,"at":"0","to":"0","tax":0.35000000000000003,"class_id":"4","$$hashKey":"01G","discount":0,"d_price":"5","total":16.049999999999997},{"id":"3","status_id":"1","product_code":"134968997","product_name":"CocaCola","price":"23.5","quantity":3,"at":"0","to":"0","tax":1.645,"class_id":"6","$$hashKey":"01I","discount":0,"d_price":"23.5","total":75.435}]}', '2014-10-16 09:11:57', '0000-00-00 00:00:00'),
(7, 1, 1, 10, 'boarding', 25, 8, '{"price":"10","deposit":"0","days":"1"}', '2014-10-27 09:16:29', '0000-00-00 00:00:00'),
(8, 1, 1, 32.1, 'pos', 1, 0, '{"client":{"id":"1","status_id":1,"client_status_id":2,"image_id":null,"pet_id":null,"first_name":"Todorescu","last_name":"Tudor","email":null,"contact_phone":"(123) 456-7890","contact_work_phone":"","contact_cell":null,"emergency_name":null,"emergency_phone":null,"address_street":null,"address_city":null,"address_state":null,"address_zip":null,"pet":{"id":"1","status_id":1,"image_id":null,"pet_name":"Rocky","pet_weight":12,"pet_color_id":2,"pet_size_id":1,"pet_sex_id":1,"pet_breed_id":492,"pet_type_id":2,"pet_status_id":null,"dob":"11/03/2014","special_instructions":"","r_boarding":[{"id":1,"status_id":1,"client_id":0,"pet_id":1,"stay_reason_id":0,"luggage":"","deposit":0,"charge_type":"charge_by_petsize","charge_type_id":0,"in_out":"in","report_id":6,"date_in":"2014-04-10","time_in":"00:00:00","date_out":"2014-08-18","time_out":"19:34:32","date_out_checkout":"0000-00-00","time_out_checkout":"00:00:00"},{"id":32,"status_id":1,"client_id":1,"pet_id":1,"stay_reason_id":2,"luggage":"Some luggage","deposit":0,"charge_type":"charge_by_petsize","charge_type_id":2,"in_out":"in","report_id":0,"date_in":"2014-12-17","time_in":"16:15:00","date_out":"2014-12-17","time_out":null,"date_out_checkout":null,"time_out_checkout":null}],"r_daycare":[{"id":21,"status_id":1,"pet_id":1,"client_id":1,"daycare_group_id":1,"date_in":"2014-12-17","time_in":"16:14:52","date_out":"2014-12-17","time_out":null,"$$hashKey":"02W"}],"r_training":[],"r_grooms":[],"no_visits":3},"$$hashKey":"00S"},"o":{"subtotal":30,"tax":2.1,"balance":32.1,"unpaid":32.1,"print_to_screen":true,"details":true,"payment_type_id":"1","payment_amount":32.1},"oo":[{"id":1,"status_id":1,"product_code":"12312534-15747","product_name":"Ear cleaning (cat)","price":5,"quantity":2,"at":0,"to":0,"tax":0.35000000000000003,"class_id":4,"commission_percentage":25,"$$hashKey":"00U","discount":0,"d_price":5,"total":10.7},{"id":2,"status_id":1,"product_code":"65789-4967","product_name":"Something cool","price":20,"quantity":1,"at":0,"to":0,"tax":1.4000000000000001,"class_id":2,"commission_percentage":25,"$$hashKey":"00V","discount":0,"d_price":20,"total":21.4}]}', '2015-02-03 22:05:06', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `payment_types`
--

CREATE TABLE IF NOT EXISTS `payment_types` (
`id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `v` varchar(255) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `payment_types`
--

INSERT INTO `payment_types` (`id`, `status_id`, `v`) VALUES
(1, 1, 'CA'),
(2, 1, 'CK'),
(3, 1, 'VI'),
(4, 1, 'MC'),
(5, 1, 'DC'),
(6, 1, 'AX'),
(7, 1, 'DE'),
(8, 1, 'GC'),
(9, 3, 'asd');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `pets`
--

CREATE TABLE IF NOT EXISTS `pets` (
`id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `image_id` int(11) DEFAULT NULL,
  `pet_name` varchar(255) DEFAULT NULL,
  `pet_weight` int(11) DEFAULT NULL,
  `pet_color_id` int(11) DEFAULT NULL,
  `pet_size_id` int(11) DEFAULT NULL,
  `pet_sex_id` int(11) DEFAULT NULL,
  `pet_breed_id` int(11) DEFAULT NULL,
  `pet_type_id` int(11) DEFAULT NULL,
  `pet_status_id` int(11) DEFAULT NULL,
  `dob` varchar(255) DEFAULT NULL,
  `special_instructions` text NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `pets`
--

INSERT INTO `pets` (`id`, `status_id`, `image_id`, `pet_name`, `pet_weight`, `pet_color_id`, `pet_size_id`, `pet_sex_id`, `pet_breed_id`, `pet_type_id`, `pet_status_id`, `dob`, `special_instructions`, `date_created`) VALUES
(1, 1, 16, 'Rocky', 12, 2, 1, 1, 492, 2, NULL, '11/03/2014', 'aqwe', '2015-03-18 10:59:52'),
(2, 1, NULL, 'Animalul', 54, 2, 1, 1, 3, 1, NULL, '01/05/2015', '', '2015-03-18 10:59:52'),
(3, 1, NULL, 'Igor', 15, 9, 2, 3, 491, 2, NULL, '06/10/2009', '', '2015-03-18 11:02:38'),
(4, 1, NULL, 'Nume', 45, 3, 1, 1, 3, 1, NULL, '03/31/2015', '', '2015-04-08 11:58:46');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `pet_breed`
--

CREATE TABLE IF NOT EXISTS `pet_breed` (
`id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `pet_type_id` int(11) NOT NULL,
  `v` tinytext NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=608 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `pet_breed`
--

INSERT INTO `pet_breed` (`id`, `status_id`, `pet_type_id`, `v`) VALUES
(1, 3, 0, 'Caine de lup'),
(2, 3, 0, 'Ciobanesc german'),
(3, 1, 1, 'Affenpinscher'),
(4, 1, 1, 'Afghan Hound'),
(5, 1, 1, 'Aidi'),
(6, 1, 1, 'Airedale Terrier'),
(7, 1, 1, 'Akbash'),
(8, 1, 1, 'Akita Inu'),
(9, 1, 1, 'Alano Español'),
(10, 1, 1, 'Alaskan Klee Kai'),
(11, 1, 1, 'Alaskan Malamute'),
(12, 1, 1, 'Alpine Dachsbracke'),
(13, 1, 1, 'Alpine Spaniel'),
(14, 1, 1, 'American Akita'),
(15, 1, 1, 'American Bulldog'),
(16, 1, 1, 'American Cocker Spaniel'),
(17, 1, 1, 'American Eskimo Dog'),
(18, 1, 1, 'American Foxhound'),
(19, 1, 1, 'American Hairless Terrier'),
(20, 1, 1, 'American Pit Bull Terrier'),
(21, 1, 1, 'American Staffordshire Terrier'),
(22, 1, 1, 'American Water Spaniel'),
(23, 1, 1, 'Anatolian Shepherd Dog'),
(24, 1, 1, 'Anglo-Français de Petite Vénerie'),
(25, 1, 1, 'Appenzeller Sennenhund'),
(26, 1, 1, 'Ariege Pointer'),
(27, 1, 1, 'Ariegeois'),
(28, 1, 1, 'Armant'),
(29, 1, 1, 'Armenian Gampr dog'),
(30, 1, 1, 'Artois Hound'),
(31, 1, 1, 'Australian Cattle Dog'),
(32, 1, 1, 'Australian Kelpie'),
(33, 1, 1, 'Australian Shepherd'),
(34, 1, 1, 'Australian Silky Terrier'),
(35, 1, 1, 'Australian Stumpy Tail Cattle Dog'),
(36, 1, 1, 'Australian Terrier'),
(37, 1, 1, 'Austrian Black and Tan Hound'),
(38, 1, 1, 'Austrian Pinscher'),
(39, 1, 1, 'Azawakh'),
(40, 1, 1, 'Bakharwal Dog'),
(41, 1, 1, 'Barbet'),
(42, 1, 1, 'Basenji'),
(43, 1, 1, 'Basque Shepherd Dog'),
(44, 1, 1, 'Basset Artésien Normand'),
(45, 1, 1, 'Basset Bleu de Gascogne'),
(46, 1, 1, 'Basset Fauve de Bretagne'),
(47, 1, 1, 'Basset Griffon Vendéen, Grand'),
(48, 1, 1, 'Basset Griffon Vendéen, Petit'),
(49, 1, 1, 'Basset Hound'),
(50, 1, 1, 'Bavarian Mountain Hound'),
(51, 1, 1, 'Beagle'),
(52, 1, 1, 'Beagle-Harrier'),
(53, 1, 1, 'Bearded Collie'),
(54, 1, 1, 'Beauceron'),
(55, 1, 1, 'Bedlington Terrier'),
(56, 1, 1, 'Belgian Shepherd Dog (Groenendael)'),
(57, 1, 1, 'Belgian Shepherd Dog (Laekenois)'),
(58, 1, 1, 'Belgian Shepherd Dog (Malinois)'),
(59, 1, 1, 'Belgian Shepherd (Tervuren)'),
(60, 1, 1, 'Bergamasco Shepherd'),
(61, 1, 1, 'Berger Blanc Suisse'),
(62, 1, 1, 'Berger Picard'),
(63, 1, 1, 'Berner Laufhund'),
(64, 1, 1, 'Bernese Mountain Dog'),
(65, 1, 1, 'Bichon Frisé'),
(66, 1, 1, 'Billy'),
(67, 1, 1, 'Black and Tan Coonhound'),
(68, 1, 1, 'Black and Tan Virginia Foxhound'),
(69, 1, 1, 'Bullenbeisser'),
(70, 1, 1, 'Black Norwegian Elkhound'),
(71, 1, 1, 'Black Russian Terrier'),
(72, 1, 1, 'Blackmouth Cur'),
(73, 1, 1, 'Bleu de Gascogne, Grand'),
(74, 1, 1, 'Bleu de Gascogne, Petit'),
(75, 1, 1, 'Bloodhound'),
(76, 1, 1, 'Blue Lacy'),
(77, 1, 1, 'Blue Paul Terrier'),
(78, 1, 1, 'Bluetick Coonhound'),
(79, 1, 1, 'Boerboel'),
(80, 1, 1, 'Bohemian Shepherd'),
(81, 1, 1, 'Bolognese'),
(82, 1, 1, 'Border Collie'),
(83, 1, 1, 'Border Terrier'),
(84, 1, 1, 'Borzoi'),
(85, 1, 1, 'Bosnian Coarse-haired Hound'),
(86, 1, 1, 'Boston Terrier'),
(87, 1, 1, 'Bouvier des Ardennes'),
(88, 1, 1, 'Bouvier des Flandres'),
(89, 1, 1, 'Boxer'),
(90, 1, 1, 'Boykin Spaniel'),
(91, 1, 1, 'Bracco Italiano'),
(92, 1, 1, 'Braque d''Auvergne'),
(93, 1, 1, 'Braque du Bourbonnais'),
(94, 1, 1, 'Braque du Puy'),
(95, 1, 1, 'Braque Francais'),
(96, 1, 1, 'Braque Saint-Germain'),
(97, 1, 1, 'Brazilian Terrier'),
(98, 1, 1, 'Briard'),
(99, 1, 1, 'Briquet Griffon Vendéen'),
(100, 1, 1, 'Brittany'),
(101, 1, 1, 'Broholmer'),
(102, 1, 1, 'Bruno Jura Hound'),
(103, 1, 1, 'Bucovina Shepherd Dog'),
(104, 1, 1, 'Bull and Terrier'),
(105, 1, 1, 'Bull Terrier'),
(106, 1, 1, 'Bull Terrier (Miniature)'),
(107, 1, 1, 'Bulldog'),
(108, 1, 1, 'Bullmastiff'),
(109, 1, 1, 'Bully Kutta'),
(110, 1, 1, 'Burgos Pointer'),
(111, 1, 1, 'Cairn Terrier'),
(112, 1, 1, 'Canaan Dog'),
(113, 1, 1, 'Canadian Eskimo Dog'),
(114, 1, 1, 'Cane Corso'),
(115, 1, 1, 'Cão da Serra de Aires'),
(116, 1, 1, 'Cão de Castro Laboreiro'),
(117, 1, 1, 'Cão Fila de São Miguel'),
(118, 1, 1, 'Carolina Dog'),
(119, 1, 1, 'Carpathian Shepherd Dog'),
(120, 1, 1, 'Catahoula Cur'),
(121, 1, 1, 'Catalan Sheepdog'),
(122, 1, 1, 'Caucasian Shepherd Dog'),
(123, 1, 1, 'Cavalier King Charles Spaniel'),
(124, 1, 1, 'Central Asian Shepherd Dog'),
(125, 1, 1, 'Cesky Fousek'),
(126, 1, 1, 'Cesky Terrier'),
(127, 1, 1, 'Chesapeake Bay Retriever'),
(128, 1, 1, 'Chien Français Blanc et Noir'),
(129, 1, 1, 'Chien Français Blanc et Orange'),
(130, 1, 1, 'Chien Français Tricolore'),
(131, 1, 1, 'Chien-gris'),
(132, 1, 1, 'Chihuahua'),
(133, 1, 1, 'Chilean Fox Terrier'),
(134, 1, 1, 'Chinese Chongqing Dog'),
(135, 1, 1, 'Chinese Crested Dog'),
(136, 1, 1, 'Chinese Imperial Dog'),
(137, 1, 1, 'Chinook'),
(138, 1, 1, 'Chippiparai'),
(139, 1, 1, 'Chow Chow'),
(140, 1, 1, 'Cierny Sery'),
(141, 1, 1, 'Cimarrón Uruguayo'),
(142, 1, 1, 'Cirneco dell''Etna'),
(143, 1, 1, 'Clumber Spaniel'),
(144, 1, 1, 'Collie, Rough'),
(145, 1, 1, 'Collie, Smooth'),
(146, 1, 1, 'Combai'),
(147, 1, 1, 'Cordoba Fighting Dog'),
(148, 1, 1, 'Coton de Tulear'),
(149, 1, 1, 'Cretan Hound'),
(150, 1, 1, 'Croatian Sheepdog'),
(151, 1, 1, 'Cumberland Sheepdog'),
(152, 1, 1, 'Curly Coated Retriever'),
(153, 1, 1, 'Cursinu'),
(154, 1, 1, 'Czechoslovak Wolfdog'),
(155, 1, 1, 'Dachshund'),
(156, 1, 1, 'Dalmatian'),
(157, 1, 1, 'Dandie Dinmont Terrier'),
(158, 1, 1, 'Danish Swedish Farmdog'),
(159, 1, 1, 'Deutsche Bracke'),
(160, 1, 1, 'Doberman Pinscher'),
(161, 1, 1, 'Dogo Argentino'),
(162, 1, 1, 'Dogo Cubano'),
(163, 1, 1, 'Dogue de Bordeaux'),
(164, 1, 1, 'Drentse Patrijshond'),
(165, 1, 1, 'Drever'),
(166, 1, 1, 'Dunker'),
(167, 1, 1, 'Dutch Shepherd Dog'),
(168, 1, 1, 'Dutch Smoushond'),
(169, 1, 1, 'East Siberian Laika'),
(170, 1, 1, 'East-European Shepherd'),
(171, 1, 1, 'Elo'),
(172, 1, 1, 'English Cocker Spaniel'),
(173, 1, 1, 'English Coonhound'),
(174, 1, 1, 'English Foxhound'),
(175, 1, 1, 'English Mastiff'),
(176, 1, 1, 'English Setter'),
(177, 1, 1, 'English Shepherd'),
(178, 1, 1, 'English Springer Spaniel'),
(179, 1, 1, 'English Toy Terrier (Black & Tan)'),
(180, 1, 1, 'English Water Spaniel'),
(181, 1, 1, 'English White Terrier'),
(182, 1, 1, 'Entlebucher Mountain Dog'),
(183, 1, 1, 'Épagneul Bleu de Picardie'),
(184, 1, 1, 'Estonian Hound'),
(185, 1, 1, 'Estrela Mountain Dog'),
(186, 1, 1, 'Eurasier'),
(187, 1, 1, 'Field Spaniel'),
(188, 1, 1, 'Fila Brasileiro'),
(189, 1, 1, 'Finnish Hound'),
(190, 1, 1, 'Finnish Lapphund'),
(191, 1, 1, 'Finnish Spitz'),
(192, 1, 1, 'Flat-Coated Retriever'),
(193, 1, 1, 'Formosan Mountain Dog'),
(194, 1, 1, 'Fox Terrier (Smooth)'),
(195, 1, 1, 'Fox Terrier, Wire'),
(196, 1, 1, 'French Brittany'),
(197, 1, 1, 'French Bulldog'),
(198, 1, 1, 'French Spaniel'),
(199, 1, 1, 'Galgo Español'),
(200, 1, 1, 'Gascon Saintongeois'),
(201, 1, 1, 'Georgian shepherd'),
(202, 1, 1, 'German Longhaired Pointer'),
(203, 1, 1, 'German Pinscher'),
(204, 1, 1, 'German Rough-haired Pointer'),
(205, 1, 1, 'German Shepherd Dog'),
(206, 1, 1, 'German Shorthaired Pointer'),
(207, 1, 1, 'German Spaniel'),
(208, 1, 1, 'German Spitz'),
(209, 1, 1, 'German Wirehaired Pointer'),
(210, 1, 1, 'Giant Schnauzer'),
(211, 1, 1, 'Glen of Imaal Terrier'),
(212, 1, 1, 'Golden Retriever'),
(213, 1, 1, 'Gordon Setter'),
(214, 1, 1, 'Gran Mastín de Borínquen'),
(215, 1, 1, 'Grand Anglo-Français Blanc et Noir'),
(216, 1, 1, 'Grand Anglo-Français Blanc et Orange'),
(217, 1, 1, 'Grand Anglo-Français Tricolore'),
(218, 1, 1, 'Grand Griffon Vendéen'),
(219, 1, 1, 'Great Dane'),
(220, 1, 1, 'Great Pyrenees'),
(221, 1, 1, 'Greater Swiss Mountain Dog'),
(222, 1, 1, 'Greek Harehound'),
(223, 1, 1, 'Greenland Dog'),
(224, 1, 1, 'Greyhound'),
(225, 1, 1, 'Griffon Bleu de Gascogne'),
(226, 1, 1, 'Griffon Bruxellois'),
(227, 1, 1, 'Griffon Fauve de Bretagne'),
(228, 1, 1, 'Griffon Nivernais'),
(229, 1, 1, 'Hamiltonstövare'),
(230, 1, 1, 'Hanover Hound'),
(231, 1, 1, 'Hare Indian Dog'),
(232, 1, 1, 'Harrier'),
(233, 1, 1, 'Havanese'),
(234, 1, 1, 'Hawaiian Poi Dog'),
(235, 1, 1, 'Himalayan Sheepdog'),
(236, 1, 1, 'Hokkaido'),
(237, 1, 1, 'Hortaya Borzaya'),
(238, 1, 1, 'Hovawart'),
(239, 1, 1, 'Huntaway'),
(240, 1, 1, 'Hygenhund'),
(241, 1, 1, 'Ibizan Hound'),
(242, 1, 1, 'Icelandic Sheepdog'),
(243, 1, 1, 'Indian pariah dog'),
(244, 1, 1, 'Indian Spitz'),
(245, 1, 1, 'Irish Red and White Setter'),
(246, 1, 1, 'Irish Setter'),
(247, 1, 1, 'Irish Terrier'),
(248, 1, 1, 'Irish Water Spaniel'),
(249, 1, 1, 'Irish Wolfhound'),
(250, 1, 1, 'Istrian Coarse-haired Hound'),
(251, 1, 1, 'Istrian Shorthaired Hound'),
(252, 1, 1, 'Italian Greyhound'),
(253, 1, 1, 'Jack Russell Terrier'),
(254, 1, 1, 'Jagdterrier'),
(255, 1, 1, 'Jämthund'),
(256, 1, 1, 'Japanese Chin'),
(257, 1, 1, 'Japanese Spitz'),
(258, 1, 1, 'Japanese Terrier'),
(259, 1, 1, 'Kaikadi'),
(260, 1, 1, 'Kai Ken'),
(261, 1, 1, 'Kangal Dog'),
(262, 1, 1, 'Kanni'),
(263, 1, 1, 'Karakachan Dog'),
(264, 1, 1, 'Karelian Bear Dog'),
(265, 1, 1, 'Karst Shepherd'),
(266, 1, 1, 'Keeshond'),
(267, 1, 1, 'Kerry Beagle'),
(268, 1, 1, 'Kerry Blue Terrier'),
(269, 1, 1, 'King Charles Spaniel'),
(270, 1, 1, 'King Shepherd'),
(271, 1, 1, 'Kintamani'),
(272, 1, 1, 'Kishu'),
(273, 1, 1, 'Komondor'),
(274, 1, 1, 'Kooikerhondje'),
(275, 1, 1, 'Koolie'),
(276, 1, 1, 'Korean Jindo Dog'),
(277, 1, 1, 'Kromfohrländer'),
(278, 1, 1, 'Kumaon Mastiff'),
(279, 1, 1, 'Kunming Wolfdog'),
(280, 1, 1, 'Kur?'),
(281, 1, 1, 'Kuvasz'),
(282, 1, 1, 'Kyi-Leo'),
(283, 1, 1, 'Labrador Husky'),
(284, 1, 1, 'Labrador Retriever'),
(285, 1, 1, 'Lagotto Romagnolo'),
(286, 1, 1, 'Lakeland Terrier'),
(287, 1, 1, 'Lancashire Heeler'),
(288, 1, 1, 'Landseer'),
(289, 1, 1, 'Lapponian Herder'),
(290, 1, 1, 'Leonberger'),
(291, 1, 1, 'Lhasa Apso'),
(292, 1, 1, 'Lithuanian Hound'),
(293, 1, 1, 'Longhaired Whippet'),
(294, 1, 1, 'Löwchen'),
(295, 1, 1, 'Magyar Agár'),
(296, 1, 1, 'Mahratta Greyhound'),
(297, 1, 1, 'Maltese'),
(298, 1, 1, 'Manchester Terrier'),
(299, 1, 1, 'Maremma Sheepdog'),
(300, 1, 1, 'McNab'),
(301, 1, 1, 'Mexican Hairless Dog'),
(302, 1, 1, 'Miniature Australian Shepherd'),
(303, 1, 1, 'Miniature American Shepherd'),
(304, 1, 1, 'Miniature Fox Terrier'),
(305, 1, 1, 'Miniature Pinscher'),
(306, 1, 1, 'Miniature Schnauzer'),
(307, 1, 1, 'Miniature Shar Pei'),
(308, 1, 1, 'Mioritic'),
(309, 1, 1, 'Molossus'),
(310, 1, 1, 'Montenegrin Mountain Hound'),
(311, 1, 1, 'Moscow Watchdog'),
(312, 1, 1, 'Moscow Water Dog'),
(313, 1, 1, 'Mountain Cur'),
(314, 1, 1, 'Mucuchies'),
(315, 1, 1, 'Mudhol Hound'),
(316, 1, 1, 'Mudi'),
(317, 1, 1, 'Münsterländer, Large'),
(318, 1, 1, 'Münsterländer, Small'),
(319, 1, 1, 'Neapolitan Mastiff'),
(320, 1, 1, 'Newfoundland'),
(321, 1, 1, 'New Zealand Heading Dog'),
(322, 1, 1, 'Norfolk Spaniel'),
(323, 1, 1, 'Norfolk Terrier'),
(324, 1, 1, 'Norrbottenspets'),
(325, 1, 1, 'North Country Beagle'),
(326, 1, 1, 'Northern Inuit Dog'),
(327, 1, 1, 'Norwegian Buhund'),
(328, 1, 1, 'Norwegian Elkhound'),
(329, 1, 1, 'Norwegian Lundehund'),
(330, 1, 1, 'Norwich Terrier'),
(331, 1, 1, 'Nova Scotia Duck-Tolling Retriever'),
(332, 1, 1, 'Old Croatian Sighthound'),
(333, 1, 1, 'Old Danish Pointer'),
(334, 1, 1, 'Old English Sheepdog'),
(335, 1, 1, 'Old English Terrier'),
(336, 1, 1, 'Old German Shepherd Dog'),
(337, 1, 1, 'Old Time Farm Shepherd'),
(338, 1, 1, 'Olde English Bulldogge'),
(339, 1, 1, 'Otterhound'),
(340, 1, 1, 'Pachon Navarro'),
(341, 1, 1, 'Pandikona'),
(342, 1, 1, 'Paisley Terrier'),
(343, 1, 1, 'Papillon'),
(344, 1, 1, 'Parson Russell Terrier'),
(345, 1, 1, 'Patterdale Terrier'),
(346, 1, 1, 'Pekingese'),
(347, 1, 1, 'Perro de Presa Canario'),
(348, 1, 1, 'Perro de Presa Mallorquin'),
(349, 1, 1, 'Peruvian Hairless Dog'),
(350, 1, 1, 'Phalène'),
(351, 1, 1, 'Pharaoh Hound'),
(352, 1, 1, 'Phu Quoc ridgeback dog'),
(353, 1, 1, 'Picardy Spaniel'),
(354, 1, 1, 'Plott Hound'),
(355, 1, 1, 'Podenco Canario'),
(356, 1, 1, 'Pointer'),
(357, 1, 1, 'Polish Greyhound'),
(358, 1, 1, 'Polish Hound'),
(359, 1, 1, 'Polish Hunting Dog'),
(360, 1, 1, 'Polish Lowland Sheepdog'),
(361, 1, 1, 'Polish Tatra Sheepdog'),
(362, 1, 1, 'Pomeranian'),
(363, 1, 1, 'Pont-Audemer Spaniel'),
(364, 1, 1, 'Poodle'),
(365, 1, 1, 'Porcelaine'),
(366, 1, 1, 'Portuguese Podengo'),
(367, 1, 1, 'Portuguese Pointer'),
(368, 1, 1, 'Portuguese Water Dog'),
(369, 1, 1, 'Posavac Hound'),
(370, 1, 1, 'Pražský Krysa?ík'),
(371, 1, 1, 'Pudelpointer'),
(372, 1, 1, 'Pug'),
(373, 1, 1, 'Puli'),
(374, 1, 1, 'Pumi'),
(375, 1, 1, 'Pungsan Dog'),
(376, 1, 1, 'Pyrenean Mastiff'),
(377, 1, 1, 'Pyrenean Shepherd'),
(378, 1, 1, 'Rafeiro do Alentejo'),
(379, 1, 1, 'Rajapalayam'),
(380, 1, 1, 'Rampur Greyhound'),
(381, 1, 1, 'Rastreador Brasileiro'),
(382, 1, 1, 'Ratonero Bodeguero Andaluz'),
(383, 1, 1, 'Ratonero Valenciano'),
(384, 1, 1, 'Rat Terrier'),
(385, 1, 1, 'Redbone Coonhound'),
(386, 1, 1, 'Rhodesian Ridgeback'),
(387, 1, 1, 'Rottweiler'),
(388, 1, 1, 'Russian Spaniel'),
(389, 1, 1, 'Russian Toy'),
(390, 1, 1, 'Russian tracker'),
(391, 1, 1, 'Russo-European Laika'),
(392, 1, 1, 'Russell Terrier'),
(393, 1, 1, 'Saarlooswolfhond'),
(394, 1, 1, 'Sabueso Español'),
(395, 1, 1, 'Saint-Usuge Spaniel'),
(396, 1, 1, 'Sakhalin Husky'),
(397, 1, 1, 'Saluki'),
(398, 1, 1, 'Samoyed'),
(399, 1, 1, 'Sapsali'),
(400, 1, 1, 'Šarplaninac'),
(401, 1, 1, 'Schapendoes'),
(402, 1, 1, 'Schillerstövare'),
(403, 1, 1, 'Schipperke'),
(404, 1, 1, 'Standard Schnauzer'),
(405, 1, 1, 'Schweizer Laufhund'),
(406, 1, 1, 'Schweizerischer Niederlaufhund'),
(407, 1, 1, 'Scotch Collie'),
(408, 1, 1, 'Scottish Deerhound'),
(409, 1, 1, 'Scottish Terrier'),
(410, 1, 1, 'Sealyham Terrier'),
(411, 1, 1, 'Segugio Italiano'),
(412, 1, 1, 'Seppala Siberian Sleddog'),
(413, 1, 1, 'Serbian Hound'),
(414, 1, 1, 'Serbian Tricolour Hound'),
(415, 1, 1, 'Shar Pei'),
(416, 1, 1, 'Shetland Sheepdog'),
(417, 1, 1, 'Shiba Inu'),
(418, 1, 1, 'Shih Tzu'),
(419, 1, 1, 'Shikoku'),
(420, 1, 1, 'Shiloh Shepherd Dog'),
(421, 1, 1, 'Siberian Husky'),
(422, 1, 1, 'Silken Windhound'),
(423, 1, 1, 'Sinhala Hound'),
(424, 1, 1, 'Skye Terrier'),
(425, 1, 1, 'Sloughi'),
(426, 1, 1, 'Slovak Cuvac'),
(427, 1, 1, 'Slovakian Rough-haired Pointer'),
(428, 1, 1, 'Slovenský Kopov'),
(429, 1, 1, 'Smålandsstövare'),
(430, 1, 1, 'Small Greek Domestic Dog'),
(431, 1, 1, 'Soft-Coated Wheaten Terrier'),
(432, 1, 1, 'South Russian Ovcharka'),
(433, 1, 1, 'Southern Hound'),
(434, 1, 1, 'Spanish Mastiff'),
(435, 1, 1, 'Spanish Water Dog'),
(436, 1, 1, 'Spinone Italiano'),
(437, 1, 1, 'Sporting Lucas Terrier'),
(438, 1, 1, 'St. Bernard'),
(439, 1, 1, 'St. John''s water dog'),
(440, 1, 1, 'Stabyhoun'),
(441, 1, 1, 'Staffordshire Bull Terrier'),
(442, 1, 1, 'Stephens Cur'),
(443, 1, 1, 'Styrian Coarse-haired Hound'),
(444, 1, 1, 'Sussex Spaniel'),
(445, 1, 1, 'Swedish Lapphund'),
(446, 1, 1, 'Swedish Vallhund'),
(447, 1, 1, 'Tahltan Bear Dog'),
(448, 1, 1, 'Taigan'),
(449, 1, 1, 'Talbot'),
(450, 1, 1, 'Tamaskan Dog'),
(451, 1, 1, 'Teddy Roosevelt Terrier'),
(452, 1, 1, 'Telomian'),
(453, 1, 1, 'Tennessee Treeing Brindle'),
(454, 1, 1, 'Tenterfield Terrier'),
(455, 1, 1, 'Thai Bangkaew Dog'),
(456, 1, 1, 'Thai Ridgeback'),
(457, 1, 1, 'Tibetan Mastiff'),
(458, 1, 1, 'Tibetan Spaniel'),
(459, 1, 1, 'Tibetan Terrier'),
(460, 1, 1, 'Tornjak'),
(461, 1, 1, 'Tosa'),
(462, 1, 1, 'Toy Bulldog'),
(463, 1, 1, 'Toy Fox Terrier'),
(464, 1, 1, 'Toy Manchester Terrier'),
(465, 1, 1, 'Toy Trawler Spaniel'),
(466, 1, 1, 'Transylvanian Hound'),
(467, 1, 1, 'Treeing Cur'),
(468, 1, 1, 'Treeing Walker Coonhound'),
(469, 1, 1, 'Trigg Hound'),
(470, 1, 1, 'Tweed Water Spaniel'),
(471, 1, 1, 'Tyrolean Hound'),
(472, 1, 1, 'Vizsla'),
(473, 1, 1, 'Volpino Italiano'),
(474, 1, 1, 'Weimaraner'),
(475, 1, 1, 'Welsh Corgi, Cardigan'),
(476, 1, 1, 'Welsh Corgi, Pembroke'),
(477, 1, 1, 'Welsh Sheepdog'),
(478, 1, 1, 'Welsh Springer Spaniel'),
(479, 1, 1, 'Welsh Terrier'),
(480, 1, 1, 'West Highland White Terrier'),
(481, 1, 1, 'West Siberian Laika'),
(482, 1, 1, 'Westphalian Dachsbracke'),
(483, 1, 1, 'Wetterhoun'),
(484, 1, 1, 'Whippet'),
(485, 1, 1, 'White Shepherd'),
(486, 1, 1, 'Wirehaired Pointing Griffon'),
(487, 1, 1, 'Wirehaired Vizsla'),
(488, 1, 1, 'Yorkshire Terrier'),
(489, 1, 2, 'Abyssinian'),
(490, 1, 2, 'Aegean cat'),
(491, 1, 2, 'Australian Mist'),
(492, 1, 2, 'American Curl'),
(493, 1, 2, 'American Bobtail'),
(494, 1, 2, 'American Polydactyl'),
(495, 1, 2, 'American Shorthair'),
(496, 1, 2, 'American Wirehair'),
(497, 1, 2, 'Arabian Mau'),
(498, 1, 2, 'Asian (cat)'),
(499, 1, 2, 'Asian Semi-longhair'),
(500, 1, 2, 'Balinese'),
(501, 1, 2, 'Bambino'),
(502, 1, 2, 'Bengal'),
(503, 1, 2, 'Birman'),
(504, 1, 2, 'Bombay'),
(505, 1, 2, 'Brazilian Shorthair'),
(506, 1, 2, 'British Shorthair'),
(507, 1, 2, 'British Longhair'),
(508, 1, 2, 'Burmese'),
(509, 1, 2, 'Burmilla'),
(510, 1, 2, 'California Spangled Cat'),
(511, 1, 2, 'Chantilly/Tiffany'),
(512, 1, 2, 'Chartreux'),
(513, 1, 2, 'Chausie'),
(514, 1, 2, 'Cheetoh'),
(515, 1, 2, 'Colorpoint Shorthair'),
(516, 1, 2, 'Cornish Rex'),
(517, 1, 2, 'Cymric'),
(518, 1, 2, 'Cyprus cat'),
(519, 1, 2, 'Devon Rex'),
(520, 1, 2, 'Donskoy'),
(521, 1, 2, 'Dragon Li'),
(522, 1, 2, 'Dwelf'),
(523, 1, 2, 'Egyptian Mau'),
(524, 1, 2, 'European Shorthair'),
(525, 1, 2, 'Exotic Shorthair'),
(526, 1, 2, 'German Rex'),
(527, 1, 2, 'Havana Brown'),
(528, 1, 2, 'Highlander'),
(529, 1, 2, 'Himalayan'),
(530, 1, 2, 'Colorpoint Persian'),
(531, 1, 2, 'Japanese Bobtail'),
(532, 1, 2, 'Javanese'),
(533, 1, 2, 'Khao Manee'),
(534, 1, 2, 'Korat'),
(535, 1, 2, 'Korn Ja'),
(536, 1, 2, 'Kurilian Bobtail'),
(537, 1, 2, 'LaPerm'),
(538, 1, 2, 'Maine Coon'),
(539, 1, 2, 'Manx'),
(540, 1, 2, 'Mekong bobtail'),
(541, 1, 2, 'Minskin'),
(542, 1, 2, 'Munchkin'),
(543, 1, 2, 'Nebelung'),
(544, 1, 2, 'Napoleon'),
(545, 1, 2, 'Norwegian Forest Cat'),
(546, 1, 2, 'Ocicat'),
(547, 1, 2, 'Ojos Azules'),
(548, 1, 2, 'Oregon Rex'),
(549, 1, 2, 'Oriental Bicolor'),
(550, 1, 2, 'Oriental Shorthair'),
(551, 1, 2, 'Oriental Longhair'),
(552, 1, 2, 'Persian'),
(553, 1, 2, 'Peterbald'),
(554, 1, 2, 'Pixie-bob'),
(555, 1, 2, 'Ragamuffin'),
(556, 1, 2, 'Ragdoll'),
(557, 1, 2, 'Russian Blue'),
(558, 1, 2, 'Russian Black, White or Tabby'),
(559, 1, 2, 'Sam Sawet'),
(560, 1, 2, 'Savannah'),
(561, 1, 2, 'Scottish Fold'),
(562, 1, 2, 'Selkirk Rex'),
(563, 1, 2, 'Serengeti cat'),
(564, 1, 2, 'Serrade petit'),
(565, 1, 2, 'Siamese'),
(566, 1, 2, 'Siberian'),
(567, 1, 2, 'Singapura'),
(568, 1, 2, 'Snowshoe'),
(569, 1, 2, 'Sokoke'),
(570, 1, 2, 'Somali'),
(571, 1, 2, 'Sphynx'),
(572, 1, 2, 'Swedish forest cat'),
(573, 1, 2, 'Thai'),
(574, 1, 2, 'Tonkinese'),
(575, 1, 2, 'Toyger'),
(576, 1, 2, 'Turkish Angora'),
(577, 1, 2, 'Turkish Van'),
(578, 1, 2, 'Ukrainian Levkoy'),
(579, 1, 2, 'York Chocolate Cat'),
(580, 1, 4, 'Canary'),
(581, 1, 4, 'Cockatiels'),
(582, 1, 4, 'Cockatoo'),
(583, 1, 4, 'General'),
(584, 1, 4, 'Lovebirds'),
(585, 1, 4, 'Macaw'),
(586, 1, 4, 'Parakeet'),
(587, 1, 4, 'Parrot'),
(588, 1, 4, 'Toucan'),
(589, 1, 3, 'Appendix Quarter horse'),
(590, 1, 3, 'Arabian'),
(591, 1, 3, 'General'),
(592, 1, 3, 'Quarter Horse'),
(593, 1, 3, 'Thoroughbred'),
(594, 1, 3, 'Trakhener'),
(595, 1, 3, 'Warmblood'),
(596, 1, 5, 'Cameleon'),
(597, 1, 5, 'General'),
(598, 1, 5, 'Iguana'),
(599, 1, 5, 'Snake'),
(600, 1, 5, 'Turtle'),
(601, 1, 6, 'Gerbil'),
(602, 1, 6, 'Guinea Pig'),
(603, 1, 6, 'Hamster'),
(604, 1, 6, 'Mice'),
(605, 1, 6, 'Prarie Dog'),
(606, 1, 7, 'Rabbit'),
(607, 1, 8, 'Domestic Ferret');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `pet_color`
--

CREATE TABLE IF NOT EXISTS `pet_color` (
`id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `v` tinytext NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `pet_color`
--

INSERT INTO `pet_color` (`id`, `status_id`, `v`) VALUES
(1, 3, 'Red'),
(2, 1, 'Blue'),
(3, 1, 'Green'),
(4, 3, 'Apricotttaaa'),
(5, 3, 'Apricot/White'),
(6, 3, 'Beige/White'),
(7, 3, 'Black/aasd'),
(8, 3, 'Black/brown'),
(9, 1, 'Black/gray'),
(10, 1, 'Black/tana'),
(11, 1, 'Black/white'),
(12, 1, 'Blonde'),
(13, 1, 'Blueeee'),
(14, 1, 'Blue merle/white'),
(15, 1, 'Blue Point'),
(16, 1, 'Blue Tri color'),
(17, 1, 'Blue-merle'),
(18, 1, 'Brindle'),
(19, 1, 'Brindle/white'),
(20, 1, 'Brown'),
(21, 1, 'Brown/black'),
(22, 1, 'Brown/white'),
(23, 1, 'Buff'),
(24, 1, 'Buff/white'),
(25, 1, 'Calico'),
(26, 1, 'Chocolate'),
(27, 1, 'Chocolate/white'),
(28, 1, 'Cream'),
(29, 1, 'Darkgold'),
(30, 1, 'Fawn'),
(31, 1, 'Fawn/white'),
(32, 1, 'Gold'),
(33, 1, 'Gray'),
(34, 1, 'Gray/black'),
(35, 1, 'Gray/white'),
(36, 1, 'Lightgold'),
(37, 1, 'Liver/white'),
(38, 1, 'Mahogany'),
(39, 1, 'Merle'),
(40, 1, 'Orange'),
(41, 1, 'Orange/white'),
(42, 1, 'Orangebelton'),
(43, 1, 'Point Blue'),
(44, 1, 'Point Flame'),
(45, 1, 'Point Lilac'),
(46, 1, 'Point Seal'),
(47, 1, 'Red Merle'),
(48, 1, 'Red/Blue'),
(49, 1, 'Sable'),
(50, 1, 'Sable/white'),
(51, 1, 'Salt&Pepper'),
(52, 1, 'Seal Point'),
(53, 1, 'Silver'),
(54, 1, 'Silver/tan'),
(55, 1, 'Tabby'),
(56, 1, 'Tan'),
(57, 1, 'Tan/black'),
(58, 1, 'Tan/white'),
(59, 1, 'Tortoiseshell'),
(60, 1, 'Tricolor'),
(61, 1, 'Wheaten'),
(62, 1, 'Wheaton'),
(63, 1, 'White'),
(64, 1, 'White with dark spots'),
(65, 1, 'White with black spots'),
(66, 1, 'White with brown spots'),
(67, 1, 'White with gray spots'),
(68, 1, 'White with liver spots'),
(69, 1, 'White/beige'),
(70, 1, 'White/black'),
(71, 1, 'White/brown'),
(72, 1, 'White/buff'),
(73, 1, 'White/chocolate'),
(74, 1, 'White/fawn'),
(75, 1, 'White/gray'),
(76, 1, 'White/liver'),
(77, 1, 'White/orange'),
(78, 1, 'White/sable'),
(79, 1, 'White/tan'),
(80, 1, 'Yellow'),
(81, 1, 'Yellow/white'),
(82, 3, 'asdad'),
(83, 3, 'Cat as'),
(84, 3, ''),
(85, 3, ''),
(86, 3, 'casaaa'),
(87, 3, ''),
(88, 3, 'asd'),
(89, 3, ''),
(90, 3, 'asda'),
(91, 3, 'asdaa'),
(92, 1, 'cas'),
(93, 3, 'cas');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `pet_sex`
--

CREATE TABLE IF NOT EXISTS `pet_sex` (
`id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `v` tinytext NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `pet_sex`
--

INSERT INTO `pet_sex` (`id`, `status_id`, `v`) VALUES
(1, 1, 'Male'),
(2, 1, 'Female'),
(3, 1, 'Neutered'),
(4, 1, 'Spayed');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `pet_size`
--

CREATE TABLE IF NOT EXISTS `pet_size` (
`id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `v` tinytext NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `pet_size`
--

INSERT INTO `pet_size` (`id`, `status_id`, `v`) VALUES
(1, 1, 'Small'),
(2, 1, 'Medium'),
(3, 1, 'Large'),
(4, 1, 'Miniature'),
(5, 1, 'Medium Large'),
(6, 1, 'Giant'),
(7, 1, 'Cat Sand'),
(8, 1, 'Other');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `pet_status`
--

CREATE TABLE IF NOT EXISTS `pet_status` (
`id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `v` tinytext NOT NULL,
  `price` float NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `pet_status`
--

INSERT INTO `pet_status` (`id`, `status_id`, `v`, `price`) VALUES
(1, 1, 'Agressive', 20),
(2, 1, 'Bully', 32.2),
(3, 1, 'Good natured', 0),
(4, 1, 'Handle with care', 12.2),
(5, 1, 'Runner', 0),
(6, 1, 'Dominant', 0),
(7, 1, 'Whiner', 0),
(8, 1, 'Fear biter', 0);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `pet_type`
--

CREATE TABLE IF NOT EXISTS `pet_type` (
`id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `v` tinytext NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `pet_type`
--

INSERT INTO `pet_type` (`id`, `status_id`, `v`) VALUES
(1, 1, 'Dog'),
(2, 1, 'Cat'),
(3, 1, 'Horse'),
(4, 1, 'Bird'),
(5, 1, 'Reptile'),
(6, 1, 'Rodent'),
(7, 1, 'Other'),
(8, 1, 'Ferret'),
(9, 1, 'pig');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `pet_vet`
--

CREATE TABLE IF NOT EXISTS `pet_vet` (
`id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `pet_id` int(11) DEFAULT NULL,
  `vet_id` int(11) DEFAULT NULL,
  `rabies` date DEFAULT NULL,
  `bordetella` date DEFAULT NULL,
  `d_h_l_p` date DEFAULT NULL,
  `fe_leuk` date DEFAULT NULL,
  `f_v_r_c_p` date DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `pet_vet`
--

INSERT INTO `pet_vet` (`id`, `status_id`, `pet_id`, `vet_id`, `rabies`, `bordetella`, `d_h_l_p`, `fe_leuk`, `f_v_r_c_p`) VALUES
(11, 1, 30, 3, '2014-09-04', NULL, '2014-09-02', NULL, NULL),
(12, 1, 27, 5, NULL, NULL, NULL, NULL, NULL),
(13, 1, 25, 3, '2014-10-27', NULL, NULL, NULL, NULL),
(14, 1, 22, 4, '2014-11-05', '2014-11-13', '2014-11-06', NULL, NULL),
(15, 1, 1, 3, '2015-03-17', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `pos_payments`
--

CREATE TABLE IF NOT EXISTS `pos_payments` (
`id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `payment_status_id` int(11) NOT NULL,
  `payment_type_id` int(11) NOT NULL DEFAULT '0',
  `required` float NOT NULL DEFAULT '0',
  `paid` float NOT NULL DEFAULT '0',
  `change` float NOT NULL,
  `unpaid` float NOT NULL,
  `information` text NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_modified` datetime DEFAULT NULL,
  `created_user_id` int(11) DEFAULT NULL,
  `modified_user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `pos_payments`
--

INSERT INTO `pos_payments` (`id`, `client_id`, `payment_status_id`, `payment_type_id`, `required`, `paid`, `change`, `unpaid`, `information`, `date_created`, `date_modified`, `created_user_id`, `modified_user_id`) VALUES
(1, 1, 1, 1, 10.1, 250, 239.9, 0, '{"o":{"print_type":"screen","promotion_id":"","promotion_discount":0,"coupon_discount":0,"language":"en","payment_type_id":1,"date_created":"2015-04-16 15:58:56","required":10.1,"paid":250,"change":239.9,"unpaid":0,"payment_status_id":1,"id":1,"date_modified":"2015-04-16 16:46:37","modified_user_id":"1"},"oo":[{"id":1,"status_id":1,"product_code":"12312534-15747","product_name":"Ear cleaning (cat)","price":5,"quantity":6,"at":0,"to":0,"tax":1,"class_id":1,"commission_percentage":40,"$$hashKey":"077","total":"10.10","margin_p":2.5,"margin_t":"0.25","markup_t":0,"sale_p":1.2,"sale_t":"0.12","damage_p":2.3,"damage_t":"0.23","whole_p":0,"whole_t":0,"comp_p":0,"comp_t":0,"employee_p":0,"employee_t":0,"tax_name":"State tax","tax_percentage":7,"tax_total":"0.70","o_tax_name":"","o_tax_percentage":0,"o_tax_total":0,"add_qty":2,"adaos":0.25,"discount":0.35,"coupon_total":0}]}', '2015-04-16 12:58:56', '2015-04-16 16:46:37', 1, 1),
(2, 1, 1, 1, 10.1, 12, 1.9, 0, '{"o":{"print_type":"screen","promotion_id":"","promotion_discount":0,"coupon_discount":0,"language":"en","payment_type_id":1,"date_created":"2015-04-16 17:23:44","required":10.1,"paid":12,"change":1.9000000000000004,"unpaid":0,"payment_status_id":1,"id":2,"date_modified":"2015-04-16 17:24:08","modified_user_id":"1"},"oo":[{"id":1,"status_id":1,"product_code":"12312534-15747","product_name":"Ear cleaning (cat)","price":5,"quantity":4,"at":0,"to":0,"tax":1,"class_id":1,"commission_percentage":40,"$$hashKey":"07A","total":"10.10","margin_p":2.5,"margin_t":"0.25","markup_t":0,"sale_p":1.2,"sale_t":"0.12","damage_p":2.3,"damage_t":"0.23","whole_p":0,"whole_t":0,"comp_p":0,"comp_t":0,"employee_p":0,"employee_t":0,"tax_name":"State tax","tax_percentage":7,"tax_total":"0.70","o_tax_name":"","o_tax_percentage":0,"o_tax_total":0,"add_qty":2,"adaos":0.25,"discount":0.35,"coupon_total":0}]}', '2015-04-16 14:23:44', '2015-04-16 17:24:08', 1, 1);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `promotions`
--

CREATE TABLE IF NOT EXISTS `promotions` (
`id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `promotion_code` varchar(255) NOT NULL,
  `promotion_name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `points` int(11) NOT NULL,
  `expiration_date` date NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `promotions`
--

INSERT INTO `promotions` (`id`, `status_id`, `promotion_code`, `promotion_name`, `description`, `points`, `expiration_date`) VALUES
(1, 1, '68793421', 'Cancel transasction', 'Scan to cancel all promoptions to current customer', 20, '2010-12-31'),
(2, 1, '24346546546', 'Bath special', 'Free 9.99 bath wash towel dry', 50, '2015-12-25'),
(3, 1, '1234656789', 'Hair', 'Some description', 100, '2015-12-26');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `promotions_settings`
--

CREATE TABLE IF NOT EXISTS `promotions_settings` (
`id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `n` varchar(255) NOT NULL,
  `v` varchar(255) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `promotions_settings`
--

INSERT INTO `promotions_settings` (`id`, `status_id`, `n`, `v`) VALUES
(1, 1, 'rewards_program_is_active', '1'),
(2, 1, 'points_per_dollar', '10'),
(3, 1, 'points_per_referral', '15');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `records_boarding`
--

CREATE TABLE IF NOT EXISTS `records_boarding` (
`id` int(11) NOT NULL,
  `status_id` tinyint(4) NOT NULL DEFAULT '1',
  `client_id` int(11) NOT NULL,
  `pet_id` int(11) NOT NULL,
  `charge_type` enum('charge_by_petsize','charge_by_runtype') NOT NULL,
  `charge_type_id` int(11) NOT NULL,
  `is_handle_carefully` tinyint(4) NOT NULL DEFAULT '0',
  `is_extra_pet` tinyint(4) NOT NULL DEFAULT '0',
  `stay_reason_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `records_boarding`
--

INSERT INTO `records_boarding` (`id`, `status_id`, `client_id`, `pet_id`, `charge_type`, `charge_type_id`, `is_handle_carefully`, `is_extra_pet`, `stay_reason_id`) VALUES
(1, 1, 1, 2, 'charge_by_runtype', 2, 1, 0, 3),
(2, 1, 0, 0, 'charge_by_petsize', 3, 0, 1, 3);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `records_daycare`
--

CREATE TABLE IF NOT EXISTS `records_daycare` (
`id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `client_id` int(11) NOT NULL,
  `pet_id` int(11) NOT NULL,
  `daycare_group_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `records_daycare`
--

INSERT INTO `records_daycare` (`id`, `status_id`, `client_id`, `pet_id`, `daycare_group_id`) VALUES
(1, 1, 1, 2, 1),
(2, 1, 2, 3, 1);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `records_grooming`
--

CREATE TABLE IF NOT EXISTS `records_grooming` (
`id` int(11) NOT NULL,
  `status_id` tinyint(4) NOT NULL DEFAULT '1',
  `client_id` int(11) NOT NULL,
  `pet_id` int(11) NOT NULL,
  `g_id` int(11) DEFAULT NULL,
  `gr_id` int(11) NOT NULL,
  `base_type_id` int(11) NOT NULL,
  `gs_ids` varchar(255) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `records_grooming`
--

INSERT INTO `records_grooming` (`id`, `status_id`, `client_id`, `pet_id`, `g_id`, `gr_id`, `base_type_id`, `gs_ids`) VALUES
(1, 1, 1, 2, 5, 2, 2, '["7",6,2]');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `records_meds_diets`
--

CREATE TABLE IF NOT EXISTS `records_meds_diets` (
`id` int(11) NOT NULL,
  `status_id` tinyint(4) NOT NULL DEFAULT '1',
  `client_id` int(11) NOT NULL,
  `pet_id` int(11) NOT NULL,
  `type` tinyint(4) NOT NULL DEFAULT '0',
  `md_id` int(11) NOT NULL,
  `md_instructions` text NOT NULL,
  `md_type_id` int(11) NOT NULL,
  `md_dosage_id` int(11) NOT NULL,
  `md_dose_type_id` int(11) NOT NULL,
  `md_morning` tinyint(4) NOT NULL DEFAULT '0',
  `md_afternoon` tinyint(4) NOT NULL DEFAULT '0',
  `md_evening` tinyint(4) NOT NULL DEFAULT '0',
  `md_as_needed` tinyint(4) NOT NULL DEFAULT '0',
  `md_date` int(11) NOT NULL,
  `md_everyday` tinyint(4) NOT NULL DEFAULT '0',
  `md_only_daycare` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `records_meds_diets`
--

INSERT INTO `records_meds_diets` (`id`, `status_id`, `client_id`, `pet_id`, `type`, `md_id`, `md_instructions`, `md_type_id`, `md_dosage_id`, `md_dose_type_id`, `md_morning`, `md_afternoon`, `md_evening`, `md_as_needed`, `md_date`, `md_everyday`, `md_only_daycare`) VALUES
(1, 3, 1, 2, 1, 4, 'adeqwe', 4, 13, 5, 0, 0, 0, 1, 0, 1, 0),
(2, 3, 1, 2, 1, 5, '', 2, 12, 5, 1, 0, 1, 0, 2015, 0, 1),
(3, 3, 1, 2, 1, 1, '', 4, 14, 5, 0, 0, 0, 1, 0, 1, 0),
(4, 3, 1, 2, 1, 7, '', 3, 16, 0, 0, 0, 0, 0, 0, 1, 0),
(5, 1, 1, 2, 2, 3, 'asdqwe', 2, 11, 4, 0, 0, 0, 1, 0, 1, 0),
(6, 1, 1, 2, 2, 4, 'qweqwe', 2, 13, 5, 0, 1, 1, 0, 2015, 0, 0),
(7, 3, 1, 2, 2, 4, '', 1, 16, 5, 0, 0, 0, 0, 0, 1, 1),
(8, 1, 1, 2, 1, 2, '', 1, 12, 3, 0, 1, 1, 0, 2015, 0, 0),
(9, 1, 1, 2, 1, 3, '', 2, 11, 0, 0, 0, 0, 1, 0, 1, 0),
(10, 1, 1, 2, 2, 4, '', 1, 14, 2, 0, 0, 0, 1, 0, 1, 0);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `records_services`
--

CREATE TABLE IF NOT EXISTS `records_services` (
`id` int(11) NOT NULL,
  `status_id` tinyint(4) NOT NULL DEFAULT '1',
  `client_id` int(11) NOT NULL,
  `pet_id` int(11) NOT NULL,
  `ss_id` int(11) NOT NULL,
  `no_charges` tinyint(4) NOT NULL,
  `is_every_day` tinyint(4) NOT NULL DEFAULT '1',
  `is_checkin_date` tinyint(4) NOT NULL DEFAULT '0',
  `is_checkout_date` tinyint(4) NOT NULL DEFAULT '0',
  `schedule` varchar(255) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `records_services`
--

INSERT INTO `records_services` (`id`, `status_id`, `client_id`, `pet_id`, `ss_id`, `no_charges`, `is_every_day`, `is_checkin_date`, `is_checkout_date`, `schedule`) VALUES
(1, 1, 1, 3, 6, 1, 1, 0, 0, 'schedule_always'),
(2, 3, 1, 3, 5, 1, 1, 0, 0, 'only_boarding'),
(3, 1, 1, 3, 2, 2, 1, 0, 0, 'only_boarding'),
(4, 3, 1, 2, 1, 1, 1, 0, 0, 'schedule_always'),
(5, 3, 1, 2, 4, 1, 1, 0, 0, 'schedule_always'),
(6, 1, 1, 2, 1, 2, 1, 1, 1, 'only_daycare'),
(7, 1, 1, 2, 2, 1, 1, 0, 1, 'schedule_always'),
(8, 3, 1, 2, 5, 5, 1, 1, 0, 'only_boarding');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `records_training`
--

CREATE TABLE IF NOT EXISTS `records_training` (
`id` int(11) NOT NULL,
  `status_id` tinyint(4) NOT NULL DEFAULT '1',
  `client_id` int(11) NOT NULL,
  `pet_id` int(11) NOT NULL,
  `trainer_id` int(11) NOT NULL,
  `trainer_notepad` text NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `records_training`
--

INSERT INTO `records_training` (`id`, `status_id`, `client_id`, `pet_id`, `trainer_id`, `trainer_notepad`) VALUES
(1, 1, 1, 3, 8, 'adad'),
(2, 1, 1, 2, 8, 'asdqweq');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `retail_classes`
--

CREATE TABLE IF NOT EXISTS `retail_classes` (
  `id` int(11) NOT NULL,
  `status_id` tinyint(4) NOT NULL DEFAULT '1',
  `class_name` varchar(255) NOT NULL,
  `margin` float NOT NULL DEFAULT '0',
  `markup` float NOT NULL DEFAULT '0',
  `sale` float NOT NULL DEFAULT '0',
  `damage` float NOT NULL DEFAULT '0',
  `whole` float NOT NULL DEFAULT '0',
  `comp` float NOT NULL DEFAULT '0',
  `employee` float NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `retail_classes`
--

INSERT INTO `retail_classes` (`id`, `status_id`, `class_name`, `margin`, `markup`, `sale`, `damage`, `whole`, `comp`, `employee`) VALUES
(1, 1, 'Accessories', 2.5, 0, 1.2, 2.3, 0, 0, 0),
(2, 1, 'Animal Medic Inc', 20, 0, 10, 20, 0, 100, 7),
(3, 1, 'Artemis', 25, 0, 10, 20, 0, 100, 7),
(4, 1, 'Beds for pets', 30, 0, 10, 20, 0, 100, 7),
(5, 1, 'Cloud star', 25.21, 0, 10, 20, 0, 100, 15),
(6, 1, 'Juice', 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `retail_inventory`
--

CREATE TABLE IF NOT EXISTS `retail_inventory` (
  `id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `product_code` varchar(255) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `price` float NOT NULL,
  `quantity` int(11) NOT NULL,
  `at` int(11) NOT NULL,
  `to` int(11) NOT NULL,
  `tax` tinyint(4) NOT NULL DEFAULT '1',
  `class_id` int(11) NOT NULL,
  `commission_percentage` float NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `retail_inventory`
--

INSERT INTO `retail_inventory` (`id`, `status_id`, `product_code`, `product_name`, `price`, `quantity`, `at`, `to`, `tax`, `class_id`, `commission_percentage`) VALUES
(1, 1, '12312534-15747', 'Ear cleaning (cat)', 5, 4, 0, 0, 1, 1, 40),
(2, 1, '65789-4967', 'Something cool', 20, 38, 0, 0, 1, 1, 45),
(3, 1, '134968997', 'CocaCola', 23.5, 50, 0, 0, 1, 1, 45);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `retail_vendors`
--

CREATE TABLE IF NOT EXISTS `retail_vendors` (
  `id` int(11) NOT NULL,
  `status_id` tinyint(4) NOT NULL DEFAULT '1',
  `name` varchar(255) NOT NULL,
  `account` varchar(255) NOT NULL,
  `contact` varchar(255) NOT NULL,
  `alt_contact` varchar(255) NOT NULL,
  `street` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  `zip` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `fax` varchar(255) NOT NULL,
  `alt_phone` varchar(255) NOT NULL,
  `other` varchar(255) NOT NULL,
  `terms` varchar(255) NOT NULL,
  `comments` varchar(255) NOT NULL,
  `website` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `retail_vendors`
--

INSERT INTO `retail_vendors` (`id`, `status_id`, `name`, `account`, `contact`, `alt_contact`, `street`, `city`, `state`, `zip`, `phone`, `fax`, `alt_phone`, `other`, `terms`, `comments`, `website`, `email`) VALUES
(3, 1, 'PetsMart', 'PetsMart', '', '', '', '', '', '', '', '', '', '', '', '', '', ''),
(4, 1, 'Pedigree', 'Pedigree', '', '', '', '', '', '', '', '', '', '', '', '', '', '');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `retail_vi`
--

CREATE TABLE IF NOT EXISTS `retail_vi` (
  `id` int(11) NOT NULL,
  `status_id` tinyint(4) NOT NULL DEFAULT '1',
  `retail_vendor_id` int(11) NOT NULL,
  `retail_inventory_id` int(11) NOT NULL,
  `our_cost` float NOT NULL DEFAULT '0',
  `reorder_number` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `retail_vi`
--

INSERT INTO `retail_vi` (`id`, `status_id`, `retail_vendor_id`, `retail_inventory_id`, `our_cost`, `reorder_number`) VALUES
(7, 1, 3, 2, 20, 0),
(8, 1, 4, 3, 10, 0);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `role`
--

CREATE TABLE IF NOT EXISTS `role` (
`id` int(11) NOT NULL,
  `n` varchar(255) NOT NULL,
  `v` tinytext NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `role`
--

INSERT INTO `role` (`id`, `n`, `v`) VALUES
(1, 'administrator', 'Administrator'),
(2, 'groomer', 'Groomer'),
(3, 'trainer', 'Trainer'),
(4, 'cleaning_staff', 'Cleaning Staff'),
(5, 'groomer_manager', 'Groomer Manager'),
(6, 'manager_junior', 'Manager Junior'),
(7, 'mananger_senior', 'Manager Senior'),
(8, 'manager_trainee', 'Manager Trainee'),
(9, 'owner', 'Owner'),
(10, 'receptionist', 'Receptionist'),
(11, 'staff', 'Staff');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `r_boarding`
--

CREATE TABLE IF NOT EXISTS `r_boarding` (
`id` int(11) NOT NULL,
  `status_id` int(11) DEFAULT '1',
  `client_id` int(11) NOT NULL,
  `pet_id` int(11) DEFAULT NULL,
  `stay_reason_id` int(11) NOT NULL,
  `luggage` varchar(255) NOT NULL,
  `deposit` float NOT NULL,
  `did_deposit` tinyint(4) NOT NULL DEFAULT '0',
  `charge_type` enum('charge_by_petsize','charge_by_runtype') NOT NULL,
  `charge_type_id` int(11) NOT NULL,
  `is_handle_carefully` tinyint(4) NOT NULL DEFAULT '0',
  `is_extra_pet` tinyint(4) NOT NULL DEFAULT '0',
  `in_out` enum('in','out') NOT NULL DEFAULT 'in',
  `is_halfday` tinyint(4) NOT NULL DEFAULT '2',
  `date_in` date DEFAULT NULL,
  `time_in` time DEFAULT NULL,
  `date_out` date DEFAULT NULL,
  `time_out` time DEFAULT NULL,
  `date_checkout` date DEFAULT NULL,
  `time_checkout` time DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `r_boarding`
--

INSERT INTO `r_boarding` (`id`, `status_id`, `client_id`, `pet_id`, `stay_reason_id`, `luggage`, `deposit`, `did_deposit`, `charge_type`, `charge_type_id`, `is_handle_carefully`, `is_extra_pet`, `in_out`, `is_halfday`, `date_in`, `time_in`, `date_out`, `time_out`, `date_checkout`, `time_checkout`) VALUES
(2, 1, 1, 2, 3, '', 0, 0, 'charge_by_runtype', 2, 1, 0, 'out', 2, '2015-04-21', '12:06:43', '2015-04-21', '12:06:43', '2015-04-21', '12:12:02');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `r_daycare`
--

CREATE TABLE IF NOT EXISTS `r_daycare` (
`id` int(11) NOT NULL,
  `status_id` int(11) DEFAULT '1',
  `pet_id` int(11) DEFAULT NULL,
  `client_id` int(11) NOT NULL,
  `daycare_group_id` int(11) NOT NULL,
  `in_out` enum('in','out') NOT NULL,
  `date_in` date DEFAULT NULL,
  `time_in` time DEFAULT NULL,
  `date_out` date DEFAULT NULL,
  `time_out` time DEFAULT NULL,
  `date_checkout` date NOT NULL,
  `time_checkout` time NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `r_daycare`
--

INSERT INTO `r_daycare` (`id`, `status_id`, `pet_id`, `client_id`, `daycare_group_id`, `in_out`, `date_in`, `time_in`, `date_out`, `time_out`, `date_checkout`, `time_checkout`) VALUES
(1, 1, 2, 1, 1, 'in', '2015-04-21', '12:40:49', '2015-04-21', NULL, '0000-00-00', '00:00:00');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `r_diets`
--

CREATE TABLE IF NOT EXISTS `r_diets` (
`id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `client_id` int(11) NOT NULL,
  `pet_id` int(11) NOT NULL,
  `r_type` varchar(255) NOT NULL,
  `r_id` int(11) NOT NULL,
  `diet_id` int(11) NOT NULL,
  `diet_instructions` varchar(255) NOT NULL,
  `diet_type_id` int(11) NOT NULL,
  `diet_dosage_id` int(11) NOT NULL,
  `diet_dose_type_id` int(11) NOT NULL,
  `diet_morning` tinyint(4) NOT NULL DEFAULT '0',
  `diet_afternoon` tinyint(4) NOT NULL DEFAULT '0',
  `diet_evening` tinyint(4) NOT NULL DEFAULT '0',
  `diet_as_needed` tinyint(4) NOT NULL DEFAULT '0',
  `diet_date` date NOT NULL,
  `diet_everyday` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `r_diets`
--

INSERT INTO `r_diets` (`id`, `status_id`, `client_id`, `pet_id`, `r_type`, `r_id`, `diet_id`, `diet_instructions`, `diet_type_id`, `diet_dosage_id`, `diet_dose_type_id`, `diet_morning`, `diet_afternoon`, `diet_evening`, `diet_as_needed`, `diet_date`, `diet_everyday`) VALUES
(1, 3, 1, 2, 'r_boarding', 1, 3, 'asdqwe', 2, 11, 4, 0, 0, 0, 1, '0000-00-00', 1),
(2, 3, 1, 2, 'r_boarding', 1, 4, 'qweqwe', 2, 13, 5, 0, 1, 1, 0, '0000-00-00', 0),
(3, 3, 1, 2, 'r_boarding', 1, 3, 'asdqwe', 2, 11, 4, 0, 0, 0, 1, '0000-00-00', 1),
(4, 3, 1, 2, 'r_boarding', 1, 4, 'qweqwe', 2, 13, 5, 0, 1, 1, 0, '0000-00-00', 0),
(5, 3, 1, 2, 'r_boarding', 1, 3, 'asdqwe', 2, 11, 4, 0, 0, 0, 1, '0000-00-00', 1),
(6, 3, 1, 2, 'r_boarding', 1, 3, 'asdqwe', 2, 11, 4, 0, 0, 0, 1, '0000-00-00', 1),
(7, 3, 1, 2, 'r_boarding', 1, 4, 'qweqwe', 2, 13, 5, 0, 1, 1, 0, '0000-00-00', 0),
(8, 1, 1, 2, 'r_boarding', 1, 3, 'asdqwe', 2, 11, 4, 0, 0, 0, 1, '0000-00-00', 1),
(9, 1, 1, 2, 'r_boarding', 1, 4, 'qweqwe', 2, 13, 5, 0, 1, 1, 0, '0000-00-00', 0),
(10, 1, 1, 2, 'r_daycare', 4, 3, 'asdqwe', 2, 11, 4, 0, 0, 0, 1, '0000-00-00', 1),
(11, 1, 1, 2, 'r_daycare', 4, 4, 'qweqwe', 2, 13, 5, 0, 1, 1, 0, '0000-00-00', 0),
(12, 1, 1, 2, 'r_daycare', 4, 5, '', 3, 3, 5, 0, 0, 0, 1, '0000-00-00', 1),
(13, 1, 1, 2, 'r_boarding', 1, 5, '', 3, 3, 5, 0, 0, 0, 1, '0000-00-00', 1),
(14, 3, 1, 2, 'r_grooms', 1, 3, '', 4, 2, 0, 0, 0, 0, 1, '0000-00-00', 1),
(15, 1, 1, 2, 'r_boarding', 1, 3, 'asdqwe', 2, 11, 4, 0, 0, 0, 1, '0000-00-00', 1),
(16, 1, 1, 2, 'r_boarding', 1, 4, 'qweqwe', 2, 13, 5, 0, 1, 1, 0, '0000-00-00', 0),
(17, 1, 1, 2, 'r_boarding', 1, 4, '', 1, 14, 2, 0, 0, 0, 1, '0000-00-00', 1),
(18, 1, 1, 2, 'r_boarding', 2, 3, 'asdqwe', 2, 11, 4, 0, 0, 0, 1, '0000-00-00', 1),
(19, 1, 1, 2, 'r_boarding', 2, 4, 'qweqwe', 2, 13, 5, 0, 1, 1, 0, '0000-00-00', 0),
(20, 1, 1, 2, 'r_boarding', 2, 4, '', 1, 14, 2, 0, 0, 0, 1, '0000-00-00', 1);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `r_grooms`
--

CREATE TABLE IF NOT EXISTS `r_grooms` (
`id` int(11) NOT NULL,
  `status_id` int(11) DEFAULT '1',
  `client_id` int(11) NOT NULL,
  `pet_id` int(11) DEFAULT NULL,
  `groomer_id` int(11) NOT NULL,
  `base_type_id` int(11) DEFAULT NULL,
  `grooming_rate_id` int(11) NOT NULL,
  `multiplier` float NOT NULL DEFAULT '0',
  `gs_array` varchar(255) NOT NULL,
  `in_out` enum('in','out') NOT NULL DEFAULT 'in',
  `date_in` date DEFAULT NULL,
  `time_in` time DEFAULT NULL,
  `date_out` date DEFAULT NULL,
  `time_out` time DEFAULT NULL,
  `date_checkout` date NOT NULL,
  `time_checkout` time NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `r_grooms`
--

INSERT INTO `r_grooms` (`id`, `status_id`, `client_id`, `pet_id`, `groomer_id`, `base_type_id`, `grooming_rate_id`, `multiplier`, `gs_array`, `in_out`, `date_in`, `time_in`, `date_out`, `time_out`, `date_checkout`, `time_checkout`) VALUES
(1, 1, 1, 2, 5, 2, 2, 0.5, '["6","7"]', 'in', '2015-03-28', '12:39:33', '2015-03-28', NULL, '0000-00-00', '00:00:00');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `r_meds`
--

CREATE TABLE IF NOT EXISTS `r_meds` (
`id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `client_id` int(11) NOT NULL,
  `pet_id` int(11) NOT NULL,
  `r_type` varchar(255) NOT NULL,
  `r_id` int(11) NOT NULL,
  `med_id` int(11) NOT NULL,
  `med_instructions` varchar(255) NOT NULL,
  `med_type_id` int(11) NOT NULL,
  `med_dosage_id` int(11) NOT NULL,
  `med_dose_type_id` int(11) NOT NULL,
  `med_morning` tinyint(4) NOT NULL DEFAULT '0',
  `med_afternoon` tinyint(4) NOT NULL DEFAULT '0',
  `med_evening` tinyint(4) NOT NULL DEFAULT '0',
  `med_as_needed` tinyint(4) NOT NULL DEFAULT '0',
  `med_date` date NOT NULL,
  `med_everyday` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `r_meds`
--

INSERT INTO `r_meds` (`id`, `status_id`, `client_id`, `pet_id`, `r_type`, `r_id`, `med_id`, `med_instructions`, `med_type_id`, `med_dosage_id`, `med_dose_type_id`, `med_morning`, `med_afternoon`, `med_evening`, `med_as_needed`, `med_date`, `med_everyday`) VALUES
(1, 3, 1, 2, 'r_boarding', 1, 4, '', 2, 2, 0, 0, 0, 0, 0, '0000-00-00', 1),
(2, 3, 1, 2, 'r_boarding', 1, 4, 'adeqwe', 4, 13, 5, 0, 0, 0, 1, '0000-00-00', 1),
(3, 3, 1, 2, 'r_boarding', 1, 1, '', 4, 14, 5, 0, 0, 0, 1, '0000-00-00', 1),
(4, 3, 1, 2, 'r_boarding', 1, 4, 'adeqwe', 4, 13, 5, 0, 0, 0, 1, '0000-00-00', 1),
(5, 3, 1, 2, 'r_boarding', 1, 4, 'adeqwe', 4, 13, 5, 0, 0, 0, 1, '0000-00-00', 1),
(6, 3, 1, 2, 'r_boarding', 1, 1, '', 4, 14, 5, 0, 0, 0, 1, '0000-00-00', 1),
(7, 1, 1, 2, 'r_daycare', 2, 1, '', 2, 5, 0, 0, 0, 0, 1, '0000-00-00', 1),
(8, 1, 1, 2, 'r_daycare', 2, 2, '', 1, 12, 3, 0, 1, 1, 0, '2015-03-24', 0),
(9, 1, 1, 2, 'r_daycare', 4, 2, '', 1, 12, 3, 0, 1, 1, 0, '0000-00-00', 0),
(10, 1, 1, 2, 'r_daycare', 4, 4, '', 2, 2, 3, 0, 0, 0, 1, '0000-00-00', 1),
(11, 1, 1, 2, 'r_daycare', 4, 7, '', 2, 2, 3, 0, 0, 0, 1, '0000-00-00', 1),
(12, 1, 1, 2, 'r_boarding', 1, 7, '', 2, 2, 3, 0, 0, 0, 1, '0000-00-00', 1),
(13, 3, 1, 2, 'r_grooms', 1, 3, '', 3, 4, 0, 0, 0, 0, 0, '0000-00-00', 1),
(14, 3, 1, 2, 'r_grooms', 1, 2, '', 2, 3, 4, 0, 0, 0, 0, '0000-00-00', 1),
(15, 3, 1, 2, 'r_grooms', 1, 7, '', 2, 3, 4, 0, 0, 0, 0, '0000-00-00', 1),
(16, 1, 1, 2, 'r_boarding', 1, 2, '', 1, 12, 3, 0, 1, 1, 0, '0000-00-00', 0),
(17, 1, 1, 2, 'r_boarding', 1, 3, '', 2, 11, 0, 0, 0, 0, 1, '0000-00-00', 1),
(18, 1, 1, 2, 'r_boarding', 2, 2, '', 1, 12, 3, 0, 1, 1, 0, '0000-00-00', 0),
(19, 1, 1, 2, 'r_boarding', 2, 3, '', 2, 11, 0, 0, 0, 0, 1, '0000-00-00', 1);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `r_ss`
--

CREATE TABLE IF NOT EXISTS `r_ss` (
`id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `client_id` int(11) NOT NULL,
  `pet_id` int(11) NOT NULL,
  `r_type` varchar(255) NOT NULL,
  `r_id` int(11) NOT NULL,
  `ss_id` int(11) NOT NULL,
  `ss_price` float NOT NULL DEFAULT '0',
  `ss_times` int(11) NOT NULL,
  `ss_instructions` varchar(255) NOT NULL,
  `ss_exclude_checkin` tinyint(4) NOT NULL DEFAULT '0',
  `ss_exclude_checkout` tinyint(4) NOT NULL DEFAULT '0',
  `ss_date` date NOT NULL,
  `ss_everyday` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `r_ss`
--

INSERT INTO `r_ss` (`id`, `status_id`, `client_id`, `pet_id`, `r_type`, `r_id`, `ss_id`, `ss_price`, `ss_times`, `ss_instructions`, `ss_exclude_checkin`, `ss_exclude_checkout`, `ss_date`, `ss_everyday`) VALUES
(1, 3, 1, 2, 'r_boarding', 1, 1, 20, 1, '', 0, 0, '0000-00-00', 1),
(2, 1, 1, 2, 'r_boarding', 1, 1, 20, 2, '', 0, 0, '0000-00-00', 1),
(3, 1, 1, 2, 'r_boarding', 1, 2, 25, 1, '', 1, 0, '0000-00-00', 1),
(4, 3, 1, 2, 'r_daycare', 2, 2, 25, 1, '', 1, 0, '0000-00-00', 1),
(5, 1, 1, 2, 'r_daycare', 2, 1, 20, 2, '', 0, 0, '0000-00-00', 1),
(6, 1, 1, 2, 'r_daycare', 2, 2, 25, 1, '', 1, 0, '0000-00-00', 1),
(7, 3, 1, 2, 'r_grooms', 1, 2, 25, 1, '', 1, 0, '0000-00-00', 1),
(8, 1, 1, 2, 'r_daycare', 4, 2, 25, 1, '', 0, 0, '0000-00-00', 1),
(9, 1, 1, 2, 'r_daycare', 4, 5, 3, 1, '', 0, 0, '0000-00-00', 1),
(10, 1, 1, 2, 'r_boarding', 1, 5, 3, 1, '', 0, 0, '0000-00-00', 1),
(11, 3, 1, 2, 'r_grooms', 1, 1, 20, 1, '', 0, 0, '0000-00-00', 1),
(12, 3, 1, 2, 'r_grooms', 1, 2, 25, 1, '', 1, 0, '0000-00-00', 1),
(13, 1, 1, 2, 'r_grooms', 1, 2, 25, 1, '', 1, 0, '0000-00-00', 1),
(14, 1, 1, 2, 'r_boarding', 5, 2, 25, 1, '', 1, 0, '0000-00-00', 1),
(15, 1, 1, 2, 'r_boarding', 1, 2, 25, 1, '', 1, 0, '0000-00-00', 1),
(16, 1, 1, 2, 'r_boarding', 2, 2, 25, 1, '', 1, 0, '0000-00-00', 1);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `r_training`
--

CREATE TABLE IF NOT EXISTS `r_training` (
`id` int(11) NOT NULL,
  `status_id` int(11) DEFAULT '1',
  `client_id` int(11) NOT NULL,
  `pet_id` int(11) DEFAULT NULL,
  `ts_id` int(11) NOT NULL,
  `tg_id` int(11) NOT NULL,
  `t_id` int(11) NOT NULL,
  `instructions` text NOT NULL,
  `in_out` enum('in','out') NOT NULL,
  `date_in` date NOT NULL,
  `time_in` time NOT NULL,
  `date_out` date NOT NULL,
  `time_out` time NOT NULL,
  `date_checkout` date NOT NULL,
  `time_checkout` time NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `r_training`
--

INSERT INTO `r_training` (`id`, `status_id`, `client_id`, `pet_id`, `ts_id`, `tg_id`, `t_id`, `instructions`, `in_out`, `date_in`, `time_in`, `date_out`, `time_out`, `date_checkout`, `time_checkout`) VALUES
(1, 3, 1, 2, 1, 1, 8, 'asdqweq', 'in', '2015-03-29', '20:00:00', '2015-04-01', '22:00:00', '0000-00-00', '00:00:00'),
(2, 1, 1, 2, 1, 1, 8, 'asdqweq', 'in', '2015-03-29', '20:00:00', '2015-03-29', '22:00:00', '0000-00-00', '00:00:00');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `schedule_services`
--

CREATE TABLE IF NOT EXISTS `schedule_services` (
`id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `v` varchar(255) NOT NULL,
  `service_description` varchar(255) NOT NULL,
  `price` float NOT NULL DEFAULT '0',
  `is_special` tinyint(4) NOT NULL DEFAULT '0',
  `limit` int(11) NOT NULL,
  `is_hcp` tinyint(4) NOT NULL DEFAULT '0',
  `order` int(11) NOT NULL,
  `is_pickup_and_delivery` tinyint(4) NOT NULL DEFAULT '0',
  `daycare_group_id` int(11) NOT NULL DEFAULT '0',
  `commission_percentage` float NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `schedule_services`
--

INSERT INTO `schedule_services` (`id`, `status_id`, `v`, `service_description`, `price`, `is_special`, `limit`, `is_hcp`, `order`, `is_pickup_and_delivery`, `daycare_group_id`, `commission_percentage`) VALUES
(1, 1, 'Basic Obedience', '', 20, 0, 0, 0, 0, 0, 0, 20),
(2, 1, 'Sunday Check in / out', '', 25, 0, 0, 0, 0, 0, 0, 20),
(3, 1, 'Behaviour Training', '', 10, 0, 0, 0, 0, 0, 0, 20),
(4, 1, 'Trip to the vet', '', 50, 0, 0, 0, 0, 0, 0, 20),
(5, 1, 'Special needs', '', 3, 0, 0, 0, 0, 0, 0, 20),
(6, 1, 'Airport trip', '', 50, 0, 0, 0, 0, 0, 0, 20),
(7, 1, 'Bordetella Vaccine', '', 25, 0, 0, 0, 0, 0, 0, 20);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `season`
--

CREATE TABLE IF NOT EXISTS `season` (
  `id` int(11) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `is_mon` tinyint(4) NOT NULL DEFAULT '1',
  `is_tue` tinyint(4) DEFAULT '1',
  `is_wed` tinyint(4) NOT NULL DEFAULT '1',
  `is_thu` tinyint(4) NOT NULL DEFAULT '1',
  `is_fri` tinyint(4) NOT NULL DEFAULT '1',
  `is_sat` tinyint(4) NOT NULL DEFAULT '0',
  `is_sun` tinyint(4) NOT NULL DEFAULT '0',
  `in_use` tinyint(4) NOT NULL DEFAULT '1',
  `v` varchar(255) NOT NULL,
  `modifier_id` tinyint(1) NOT NULL DEFAULT '1',
  `rate` float NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `season`
--

INSERT INTO `season` (`id`, `start_date`, `end_date`, `is_mon`, `is_tue`, `is_wed`, `is_thu`, `is_fri`, `is_sat`, `is_sun`, `in_use`, `v`, `modifier_id`, `rate`) VALUES
(1, '2015-01-01', '2015-05-01', 1, 1, 1, 1, 0, 0, 0, 1, 'Low season', 2, 20),
(2, '2015-05-03', '2015-09-01', 1, 1, 0, 1, 1, 0, 0, 0, 'High season', 1, 15),
(3, '2015-12-16', '2015-12-26', 1, 1, 1, 1, 1, 0, 0, 0, 'Christmas season', 2, 15);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `security_levels`
--

CREATE TABLE IF NOT EXISTS `security_levels` (
`id` int(11) NOT NULL,
  `n` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `t` varchar(255) NOT NULL,
  `t_title` varchar(255) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `security_levels`
--

INSERT INTO `security_levels` (`id`, `n`, `title`, `t`, `t_title`) VALUES
(1, 'boarding_waiting_list', 'Boarding, waiting list', 'add_reservations', 'Add Reservations'),
(2, 'grooming_and_trainig', 'Grooming & Training', 'add_reservations', 'Add Reservations'),
(3, 'daycare', 'Daycare', 'add_reservations', 'Add Reservations'),
(4, 'all_boarding', 'All boarding', 'edit_reservations', 'Edit Reservations'),
(5, 'all_grooming', 'All grooming', 'edit_reservations', 'Edit Reservations'),
(6, 'all_daycare', 'All daycare', 'edit_reservations', 'Edit Reservations'),
(7, 'own_grooming', 'Own grooming', 'edit_reservations', 'Edit Reservations'),
(8, 'all_boarding', 'All boarding', 'delete_reservations', 'Delete reservations'),
(9, 'grooming_and_training', 'Grooming & training', 'delete_reservations', 'Delete reservations'),
(10, 'all_daycare', 'All daycare', 'delete_reservations', 'Delete reservations'),
(11, 'own_grooming', 'Own grooming', 'delete_reservations', 'Delete reservations'),
(12, 'checkin_date', 'Check in date', 'edit', 'Edit'),
(13, 'boarding_rate', 'Boarding rate', 'edit', 'Edit'),
(14, 'waiting_list', 'Waiting List', 'edit', 'Edit'),
(15, 'checkout_discounts', 'Checkout discounts', 'edit', 'Edit'),
(16, 'preferred_groomer', 'Preffered groomer', 'edit', 'Edit'),
(17, 'security_lock', 'Security lock', 'protection', 'Protection'),
(18, 'system_restore', 'System restore', 'protection', 'Protection'),
(19, 'k9_koordinator', 'K9 Koordinator', 'access', 'Access'),
(20, 'point_of_sale', 'Point of sale', 'access', 'Access'),
(21, 'cash_drawer', 'Cash drawer', 'access', 'Access'),
(22, 'delete_client_pets_meds_and_diets', 'Delete client, pets, meds & diets', 'access', 'Access'),
(23, 'customer_private', 'Customer private', 'access', 'Access'),
(24, 'credit_card_customer_file_pet_file', 'Credit card, customer file, pet file', 'access', 'Access'),
(25, 'checkin_checkout_manager_and_run_transfers', 'Checkin, checkout, manager & run transfers', 'access', 'Access'),
(26, 'refunds_and_manual_discounts', 'Refunds & manual discounts', 'access', 'Access'),
(27, 'credits', 'Credits', 'access', 'Access'),
(28, 'mailing_system_and_report_cards', 'Mailing system and report cards', 'access', 'Access'),
(29, 'financial_reports', 'Financial reports', 'view_reports', 'View reports'),
(30, 'general_reports', 'General reports', 'view_reports', 'View reports'),
(31, 'security_log', 'Security log', 'view_reports', 'View reports'),
(32, 'marketing_and_kennel_totals', 'Marketing & kennel totals', 'view_reports', 'View reports'),
(33, 'history_reports_and_last_bills', 'History reports and last bills', 'view_reports', 'View reports'),
(34, 'all_setup_screens', 'All setup screens', 'setup_access', 'Setup access'),
(35, 'records_editing', 'Records editing', 'setup_access', 'Setup access'),
(36, 'password_management', 'Password management', 'setup_access', 'Setup access'),
(37, 'sec_center_and_employees', 'Sec. center & employees', 'setup_access', 'Setup access'),
(38, 'sec_level_mgt_edit_trx_credit_card_setup', 'Sec. Level Mgt, Edit Trx, Credit card setup', 'setup_access', 'Setup access'),
(39, 'training_breeds_colors_vets', 'Training breeds, colors, vets', 'setup_access', 'Setup access'),
(40, 'add_med_diets_po_inventory_time_schedule', 'Add med/diets, PO, inventory, time schedule', 'setup_access', 'Setup access');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `settings`
--

CREATE TABLE IF NOT EXISTS `settings` (
`id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `n` tinytext NOT NULL,
  `v` tinytext NOT NULL,
  `t` tinytext NOT NULL,
  `j` tinytext NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `settings`
--

INSERT INTO `settings` (`id`, `status_id`, `n`, `v`, `t`, `j`) VALUES
(1, 1, 'layout_topbar_bg_color', '#3c007d', 'text', ''),
(2, 1, 'layout_button_bg_color', '#b90202', 'text', ''),
(3, 1, 'layout_title', 'K9', 'text', ''),
(4, 1, 'layout_alt_title', 'K9', 'text', ''),
(5, 1, 'layout_sidebar_bg_color', '', 'text', ''),
(7, 1, 'layout_button_hover_bg_color', '#b01010', 'text', ''),
(8, 1, 'languages', '[{"lang":"en","text":"English"},{"lang":"fr","text":"French"},{"lang":"de","text":"German"},{"lang":"it","text":"Italian"},{"lang":"pt","text":"Portuguese"},{"lang":"es","text":"Spanish"},{"lang":"ro","text":"Romanian"}]', 'text', ''),
(11, 1, 'business_name', 'k9 koordinator', 'text', ''),
(12, 1, 'business_address', '1234 Main Street - MainVille, MV 123456', 'text', ''),
(15, 1, 'business_main_phone', '(123) 456-7890', 'text', ''),
(16, 1, 'business_extra_phone', '', 'text', ''),
(17, 1, 'business_fax', '', 'text', ''),
(18, 1, 'business_website', '', 'text', ''),
(19, 1, 'business_email', 'whitejuly.art@gmail.com', 'text', ''),
(20, 1, 'business_id', 'a87cd62', 'text', ''),
(21, 1, 'business_address_membership', '', 'text', ''),
(22, 1, 'business_address_membership_2', '', 'text', ''),
(23, 1, 'image_logo_id', '21', 'array', 'files'),
(24, 1, 'report_image_id', '32', 'array', 'files');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `sl_cp`
--

CREATE TABLE IF NOT EXISTS `sl_cp` (
`id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `sl_id` int(11) NOT NULL,
  `v` varchar(255) NOT NULL DEFAULT 'false'
) ENGINE=InnoDB AUTO_INCREMENT=608 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `sl_cp`
--

INSERT INTO `sl_cp` (`id`, `role_id`, `sl_id`, `v`) VALUES
(1, 1, 1, '1'),
(2, 1, 2, '1'),
(3, 1, 3, '1'),
(4, 1, 4, '1'),
(5, 1, 5, '1'),
(6, 1, 6, '1'),
(7, 1, 7, '1'),
(8, 1, 8, '1'),
(9, 1, 9, '1'),
(10, 1, 10, '1'),
(11, 1, 11, '1'),
(12, 1, 12, '1'),
(13, 1, 13, '1'),
(14, 1, 14, '1'),
(15, 1, 15, '1'),
(16, 1, 16, '1'),
(17, 1, 17, '1'),
(18, 1, 18, '1'),
(19, 1, 19, '1'),
(20, 1, 20, '1'),
(21, 1, 21, '1'),
(22, 1, 22, '1'),
(23, 1, 23, '1'),
(24, 1, 24, '1'),
(25, 1, 25, '1'),
(26, 1, 26, '1'),
(27, 1, 27, '1'),
(28, 1, 28, '1'),
(29, 1, 29, '1'),
(30, 1, 30, '1'),
(31, 1, 31, '1'),
(32, 1, 32, '1'),
(33, 1, 33, '1'),
(34, 1, 34, '1'),
(35, 1, 35, '1'),
(36, 1, 36, '1'),
(37, 1, 37, '1'),
(38, 1, 38, '1'),
(39, 1, 39, '1'),
(40, 1, 40, '1'),
(41, 4, 1, '0'),
(42, 4, 2, '0'),
(43, 4, 3, '0'),
(44, 4, 4, '0'),
(45, 4, 5, '0'),
(46, 4, 6, '0'),
(47, 4, 7, '0'),
(48, 4, 8, '0'),
(49, 4, 9, '0'),
(50, 4, 10, '0'),
(51, 4, 11, '0'),
(52, 4, 12, '0'),
(53, 4, 13, '0'),
(54, 4, 14, '0'),
(55, 4, 15, '0'),
(56, 4, 16, '0'),
(57, 4, 17, '0'),
(58, 4, 18, '0'),
(59, 4, 19, '0'),
(60, 4, 20, '0'),
(61, 4, 21, '0'),
(62, 4, 22, '0'),
(63, 4, 23, '0'),
(64, 4, 24, '0'),
(65, 4, 25, '0'),
(66, 4, 26, '0'),
(67, 4, 27, '0'),
(68, 4, 28, '0'),
(69, 4, 29, '0'),
(70, 4, 30, '0'),
(71, 4, 31, '0'),
(72, 4, 32, '0'),
(73, 4, 33, '0'),
(74, 4, 34, '0'),
(75, 4, 35, '0'),
(76, 4, 36, '0'),
(77, 4, 37, '0'),
(78, 4, 38, '0'),
(79, 4, 39, '0'),
(80, 4, 40, '0'),
(81, 2, 1, '1'),
(82, 2, 2, '1'),
(83, 2, 3, '1'),
(84, 2, 4, '0'),
(85, 2, 5, '0'),
(86, 2, 6, '0'),
(87, 2, 7, '1'),
(88, 2, 8, '0'),
(89, 2, 9, '0'),
(90, 2, 10, '0'),
(91, 2, 11, '1'),
(92, 2, 12, '0'),
(93, 2, 13, '0'),
(94, 2, 14, '0'),
(95, 2, 15, '0'),
(96, 2, 16, '0'),
(97, 2, 17, '0'),
(98, 2, 18, '0'),
(99, 2, 19, '1'),
(100, 2, 20, '1'),
(101, 2, 21, '0'),
(102, 2, 22, '0'),
(103, 2, 23, '0'),
(104, 2, 24, '0'),
(105, 2, 25, '1'),
(106, 2, 26, '0'),
(107, 2, 27, '0'),
(108, 2, 28, '0'),
(109, 2, 29, '0'),
(110, 2, 30, '1'),
(111, 2, 31, '0'),
(112, 2, 32, '0'),
(113, 2, 33, '1'),
(114, 2, 34, '0'),
(115, 2, 35, '0'),
(116, 2, 36, '0'),
(117, 2, 37, '0'),
(118, 2, 38, '0'),
(119, 2, 39, '0'),
(120, 2, 40, '0'),
(200, 5, 1, '1'),
(201, 5, 2, '1'),
(202, 5, 3, '1'),
(203, 5, 4, '1'),
(204, 5, 5, '1'),
(205, 5, 6, '1'),
(206, 5, 7, '0'),
(207, 5, 8, '1'),
(208, 5, 9, '1'),
(209, 5, 10, '1'),
(210, 5, 11, '0'),
(211, 5, 12, '1'),
(212, 5, 13, '1'),
(213, 5, 14, '1'),
(214, 5, 15, '1'),
(215, 5, 16, '0'),
(216, 5, 17, '0'),
(217, 5, 18, '1'),
(218, 5, 19, '1'),
(219, 5, 20, '1'),
(220, 5, 21, '0'),
(221, 5, 22, '0'),
(222, 5, 23, '0'),
(223, 5, 24, '0'),
(224, 5, 25, '1'),
(225, 5, 26, '1'),
(226, 5, 27, '0'),
(227, 5, 28, '1'),
(228, 5, 29, '1'),
(229, 5, 30, '1'),
(230, 5, 31, '0'),
(231, 5, 32, '0'),
(232, 5, 33, '1'),
(233, 5, 34, '1'),
(234, 5, 35, '1'),
(235, 5, 36, '0'),
(236, 5, 37, '1'),
(237, 5, 38, '1'),
(238, 5, 39, '0'),
(239, 5, 40, '0'),
(244, 6, 1, '1'),
(245, 6, 2, '1'),
(246, 6, 3, '1'),
(247, 6, 4, '1'),
(248, 6, 5, '1'),
(249, 6, 6, '1'),
(250, 6, 7, '1'),
(251, 6, 8, '1'),
(252, 6, 9, '1'),
(253, 6, 10, '1'),
(254, 6, 11, '1'),
(255, 6, 12, '1'),
(256, 6, 13, '1'),
(257, 6, 14, '1'),
(258, 6, 15, '1'),
(259, 6, 16, '1'),
(260, 6, 17, '0'),
(261, 6, 18, '0'),
(262, 6, 19, '1'),
(263, 6, 20, '1'),
(264, 6, 21, '0'),
(265, 6, 22, '1'),
(266, 6, 23, '1'),
(267, 6, 24, '1'),
(268, 6, 25, '1'),
(269, 6, 26, '1'),
(270, 6, 27, '1'),
(271, 6, 28, '0'),
(272, 6, 29, '1'),
(273, 6, 30, '1'),
(274, 6, 31, '0'),
(275, 6, 32, '1'),
(276, 6, 33, '1'),
(277, 6, 34, '1'),
(278, 6, 35, '1'),
(279, 6, 36, '0'),
(280, 6, 37, '0'),
(281, 6, 38, '0'),
(282, 6, 39, '0'),
(283, 6, 40, '1'),
(367, 7, 1, '1'),
(368, 7, 2, '1'),
(369, 7, 3, '1'),
(370, 7, 4, '1'),
(371, 7, 5, '1'),
(372, 7, 6, '1'),
(373, 7, 7, '1'),
(374, 7, 8, '1'),
(375, 7, 9, '1'),
(376, 7, 10, '1'),
(377, 7, 11, '1'),
(378, 7, 12, '1'),
(379, 7, 13, '1'),
(380, 7, 14, '1'),
(381, 7, 15, '1'),
(382, 7, 16, '0'),
(383, 7, 17, '0'),
(384, 7, 18, '0'),
(385, 7, 19, '1'),
(386, 7, 20, '1'),
(387, 7, 21, '0'),
(388, 7, 22, '0'),
(389, 7, 23, '0'),
(390, 7, 24, '0'),
(391, 7, 25, '1'),
(392, 7, 26, '1'),
(393, 7, 27, '0'),
(394, 7, 28, '1'),
(395, 7, 29, '1'),
(396, 7, 30, '1'),
(397, 7, 31, '0'),
(398, 7, 32, '0'),
(399, 7, 33, '1'),
(400, 7, 34, '1'),
(401, 7, 35, '0'),
(402, 7, 36, '1'),
(403, 7, 37, '1'),
(404, 7, 38, '0'),
(405, 7, 39, '0'),
(406, 7, 40, '1'),
(408, 8, 1, '1'),
(409, 8, 2, '1'),
(410, 8, 3, '1'),
(411, 8, 4, '1'),
(412, 8, 5, '1'),
(413, 8, 6, '1'),
(414, 8, 7, '0'),
(415, 8, 8, '1'),
(416, 8, 9, '1'),
(417, 8, 10, '1'),
(418, 8, 11, '0'),
(419, 8, 12, '0'),
(420, 8, 13, '1'),
(421, 8, 14, '0'),
(422, 8, 15, '1'),
(423, 8, 16, '0'),
(424, 8, 17, '0'),
(425, 8, 18, '0'),
(426, 8, 19, '1'),
(427, 8, 20, '1'),
(428, 8, 21, '0'),
(429, 8, 22, '0'),
(430, 8, 23, '0'),
(431, 8, 24, '0'),
(432, 8, 25, '1'),
(433, 8, 26, '1'),
(434, 8, 27, '0'),
(435, 8, 28, '0'),
(436, 8, 29, '1'),
(437, 8, 30, '1'),
(438, 8, 31, '1'),
(439, 8, 32, '0'),
(440, 8, 33, '1'),
(441, 8, 34, '0'),
(442, 8, 35, '0'),
(443, 8, 36, '0'),
(444, 8, 37, '0'),
(445, 8, 38, '0'),
(446, 8, 39, '0'),
(447, 8, 40, '1'),
(448, 9, 1, '1'),
(449, 9, 2, '1'),
(450, 9, 3, '1'),
(451, 9, 4, '1'),
(452, 9, 5, '1'),
(453, 9, 6, '1'),
(454, 9, 7, '1'),
(455, 9, 8, '1'),
(456, 9, 9, '1'),
(457, 9, 10, '1'),
(458, 9, 11, '1'),
(459, 9, 12, '1'),
(460, 9, 13, '1'),
(461, 9, 14, '1'),
(462, 9, 15, '1'),
(463, 9, 16, '1'),
(464, 9, 17, '1'),
(465, 9, 18, '1'),
(466, 9, 19, '1'),
(467, 9, 20, '1'),
(468, 9, 21, '1'),
(469, 9, 22, '1'),
(470, 9, 23, '1'),
(471, 9, 24, '1'),
(472, 9, 25, '1'),
(473, 9, 26, '1'),
(474, 9, 27, '1'),
(475, 9, 28, '1'),
(476, 9, 29, '1'),
(477, 9, 30, '1'),
(478, 9, 31, '1'),
(479, 9, 32, '1'),
(480, 9, 33, '1'),
(481, 9, 34, '1'),
(482, 9, 35, '1'),
(483, 9, 36, '1'),
(484, 9, 37, '1'),
(485, 9, 38, '1'),
(486, 9, 39, '1'),
(487, 9, 40, '1'),
(488, 10, 1, '1'),
(489, 10, 2, '0'),
(490, 10, 3, '0'),
(491, 10, 4, '1'),
(492, 10, 5, '1'),
(493, 10, 6, '1'),
(494, 10, 7, '0'),
(495, 10, 8, '1'),
(496, 10, 9, '1'),
(497, 10, 10, '1'),
(498, 10, 11, '0'),
(499, 10, 12, '0'),
(500, 10, 13, '0'),
(501, 10, 14, '0'),
(502, 10, 15, '0'),
(503, 10, 16, '0'),
(504, 10, 17, '0'),
(505, 10, 18, '0'),
(506, 10, 19, '1'),
(507, 10, 20, '1'),
(508, 10, 21, '0'),
(509, 10, 22, '0'),
(510, 10, 23, '0'),
(511, 10, 24, '0'),
(512, 10, 25, '1'),
(513, 10, 26, '0'),
(514, 10, 27, '0'),
(515, 10, 28, '0'),
(516, 10, 29, '0'),
(517, 10, 30, '1'),
(518, 10, 31, '0'),
(519, 10, 32, '0'),
(520, 10, 33, '1'),
(521, 10, 34, '0'),
(522, 10, 35, '0'),
(523, 10, 36, '0'),
(524, 10, 37, '0'),
(525, 10, 38, '0'),
(526, 10, 39, '0'),
(527, 10, 40, '0'),
(528, 11, 1, '1'),
(529, 11, 2, '1'),
(530, 11, 3, '1'),
(531, 11, 4, '1'),
(532, 11, 5, '1'),
(533, 11, 6, '1'),
(534, 11, 7, '0'),
(535, 11, 8, '1'),
(536, 11, 9, '1'),
(537, 11, 10, '1'),
(538, 11, 11, '0'),
(539, 11, 12, '0'),
(540, 11, 13, '1'),
(541, 11, 14, '0'),
(542, 11, 15, '0'),
(543, 11, 16, '0'),
(544, 11, 17, '0'),
(545, 11, 18, '0'),
(546, 11, 19, '1'),
(547, 11, 20, '1'),
(548, 11, 21, '0'),
(549, 11, 22, '0'),
(550, 11, 23, '0'),
(551, 11, 24, '0'),
(552, 11, 25, '0'),
(553, 11, 26, '0'),
(554, 11, 27, '0'),
(555, 11, 28, '0'),
(556, 11, 29, '0'),
(557, 11, 30, '1'),
(558, 11, 31, '0'),
(559, 11, 32, '0'),
(560, 11, 33, '0'),
(561, 11, 34, '0'),
(562, 11, 35, '0'),
(563, 11, 36, '0'),
(564, 11, 37, '0'),
(565, 11, 38, '0'),
(566, 11, 39, '0'),
(567, 11, 40, '0'),
(568, 3, 1, '1'),
(569, 3, 2, '1'),
(570, 3, 3, '1'),
(571, 3, 4, '1'),
(572, 3, 5, '1'),
(573, 3, 6, '1'),
(574, 3, 7, '1'),
(575, 3, 8, '1'),
(576, 3, 9, '1'),
(577, 3, 10, '1'),
(578, 3, 11, '1'),
(579, 3, 12, '1'),
(580, 3, 13, '1'),
(581, 3, 14, '1'),
(582, 3, 15, '1'),
(583, 3, 16, '1'),
(584, 3, 17, '1'),
(585, 3, 18, '1'),
(586, 3, 19, '1'),
(587, 3, 20, '1'),
(588, 3, 21, '1'),
(589, 3, 22, '1'),
(590, 3, 23, '1'),
(591, 3, 24, '1'),
(592, 3, 25, '1'),
(593, 3, 26, '1'),
(594, 3, 27, '1'),
(595, 3, 28, '1'),
(596, 3, 29, '1'),
(597, 3, 30, '1'),
(598, 3, 31, '1'),
(599, 3, 32, '1'),
(600, 3, 33, '1'),
(601, 3, 34, '1'),
(602, 3, 35, '1'),
(603, 3, 36, '1'),
(604, 3, 37, '1'),
(605, 3, 38, '1'),
(606, 3, 39, '1'),
(607, 3, 40, '1');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `stay_reasons`
--

CREATE TABLE IF NOT EXISTS `stay_reasons` (
`id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `v` varchar(255) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `stay_reasons`
--

INSERT INTO `stay_reasons` (`id`, `status_id`, `v`) VALUES
(1, 1, 'Rescue animal'),
(2, 1, 'Other'),
(3, 1, 'Vacation local'),
(4, 1, 'Vaction interstate'),
(5, 1, 'Vacation international'),
(6, 1, 'Vacation international'),
(7, 1, 'Renovating home'),
(8, 1, 'Moving or relocating');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `sticky`
--

CREATE TABLE IF NOT EXISTS `sticky` (
`id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `client_id` int(11) NOT NULL DEFAULT '0',
  `pet_id` int(11) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL,
  `v` text NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `sticky`
--

INSERT INTO `sticky` (`id`, `status_id`, `client_id`, `pet_id`, `user_id`, `v`, `date`) VALUES
(1, 1, 1, 0, 1, 'Ia pula sclvaule', '2015-03-20 15:49:13');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `tax_settings`
--

CREATE TABLE IF NOT EXISTS `tax_settings` (
  `id` int(11) NOT NULL,
  `n` varchar(255) NOT NULL,
  `v` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `tax_settings`
--

INSERT INTO `tax_settings` (`id`, `n`, `v`) VALUES
(1, 'state_tax', '7'),
(2, 's_boarding', '0'),
(3, 's_grooms', '0'),
(4, 's_baths', '0'),
(5, 's_medications', '0'),
(6, 's_diets', '0'),
(7, 's_retail', '1'),
(8, 's_services', '0'),
(9, 's_training', '0'),
(10, 's_daycare', '0'),
(11, 'o_tax_in_use', '0'),
(12, 'o_tax_name', ''),
(13, 'o_tax_amount', '0'),
(14, 'o_boarding', '0'),
(15, 'o_grooms', '0'),
(16, 'o_baths', '0'),
(17, 'o_medications', '0'),
(18, 'o_diets', '0'),
(19, 'o_retail', '1'),
(20, 'o_services', '0'),
(21, 'o_training', '0'),
(22, 'o_daycare', '0');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `tokens`
--

CREATE TABLE IF NOT EXISTS `tokens` (
`id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `device_id` int(11) NOT NULL DEFAULT '1',
  `token` varchar(255) NOT NULL,
  `date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `total_time` time NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `tokens`
--

INSERT INTO `tokens` (`id`, `user_id`, `device_id`, `token`, `date`, `start_time`, `end_time`, `total_time`) VALUES
(1, 1, 1, 'k9_testb7aeeeduabsble1eebpt4iso33', '0000-00-00', '00:00:00', '00:00:00', '00:00:00'),
(2, 1, 1, 'k9_testle3v6620i2pb7do4tmig1oidt7', '2015-01-15', '11:29:02', '00:00:00', '00:00:00'),
(3, 0, 1, '', '0000-00-00', '00:00:00', '13:23:57', '00:00:00'),
(4, 1, 1, 'k9_testp91noe1ag7f6r21bt9rvo6er50', '2015-01-15', '13:24:15', '11:31:30', '00:00:00'),
(5, 0, 1, '', '0000-00-00', '00:00:00', '16:24:48', '00:00:00'),
(6, 1, 1, 'k9_testbho6f9ieqkcs2e8g7muhbg0he1', '2015-01-15', '16:24:52', '16:58:43', '00:00:00'),
(7, 1, 1, 'k9_testbho6f9ieqkcs2e8g7muhbg0he1', '2015-01-15', '16:58:46', '00:00:00', '00:00:00'),
(8, 1, 1, 'k9_testp91noe1ag7f6r21bt9rvo6er50', '2015-01-16', '11:31:34', '00:00:00', '00:00:00'),
(9, 1, 1, 'k9_testd3ortpqlmvej9lvjrom2qma5b7', '2015-01-16', '11:38:29', '00:00:00', '00:00:00'),
(10, 1, 1, 'k9_test375n08drcl4l17ovj2av4nks12', '2015-01-16', '17:06:42', '00:00:00', '00:00:00'),
(11, 1, 1, 'k9_testvshdkvun7jhs2mda8tg86rfrv4', '2015-01-18', '10:46:46', '11:19:52', '00:00:00'),
(12, 1, 1, 'k9_testuqh5ecffmdc65i5e9m4cs0dem6', '2015-01-26', '09:44:29', '00:00:00', '00:00:00'),
(13, 1, 1, 'k9_test6h04qgokmnfhqe0rlf17nhcj52', '2015-01-28', '13:39:27', '00:00:00', '00:00:00'),
(14, 1, 1, 'k9_testd9iv7ch2dhqp7hietmrn6d5ev1', '2015-01-28', '14:11:58', '00:00:00', '00:00:00'),
(15, 1, 1, 'k9_testui7j4mg8c4tlq3a3limljsoq87', '2015-02-03', '17:02:21', '00:00:00', '00:00:00'),
(16, 1, 1, 'k9_test4nrv2p4tn2u6phm9idvc4tr1j4', '2015-02-04', '15:27:05', '00:00:00', '00:00:00'),
(17, 1, 1, 'k9_testri6ecba3e82771n4vpbac6p992', '2015-02-05', '08:05:20', '00:00:00', '00:00:00'),
(18, 0, 1, '', '0000-00-00', '00:00:00', '13:14:20', '00:00:00'),
(19, 1, 1, 'k9_test_remotei6vcmfead7orevdnfsgc2te553', '2015-02-12', '13:14:24', '13:22:16', '00:00:00'),
(20, 1, 1, 'k9_test_remotei6vcmfead7orevdnfsgc2te553', '2015-02-12', '13:22:20', '13:24:06', '00:00:00'),
(21, 1, 1, 'k9_test_remotei6vcmfead7orevdnfsgc2te553', '2015-02-12', '13:24:10', '00:00:00', '00:00:00'),
(22, 1, 1, 'k9_testri6ecba3e82771n4vpbac6p992', '2015-02-12', '13:48:00', '00:00:00', '00:00:00'),
(23, 1, 1, 'k9_test0q1iqsmtr2l9qjjia45d3hggh7', '2015-02-19', '16:34:29', '00:00:00', '00:00:00'),
(24, 0, 1, '', '0000-00-00', '00:00:00', '14:06:11', '00:00:00'),
(25, 1, 1, 'k9_test5cmcvcb0gmlivok20gq25890n0', '2015-02-26', '14:06:16', '00:00:00', '00:00:00'),
(26, 1, 1, 'k9_test99eb5lmnavduvkilgtbq4qirl7', '2015-03-17', '15:27:25', '00:00:00', '00:00:00'),
(27, 1, 1, 'k9_testo1drm24lqfjdp2hmkbtuioag91', '2015-03-17', '18:39:08', '00:00:00', '00:00:00'),
(28, 1, 1, 'k9_testavnflhhba8bdlaogfrbnjd3rj3', '2015-03-17', '19:10:21', '19:18:08', '00:07:47'),
(29, 1, 1, 'k9_testn7g352oj6gsmcp9dh2j7ab7ql3', '2015-03-17', '19:36:28', '19:37:00', '00:00:32'),
(30, 1, 1, 'k9_testn7g352oj6gsmcp9dh2j7ab7ql3', '2015-03-17', '19:48:30', '10:05:31', '14:17:01'),
(31, 1, 1, 'k9_testk6prb2ag8h4e6ccgsn93gvaj22', '2015-03-17', '20:01:33', '00:00:00', '00:00:00'),
(32, 1, 1, 'k9_testn7g352oj6gsmcp9dh2j7ab7ql3', '2015-03-18', '10:05:58', '00:00:00', '00:00:00'),
(33, 1, 1, 'k9_testn7g352oj6gsmcp9dh2j7ab7ql3', '2015-03-18', '11:16:17', '00:00:00', '00:00:00'),
(34, 1, 1, 'k9_testgp6h3f356bmdp2bhl24bd992h3', '2015-03-18', '21:06:50', '10:28:40', '13:21:50'),
(35, 1, 1, 'k9_testgp6h3f356bmdp2bhl24bd992h3', '2015-03-20', '10:28:48', '10:28:56', '00:00:08'),
(36, 1, 1, 'k9_testgp6h3f356bmdp2bhl24bd992h3', '2015-03-20', '10:29:04', '11:49:30', '01:20:26'),
(37, 5, 1, 'k9_testgp6h3f356bmdp2bhl24bd992h3', '2015-03-20', '11:49:35', '11:50:21', '00:00:46'),
(38, 1, 1, 'k9_testgp6h3f356bmdp2bhl24bd992h3', '2015-03-20', '11:50:26', '00:00:00', '00:00:00'),
(39, 1, 1, 'k9_test5f8g296jm4rndr6jaunt191kn7', '2015-03-27', '06:06:14', '00:00:00', '00:00:00'),
(40, 1, 1, 'k9_testhunvpgi6f9lhl6cbb2v9pu5c11', '2015-03-28', '06:01:27', '00:00:00', '00:00:00'),
(41, 1, 1, 'k9_testdajk456r20cerjt1rjmlecd265', '2015-04-03', '03:29:52', '00:00:00', '00:00:00'),
(42, 1, 1, 'k9_test7ie409sgihu3vi8p58ru11k4i5', '2015-04-06', '10:47:11', '00:00:00', '00:00:00'),
(43, 1, 1, 'k9_testavlbu8h7446le3dlueauoar335', '2015-04-07', '20:12:59', '00:00:00', '00:00:00'),
(44, 1, 1, 'k9_testt1auqgaj0qdvamfqna4b8g32n2', '2015-04-08', '06:52:22', '00:00:00', '00:00:00'),
(45, 0, 1, '', '0000-00-00', '00:00:00', '08:55:27', '00:28:03'),
(46, 1, 1, 'k9_testt1auqgaj0qdvamfqna4b8g32n2', '2015-04-08', '08:55:31', '00:00:00', '00:00:00'),
(47, 1, 1, 'k9_test1nqet3a1mdrfhof51gmvni7311', '2015-04-14', '04:54:19', '00:00:00', '00:00:00'),
(48, 1, 1, 'k9_testt8274pnq9e6tt6766h05ke0lb4', '2015-04-16', '04:07:04', '00:00:00', '00:00:00'),
(49, 1, 1, 'k9_testf4qsm4ob4b9pkrft5m8i7jlg66', '2015-04-21', '03:05:18', '00:00:00', '00:00:00');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `training_groups`
--

CREATE TABLE IF NOT EXISTS `training_groups` (
`id` int(11) NOT NULL,
  `status_id` tinyint(4) NOT NULL DEFAULT '1',
  `rank` int(11) NOT NULL,
  `v` varchar(255) NOT NULL,
  `price` float NOT NULL,
  `limit` int(11) NOT NULL,
  `instructions` varchar(255) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `training_groups`
--

INSERT INTO `training_groups` (`id`, `status_id`, `rank`, `v`, `price`, `limit`, `instructions`) VALUES
(1, 1, 1, 'Kindergarden', 25, 5, '- small puppies and kittens'),
(2, 1, 2, 'Adult', 30, 5, '- adult only pets');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `training_options`
--

CREATE TABLE IF NOT EXISTS `training_options` (
`id` int(11) NOT NULL,
  `status_id` tinyint(4) NOT NULL DEFAULT '1',
  `tg_id` int(11) NOT NULL,
  `v` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `price` float NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `training_options`
--

INSERT INTO `training_options` (`id`, `status_id`, `tg_id`, `v`, `description`, `price`) VALUES
(1, 1, 1, 'Help small pets', '-', 5),
(2, 1, 1, 'Play with small pets', '-', 7),
(3, 1, 2, 'Adult stuff', '- adult description', 10.5);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `training_schedule`
--

CREATE TABLE IF NOT EXISTS `training_schedule` (
`id` int(11) NOT NULL,
  `status_id` tinyint(4) NOT NULL DEFAULT '1',
  `tg_id` int(11) NOT NULL,
  `t_id` int(11) NOT NULL,
  `date_in` date NOT NULL,
  `time_in` time NOT NULL,
  `date_out` date NOT NULL,
  `time_out` time NOT NULL,
  `time_duration` time NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `training_schedule`
--

INSERT INTO `training_schedule` (`id`, `status_id`, `tg_id`, `t_id`, `date_in`, `time_in`, `date_out`, `time_out`, `time_duration`) VALUES
(1, 1, 1, 8, '2015-03-25', '20:00:00', '2015-04-01', '22:00:00', '02:00:00'),
(2, 1, 2, 8, '2015-03-18', '10:00:00', '2015-04-01', '12:00:00', '02:30:00');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `users`
--

CREATE TABLE IF NOT EXISTS `users` (
`id` int(11) NOT NULL,
  `status_id` tinyint(4) NOT NULL DEFAULT '1',
  `role_id` tinyint(4) DEFAULT NULL,
  `image_id` int(11) DEFAULT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `cell` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `street` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  `zip` varchar(255) NOT NULL,
  `mon` tinyint(4) NOT NULL,
  `mon_in` time NOT NULL,
  `mon_out` time NOT NULL,
  `tue` tinyint(4) NOT NULL,
  `tue_in` time NOT NULL,
  `tue_out` time NOT NULL,
  `wed` tinyint(4) NOT NULL,
  `wed_in` time NOT NULL,
  `wed_out` time NOT NULL,
  `thu` tinyint(4) NOT NULL,
  `thu_in` time NOT NULL,
  `thu_out` time NOT NULL,
  `fri` tinyint(4) NOT NULL,
  `fri_in` time NOT NULL,
  `fri_out` time NOT NULL,
  `sat` tinyint(4) NOT NULL,
  `sat_in` time NOT NULL,
  `sat_out` time NOT NULL,
  `sun` tinyint(4) NOT NULL,
  `sun_in` time NOT NULL,
  `sun_out` time NOT NULL,
  `daily_limit` int(11) NOT NULL,
  `commission_percentage` float NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `users`
--

INSERT INTO `users` (`id`, `status_id`, `role_id`, `image_id`, `username`, `password`, `first_name`, `last_name`, `phone`, `cell`, `email`, `street`, `city`, `state`, `zip`, `mon`, `mon_in`, `mon_out`, `tue`, `tue_in`, `tue_out`, `wed`, `wed_in`, `wed_out`, `thu`, `thu_in`, `thu_out`, `fri`, `fri_in`, `fri_out`, `sat`, `sat_in`, `sat_out`, `sun`, `sun_in`, `sun_out`, `daily_limit`, `commission_percentage`, `date_created`) VALUES
(1, 1, 1, 0, 'admin', '14e1b600b1fd579f47433b88e8d85291', 'admin', 'admin', '', '', 'admin@example.net', '', '', '', '', 0, '00:00:00', '00:00:00', 0, '00:00:00', '00:00:00', 0, '00:00:00', '00:00:00', 0, '00:00:00', '00:00:00', 0, '00:00:00', '00:00:00', 0, '00:00:00', '00:00:00', 0, '00:00:00', '00:00:00', 1, 0, '0000-00-00 00:00:00'),
(2, 1, 9, NULL, 'owner', '7022cd14c42ff272619d6beacdc9ffde', 'owner', 'owner', '', '', '', '', '', '', '', 1, '08:00:00', '18:00:00', 1, '08:00:00', '18:00:00', 1, '08:00:00', '18:00:00', 1, '08:00:00', '18:00:00', 1, '08:00:00', '18:00:00', 0, '08:00:00', '18:00:00', 0, '08:00:00', '18:00:00', 1, 0, '0000-00-00 00:00:00'),
(5, 1, 2, 3, 'groomer_dude', '14e1b600b1fd579f47433b88e8d85291', 'Groomer', 'Man', '(123) 456-7890', '', 'groomer.dude@gmail.com', '', '', '', '', 1, '08:00:00', '18:00:00', 1, '08:00:00', '18:00:00', 1, '08:00:00', '18:00:00', 1, '08:00:00', '18:00:00', 1, '08:00:00', '18:00:00', 0, '08:00:00', '18:00:00', 0, '08:00:00', '18:00:00', 4, 0, '2014-12-02 23:26:11'),
(8, 1, 3, 15, 'trainer', '', 'Trainer', 'Trainer', '(123) 456-7890', '', 'testing@testing.com', 'U.S. Avenue', 'Plattsburgh', 'NY', '564218', 1, '10:00:00', '16:00:00', 1, '10:00:00', '16:00:00', 1, '10:00:00', '16:00:00', 1, '10:00:00', '16:00:00', 1, '10:00:00', '16:00:00', 0, '10:00:00', '16:00:00', 0, '10:00:00', '16:00:00', 6, 0, '2015-03-17 20:56:51');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `user_interface_settings`
--

CREATE TABLE IF NOT EXISTS `user_interface_settings` (
`id` int(11) NOT NULL,
  `n` varchar(255) NOT NULL,
  `v` varchar(255) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `user_interface_settings`
--

INSERT INTO `user_interface_settings` (`id`, `n`, `v`) VALUES
(1, 'disable_credit_card_storage', '0'),
(2, 'require_address_when_creating_client', '0'),
(3, 'require_email_when_creating_client', '0'),
(4, 'alarm_pet_age_when_older_than', '1'),
(5, 'alarm_pet_age_when_older_than_value', '9'),
(6, 'enable_membership', '1'),
(7, 'enable_email', '1'),
(8, 'enable_contracts', '1'),
(9, 'enable_pet_id', '0'),
(10, 'enable_reason_for_stay', '0'),
(11, 'show_survey_when_creating_client', '1'),
(12, 'show_income_survey_when_creating_client', '1'),
(13, 'send_texts_from_message_system', '1'),
(14, 'show_clock_status', '0'),
(15, 'pos_general_items', '0'),
(16, 'pos_price_levels', '0'),
(17, 'send_email_at_check_out', '0'),
(18, 'allow_sold_by_for_retail_sales', '0'),
(19, 'enable_manual_discounts_at_checkout', '0'),
(20, 'enable_pre_set_discounts_at_checkout', '1'),
(21, 'country', 'us'),
(22, 'language', 'en'),
(23, 'zip_postcode_length', '6'),
(28, 'state_length', '2'),
(29, 'date_format', '0'),
(30, 'payment_type_id', '1'),
(31, 'payment_type_id', '1'),
(32, 'phone_format_id', '1'),
(33, 'cell_format_id', '1'),
(34, 'fax_format_id', '1'),
(35, 'phone_format_id', '1'),
(36, 'cell_format_id', '1'),
(37, 'fax_format_id', '1');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `vets`
--

CREATE TABLE IF NOT EXISTS `vets` (
`id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `v` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `fax` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `contact` varchar(255) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `zip` varchar(255) DEFAULT NULL,
  `notes` text
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `vets`
--

INSERT INTO `vets` (`id`, `status_id`, `v`, `phone`, `fax`, `email`, `contact`, `street`, `city`, `state`, `zip`, `notes`) VALUES
(2, 1, 'Martha', '(229) 357-6120', '', 'kezheki@ne.co.uk', '', '1297 Dugje Ridge', 'Deffemagi', 'WY', '01421', 'orem ipsum dolor sit amet, consectetur adipiscing elit. Nulla ultricies velit quis sagittis luctus. Sed ac leo sed dui aliquet porta sit amet at ligula. Proin eu leo lacus. Maecenas ullamcorper nunc laoreet quam euismod eleifend. Integer consectetur massa convallis, placerat lacus ut, ultricies ligula. Maecenas sagittis non nunc vel congue. Pellentesque ullamcorper quam a quam faucibus malesuada. Phasellus rutrum justo facilisis dolor vehicula aliquet. Nunc non dapibus ante. Pellentesque augue sapien, rutrum aliquam adipiscing at, faucibus nec erat. Ut tempus mi lectus, nec interdum dui vehicula ac. Fusce suscipit fermentum elementum.\r\n\r\nNulla sem tellus, volutpat sed suscipit vel, dapibus nec dui. Sed feugiat dolor odio, quis malesuada libero eleifend at. Suspendisse risus erat, luctus ut commodo nec, pulvinar quis libero. Ut in tortor vel orci accumsan laoreet. Praesent ut quam enim. Morbi nec elit id elit mattis imperdiet. Maecenas tellus erat, ultrices sed dui in, aliquam consequat urna. Sed ut arcu gravida, elementum quam vel, volutpat turpis. '),
(3, 1, 'Patrick', '(328) 540-7205', '', 'co@um.edu', '', '1695 Zarum Path', 'Nagoweb', 'GU', '99107', ''),
(4, 1, 'Shawn', '(823) 761-8627', '', 'to@rokzi.edu', '', '1839 Koum Lane', 'Nebacca', 'MA', '15639', ''),
(5, 1, 'Caroline', '(347) 719-7558', '', 'cu@suf.com', '', '119 Hiric Circle', 'Mifouz', 'GA', '98956', ''),
(6, 1, 'Alexander', '(636) 472-4988', '', 'rum@pugav.org', '', '1222 Paob Place', 'Curefo', 'IA', '24784', ''),
(7, 1, 'Jack', '(864) 726-4632', '', 'fajel@heghuvpob.io', '', '608 Lodne Turnpike', 'Sucemo', 'MS', '43234', ''),
(8, 1, 'Ina', '(334) 601-1246', '', 'lizanfud@bokbumugu.co.uk', '', '628 Wazce Road', 'Powimasu', 'MD', '38068', ''),
(9, 1, 'Luellaaaa', '(889) 745-1914', '', 'radeg@zewlavaz.org', '', '1536 Isabe Court', 'Eritaage', 'NV', '53058', ''),
(10, 3, 'Alberta', '(242) 202-3489', '', 'wizagu@tifu.co.uk', '', '892 Zowu Way', 'Hurroir', 'TX', '62772', ''),
(11, 1, 'Virgie', '(808) 850-7878', '', 'mun@ruwgoklav.io', '', '963 Wiwle Terrace', 'Pogacul', 'AP', '69563', ''),
(12, 1, 'Adelaide', '(249) 268-6265', '', 'vap@if.org', '', '1762 Zihi Grove', 'Corethog', 'WA', '21590', ''),
(13, 1, 'Patrick', '(641) 712-3384', '', 'zeloj@olimi.net', '', '1784 Puwol Boulevard', 'Jowsifi', 'CT', '40954', ''),
(14, 1, 'Bettie', '(210) 952-4015', '', 'hepaej@is.net', '', '14 Kiif Ridge', 'Liwuov', 'MI', '09788', ''),
(15, 1, 'Birdie', '(565) 863-9874', '', 'umge@piwo.io', '', '1506 Zojep Junction', 'Ommemib', 'VI', '38014', ''),
(16, 1, 'Genevieve', '(642) 566-4396', '', 'karvu@kusbu.gov', '', '81 Hojnod View', 'Culjijru', 'AZ', '82546', ''),
(17, 1, 'Ralph', '(934) 755-4467', '', 'bu@tis.net', '', '1749 Owuak Court', 'Iseamofu', 'AS', '59999', ''),
(18, 1, 'Lela', '(545) 489-8913', '', 'rijkupno@zajzab.net', '', '461 Abada Heights', 'Custirmen', 'MN', '90812', ''),
(19, 1, 'Jean', '(465) 859-1552', '', 'vutesu@low.gov', '', '1836 Micu Pike', 'Bijozo', 'NY', '37861', ''),
(20, 1, 'Justin', '(206) 442-9769', '', 'ok@lepsochud.co.uk', '', '1507 Izeta Extension', 'Goiwpec', 'MD', '35809', '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `boarding_payments`
--
ALTER TABLE `boarding_payments`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `boarding_petsizes`
--
ALTER TABLE `boarding_petsizes`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `boarding_runtypes`
--
ALTER TABLE `boarding_runtypes`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `boarding_settings`
--
ALTER TABLE `boarding_settings`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `clients`
--
ALTER TABLE `clients`
 ADD PRIMARY KEY (`id`), ADD KEY `address_city_id` (`address_city`), ADD KEY `address_state_id` (`address_state`), ADD KEY `address_zip_id` (`address_zip`);

--
-- Indexes for table `clients_membership`
--
ALTER TABLE `clients_membership`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `clients_private`
--
ALTER TABLE `clients_private`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `clients_rewards`
--
ALTER TABLE `clients_rewards`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `clients_survey`
--
ALTER TABLE `clients_survey`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `client_status`
--
ALTER TABLE `client_status`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `client_survey_findout`
--
ALTER TABLE `client_survey_findout`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `client_survey_income`
--
ALTER TABLE `client_survey_income`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cp`
--
ALTER TABLE `cp`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `daycare_groups`
--
ALTER TABLE `daycare_groups`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `daycare_settings`
--
ALTER TABLE `daycare_settings`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `deposits`
--
ALTER TABLE `deposits`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `diets`
--
ALTER TABLE `diets`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `diets_type`
--
ALTER TABLE `diets_type`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `discounts_boarding_long_term`
--
ALTER TABLE `discounts_boarding_long_term`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `discounts_boarding_multiple_pet`
--
ALTER TABLE `discounts_boarding_multiple_pet`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `discounts_boarding_new_client`
--
ALTER TABLE `discounts_boarding_new_client`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `discounts_boarding_priority_club`
--
ALTER TABLE `discounts_boarding_priority_club`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `files`
--
ALTER TABLE `files`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `general_features`
--
ALTER TABLE `general_features`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `grooming_commissions`
--
ALTER TABLE `grooming_commissions`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `grooming_options`
--
ALTER TABLE `grooming_options`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `grooming_priority`
--
ALTER TABLE `grooming_priority`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `grooming_rates`
--
ALTER TABLE `grooming_rates`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `grooming_services`
--
ALTER TABLE `grooming_services`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `holiday`
--
ALTER TABLE `holiday`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `languages`
--
ALTER TABLE `languages`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `k` (`k`);

--
-- Indexes for table `layout_runs`
--
ALTER TABLE `layout_runs`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `layout_sections`
--
ALTER TABLE `layout_sections`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `md_dosage`
--
ALTER TABLE `md_dosage`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `md_dose_type`
--
ALTER TABLE `md_dose_type`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `meds`
--
ALTER TABLE `meds`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `meds_type`
--
ALTER TABLE `meds_type`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notepads`
--
ALTER TABLE `notepads`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_types`
--
ALTER TABLE `payment_types`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pets`
--
ALTER TABLE `pets`
 ADD PRIMARY KEY (`id`), ADD KEY `pet_color_id` (`pet_color_id`), ADD KEY `pet_size_id` (`pet_size_id`), ADD KEY `pet_sex_id` (`pet_sex_id`), ADD KEY `pet_breed_id` (`pet_breed_id`), ADD KEY `pet_type_id` (`pet_type_id`);

--
-- Indexes for table `pet_breed`
--
ALTER TABLE `pet_breed`
 ADD PRIMARY KEY (`id`), ADD KEY `id` (`id`);

--
-- Indexes for table `pet_color`
--
ALTER TABLE `pet_color`
 ADD PRIMARY KEY (`id`), ADD KEY `id` (`id`);

--
-- Indexes for table `pet_sex`
--
ALTER TABLE `pet_sex`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pet_size`
--
ALTER TABLE `pet_size`
 ADD PRIMARY KEY (`id`), ADD KEY `id` (`id`);

--
-- Indexes for table `pet_status`
--
ALTER TABLE `pet_status`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pet_type`
--
ALTER TABLE `pet_type`
 ADD PRIMARY KEY (`id`), ADD KEY `id` (`id`);

--
-- Indexes for table `pet_vet`
--
ALTER TABLE `pet_vet`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pos_payments`
--
ALTER TABLE `pos_payments`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `promotions`
--
ALTER TABLE `promotions`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `promotions_settings`
--
ALTER TABLE `promotions_settings`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `records_boarding`
--
ALTER TABLE `records_boarding`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `records_daycare`
--
ALTER TABLE `records_daycare`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `records_grooming`
--
ALTER TABLE `records_grooming`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `records_meds_diets`
--
ALTER TABLE `records_meds_diets`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `records_services`
--
ALTER TABLE `records_services`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `records_training`
--
ALTER TABLE `records_training`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `retail_classes`
--
ALTER TABLE `retail_classes`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `retail_inventory`
--
ALTER TABLE `retail_inventory`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `retail_vendors`
--
ALTER TABLE `retail_vendors`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `retail_vi`
--
ALTER TABLE `retail_vi`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `r_boarding`
--
ALTER TABLE `r_boarding`
 ADD PRIMARY KEY (`id`), ADD KEY `id` (`id`);

--
-- Indexes for table `r_daycare`
--
ALTER TABLE `r_daycare`
 ADD PRIMARY KEY (`id`), ADD KEY `id` (`id`);

--
-- Indexes for table `r_diets`
--
ALTER TABLE `r_diets`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `r_grooms`
--
ALTER TABLE `r_grooms`
 ADD PRIMARY KEY (`id`), ADD KEY `id` (`id`);

--
-- Indexes for table `r_meds`
--
ALTER TABLE `r_meds`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `r_ss`
--
ALTER TABLE `r_ss`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `r_training`
--
ALTER TABLE `r_training`
 ADD PRIMARY KEY (`id`), ADD KEY `id` (`id`);

--
-- Indexes for table `schedule_services`
--
ALTER TABLE `schedule_services`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `season`
--
ALTER TABLE `season`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `security_levels`
--
ALTER TABLE `security_levels`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sl_cp`
--
ALTER TABLE `sl_cp`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stay_reasons`
--
ALTER TABLE `stay_reasons`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sticky`
--
ALTER TABLE `sticky`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tax_settings`
--
ALTER TABLE `tax_settings`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tokens`
--
ALTER TABLE `tokens`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `training_groups`
--
ALTER TABLE `training_groups`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `training_options`
--
ALTER TABLE `training_options`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `training_schedule`
--
ALTER TABLE `training_schedule`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_interface_settings`
--
ALTER TABLE `user_interface_settings`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vets`
--
ALTER TABLE `vets`
 ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `boarding_payments`
--
ALTER TABLE `boarding_payments`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `boarding_petsizes`
--
ALTER TABLE `boarding_petsizes`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `boarding_runtypes`
--
ALTER TABLE `boarding_runtypes`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `boarding_settings`
--
ALTER TABLE `boarding_settings`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=26;
--
-- AUTO_INCREMENT for table `clients`
--
ALTER TABLE `clients`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `clients_membership`
--
ALTER TABLE `clients_membership`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `clients_private`
--
ALTER TABLE `clients_private`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `clients_rewards`
--
ALTER TABLE `clients_rewards`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `clients_survey`
--
ALTER TABLE `clients_survey`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `client_status`
--
ALTER TABLE `client_status`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `client_survey_findout`
--
ALTER TABLE `client_survey_findout`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT for table `client_survey_income`
--
ALTER TABLE `client_survey_income`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `cp`
--
ALTER TABLE `cp`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `daycare_groups`
--
ALTER TABLE `daycare_groups`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `daycare_settings`
--
ALTER TABLE `daycare_settings`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=20;
--
-- AUTO_INCREMENT for table `deposits`
--
ALTER TABLE `deposits`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `diets`
--
ALTER TABLE `diets`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `diets_type`
--
ALTER TABLE `diets_type`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `files`
--
ALTER TABLE `files`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=35;
--
-- AUTO_INCREMENT for table `general_features`
--
ALTER TABLE `general_features`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=30;
--
-- AUTO_INCREMENT for table `grooming_commissions`
--
ALTER TABLE `grooming_commissions`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `grooming_options`
--
ALTER TABLE `grooming_options`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `grooming_priority`
--
ALTER TABLE `grooming_priority`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `grooming_rates`
--
ALTER TABLE `grooming_rates`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `grooming_services`
--
ALTER TABLE `grooming_services`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `languages`
--
ALTER TABLE `languages`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=90;
--
-- AUTO_INCREMENT for table `layout_runs`
--
ALTER TABLE `layout_runs`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `md_dosage`
--
ALTER TABLE `md_dosage`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=29;
--
-- AUTO_INCREMENT for table `md_dose_type`
--
ALTER TABLE `md_dose_type`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `meds`
--
ALTER TABLE `meds`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=62;
--
-- AUTO_INCREMENT for table `meds_type`
--
ALTER TABLE `meds_type`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `notepads`
--
ALTER TABLE `notepads`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `payment_types`
--
ALTER TABLE `payment_types`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `pets`
--
ALTER TABLE `pets`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `pet_breed`
--
ALTER TABLE `pet_breed`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=608;
--
-- AUTO_INCREMENT for table `pet_color`
--
ALTER TABLE `pet_color`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=94;
--
-- AUTO_INCREMENT for table `pet_sex`
--
ALTER TABLE `pet_sex`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `pet_size`
--
ALTER TABLE `pet_size`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `pet_status`
--
ALTER TABLE `pet_status`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `pet_type`
--
ALTER TABLE `pet_type`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `pet_vet`
--
ALTER TABLE `pet_vet`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT for table `pos_payments`
--
ALTER TABLE `pos_payments`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `promotions`
--
ALTER TABLE `promotions`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `promotions_settings`
--
ALTER TABLE `promotions_settings`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `records_boarding`
--
ALTER TABLE `records_boarding`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `records_daycare`
--
ALTER TABLE `records_daycare`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `records_grooming`
--
ALTER TABLE `records_grooming`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `records_meds_diets`
--
ALTER TABLE `records_meds_diets`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `records_services`
--
ALTER TABLE `records_services`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `records_training`
--
ALTER TABLE `records_training`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `r_boarding`
--
ALTER TABLE `r_boarding`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `r_daycare`
--
ALTER TABLE `r_daycare`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `r_diets`
--
ALTER TABLE `r_diets`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=21;
--
-- AUTO_INCREMENT for table `r_grooms`
--
ALTER TABLE `r_grooms`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `r_meds`
--
ALTER TABLE `r_meds`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=20;
--
-- AUTO_INCREMENT for table `r_ss`
--
ALTER TABLE `r_ss`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT for table `r_training`
--
ALTER TABLE `r_training`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `schedule_services`
--
ALTER TABLE `schedule_services`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `security_levels`
--
ALTER TABLE `security_levels`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=41;
--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=25;
--
-- AUTO_INCREMENT for table `sl_cp`
--
ALTER TABLE `sl_cp`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=608;
--
-- AUTO_INCREMENT for table `stay_reasons`
--
ALTER TABLE `stay_reasons`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `sticky`
--
ALTER TABLE `sticky`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `tokens`
--
ALTER TABLE `tokens`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=50;
--
-- AUTO_INCREMENT for table `training_groups`
--
ALTER TABLE `training_groups`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `training_options`
--
ALTER TABLE `training_options`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `training_schedule`
--
ALTER TABLE `training_schedule`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `user_interface_settings`
--
ALTER TABLE `user_interface_settings`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=38;
--
-- AUTO_INCREMENT for table `vets`
--
ALTER TABLE `vets`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=21;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
