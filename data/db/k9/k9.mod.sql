/** K9 Modifications **/

-- 24.04.2014
ALTER TABLE k9.r_boarding ADD pet_id int NULL AFTER id;
ALTER TABLE k9.r_daycare ADD pet_id int NULL AFTER id;
ALTER TABLE k9.r_grooms ADD pet_id int NULL AFTER id;
ALTER TABLE k9.r_training ADD pet_id int NULL AFTER id;

ALTER TABLE `r_grooms` DROP FOREIGN KEY `r_grooms_ibfk_1`;
ALTER TABLE `r_training` DROP FOREIGN KEY `r_training_ibfk_1`;
ALTER TABLE `r_daycare` DROP FOREIGN KEY `r_daycare_ibfk_1`;
ALTER TABLE `r_boarding` DROP FOREIGN KEY `r_boarding_ibfk_1` ;

-- 25.04.2014
ALTER TABLE k9.r_boarding ADD status_id int NULL default 1 AFTER id;
ALTER TABLE k9.r_daycare ADD status_id int NULL default 1 AFTER id;
ALTER TABLE k9.r_grooms ADD status_id int NULL default 1 AFTER id;
ALTER TABLE k9.r_training ADD status_id int NULL default 1 AFTER id;

-- 26.04.2014
drop table r_grooms;
drop table r_training;

CREATE TABLE `r_grooms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_id` int(11) DEFAULT '1',
  `pet_id` int(11) DEFAULT NULL,
  `date_in` date DEFAULT NULL,
  `time_in` time DEFAULT NULL,
  `date_out` date DEFAULT NULL,
  `time_out` time DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

CREATE TABLE `r_training` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_id` int(11) DEFAULT '1',
  `pet_id` int(11) DEFAULT NULL,
  `date_in` date DEFAULT NULL,
  `time_in` time DEFAULT NULL,
  `date_out` date DEFAULT NULL,
  `time_out` time DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;



-- 29.04.2014
CREATE TABLE `c_boarding` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `v` tinytext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

CREATE TABLE `c_daycare` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `v` tinytext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

CREATE TABLE `c_grooms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `v` tinytext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

CREATE TABLE `c_training` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `v` tinytext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

ALTER TABLE r_boarding ADD c_boarding_id int DEFAULT NULL after pet_id;
ALTER TABLE r_daycare ADD c_daycare_id int DEFAULT NULL after pet_id;
ALTER TABLE r_grooms ADD c_grooms_id int DEFAULT NULL after pet_id;
ALTER TABLE r_training ADD c_training_id int DEFAULT NULL after pet_id;


-- 07.05.2014
CREATE TABLE IF NOT EXISTS `client_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `v` tinytext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;

ALTER TABLE `clients` DROP `second_owner`;
ALTER TABLE `clients` ADD `client_status_id` INT( 11 ) NOT NULL DEFAULT '1' AFTER `status_id` ;
ALTER TABLE `clients` DROP `emergency_cell` ;

INSERT INTO `client_status` (`id`, `v`) VALUES
(1, 'New'),
(2, 'Refuse'),
(3, 'VIP');


-- 16.05.2014 - charges_petsizes, charges_runtypes, charges_settings

CREATE TABLE IF NOT EXISTS `charges_petsizes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `pet_size_id` int(11) NOT NULL,
  `pet_size_v` varchar(255) NOT NULL,
  `rate` float NOT NULL DEFAULT '0',
  `from_weight` float NOT NULL DEFAULT '0',
  `to_weight` float NOT NULL DEFAULT '0',
  `run` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=33 ;

INSERT INTO `charges_petsizes` (`id`, `status_id`, `pet_size_id`, `pet_size_v`, `rate`, `from_weight`, `to_weight`, `run`) VALUES
(1, 1, 1, 'Miniature', 50, 5, 55, 3),
(2, 1, 2, 'Small', 0, 23, 40, 51),
(3, 1, 3, 'Medium', 56, 50, 5.52, 50),
(4, 1, 0, 'Big', 0, 0, 0, 3),
(5, 1, 0, 'Large', 25, 56, 12, 0),
(6, 1, 0, 'Extraordinary', 500, 41, 10, 0);


CREATE TABLE IF NOT EXISTS `charges_runtypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_id` tinyint(4) NOT NULL DEFAULT '1',
  `runtype` varchar(255) NOT NULL,
  `rate` float NOT NULL DEFAULT '0',
  `limit` tinyint(4) NOT NULL,
  `override` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

INSERT INTO `charges_runtypes` (`id`, `status_id`, `runtype`, `rate`, `limit`, `override`) VALUES
(1, 1, 'No Charge', 0, 1, 0),
(2, 1, 'VIP', 32, 5, 1),
(3, 1, 'Special runtype', 18, 2, 0);

CREATE TABLE IF NOT EXISTS `charges_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `n` varchar(255) NOT NULL,
  `v` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

INSERT INTO `charges_settings` (`id`, `n`, `v`) VALUES
(3, 'handle_carefully_surcharge', '60'),
(7, 'charge_type', 'charge_by_petsize'),
(8, 'medication_fee', '15.21'),
(9, 'daycare_daily_fee', '60'),
(10, 'diet_fee', '50'),
(11, 'charge_fee', 'charge_by_daily_fee');

-- 18.05.2014
alter table `clients` drop `civility_id`;
drop table `civilities`;



-- 19.05.2014
CREATE TABLE IF NOT EXISTS `r_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `n` varchar(255) NOT NULL,
  `v` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

INSERT INTO `r_settings` (`id`, `n`, `v`) VALUES
(1, 'available_boarding', '2'),
(2, 'available_daycare', '4'),
(3, 'available_grooms', '10'),
(4, 'available_training', '5');

CREATE TABLE IF NOT EXISTS `r_boarding_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `available` int(11) NOT NULL,
  `closed` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- 21.05.2014
drop table `charges_petsizes`;
drop table `charges_runtypes`;
drop table `charges_settings`;

CREATE TABLE IF NOT EXISTS `charges_petsizes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `pet_size_v` varchar(255) NOT NULL,
  `limit` int(11) NOT NULL DEFAULT '0',
  `full_day` float NOT NULL DEFAULT '0',
  `half_day` float NOT NULL DEFAULT '0',
  `from_weight` float NOT NULL DEFAULT '0',
  `to_weight` float NOT NULL DEFAULT '0',
  `run` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

INSERT INTO `charges_petsizes` (`id`, `status_id`, `pet_size_v`, `limit`, `full_day`, `half_day`, `from_weight`, `to_weight`, `run`) VALUES
(1, 1, 'Miniature', 55, 25, 18, 22, 55.33, 8),
(2, 1, 'Small', 23, 0, 0, 23, 40, 55),
(3, 1, 'Medium', 0, 0, 0, 50, 5.52, 50),
(4, 1, 'Big', 0, 0, 0, 0, 0, 3),
(5, 1, 'Large', 0, 0, 0, 56, 12, 0),
(6, 1, 'Extraordinary', 0, 0, 0, 41, 10, 0),
(7, 1, 'Superb', 50, 10, 2, 5, 7.55, 5);

CREATE TABLE IF NOT EXISTS `charges_runtypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_id` tinyint(4) NOT NULL DEFAULT '1',
  `runtype` varchar(255) NOT NULL,
  `limit` tinyint(4) NOT NULL,
  `full_day` float NOT NULL DEFAULT '0',
  `half_day` float NOT NULL DEFAULT '0',
  `override` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

INSERT INTO `charges_runtypes` (`id`, `status_id`, `runtype`, `limit`, `full_day`, `half_day`, `override`) VALUES
(1, 2, 'No Charge', 0, 0, 0, 1),
(2, 1, 'VIP', 5, 0, 0, 1),
(3, 1, 'Special runtype', 2, 0, 0, 0),
(4, 1, 'Special offer', 10, 20, 30, 0);

CREATE TABLE IF NOT EXISTS `charges_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `n` varchar(255) NOT NULL,
  `v` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=34 ;

INSERT INTO `charges_settings` (`id`, `n`, `v`) VALUES
(1, 'charge_type', 'charge_by_petsize'),
(2, 'surcharge_aggressive', '24.00'),
(3, 'surcharge_special_needs', '56.00'),
(4, 'surcharge_difficult', '42.00'),
(5, 'charge_meds_diets', 'charge_by_diets'),
(6, 'charge_fee_per_diets_diet', '52.00'),
(7, 'charge_fee_per_administration_diet', '23'),
(8, 'charge_fee_per_administration_meds', '60'),
(9, 'charge_fee_per_diets_meds', '120.00'),
(10, 'check_out_time', '16:20'),
(11, 'check_in_time', '10:30'),
(13, 'charge_24_hour', '1'),
(14, 'charge_after_checkout', '1'),
(15, 'charge_after_checkout_hours', '1'),
(16, 'charge_after_checkout_fee', '20.00'),
(17, 'charge_hour_after_checkout', '1'),
(18, 'charge_half_day_rate', '1'),
(19, 'charge_hour_after_checkout_fee', '50'),
(20, 'charge_half_day_rate_fee', '50'),
(21, 'deduct_daycare_from_existing_pass', '0'),
(22, 'charge_daycare_group_rate', '1'),
(23, 'half_day_from', '09:50'),
(24, 'half_day_to', '11:50'),
(25, 'full_day_from', '14:15'),
(26, 'full_half_day_to', '04:50'),
(27, 'is_full_day', '0'),
(28, 'is_half_day', '1'),
(29, 'charge_for_holidays', '1'),
(30, 'charge_aditional_for_holidays', '1'),
(31, 'charge_for_saturdays', '1'),
(32, 'charge_for_sundays', '1'),
(33, 'charge_aditional_for_holidays_fee', '20');



-- 31.05.2014
truncate table `charges_settings`;

INSERT INTO `charges_settings` (`id`, `n`, `v`) VALUES
(1, 'check_out_time', '09:20'),
(2, 'check_in_time', '12:20'),
(3, 'charge_24_hour', '1'),
(4, 'charge_hour_after_checkout_fee', '50'),
(5, 'charge_after_checkout_option', 'charge_holidays'),
(6, 'charge_aditional_for_holidays_fee', '20'),
(7, 'charge_half_day_checkout_fee', '15'),
(8, 'charge_for_saturdays', '1'),
(9, 'charge_for_sundays', '1'),
(10, 'charge_daycare_option', 'charge_daycare_deduct'),
(11, 'charge_daycare_deduct_fulldays', '1'),
(12, 'half_day_from', '08:00'),
(13, 'half_full_day_option', 'is_full_day'),
(14, 'half_day_to', '12:00'),
(15, 'full_day_from', '08:00'),
(16, 'full_half_day_to', '16:00'),
(17, 'charge_type', 'charge_by_runtype'),
(18, 'surcharge_difficult', '50.00'),
(19, 'surcharge_special_needs', '60.00'),
(20, 'surcharge_aggressive', '20.00'),
(21, 'charge_meds_diets', 'charge_by_administration'),
(22, 'charge_fee_per_diets_meds', '50.00'),
(23, 'charge_fee_per_diets_diet', '20.00'),
(24, 'charge_fee_per_administration_meds', '15.00'),
(25, 'charge_fee_per_administration_diet', '50.00');

-- 02.06.2014
CREATE TABLE IF NOT EXISTS `pet_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `v` tinytext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

INSERT INTO `pet_status` (`id`, `v`) VALUES
(1, 'Agressive'),
(2, 'Bully'),
(3, 'Good natured'),
(4, 'Handle with care'),
(5, 'Runner'),
(6, 'Dominant'),
(7, 'Whiner'),
(8, 'Fear biter');

ALTER TABLE `pets` ADD `pet_status_id` INT NOT NULL AFTER `pet_type_id` ;
ALTER TABLE `pets` CHANGE `pet_status_id` `pet_status_id` INT( 11 ) NULL ;
ALTER TABLE `pet_status` ADD `status_id` INT NOT NULL DEFAULT '1' AFTER `id` ;



-- 03.06.2014
CREATE TABLE IF NOT EXISTS `pet_vet` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pet_id` int(11) DEFAULT NULL,
  `vet_id` int(11) DEFAULT NULL,
  `rabies` date DEFAULT NULL,
  `bordetella` date DEFAULT NULL,
  `d_h_l_p` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `vets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `fax` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `contact` varchar(255) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `zip` varchar(255) DEFAULT NULL,
  `notes` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

ALTER TABLE `vets` ADD `status_id` INT NOT NULL DEFAULT '1' AFTER `id` ;

-- 04.06.2014
ALTER TABLE `pet_vet` ADD `status_id` INT NOT NULL DEFAULT '1' AFTER `id` ;



-- 10.06.2014
CREATE TABLE IF NOT EXISTS `r_boarding_stay_reason` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `v` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

INSERT INTO `r_boarding_stay_reason` (`id`, `status_id`, `v`) VALUES
(1, 1, 'Rescue animal'),
(2, 1, 'Other'),
(3, 1, 'Vacation local'),
(4, 1, 'Vaction interstate'),
(5, 1, 'Vacation international'),
(6, 1, 'Vacation international'),
(7, 1, 'Renovating home'),
(8, 1, 'Moving or relocating');

ALTER TABLE `r_boarding` ADD `stay_reason_id` INT NOT NULL AFTER `pet_id` ;
ALTER TABLE `r_boarding` ADD `in_out` ENUM( 'in', 'out' ) NOT NULL DEFAULT 'in' AFTER `c_boarding_id` ;
ALTER TABLE `r_boarding` ADD `deposit` FLOAT NOT NULL AFTER `c_boarding_id` ;
ALTER TABLE `r_boarding` ADD `charge_type_id` INT NOT NULL AFTER `deposit` ;
ALTER TABLE `r_boarding` ADD `charge_type` ENUM( 'charge_by_petsize', 'charge_by_runtype' ) NOT NULL AFTER `deposit` ;
ALTER TABLE `r_boarding` ADD `client_id` INT NOT NULL AFTER `status_id` ;
insert into settings set n = 'layout_button_hover_bg_color', v = '#d40000', t = 'text';



-- 28.06.2014

CREATE TABLE IF NOT EXISTS `r_boarding_ss` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `v` varchar(255) NOT NULL,
  `price` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

INSERT INTO `r_boarding_ss` (`id`, `status_id`, `v`, `price`) VALUES
(1, 1, 'Basic Obedience', 20),
(2, 1, 'Sunday Check in / out', 25),
(3, 1, 'Behaviour Training', 10),
(4, 1, 'Trip to the vet', 50),
(5, 1, 'Special needs', 3),
(6, 1, 'Airport trip', 50),
(7, 1, 'Bordetella Vaccine', 25);


CREATE TABLE IF NOT EXISTS `r_boarding_ss_t` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `r_boarding_id` int(11) NOT NULL,
  `r_boarding_ss_id` int(11) NOT NULL,
  `ss_price` float NOT NULL DEFAULT '0',
  `ss_times` int(11) NOT NULL,
  `ss_instructions` varchar(255) NOT NULL,
  `ss_exclude_checkin` tinyint(4) NOT NULL DEFAULT '0',
  `ss_exclude_checkout` tinyint(4) NOT NULL DEFAULT '0',
  `ss_date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;


-- 30.06.2014

ALTER TABLE `r_boarding` ADD `luggage` VARCHAR( 255 ) NOT NULL AFTER `c_boarding_id` ;
ALTER TABLE `r_boarding_ss_t` ADD `ss_everyday` TINYINT NOT NULL DEFAULT '0' AFTER `ss_date` ;

CREATE TABLE IF NOT EXISTS `meds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `v` varchar(255) NOT NULL,
  `price` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

INSERT INTO `meds` (`id`, `status_id`, `v`, `price`) VALUES
(1, 1, 'Ace', 0),
(2, 1, 'Advantage', 0),
(3, 1, 'Alcohol', 0),
(4, 1, 'Aller-G3', 0),
(5, 1, 'Amforal', 0),
(6, 1, 'Aminophyline', 0),
(7, 1, 'Amitriptyline', 0),
(8, 3, 'test', 0);

CREATE TABLE IF NOT EXISTS `r_boarding_meds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `r_boarding_id` int(11) NOT NULL,
  `med_id` int(11) NOT NULL,
  `med_type` varchar(25) NOT NULL,
  `med_dose_ml` varchar(255) NOT NULL,
  `med_dose_type` varchar(255) NOT NULL,
  `med_morning` tinyint(4) NOT NULL DEFAULT '0',
  `med_afternoon` tinyint(4) NOT NULL DEFAULT '0',
  `med_evening` tinyint(4) NOT NULL DEFAULT '0',
  `med_as_needed` tinyint(4) NOT NULL DEFAULT '0',
  `med_date` date NOT NULL,
  `med_everyday` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;
ALTER TABLE `r_boarding_meds` ADD `med_instructions` VARCHAR( 255 ) NOT NULL AFTER `med_id` ;

CREATE TABLE IF NOT EXISTS `diets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `v` varchar(255) NOT NULL,
  `price` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

INSERT INTO `diets` (`id`, `status_id`, `v`, `price`) VALUES
(1, 1, 'Allpo canned', 0),
(2, 1, 'Allpo dry', 0),
(3, 1, 'Beneful dry', 0),
(4, 1, 'bil-jac dry', 0),
(5, 1, 'bil-jac frozen', 0);

CREATE TABLE IF NOT EXISTS `r_boarding_diets` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`status_id` int(11) NOT NULL DEFAULT '1',
`r_boarding_id` int(11) NOT NULL,
`diet_id` int(11) NOT NULL,
`diet_instructions` varchar(255) NOT NULL,
`diet_type` varchar(25) NOT NULL,
`diet_dose_ml` varchar(255) NOT NULL,
`diet_dose_type` varchar(255) NOT NULL,
`diet_morning` tinyint(4) NOT NULL DEFAULT '0',
`diet_afternoon` tinyint(4) NOT NULL DEFAULT '0',
`diet_evening` tinyint(4) NOT NULL DEFAULT '0',
`diet_as_needed` tinyint(4) NOT NULL DEFAULT '0',
`diet_date` date NOT NULL,
`diet_everyday` tinyint(4) NOT NULL DEFAULT '0',
PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;


CREATE TABLE IF NOT EXISTS `meds_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `v` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

INSERT INTO `meds_type` (`id`, `status_id`, `v`) VALUES
(1, 1, 'pill'),
(2, 1, 'ointment'),
(3, 1, 'drop'),
(4, 1, 'liquid'),
(5, 1, 'injection');

CREATE TABLE IF NOT EXISTS `md_dosage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `v` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=29 ;

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

CREATE TABLE IF NOT EXISTS `md_dose_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `v` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

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

CREATE TABLE IF NOT EXISTS `diets_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `v` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

INSERT INTO `diets_type` (`id`, `status_id`, `v`) VALUES
(1, 1, 'liquid'),
(2, 1, 'solid'),
(3, 1, 'can'),
(4, 1, 'own food'),
(5, 1, 'dry');

ALTER TABLE `r_boarding_meds` CHANGE `med_type` `med_type_id` INT NOT NULL ;
ALTER TABLE `r_boarding_meds` CHANGE `med_dose_ml` `med_dosage_id` INT NOT NULL ;
ALTER TABLE `r_boarding_meds` CHANGE `med_dose_type` `med_dose_type_id` INT NOT NULL ;

ALTER TABLE `r_boarding_diets` CHANGE `diet_type` `diet_type_id` INT NOT NULL ;
ALTER TABLE `r_boarding_diets` CHANGE `diet_dose_ml` `diet_dosage_id` INT NOT NULL ;
ALTER TABLE `r_boarding_diets` CHANGE `diet_dose_type` `diet_dose_type_id` INT NOT NULL ;



-- 11.07.2014

CREATE TABLE IF NOT EXISTS `languages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `k` varchar(255) NOT NULL,
  `en` text NOT NULL,
  `fr` text NOT NULL,
  `de` text NOT NULL,
  `it` text NOT NULL,
  `pt` text NOT NULL,
  `es` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=24 ;

INSERT INTO `languages` (`id`, `k`, `en`, `fr`, `de`, `it`, `pt`, `es`) VALUES
(1, 'billing_details', 'Billing details', '', '', '', '', 'Detalii de facturare'),
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
(22, 'total', 'Total', '', '', '', '', ''),
(23, 'pp_thank_you_for_boarding', 'Thank you for boarding with us, <br /> Come back again !', '', '', '', '', ''),
(24, 'pet_name', 'Pet name', '', '', '', '', '');

CREATE TABLE IF NOT EXISTS `reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `report` varchar(255) NOT NULL,
  `language` varchar(16) NOT NULL,
  `params` text NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;



-- 12.09.2014

ALTER TABLE `r_boarding` ADD `report_id` INT NOT NULL AFTER `in_out` ;
ALTER TABLE `reports` ADD `date_modified` TIMESTAMP NOT NULL AFTER `date_created` ;
INSERT INTO `k9`.`settings` (`id` ,`status_id` ,`n` ,`v` ,`t` ,`j`) VALUES (NULL , '1', 'languages', '[{"lang":"en","text":"English"},{"lang":"fr","text":"French"},{"lang":"de","text":"German"},{"lang":"it","text":"Italian"},{"lang":"pt","text":"Portuguese"},{"lang":"es","text":"Spanish"}]', 'text', '');

CREATE TABLE IF NOT EXISTS `payment_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `v` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

INSERT INTO `payment_types` (`id`, `status_id`, `v`) VALUES
(1, 1, 'CA'),
(2, 1, 'CK'),
(3, 1, 'VI'),
(4, 1, 'MC'),
(5, 1, 'DC'),
(6, 1, 'AX'),
(7, 1, 'DE'),
(8, 1, 'GC');

INSERT INTO `k9`.`settings` (`id` ,`status_id` ,`n` ,`v` ,`t` ,`j`) VALUES (NULL , '1', 'default_language', 'en', 'text', '');
INSERT INTO `k9`.`settings` (`id`, `status_id`, `n`, `v`, `t`, `j`) VALUES (NULL, '1', 'default_payment_type_id', '1', 'array', 'payment_types');

CREATE TABLE IF NOT EXISTS `payments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `payment_status_id` int(11) NOT NULL DEFAULT '1',
  `payment` varchar(255) NOT NULL,
  `report_id` int(11) NOT NULL,
  `information` text NOT NULL,
  `amount` float NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `payment_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `v` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

INSERT INTO `payment_status` (`id`, `status_id`, `v`) VALUES
(1, 1, 'Active'),
(2, 1, 'Inactive'),
(3, 1, 'Deleted'),
(4, 1, 'Pending'),
(5, 1, 'Processed');

ALTER TABLE `r_boarding` ADD `date_out_checkout` DATE NOT NULL AFTER `time_out` ;
ALTER TABLE `r_boarding` ADD `time_out_checkout` TIME NOT NULL AFTER `date_out_checkout` ;

-- 14.07.2014
UPDATE `k9`.`settings` SET `n` = 'image_logo_id' WHERE `settings`.`n` = 'image_logo';


-- 30.07.2014
ALTER TABLE `client_status` ADD `status_id` INT NOT NULL DEFAULT '1' AFTER `id` ;
ALTER TABLE `charges_petsizes` CHANGE `pet_size_v` `v` VARCHAR( 255 ) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL ;
ALTER TABLE `charges_runtypes` CHANGE `runtype` `v` VARCHAR( 255 ) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL ;

-- 06.08.2014
ALTER TABLE `vets` CHANGE `name` `v` VARCHAR( 255 ) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL ;





-- 11.08.2014
CREATE TABLE IF NOT EXISTS `client_survey_income` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `v` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

INSERT INTO `client_survey_income` (`id`, `status_id`, `v`) VALUES
(1, 1, '$250,000 and higher'),
(2, 1, '$150,000 to $250,000'),
(3, 1, '$100,000 to $150,000'),
(4, 1, '$75,000 to $100,000'),
(5, 1, '$60,000 to $75,000'),
(6, 1, '$45,000 to $60,000'),
(7, 1, '$30,000 to $45,000'),
(8, 1, 'Less than $30,000');

CREATE TABLE IF NOT EXISTS `client_survey_findout` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `is_refferal` int(11) NOT NULL DEFAULT '0',
  `v` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

INSERT INTO `client_survey_findout` (`id`, `status_id`, `is_refferal`, `v`) VALUES
(1, 1, 0, 'Animal Clinic'),
(2, 1, 0, 'Coupon Book'),
(3, 1, 0, 'Drive by'),
(4, 1, 0, 'Flyer'),
(5, 1, 1, 'Friend referral'),
(6, 1, 0, 'Internet search'),
(7, 1, 0, 'Mascott dog on 41'),
(8, 1, 0, 'Newspaper'),
(9, 1, 0, 'No answer given'),
(10, 1, 0, 'Other'),
(11, 1, 0, 'Party in the park'),
(12, 1, 0, 'Radio'),
(13, 1, 0, 'Rescue event'),
(14, 1, 0, 'Veterinarian'),
(15, 1, 0, 'Yellow Pages');

CREATE TABLE IF NOT EXISTS `clients_survey` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `client_id` int(11) DEFAULT NULL,
  `reffered_client_id` int(11) DEFAULT NULL,
  `client_survey_income_id` int(11) DEFAULT NULL,
  `client_survey_findout_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- 12.08.2014
ALTER TABLE `pet_color` DROP `hex` ;
ALTER TABLE `clients` DROP `pet_id` ;

-- 25.08.2014
CREATE TABLE IF NOT EXISTS `groomers` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `status_id` int(11) NOT NULL DEFAULT '1',
    `image_id` int(11) NOT NULL,
    `first_name` varchar(255) NOT NULL,
    `last_name` varchar(255) NOT NULL,
    `phone` varchar(255) NOT NULL,
    `cell` varchar(255) NOT NULL,
    `email` varchar(255) NOT NULL,
    `street` varchar(255) NOT NULL,
    `city` varchar(255) NOT NULL,
    `state` varchar(255) NOT NULL,
    `zip` varchar(255) NOT NULL,
    `mon` tinyint(4) NOT NULL DEFAULT '1',
    `mon_in` time NOT NULL DEFAULT '08:00',
    `mon_out` time NOT NULL DEFAULT '18:00',
    `tue` tinyint(4) NOT NULL DEFAULT '1',
    `tue_in` time NOT NULL DEFAULT '08:00',
    `tue_out` time NOT NULL DEFAULT '18:00',
    `wed` tinyint(4) NOT NULL DEFAULT '1',
    `wed_in` time NOT NULL DEFAULT '08:00',
    `wed_out` time NOT NULL DEFAULT '18:00',
    `thu` tinyint(4) NOT NULL DEFAULT '1',
    `thu_in` time NOT NULL DEFAULT '08:00',
    `thu_out` time NOT NULL DEFAULT '18:00',
    `fri` tinyint(4) NOT NULL DEFAULT '1',
    `fri_in` time NOT NULL DEFAULT '08:00',
    `fri_out` time NOT NULL DEFAULT '18:00',
    `sat` tinyint(4) NOT NULL DEFAULT '0',
    `sat_in` time NOT NULL DEFAULT '08:00',
    `sat_out` time NOT NULL DEFAULT '18:00',
    `sun` tinyint(4) NOT NULL DEFAULT '0',
    `sun_in` time NOT NULL DEFAULT '08:00',
    `sun_out` time NOT NULL DEFAULT '18:00',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `grooming_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `v` varchar(255) NOT NULL,
  `multiplier` float NOT NULL DEFAULT '0',
  `change_price` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

INSERT INTO `grooming_types` (`id`, `status_id`, `v`, `multiplier`, `change_price`) VALUES
(1, 1, 'Bad shape', 2, 1),
(2, 1, 'Good shape', 0.5, 0),
(3, 1, 'Heavily matted', 1.5, 1),
(4, 1, 'Tidy up', 0, 0),
(5, 1, 'Shave', 0, 0),
(6, 1, 'Full groom', 0, 0),
(7, 1, 'Special', 0.3, 1),
(8, 1, 'De-matting', 1, 1);

CREATE TABLE IF NOT EXISTS `grooming_services` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
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
  `type` enum('bath','hair_cut') NOT NULL DEFAULT 'bath',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

INSERT INTO `grooming_services` (`id`, `status_id`, `v`, `miniature`, `small`, `medium`, `med_lg`, `large`, `giant`, `cat`, `sand`, `other`, `hcp`, `in_use`, `type`) VALUES
(1, 1, 'Nails', 10, 10, 10, 10, 10, 15, 12, 0, 0, 10, 1, 'bath'),
(2, 1, 'Ears', 5, 5, 5, 5, 5, 5, 0, 0, 0, 10, 1, 'bath'),
(3, 1, 'Front line flea', 9.99, 9.99, 9.99, 9.99, 9.99, 9.99, 0, 0, 0, 10, 1, 'bath'),
(4, 1, 'Conditioner', 3, 3, 5, 5, 5, 5, 0, 0, 0, 10, 1, 'bath'),
(5, 1, 'Hypo-alergenic', 5, 5, 5, 5, 5, 5, 0, 0, 0, 10, 1, 'bath'),
(6, 1, 'Flea & tic dip', 5, 5, 5, 5, 5, 5, 0, 0, 0, 0, 1, 'hair_cut'),
(7, 1, 'Furminator shampo', 5, 5, 5, 5, 5, 5, 0, 0, 0, 0, 1, 'hair_cut'),
(8, 1, 'De-sheding', 15, 15, 20, 20, 25, 30, 0, 0, 0, 0, 1, 'hair_cut'),
(9, 1, 'De-matting', 5, 5, 5, 5, 5, 5, 0, 0, 0, 0, 1, 'hair_cut');

ALTER TABLE `r_grooms` ADD `groomer_id` INT NOT NULL AFTER `c_grooms_id` ,
ADD `service_type` ENUM( 'bath', 'hair_cut' ) NULL DEFAULT NULL AFTER `groomer_id` ,
ADD `grooming_type_id` INT NOT NULL AFTER `service_type` ,
ADD `multiplier` FLOAT NOT NULL DEFAULT '0' AFTER `grooming_type_id` ,
ADD `gs_array` VARCHAR( 255 ) NOT NULL AFTER `multiplier` ;




-- 04.09.2014
CREATE TABLE IF NOT EXISTS `retail_classes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_id` tinyint(4) NOT NULL DEFAULT '1',
  `class_name` varchar(255) NOT NULL,
  `margin` tinyint(4) NOT NULL DEFAULT '0',
  `markup` tinyint(4) NOT NULL DEFAULT '0',
  `sale` tinyint(4) NOT NULL DEFAULT '0',
  `damage` tinyint(4) NOT NULL DEFAULT '0',
  `whole` tinyint(4) NOT NULL DEFAULT '0',
  `comp` tinyint(4) NOT NULL DEFAULT '0',
  `employee` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `retail_classes`
--

INSERT INTO `retail_classes` (`id`, `status_id`, `class_name`, `margin`, `markup`, `sale`, `damage`, `whole`, `comp`, `employee`) VALUES
(1, 1, 'Accessories', 0, 50, 10, 20, 20, 100, 10),
(2, 1, 'Animal Medic Inc', 20, 0, 10, 20, 0, 100, 7),
(3, 1, 'Artemis', 25, 0, 10, 20, 0, 100, 7),
(4, 1, 'Beds for pets', 30, 0, 10, 20, 0, 100, 7),
(5, 1, 'Cloud star', 25, 0, 10, 20, 0, 100, 15),
(6, 1, 'Juice', 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `retail_inventory`
--

CREATE TABLE IF NOT EXISTS `retail_inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `product_code` varchar(255) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `price` float NOT NULL,
  `quantity` int(11) NOT NULL,
  `at` int(11) NOT NULL,
  `to` int(11) NOT NULL,
  `tax` tinyint(4) NOT NULL DEFAULT '1',
  `class_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `retail_inventory`
--

INSERT INTO `retail_inventory` (`id`, `status_id`, `product_code`, `product_name`, `price`, `quantity`, `at`, `to`, `tax`, `class_id`) VALUES
(1, 1, '12312534-15747', 'Ear cleaning (cat)', 5, 3, 0, 0, 0, 4),
(2, 1, '65789-4967', 'Something cool', 20, 0, 0, 0, 1, 2),
(3, 1, '134968997', 'CocaCola', 23.5, 10, 0, 0, 1, 6);

-- --------------------------------------------------------

--
-- Table structure for table `retail_vendors`
--

CREATE TABLE IF NOT EXISTS `retail_vendors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
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
  `email` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `retail_vendors`
--

INSERT INTO `retail_vendors` (`id`, `status_id`, `name`, `account`, `contact`, `alt_contact`, `street`, `city`, `state`, `zip`, `phone`, `fax`, `alt_phone`, `other`, `terms`, `comments`, `website`, `email`) VALUES
(1, 1, 'TODORESCU LTD', '49123987', '(452) 123-4567', '', 'str. Tudor Vladimirescu nr. 62', 'Alba Iulia', 'AB', '510167', '0740815174', '', '', '', 'Niste termeni si conditii', 'Niste comentarii', 'http://www.google.com', 'fishbonezul@yahoo.com'),
(2, 1, 'BOLCA DORIAN SERVICES', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `retail_vi`
--

CREATE TABLE IF NOT EXISTS `retail_vi` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_id` tinyint(4) NOT NULL DEFAULT '1',
  `retail_vendor_id` int(11) NOT NULL,
  `retail_inventory_id` int(11) NOT NULL,
  `our_cost` float NOT NULL DEFAULT '0',
  `reorder_number` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

--
-- Dumping data for table `retail_vi`
--

INSERT INTO `retail_vi` (`id`, `status_id`, `retail_vendor_id`, `retail_inventory_id`, `our_cost`, `reorder_number`) VALUES
(7, 1, 1, 2, 20, 0),
(8, 1, 2, 3, 10, 0);

-- 22.09.2014
ALTER TABLE `payments` ADD `payment_type_id` INT NOT NULL AFTER `id`;
ALTER TABLE `payments` ADD `payment_amount` FLOAT NOT NULL AFTER `payment_status_id`;
ALTER TABLE `payments` DROP `amount`;
ALTER TABLE `payments` ADD `client_id` INT NOT NULL AFTER `payment`;
insert into `settings` set `n` = 'report_image_id', `v` = '1', `t` = 'array', `j` = 'files';




-- 14.10.2014
CREATE TABLE IF NOT EXISTS `training_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_id` tinyint(4) NOT NULL DEFAULT '1',
  `rank` int(11) NOT NULL,
  `v` varchar(255) NOT NULL,
  `price` float NOT NULL,
  `limit` int(11) NOT NULL,
  `instructions` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

INSERT INTO `training_groups` (`id`, `status_id`, `rank`, `v`, `price`, `limit`, `instructions`) VALUES
(1, 1, 0, 'Kindergarten Puppy', 55, 10, ''),
(2, 1, 1, 'Beginning', 70, 10, '\r\n'),
(3, 1, 2, 'Intermediate', 125, 10, '');

CREATE TABLE IF NOT EXISTS `training_options` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_id` tinyint(4) NOT NULL DEFAULT '1',
  `tg_id` int(11) NOT NULL,
  `v` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `price` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

INSERT INTO `training_options` (`id`, `status_id`, `tg_id`, `v`, `description`, `price`) VALUES
(5, 1, 2, 'Something', '- short description -', 10),
(8, 1, 2, 'Other stuff', '', 20);

CREATE TABLE IF NOT EXISTS `trainers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `image_id` int(11) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `cell` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `street` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  `zip` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

INSERT INTO `trainers` (`id`, `status_id`, `image_id`, `first_name`, `last_name`, `phone`, `cell`, `email`, `street`, `city`, `state`, `zip`) VALUES
(1, 1, 0, 'Todorescu', 'Tudor', '0740815174', '0325123156', 'todorescu.tudor@example.com', 'T. Alexandri nr. 62', 'Alba Iulia', 'Alba', '510167');



-- 17.10.2014
drop table trainers;
drop table training_groups;
drop table training_options;

CREATE TABLE IF NOT EXISTS `trainers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `image_id` int(11) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `cell` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `street` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  `zip` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

INSERT INTO `trainers` (`id`, `status_id`, `image_id`, `first_name`, `last_name`, `phone`, `cell`, `email`, `street`, `city`, `state`, `zip`) VALUES
(1, 1, 112, 'Todorescu', 'Tudor', '(123) 456-7890', '(123) 456-7890', 'todorescu.tudor@example.com', 'T. Alexandri nr. 62', 'Alba Iuliaa', 'Alba', '510167\r\n'),
(2, 1, 0, 'Dorian', 'Bolca', '', '', '', '', '', '', '');

CREATE TABLE IF NOT EXISTS `training_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_id` tinyint(4) NOT NULL DEFAULT '1',
  `rank` int(11) NOT NULL,
  `v` varchar(255) NOT NULL,
  `price` float NOT NULL,
  `limit` int(11) NOT NULL,
  `instructions` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

INSERT INTO `training_groups` (`id`, `status_id`, `rank`, `v`, `price`, `limit`, `instructions`) VALUES
(1, 1, 0, 'Kindergarten Puppy', 55.2, 90, ''),
(2, 1, 1, 'Beginning', 70, 10, ''),
(3, 1, 2, 'Intermediate', 125, 10, ''),
(4, 3, 2, 'asd', 12, 1, 'aac');

CREATE TABLE IF NOT EXISTS `training_options` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_id` tinyint(4) NOT NULL DEFAULT '1',
  `tg_id` int(11) NOT NULL,
  `v` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `price` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

INSERT INTO `training_options` (`id`, `status_id`, `tg_id`, `v`, `description`, `price`) VALUES
(5, 1, 2, 'Something', '- short description -', 10),
(8, 1, 2, 'Other stuff', '', 20);

CREATE TABLE IF NOT EXISTS `training_schedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_id` tinyint(4) NOT NULL DEFAULT '1',
  `tg_id` int(11) NOT NULL,
  `t_id` int(11) NOT NULL,
  `date_start` date NOT NULL,
  `date_end` date NOT NULL,
  `time_duration` time NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

INSERT INTO `training_schedule` (`id`, `status_id`, `tg_id`, `t_id`, `date_start`, `date_end`, `time_duration`) VALUES
(1, 1, 2, 1, '2014-10-15', '2014-10-09', '10:00:00'),
(2, 1, 1, 2, '2014-10-10', '0000-00-00', '00:00:50'),
(3, 1, 2, 1, '2014-10-08', '2014-10-08', '09:00:00'),
(4, 1, 1, 2, '2014-10-16', '2014-10-17', '08:05:00'),
(5, 1, 3, 1, '2014-10-07', '2014-10-07', '15:05:00'),
(6, 3, 3, 1, '2014-10-07', '2014-10-07', '15:05:00'),
(7, 1, 1, 1, '2014-10-17', '2014-10-17', '09:50:00');















-- 21.10.14

CREATE TABLE IF NOT EXISTS `daycare_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_id` tinyint(4) NOT NULL DEFAULT '1',
  `v` varchar(25) NOT NULL,
  `day_rate` float NOT NULL,
  `limit` int(11) NOT NULL,
  `hour_rate` float NOT NULL,
  `group_as_id` int(11) NOT NULL,
  `halfday_rate` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

INSERT INTO `daycare_groups` (`id`, `status_id`, `v`, `day_rate`, `limit`, `hour_rate`, `group_as_id`, `halfday_rate`) VALUES
(1, 1, 'Daycare', 25, 10, 0, 0, 26),
(2, 1, 'None', 0, 100, 0, 0, 0),
(3, 3, 'asdad', 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `daycare_settings`
--

CREATE TABLE IF NOT EXISTS `daycare_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `n` varchar(255) NOT NULL,
  `v` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=19 ;

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
(10, 'rvt_before_hour', '10:00'),
(11, 'rvs_less_than_nr_hours', '4'),
(12, 'c_fast_checkin', '1'),
(13, 'c_default_to_charge_per_hour', '0'),
(14, 'sh_hours_rounding', '2'),
(15, 't_over_1_day_penalty', '20'),
(16, 'se_default_daycare_group', '1'),
(17, 'sh_check_groups_limit', '1'),
(18, 'c_print_collar_automatically', '1'),
(19, 'se_prefered_group', '1');


-- 22.10.2014
RENAME TABLE c_boarding TO boarding_centers;
RENAME TABLE c_daycare TO daycare_centers;
RENAME TABLE c_grooms TO grooms_centers;
RENAME TABLE c_training TO training_centers;

ALTER TABLE `r_boarding` CHANGE `c_boarding_id` `boarding_center_id` INT( 11 ) NULL DEFAULT NULL ;
ALTER TABLE `r_grooms` CHANGE `c_grooms_id` `grooms_center_id` INT( 11 ) NULL DEFAULT NULL ;
ALTER TABLE `r_daycare` CHANGE `c_daycare_id` `daycare_center_id` INT( 11 ) NULL DEFAULT NULL ;
ALTER TABLE `r_training` CHANGE `c_training_id` `training_center_id` INT( 11 ) NULL DEFAULT NULL ;




DROP TABLE r_boarding_settings;
DROP TABLE r_daycare;
CREATE TABLE IF NOT EXISTS `r_daycare` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_id` int(11) DEFAULT '1',
  `pet_id` int(11) DEFAULT NULL,
  `client_id` int(11) NOT NULL,
  `daycare_center_id` int(11) DEFAULT NULL,
  `daycare_group_id` int(11) NOT NULL,
  `date_in` date DEFAULT NULL,
  `time_in` time DEFAULT NULL,
  `date_out` date DEFAULT NULL,
  `time_out` time DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;


-- 27.10.2014
ALTER TABLE `r_boarding_ss_t` CHANGE `r_boarding_ss_id` `ss_id` INT( 11 ) NOT NULL ;
RENAME TABLE r_boarding_ss TO schedule_services;
RENAME TABLE r_boarding_ss_t TO r_boarding_ss;
RENAME TABLE r_boarding_stay_reason TO stay_reasons;

-- 29.10.2014
ALTER TABLE `r_grooms` ADD `client_id` INT NOT NULL AFTER `status_id` ;
drop table r_settings;
ALTER TABLE `schedule_services` ADD `commission_percentage` FLOAT NOT NULL DEFAULT '0' AFTER `price` ;
ALTER TABLE `retail_inventory` ADD `commission_percentage` FLOAT NOT NULL DEFAULT '0' AFTER `class_id` ;
ALTER TABLE `trainers` ADD `commission_percentage` FLOAT NOT NULL DEFAULT '0' AFTER `zip` ;
ALTER TABLE `groomers` ADD `commission_percentage` FLOAT NOT NULL DEFAULT '0' AFTER `sun_out` ;
INSERT INTO `k9`.`charges_settings` (`id` ,`n` ,`v`) VALUES (NULL , 'commissions_new_customers_board', '50');
insert into client_status set v = 'No show';
insert into client_status set v = 'Low';
insert into client_status set v = 'Mid';
insert into client_status set v = 'High';



-- 02.11.2014
ALTER TABLE `clients` ADD `contact_work_phone` VARCHAR( 120 ) NOT NULL AFTER `contact_phone` ;
ALTER TABLE `r_boarding` CHANGE `date_out_checkout` `date_out_checkout` DATE NULL ;
ALTER TABLE `r_boarding` CHANGE `time_out_checkout` `time_out_checkout` TIME NULL ;
drop table `daycare_centers`;

ALTER TABLE `r_daycare` DROP `daycare_center_id` ;
CREATE TABLE IF NOT EXISTS `checkin_daycare` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `client_id` int(11) NOT NULL,
  `pet_id` int(11) NOT NULL,
  `daycare_group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;


-- 05.11.14
ALTER TABLE `pets` ADD `special_instructions` TEXT NOT NULL AFTER `dob` ;
RENAME TABLE checkin_daycare TO records_daycare;

CREATE TABLE IF NOT EXISTS `records_boarding` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_id` tinyint(4) NOT NULL DEFAULT '1',
  `client_id` int(11) NOT NULL,
  `pet_id` int(11) NOT NULL,
  `charge_type` enum('charge_by_petsize','charge_by_runtype') NOT NULL,
  `charge_type_id` int(11) NOT NULL,
  `is_handle_carefully` tinyint(4) NOT NULL DEFAULT '0',
  `is_extra_pet` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `records_daycare` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `client_id` int(11) NOT NULL,
  `pet_id` int(11) NOT NULL,
  `daycare_group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `records_services` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_id` tinyint(4) NOT NULL DEFAULT '1',
  `client_id` int(11) NOT NULL,
  `pet_id` int(11) NOT NULL,
  `ss_id` int(11) NOT NULL,
  `no_charges` tinyint(4) NOT NULL,
  `is_every_day` tinyint(4) NOT NULL DEFAULT '1',
  `is_every_other_day` tinyint(4) NOT NULL DEFAULT '0',
  `is_checkin_date` tinyint(4) NOT NULL DEFAULT '0',
  `is_checkout_date` tinyint(4) NOT NULL DEFAULT '0',
  `schedule` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;


-- 06.11.14
CREATE TABLE IF NOT EXISTS `records_grooming` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_id` tinyint(4) NOT NULL DEFAULT '1',
  `client_id` int(11) NOT NULL,
  `pet_id` int(11) NOT NULL,
  `g_id` int(11) DEFAULT NULL,
  `gs_ids` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- 13.11.14
CREATE TABLE IF NOT EXISTS `records_training` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_id` tinyint(4) NOT NULL DEFAULT '1',
  `client_id` int(11) NOT NULL,
  `pet_id` int(11) NOT NULL,
  `trainer_id` int(11) NOT NULL,
  `trainer_notepad` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;


CREATE TABLE IF NOT EXISTS `records_meds_diets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_id` tinyint(4) NOT NULL DEFAULT '1',
  `client_id` int(11) NOT NULL,
  `pet_id` int(11) NOT NULL,
  `type` enum('meds','diets') NOT NULL,
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
  `md_only_daycare` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- 25.11.2014
DROP TABLE k9_first.users_details;
DROP TABLE k9_simple.users_details;

-- 05.12.2014
ALTER TABLE `charges_petsizes` CHANGE `limit` `limits` INT( 11 ) NOT NULL DEFAULT '0';
ALTER TABLE `charges_runtypes` CHANGE `limit` `limits` INT( 11 ) NOT NULL DEFAULT '0';

-- 15.12.2014
drop table boarding_centers;
truncate table r_grooms;
ALTER TABLE `r_boarding` DROP `boarding_center_id` ;
ALTER TABLE `r_grooms` CHANGE `service_type` `base_type_id` INT NULL DEFAULT NULL ;
ALTER TABLE `r_grooms` CHANGE `grooming_type_id` `grooming_rate_id` INT( 11 ) NOT NULL ;




-- 20.12.2014
CREATE TABLE IF NOT EXISTS `notepads` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `v` text NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `sticky` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `pet_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `v` text NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

ALTER TABLE `clients_survey` CHANGE `reffered_client_id` `reffered_id` INT( 11 ) NULL DEFAULT NULL ;
ALTER TABLE `client_survey_findout` ADD `refferal_table` VARCHAR( 255 ) NOT NULL AFTER `is_refferal` ;
UPDATE `k9_test`.`client_survey_findout` SET `refferal_table` = 'clients', `is_refferal` = '1' WHERE `client_survey_findout`.`id` = 5;
UPDATE `k9_test`.`client_survey_findout` SET `refferal_table` = 'vets', `is_refferal` = '1' WHERE `client_survey_findout`.`id` = 14;





-- 05.01.2015
CREATE TABLE IF NOT EXISTS `tax_settings` (
`id` int(11) NOT NULL,
  `n` varchar(255) NOT NULL,
  `v` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;

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


CREATE TABLE IF NOT EXISTS `user_interface_settings` (
`id` int(11) NOT NULL,
  `n` varchar(255) NOT NULL,
  `v` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=latin1;

INSERT INTO `user_interface_settings` (`id`, `n`, `v`) VALUES
(1, 'disable_credit_card_storage', '0'),
(2, 'require_address_when_creating_client', '0'),
(3, 'require_email_when_creating_client', '0'),
(4, 'alarm_pet_age_when_older_than', '1'),
(5, 'alarm_pet_age_when_older_than_value', '9'),
(6, 'enable_membership', '0'),
(7, 'enable_email', '1'),
(8, 'enable_contracts', '1'),
(9, 'enable_pet_id', '0'),
(10, 'enable_reason_for_stay', '0'),
(11, 'show_survey_when_creating_client', '1'),
(12, 'show_income_survey_when_creating_client', '0'),
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
(23, 'zip_postcode_length', '5'),
(24, 'phone_area_code_length', '3'),
(25, 'phone_length', '7'),
(26, 'cell_mobile_area_code_length', '3'),
(27, 'cell_mobile_phone_length', '7'),
(28, 'state_length', '2'),
(29, 'date_format', '0');

update `settings` SET `v` = '[{"lang":"en","text":"English"},{"lang":"fr","text":"French"},{"lang":"de","text":"German"},{"lang":"it","text":"Italian"},{"lang":"pt","text":"Portuguese"},{"lang":"es","text":"Spanish"}]' where `n` = 'languages';

CREATE TABLE IF NOT EXISTS `layout_sections` (
`id` int(11) NOT NULL,
  `in_use` tinyint(4) NOT NULL DEFAULT '0',
  `v` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

INSERT INTO `layout_sections` (`id`, `in_use`, `v`) VALUES
(1, 1, 'Main'),
(2, 1, 'Cats'),
(3, 0, ''),
(4, 0, ''),
(5, 0, '');

CREATE TABLE IF NOT EXISTS `layout_runs` (
  `id` int(11) NOT NULL auto_increment,
  `status_id` tinyint(4) NOT NULL DEFAULT '1',
  `run_number` varchar(255) NOT NULL,
  `runtype_id` int(11) NOT NULL,
  `layout_section_id` int(11) NOT NULL,
  `position_layout_screen` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

INSERT INTO `layout_runs` (`id`, `status_id`, `run_number`, `runtype_id`, `layout_section_id`, `position_layout_screen`) VALUES
(3, 1, 'A1', 2, 1, 1),
(4, 1, 'A2', 3, 1, 3),
(5, 1, 'A3', 2, 1, 2);

CREATE TABLE IF NOT EXISTS `discounts_boarding_long_term` (
  `id` int(11) NOT NULL auto_increment,
  `nr_days` int(11) NOT NULL,
  `modifier_id` int(11) NOT NULL,
  `amount` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

INSERT INTO `discounts_boarding_long_term` (`id`, `nr_days`, `modifier_id`, `amount`) VALUES
(1, 30, 1, 0),
(2, 45, 1, 0);

CREATE TABLE IF NOT EXISTS `discounts_boarding_multiple_pet` (
  `id` int(11) NOT NULL auto_increment,
  `charges_runtype_id` int(11) NOT NULL,
  `is_percentage` tinyint(4) NOT NULL DEFAULT '0',
  `1_pet_discount` float NOT NULL,
  `2_pet_discount` float NOT NULL,
  `3_pet_discount` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

INSERT INTO `discounts_boarding_multiple_pet` (`id`, `charges_runtype_id`, `is_percentage`, `1_pet_discount`, `2_pet_discount`, `3_pet_discount`) VALUES
(1, 3, 0, 0, 0, 0);

CREATE TABLE IF NOT EXISTS `discounts_boarding_new_client` (
  `id` int(11) NOT NULL auto_increment,
  `modifier_id` tinyint(4) NOT NULL DEFAULT '1',
  `amount` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

INSERT INTO `discounts_boarding_new_client` (`id`, `modifier_id`, `amount`) VALUES
(1, 1, 0);

CREATE TABLE IF NOT EXISTS `discounts_boarding_priority_club` (
  `id` int(11) NOT NULL auto_increment,
  `in_use` int(11) NOT NULL DEFAULT '0',
  `nr_visits` int(11) NOT NULL,
  `discount_amount` float NOT NULL,
  `v` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

INSERT INTO `discounts_boarding_priority_club` (`id`, `in_use`, `nr_visits`, `discount_amount`, `v`) VALUES
(1, 0, 10, 1, 'Priority club'),
(2, 0, 20, 2, 'Priority club VIP'),
(3, 0, 30, 2, 'Great customer'),
(4, 0, 40, 2, 'VIP Customer');

CREATE TABLE IF NOT EXISTS `season` (
  `id` int(11) NOT NULL auto_increment,
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
  `rate` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

INSERT INTO `season` (`id`, `start_date`, `end_date`, `is_mon`, `is_tue`, `is_wed`, `is_thu`, `is_fri`, `is_sat`, `is_sun`, `in_use`, `v`, `modifier_id`, `rate`) VALUES
(1, '2015-01-01', '2015-01-01', 1, 1, 1, 1, 1, 0, 0, 1, 'Low season', 1, 0),
(2, '2015-01-01', '2015-01-01', 1, 1, 1, 1, 1, 0, 0, 1, 'High season', 1, 0),
(3, '2015-01-01', '2015-01-01', 1, 1, 1, 1, 1, 0, 0, 1, 'Christmas season', 1, 0);

CREATE TABLE IF NOT EXISTS `holiday` (
  `id` int(11) NOT NULL auto_increment,
  `v` varchar(255) NOT NULL,
  `date` date NOT NULL,
  `open` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

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
(11, 'New Year', '2015-12-31', 1),
(13, '', '0000-00-00', 1);



-- 13.01.2014
ALTER TABLE `schedule_services` ADD `service_description` VARCHAR(255) NOT NULL AFTER `v`;
ALTER TABLE `schedule_services` ADD `is_special` TINYINT NOT NULL DEFAULT '0' AFTER `price`;
ALTER TABLE `schedule_services` ADD `limit` INT NOT NULL AFTER `is_special`;
ALTER TABLE `schedule_services` ADD `is_hcp` TINYINT NOT NULL DEFAULT '0' AFTER `limit`;
ALTER TABLE `schedule_services` ADD `order` INT NOT NULL AFTER `is_hcp`;
ALTER TABLE `schedule_services` ADD `is_pickup_and_delivery` TINYINT NOT NULL DEFAULT '0' AFTER `order`;
ALTER TABLE `schedule_services` ADD `daycare_group_id` INT NOT NULL DEFAULT '0' AFTER `is_pickup_and_delivery`;

truncate table `tokens`;
ALTER TABLE `tokens`
  DROP `date_login`,
  DROP `date_logout`;
ALTER TABLE `tokens` ADD `start_date` DATE NOT NULL AFTER `token`, ADD `start_time` TIME NOT NULL AFTER `start_date`, ADD `end_date` DATE NOT NULL AFTER `start_time`, ADD `end_time` TIME NOT NULL AFTER `end_date`;



-- 16.01.2014
INSERT INTO `general_features` (`id`, `type`, `n`, `title`, `v`) VALUES (NULL, 'features', 'meds', 'Meds', '1');
INSERT INTO `general_features` (`id`, `type`, `n`, `title`, `v`) VALUES (NULL, 'features', 'diets', 'Diets', '1');

INSERT INTO `general_features` (`id`, `type`, `n`, `title`, `v`) VALUES (NULL, 'general_features', 'vaccinations', 'Vaccinations', '1');
INSERT INTO `general_features` (`id`, `type`, `n`, `title`, `v`) VALUES (NULL, 'general_features', 'pet_records', 'Pet records', '1');
INSERT INTO `general_features` (`id`, `type`, `n`, `title`, `v`) VALUES (NULL, 'general_features', 'sticky', 'Sticky notes', '1');
INSERT INTO `general_features` (`id`, `type`, `n`, `title`, `v`) VALUES (NULL, 'general_features', 'notepads', 'Notepads', '1');








-- 30.01.2014
INSERT INTO `general_features` (`id`, `type`, `n`, `title`, `v`) VALUES (NULL, 'search_options', 'client_membership', 'Client membership', '0');
INSERT INTO `general_features` (`id`, `type`, `n`, `title`, `v`) VALUES (NULL, 'search_options', 'pet_id', 'Pet ID', '0');
INSERT INTO `general_features` (`id`, `type`, `n`, `title`, `v`) VALUES (NULL, 'search_options', 'pet_breed', 'Pet breed', '1');
INSERT INTO `general_features` (`id`, `type`, `n`, `title`, `v`) VALUES (NULL, 'search_options', 'default_search', 'Default search', '5');

ALTER TABLE `layout_sections` CHANGE `in_use` `in_use` VARCHAR(255) NOT NULL DEFAULT 'false';
ALTER TABLE `grooming_options` CHANGE `v` `v` VARCHAR(255) NOT NULL DEFAULT 'false';
ALTER TABLE `general_features` CHANGE `v` `v` VARCHAR(255) NOT NULL DEFAULT 'false';
ALTER TABLE `sl_cp` CHANGE `v` `v` VARCHAR(255) NOT NULL DEFAULT 'false';
ALTER TABLE `clients` DROP `pet_id`;

CREATE TABLE IF NOT EXISTS `clients_membership` (
  `id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `membership` varchar(255) NOT NULL,
  `valability` date NOT NULL,
  `print_photo_client` tinyint(4) NOT NULL DEFAULT '0',
  `print_photo_pet` tinyint(4) NOT NULL DEFAULT '0',
  `add_pet_name` tinyint(4) NOT NULL DEFAULT '0',
  `barcode` varchar(255) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
ALTER TABLE `clients_membership` ADD PRIMARY KEY (`id`);
ALTER TABLE `clients_membership` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=1;

-- 09.02.2014
INSERT INTO `general_features` (`id`, `type`, `n`, `title`, `v`) VALUES (NULL, 'side_menu', 'points_of_sale', 'Points of sale', 'true');
INSERT INTO `general_features` (`id`, `type`, `n`, `title`, `v`) VALUES (NULL, 'side_menu', 'manager', 'Manager', 'true');
INSERT INTO `general_features` (`id`, `type`, `n`, `title`, `v`) VALUES (NULL, 'side_menu', 'reports', 'Reports', 'true');
INSERT INTO `general_features` (`id`, `type`, `n`, `title`, `v`) VALUES (NULL, 'side_menu', 'vacancies', 'Vacancies', 'true');
INSERT INTO `general_features` (`id`, `type`, `n`, `title`, `v`) VALUES (NULL, 'side_menu', 'deposits', 'Deposits', 'true');
INSERT INTO `general_features` (`id`, `type`, `n`, `title`, `v`) VALUES (NULL, 'side_menu', 'layout', 'Layout', 'true');

ALTER TABLE `retail_classes` CHANGE `margin` `margin` FLOAT(4) NOT NULL DEFAULT '0';
ALTER TABLE `retail_classes` CHANGE `markup` `markup` FLOAT(4) NOT NULL DEFAULT '0';
ALTER TABLE `retail_classes` CHANGE `sale` `sale` FLOAT(4) NOT NULL DEFAULT '0';
ALTER TABLE `retail_classes` CHANGE `damage` `damage` FLOAT(4) NOT NULL DEFAULT '0';
ALTER TABLE `retail_classes` CHANGE `whole` `whole` FLOAT(4) NOT NULL DEFAULT '0';
ALTER TABLE `retail_classes` CHANGE `comp` `comp` FLOAT(4) NOT NULL DEFAULT '0';
ALTER TABLE `retail_classes` CHANGE `employee` `employee` FLOAT(4) NOT NULL DEFAULT '0';

drop table payment_status;
ALTER TABLE `languages` ADD UNIQUE(`k`);

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
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

ALTER TABLE `pos_payments` ADD PRIMARY KEY (`id`);
ALTER TABLE `pos_payments` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=1;

drop table languages;
drop table retail_inventory;
drop table retail_classes;
drop table retail_vendors;
drop table retail_vi;

CREATE TABLE IF NOT EXISTS `languages` (
`id` int(11) NOT NULL,
  `k` varchar(255) NOT NULL,
  `en` text NOT NULL,
  `fr` text NOT NULL,
  `de` text NOT NULL,
  `it` text NOT NULL,
  `pt` text NOT NULL,
  `ro` text NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=latin1;

INSERT INTO `languages` (`id`, `k`, `en`, `fr`, `de`, `it`, `pt`, `ro`) VALUES
(1, 'billing_details', 'Billing details', '', '', '', '', ''),
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
(41, 'billing_information', 'Billing information', '', '', '', '', ''),
(42, 'language', 'Language', 'Limba', '', '', '', ''),
(43, 'payment_type', 'Payment type', 'Tipul de plata', '', '', '', ''),
(44, 'rewards', 'Rewards', '', '', '', '', ''),
(45, 'points_per_dollar', 'Points per dollar', '', '', '', '', ''),
(46, 'discount', 'Discount', '', '', '', '', ''),
(47, 'address', 'Address', 'Adresa', '', '', '', ''),
(48, 'phone', 'Phone', '', '', '', '', ''),
(49, 'contact', 'Contact', '', '', '', '', ''),
(51, 'contact_phone', 'Contact phone', '', '', '', '', '');

ALTER TABLE `languages`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `k` (`k`);

ALTER TABLE `languages`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=52;

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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

INSERT INTO `retail_classes` (`id`, `status_id`, `class_name`, `margin`, `markup`, `sale`, `damage`, `whole`, `comp`, `employee`) VALUES
(1, 1, 'Accessories', 2.5, 0, 1.2, 2.3, 0, 0, 0),
(2, 1, 'Animal Medic Inc', 20, 0, 10, 20, 0, 100, 7),
(3, 1, 'Artemis', 25, 0, 10, 20, 0, 100, 7),
(4, 1, 'Beds for pets', 30, 0, 10, 20, 0, 100, 7),
(5, 1, 'Cloud star', 25.21, 0, 10, 20, 0, 100, 15),
(6, 1, 'Juice', 0, 0, 0, 0, 0, 0, 0);

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

INSERT INTO `retail_inventory` (`id`, `status_id`, `product_code`, `product_name`, `price`, `quantity`, `at`, `to`, `tax`, `class_id`, `commission_percentage`) VALUES
(1, 1, '12312534-15747', 'Ear cleaning (cat)', 5, 47, 0, 0, 1, 1, 40),
(2, 1, '65789-4967', 'Something cool', 20, 40, 0, 0, 1, 1, 45),
(3, 1, '134968997', 'CocaCola', 23.5, 50, 0, 0, 1, 1, 45);

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

INSERT INTO `retail_vendors` (`id`, `status_id`, `name`, `account`, `contact`, `alt_contact`, `street`, `city`, `state`, `zip`, `phone`, `fax`, `alt_phone`, `other`, `terms`, `comments`, `website`, `email`) VALUES
(3, 1, 'PetsMart', 'PetsMart', '', '', '', '', '', '', '', '', '', '', '', '', '', ''),
(4, 1, 'Pedigree', 'Pedigree', '', '', '', '', '', '', '', '', '', '', '', '', '', '');

CREATE TABLE IF NOT EXISTS `retail_vi` (
`id` int(11) NOT NULL,
  `status_id` tinyint(4) NOT NULL DEFAULT '1',
  `retail_vendor_id` int(11) NOT NULL,
  `retail_inventory_id` int(11) NOT NULL,
  `our_cost` float NOT NULL DEFAULT '0',
  `reorder_number` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

INSERT INTO `retail_vi` (`id`, `status_id`, `retail_vendor_id`, `retail_inventory_id`, `our_cost`, `reorder_number`) VALUES
(7, 1, 3, 2, 20, 0),
(8, 1, 4, 3, 10, 0);

ALTER TABLE `retail_classes`
 ADD PRIMARY KEY (`id`);

ALTER TABLE `retail_inventory`
 ADD PRIMARY KEY (`id`);

ALTER TABLE `retail_vendors`
 ADD PRIMARY KEY (`id`);

ALTER TABLE `retail_vi`
 ADD PRIMARY KEY (`id`);



drop table promotions;
CREATE TABLE IF NOT EXISTS `promotions` (
`id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `promotion_code` varchar(255) NOT NULL,
  `promotion_name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `points` int(11) NOT NULL,
  `expiration_date` date NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

INSERT INTO `promotions` (`id`, `status_id`, `promotion_code`, `promotion_name`, `description`, `points`, `expiration_date`) VALUES
(1, 1, '68793421', 'Cancel transasction', 'Scan to cancel all promoptions to current customer', 20, '2010-12-31'),
(2, 1, '24346546546', 'Bath special', 'Free 9.99 bath wash towel dry', 50, '2015-12-25'),
(3, 1, '1234656789', 'Hair', 'Some description', 100, '2015-12-26');

ALTER TABLE `promotions` ADD PRIMARY KEY (`id`);
ALTER TABLE `promotions` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;





-- 17.02.2015
ALTER TABLE `clients` ADD `preffered_phone_id` INT NOT NULL AFTER `emergency_phone`;
ALTER TABLE `sticky` ADD `client_id` INT NOT NULL AFTER `status_id`;
ALTER TABLE `sticky` CHANGE `client_id` `client_id` INT(11) NOT NULL DEFAULT '0';
ALTER TABLE `sticky` CHANGE `pet_id` `pet_id` INT(11) NOT NULL DEFAULT '0';

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
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
ALTER TABLE `deposits` ADD PRIMARY KEY (`id`);
ALTER TABLE `deposits` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=1;

delete from settings where n = 'default_language' or n = 'default_payment_type_id'
ALTER TABLE `user_interface_settings` CHANGE `id` `id` INT(11) NOT NULL AUTO_INCREMENT;
INSERT INTO `user_interface_settings` (`n`, `v`) VALUES ('payment_type_id', '1');

UPDATE `general_features` SET `n` = 'allow_refunds_in_pos' WHERE `general_features`.`id` = 7;
UPDATE `general_features` SET `title` = 'Allow refunds in POS' WHERE `general_features`.`id` = 7;

CREATE TABLE IF NOT EXISTS `clients_rewards` (
`id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `points` float NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE `clients_rewards` ADD PRIMARY KEY (`id`);
ALTER TABLE `clients_rewards` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;


-- languages
DELETE FROM `user_interface_settings` WHERE `user_interface_settings`.`id` = 24;
DELETE FROM `user_interface_settings` WHERE `user_interface_settings`.`id` = 25;
DELETE FROM `user_interface_settings` WHERE `user_interface_settings`.`id` = 26;
DELETE FROM `user_interface_settings` WHERE `user_interface_settings`.`id` = 27;

INSERT INTO `user_interface_settings` (`id`, `n`, `v`) VALUES (NULL, 'phone_format_id', '1');
INSERT INTO `user_interface_settings` (`id`, `n`, `v`) VALUES (NULL, 'cell_format_id', '1');
INSERT INTO `user_interface_settings` (`id`, `n`, `v`) VALUES (NULL, 'fax_format_id', '1');




drop table languages;

CREATE TABLE IF NOT EXISTS `languages` (
`id` int(11) NOT NULL,
  `k` varchar(255) NOT NULL,
  `en` text NOT NULL,
  `fr` text NOT NULL,
  `de` text NOT NULL,
  `it` text NOT NULL,
  `pt` text NOT NULL,
  `ro` text NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=latin1;

INSERT INTO `languages` (`id`, `k`, `en`, `fr`, `de`, `it`, `pt`, `ro`) VALUES
(1, 'billing_details', 'Billing details', '', '', '', '', ''),
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
(41, 'billing_information', 'Billing information', '', '', '', '', ''),
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
(62, 'contact_tel', 'Contact tel', '', '', '', '', '');

ALTER TABLE `languages` ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `k` (`k`);
ALTER TABLE `languages` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=63;



-- 23.02.2015
drop table if exists `notepads`;
CREATE TABLE IF NOT EXISTS `notepads` (
  `id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL DEFAULT '1',
  `created_user_id` int(11) NOT NULL,
  `v` text NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_modified` timestamp NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE `notepads` ADD PRIMARY KEY (`id`);
ALTER TABLE `notepads` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

drop table if exists `clients_private`;
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
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

ALTER TABLE `clients_private` ADD PRIMARY KEY (`id`);
ALTER TABLE `clients_private` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=1;

drop table if exists pet_reservations;

drop table if exists `messages`;
CREATE TABLE IF NOT EXISTS `messages` (
  `id` int(11) NOT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT '0',
  `is_read` tinyint(4) NOT NULL DEFAULT '0',
  `sent_user_id` int(11) NOT NULL,
  `inbox_user_id` int(11) NOT NULL,
  `color_hex` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE `messages` ADD PRIMARY KEY (`id`);
ALTER TABLE `messages` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `tokens` CHANGE `start_date` `date` DATE NOT NULL;
ALTER TABLE `tokens` DROP `end_date`;
ALTER TABLE `tokens` ADD `total_time` TIME NOT NULL AFTER `end_time`;





-- 11.03.2014
ALTER TABLE `records_meds_diets` CHANGE `type` `type` TINYINT NOT NULL DEFAULT '0';
truncate table clients_membership;
truncate table clients_survey;
truncate table clients_private;
truncate table records_boarding;
truncate table records_daycare;
truncate table records_grooming;
truncate table records_meds_diets;
truncate table records_services;
truncate table records_training;

ALTER TABLE `clients` ADD `date_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER `address_zip`;
ALTER TABLE `pets` ADD `date_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER `special_instructions`;
ALTER TABLE `r_boarding` DROP `report_id`;
ALTER TABLE `records_boarding` ADD `stay_reason_id` INT NOT NULL AFTER `is_extra_pet`;
ALTER TABLE `r_boarding` ADD `is_extra_pet` TINYINT NOT NULL DEFAULT '0' AFTER `charge_type_id`;
ALTER TABLE `r_boarding` ADD `did_deposit` TINYINT NOT NULL DEFAULT '0' AFTER `deposit`;

ALTER TABLE `r_boarding_ss` CHANGE `r_boarding_id` `r_id` INT(11) NOT NULL;
ALTER TABLE `r_boarding_ss` ADD `r_type` VARCHAR(255) NOT NULL AFTER `status_id`;
RENAME TABLE `r_boarding_ss` TO `r_ss`;
ALTER TABLE `r_ss` ADD `client_id` INT NOT NULL AFTER `status_id`;
ALTER TABLE `r_ss` ADD `pet_id` INT NOT NULL AFTER `client_id`;

drop table if exists `r_ss`;
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
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

ALTER TABLE `r_ss` ADD PRIMARY KEY (`id`);
ALTER TABLE `r_ss` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `boarding_settings` (
`id` int(11) NOT NULL,
  `n` varchar(255) NOT NULL,
  `v` text NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

INSERT INTO `boarding_settings` (`id`, `n`, `v`) VALUES
(1, 'charge_type_id', '0'),
(2, 'stay_reason_id', '0'),
(3, 'is_handle_carefully', '0'),
(4, 'is_extra_pet', '0');

ALTER TABLE `boarding_settings` ADD PRIMARY KEY (`id`);
ALTER TABLE `boarding_settings` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;

truncate table `r_boarding_meds`;
RENAME TABLE r_boarding_meds TO r_meds;
ALTER TABLE `r_meds` ADD `client_id` INT NOT NULL AFTER `status_id`;
ALTER TABLE `r_meds` ADD `pet_id` INT NOT NULL AFTER `client_id`;
ALTER TABLE `r_meds` ADD `r_type` VARCHAR(255) NOT NULL AFTER `pet_id`;
ALTER TABLE `r_meds` CHANGE `r_boarding_id` `r_id` INT(11) NOT NULL;

truncate table `r_boarding_diets`;
RENAME TABLE r_boarding_diets TO r_diets;
ALTER TABLE `r_diets` ADD `client_id` INT NOT NULL AFTER `status_id`;
ALTER TABLE `r_diets` ADD `pet_id` INT NOT NULL AFTER `client_id`;
ALTER TABLE `r_diets` ADD `r_type` VARCHAR(255) NOT NULL AFTER `pet_id`;
ALTER TABLE `r_diets` CHANGE `r_boarding_id` `r_id` INT(11) NOT NULL;

ALTER TABLE `records_services` DROP `is_every_other_day`;
ALTER TABLE `records_grooming` CHANGE `gs_ids` `gs_id` INT NOT NULL;


ALTER TABLE `r_training` CHANGE `date_start` `date_in` DATE NOT NULL;
ALTER TABLE `r_training` CHANGE `date_end` `date_out` DATE NOT NULL;
ALTER TABLE `training_schedule` CHANGE `date_start` `date_in` DATE NOT NULL;
ALTER TABLE `training_schedule` CHANGE `date_end` `date_out` DATE NOT NULL;

ALTER TABLE `r_boarding` CHANGE `date_out_checkout` `date_checkout` TIME NULL DEFAULT NULL;
ALTER TABLE `r_boarding` CHANGE `time_out_checkout` `time_checkout` TIME NULL DEFAULT NULL;
ALTER TABLE `r_daycare` ADD `date_checkout` DATE NOT NULL AFTER `time_out`;
ALTER TABLE `r_daycare` ADD `time_checkout` TIME NOT NULL AFTER `date_checkout`;
ALTER TABLE `r_daycare` ADD `in_out` ENUM('in','out') NOT NULL AFTER `daycare_group_id`;
DELETE FROM `daycare_settings` WHERE `daycare_settings`.`id` = 16;

ALTER TABLE `r_grooms` ADD `in_out` ENUM('in','out') NOT NULL DEFAULT 'in' AFTER `gs_array`;
ALTER TABLE `r_grooms` ADD `date_checkout` DATE NOT NULL AFTER `time_out`;
ALTER TABLE `r_grooms` ADD `time_checkout` TIME NOT NULL AFTER `date_checkout`;

drop table grooming_centers;
drop table training_centers;

ALTER TABLE `r_grooms` DROP `grooms_center_id`;
ALTER TABLE `r_training` DROP `training_center_id`;

ALTER TABLE `records_grooming` ADD `base_type_id` INT NOT NULL AFTER `g_id`;
ALTER TABLE `records_grooming` ADD `gr_id` INT NOT NULL AFTER `g_id`;
ALTER TABLE `records_grooming` CHANGE `gs_id` `gs_ids` VARCHAR(255) NOT NULL;

ALTER TABLE `r_training` ADD `in_out` ENUM('in','out') NOT NULL AFTER `t_id`;
ALTER TABLE `r_training` ADD `date_checkout` DATE NOT NULL AFTER `date_out`;
ALTER TABLE `r_training` ADD `time_checkout` TIME NOT NULL AFTER `date_checkout`;
ALTER TABLE `r_training` ADD `time_in` TIME NOT NULL AFTER `date_in`;
ALTER TABLE `r_training` ADD `time_out` TIME NOT NULL AFTER `date_out`;

drop table cities;
drop table states;
drop table status;
drop table zips;
drop table reports;
drop table devices;

ALTER TABLE `r_training` ADD `instructions` TEXT NOT NULL AFTER `t_id`;
DELETE FROM `general_features` WHERE `id` = '9';

ALTER TABLE `training_schedule` ADD `time_in` TIME NOT NULL AFTER `date_in`;
ALTER TABLE `training_schedule` ADD `time_out` TIME NOT NULL AFTER `date_out`;









-- 08.04.2014
ALTER TABLE `charges_petsizes` DROP `run`;
ALTER TABLE `charges_petsizes` ADD `override` TINYINT NOT NULL AFTER `to_weight`;
DELETE FROM `charges_settings` WHERE `id` = 3;
UPDATE `charges_settings` SET `n` = 'available_for_saturdays' WHERE `charges_settings`.`id` = 8;
UPDATE `charges_settings` SET `n` = 'available_for_sundays' WHERE `charges_settings`.`id` = 9;
UPDATE `charges_settings` SET `n` = 'charge_aditional_amount_for_holidays' WHERE `charges_settings`.`id` = 28;
UPDATE `charges_settings` SET `n` = 'available_for_holidays' WHERE `charges_settings`.`id` = 29;
DELETE FROM `charges_settings` WHERE `id` = 10;
DELETE FROM `charges_settings` WHERE `id` = 11;
DELETE FROM `charges_settings` WHERE `id` = 30;
DELETE FROM `charges_settings` WHERE `id` = 13;
DELETE FROM `charges_settings` WHERE `id` = 18;
DELETE FROM `charges_settings` WHERE `id` = 19;
DELETE FROM `charges_settings` WHERE `id` = 20;
DELETE FROM `charges_settings` WHERE `id` = 32;
DELETE FROM `charges_settings` WHERE `id` = 22;
DELETE FROM `charges_settings` WHERE `id` = 24;

INSERT INTO `boarding_settings` (`id`, `n`, `v`) VALUES (NULL, 'commissions_new_customers_board', '0');

ALTER TABLE `discounts_boarding_multiple_pet` DROP `charges_runtype_id`;
ALTER TABLE `discounts_boarding_multiple_pet` ADD `boarding_runtype_id` INT NOT NULL AFTER `id`;

rename table charges_petsizes to boarding_petsizes;
rename table charges_runtypes to boarding_runtypes;

INSERT INTO `boarding_settings` (`n`, `v`) VALUES
('check_out_time', '16:00'),
('check_in_time', '10:00'),
('charge_hour_after_checkout_fee', '50'),
('charge_after_checkout_option', 'charge_no_hours_for_half_day'),
('charge_aditional_for_holidays_fee', '20'),
('charge_half_day_checkout_fee', '15'),
('available_for_saturdays', '1'),
('available_for_sundays', '1'),
('half_day_from', '15:30'),
('half_day_to', '10:35'),
('full_day_from', '11:00'),
('full_half_day_to', '16:00'),
('charge_type', 'charge_by_runtype'),
('charge_meds_diets', 'charge_by_administration'),
('charge_fee_per_diets_diet', '20'),
('charge_amount_per_hour_v', '0'),
('charge_no_hours_for_half_day_v', '0'),
('charge_aditional_amount_for_holidays', '0'),
('available_for_holidays', '0'),
('full_day_to', '17:35');

drop table charges_settings;
ALTER TABLE `pet_status` ADD `price` FLOAT NOT NULL AFTER `v`;

ALTER TABLE `layout_runs` ADD `charge_type` INT NOT NULL AFTER `run_number`;
ALTER TABLE `layout_runs` CHANGE `runtype_id` `charge_type_id` INT(11) NOT NULL;
ALTER TABLE `layout_runs` CHANGE `id` `id` INT(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `layout_sections` CHANGE `in_use` `in_use` TINYINT NOT NULL DEFAULT '0';
ALTER TABLE `layout_runs` ADD `run_description` TEXT NOT NULL AFTER `run_number`;


DROP TABLE IF EXISTS `languages`;
CREATE TABLE IF NOT EXISTS `languages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `k` varchar(255) NOT NULL,
  `en` text NOT NULL,
  `fr` text NOT NULL,
  `de` text NOT NULL,
  `it` text NOT NULL,
  `pt` text NOT NULL,
  `ro` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `k` (`k`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=63 ;

INSERT INTO `languages` (`id`, `k`, `en`, `fr`, `de`, `it`, `pt`, `ro`) VALUES
(1, 'billing_details', 'Billing details', '', '', '', '', ''),
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
(41, 'billing_information', 'Billing information', '', '', '', '', ''),
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
(62, 'contact_tel', 'Contact tel', '', '', '', '', '');


DROP TABLE IF EXISTS `boarding_settings`;
CREATE TABLE IF NOT EXISTS `boarding_settings` (
`id` int(11) NOT NULL,
  `n` varchar(255) NOT NULL,
  `v` text NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;

INSERT INTO `boarding_settings` (`id`, `n`, `v`) VALUES
(1, 'charge_type_id', '2'),
(2, 'stay_reason_id', '1'),
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
(14, 'half_day_from', '15:30'),
(15, 'half_day_to', '10:35'),
(16, 'full_day_from', '11:00'),
(17, 'full_half_day_to', '16:00'),
(18, 'charge_type', 'charge_by_runtype'),
(19, 'charge_meds_diets', 'charge_by_administration'),
(20, 'charge_fee_per_diets_diet', '20'),
(21, 'charge_amount_per_hour_v', '12.52'),
(22, 'charge_no_hours_for_half_day_v', '2'),
(23, 'charge_aditional_amount_for_holidays', '25.2'),
(24, 'available_for_holidays', '0'),
(25, 'full_day_to', '17:35');

ALTER TABLE `boarding_settings` ADD PRIMARY KEY (`id`);
ALTER TABLE `boarding_settings` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=26;



DROP TABLE IF EXISTS `boarding_runtypes`;
CREATE TABLE IF NOT EXISTS `boarding_runtypes` (
`id` int(11) NOT NULL,
  `status_id` tinyint(4) NOT NULL DEFAULT '1',
  `v` varchar(255) NOT NULL,
  `limits` int(11) NOT NULL DEFAULT '0',
  `full_day` float NOT NULL DEFAULT '0',
  `half_day` float NOT NULL DEFAULT '0',
  `override` tinyint(4) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

INSERT INTO `boarding_runtypes` (`id`, `status_id`, `v`, `limits`, `full_day`, `half_day`, `override`) VALUES
(1, 2, 'No Charge', 5, 20.5, 13.2, 0),
(2, 1, 'VIP', 10, 20.5, 13.2, 0),
(3, 1, 'Special runtype', 16, 20.5, 13.2, 0),
(4, 1, 'Special offer', 12, 20.5, 13.2, 0),
(5, 3, '', 0, 0, 0, 0);

ALTER TABLE `boarding_runtypes` ADD PRIMARY KEY (`id`);
ALTER TABLE `boarding_runtypes` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;


DROP TABLE IF EXISTS `boarding_petsizes`;
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

INSERT INTO `boarding_petsizes` (`id`, `status_id`, `v`, `limits`, `full_day`, `half_day`, `from_weight`, `to_weight`, `override`) VALUES
(1, 1, 'Miniature', 10, 15.2, 12.1, 0, 0, 0),
(2, 1, 'Small', 10, 15.2, 12.1, 0, 0, 0),
(3, 1, 'Medium', 10, 15.2, 12.1, 0, 0, 0),
(4, 1, 'Big', 10, 15.2, 12.1, 0, 0, 0),
(5, 1, 'Large', 10, 15.2, 12.1, 0, 0, 0),
(6, 1, 'Extraordinary', 10, 15.2, 12.1, 0, 0, 0),
(7, 2, 'Superb', 10, 15.2, 12.1, 0, 0, 0);

ALTER TABLE `boarding_petsizes` ADD PRIMARY KEY (`id`);
ALTER TABLE `boarding_petsizes` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;


-- 16.04.2015
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
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

ALTER TABLE `boarding_payments` ADD PRIMARY KEY (`id`);
ALTER TABLE `boarding_payments` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=1;









-- 21.04.2015
ALTER TABLE `boarding_runtypes` CHANGE `override` `override` TINYINT(4) NOT NULL DEFAULT '0';
ALTER TABLE `r_boarding` ADD `is_halfday` TINYINT NOT NULL DEFAULT '2' AFTER `in_out`;
ALTER TABLE `r_daycare` ADD `is_halfday` TINYINT NOT NULL DEFAULT '2' AFTER `in_out`;

drop table if exists `daycare_groups`;
CREATE TABLE IF NOT EXISTS `daycare_groups` (
`id` int(11) NOT NULL,
  `status_id` tinyint(4) NOT NULL DEFAULT '1',
  `v` varchar(25) NOT NULL,
  `limits` int(11) NOT NULL,
  `full_day` float NOT NULL,
  `half_day` float NOT NULL,
  `override` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE `daycare_groups` ADD PRIMARY KEY (`id`);
ALTER TABLE `daycare_groups` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;


CREATE TABLE IF NOT EXISTS `daycare_payments` (
  `id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `pet_id` int(11) NOT NULL,
  `r_daycare_id` int(11) NOT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

ALTER TABLE `daycare_payments` ADD PRIMARY KEY (`id`);
ALTER TABLE `daycare_payments` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=1;

ALTER TABLE `r_daycare` CHANGE `date_checkout` `date_checkout` DATE NULL;
ALTER TABLE `r_daycare` CHANGE `time_checkout` `time_checkout` TIME NULL;

ALTER TABLE `r_grooms` CHANGE `date_checkout` `date_checkout` DATE NULL;
ALTER TABLE `r_grooms` CHANGE `time_checkout` `time_checkout` TIME NULL;

ALTER TABLE `r_training` CHANGE `date_checkout` `date_checkout` DATE NULL;
ALTER TABLE `r_training` CHANGE `time_checkout` `time_checkout` TIME NULL;

ALTER TABLE `r_grooms` ADD `is_hcp` TINYINT NOT NULL DEFAULT '0' AFTER `gs_array`;


ALTER TABLE `grooming_services` CHANGE `small` `v_1` FLOAT NOT NULL;
ALTER TABLE `grooming_services` CHANGE `medium` `v_2` FLOAT NOT NULL;
ALTER TABLE `grooming_services` CHANGE `large` `v_3` FLOAT NOT NULL;
ALTER TABLE `grooming_services` CHANGE `miniature` `v_4` FLOAT NOT NULL;
ALTER TABLE `grooming_services` CHANGE `med_lg` `v_5` FLOAT NOT NULL;
ALTER TABLE `grooming_services` CHANGE `giant` `v_6` FLOAT NOT NULL;
ALTER TABLE `grooming_services` CHANGE `cat` `v_7` FLOAT NOT NULL;
ALTER TABLE `grooming_services` CHANGE `other` `v_8` FLOAT NOT NULL;
ALTER TABLE `grooming_services` DROP `sand`;

CREATE TABLE IF NOT EXISTS `grooms_payments` (
 `id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `pet_id` int(11) NOT NULL,
  `r_grooms_id` int(11) NOT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

ALTER TABLE `grooms_payments` ADD PRIMARY KEY (`id`);
ALTER TABLE `grooms_payments` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=1;

ALTER TABLE `records_grooming` ADD `is_hcp` TINYINT NOT NULL DEFAULT '0' AFTER `gs_ids`;

CREATE TABLE IF NOT EXISTS `training_payments` (
`id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `pet_id` int(11) NOT NULL,
  `r_training_id` int(11) NOT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

ALTER TABLE `training_payments` ADD PRIMARY KEY (`id`);
ALTER TABLE `training_payments` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=1;

truncate table `languages`;

INSERT INTO `languages` (`id`, `k`, `en`, `fr`, `de`, `it`, `pt`, `ro`) VALUES
(1, 'billing_details', 'Billing details', 'aweq', '', '', '', 'Detalii de livrare'),
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
(89, 'subtotal', 'Sub-total', '', '', '', '', ''),
(90, 'daycare_report', 'Daycare report', '', '', '', '', ''),
(91, 'grooms_report', 'Grooming report', '', '', '', '', ''),
(92, 'pet_size', 'Pet size', '', '', '', '', ''),
(93, 'groomer', 'Groomer', '', '', '', '', ''),
(94, 'grooming_rate', 'Grooming rate', '', '', '', '', ''),
(95, 'grooming_rate_multiplier', 'Grooming rate multiplier', '', '', '', '', ''),
(96, 'base_type_service', 'Base type service', '', '', '', '', ''),
(97, 'grooming_services', 'Grooming services', '', '', '', '', ''),
(98, 'service_type', 'Service type', '', '', '', '', ''),
(99, 'multiplier', 'Multiplier', '', '', '', '', ''),
(100, 'trainer', 'Trainer', '', '', '', '', ''),
(101, 'training_group', 'Training group', '', '', '', '', ''),
(102, 'limit', 'Limit', '', '', '', '', ''),
(103, 'training_report', 'Training report', '', '', '', '', ''),
(104, 'rank', 'Rank', '', '', '', '', ''),
(105, 'duration', 'Duration', '', '', '', '', ''),
(106, 'training_services', 'Training services', '', '', '', '', ''),
(107, 'description', 'Description', '', '', '', '', '');