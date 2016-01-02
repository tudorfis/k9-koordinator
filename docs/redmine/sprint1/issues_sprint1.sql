-- phpMyAdmin SQL Dump
-- version 3.4.10.1deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 14, 2014 at 03:10 PM
-- Server version: 5.5.35
-- PHP Version: 5.3.10-1ubuntu3.10

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `redmine_default`
--

-- --------------------------------------------------------

--
-- Table structure for table `issues`
--

CREATE TABLE IF NOT EXISTS `issues` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tracker_id` int(11) NOT NULL DEFAULT '0',
  `project_id` int(11) NOT NULL DEFAULT '0',
  `subject` varchar(255) NOT NULL DEFAULT '',
  `description` text,
  `due_date` date DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `status_id` int(11) NOT NULL DEFAULT '0',
  `assigned_to_id` int(11) DEFAULT NULL,
  `priority_id` int(11) NOT NULL DEFAULT '0',
  `fixed_version_id` int(11) DEFAULT NULL,
  `author_id` int(11) NOT NULL DEFAULT '0',
  `lock_version` int(11) NOT NULL DEFAULT '0',
  `created_on` datetime DEFAULT NULL,
  `updated_on` datetime DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `done_ratio` int(11) NOT NULL DEFAULT '0',
  `estimated_hours` float DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `root_id` int(11) DEFAULT NULL,
  `lft` int(11) DEFAULT NULL,
  `rgt` int(11) DEFAULT NULL,
  `is_private` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `issues_project_id` (`project_id`),
  KEY `index_issues_on_status_id` (`status_id`),
  KEY `index_issues_on_category_id` (`category_id`),
  KEY `index_issues_on_assigned_to_id` (`assigned_to_id`),
  KEY `index_issues_on_fixed_version_id` (`fixed_version_id`),
  KEY `index_issues_on_tracker_id` (`tracker_id`),
  KEY `index_issues_on_priority_id` (`priority_id`),
  KEY `index_issues_on_author_id` (`author_id`),
  KEY `index_issues_on_created_on` (`created_on`),
  KEY `index_issues_on_root_id_and_lft_and_rgt` (`root_id`,`lft`,`rgt`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2409 ;

--
-- Dumping data for table `issues`
--

INSERT INTO `issues` (`id`, `tracker_id`, `project_id`, `subject`, `description`, `due_date`, `category_id`, `status_id`, `assigned_to_id`, `priority_id`, `fixed_version_id`, `author_id`, `lock_version`, `created_on`, `updated_on`, `start_date`, `done_ratio`, `estimated_hours`, `parent_id`, `root_id`, `lft`, `rgt`, `is_private`) VALUES
(1, 2, 3, '29.01.2015 - Modifications', '1)  the first major thing is the rates that are displayed for the client login. Can we only display the end rate please, i.e. after all the percentage fees have been added on etc so that it tells them the final rate. we dont want to display any information about margins here at all\r\n\r\n1.1) -   When client is creating an order, client is able to see our margins as ‘Buy Cash Fee’.  We would like this not to be visible to clients. \r\n \r\n1.2) “When I enter the margins for individual rates, then press ctr F5 as your instructions, page refreshes okay. But what we want to see is that ‘buy rate’ and Sell Rate’ are altered according to the margins I input.  Instead what I see is a new column called ‘Total’ showing the rate after the margins added on. However I tried to place an order, I realised that  when client is creating an order,  they see the ‘Buy Rate’ not the total rate, so we are not applying the correct rates.  This needs to be switched around, so client gets the rate with the margins added on, which is the total rate.” - This is the feedback from the client regarding the rates.  \r\n\r\n2) In the margins menu we also would like the term ‘Buy Cash Fee’ and  ‘Sell Cash Fee ‘ changed to Buy Cash Margins and Sell Cash Margins instead\r\n\r\n\r\n3)Can we please add a “*” next to the rate for all buying and selling and have a disclaimer at the bottom that says *Rates are indicative only and subject to change\r\n\r\n\r\n4) There are only two processing centres that we will be using so if we can have the order confirmation emails sent to the specific processing centre after the customer associated with the account creates an order that would be good. \r\n\r\n5) The contact button on the top right for each customer should display information regarding their processing centre. As mentioned above there are only two processing centres at the moment so this will be one of two centres depending on who they are associated with -\r\n\r\nHolborn:\r\nholborn.uk@kanoofes.com\r\nTel: 0207 837 4416\r\nFax:0207 833 0356\r\n \r\nHaymarket:\r\nhaymarket.corporate@kanoofes.com\r\nTel: 0207 484 9607\r\nFax: 0207 484 9645\r\n\r\n\r\n7) Make administration panel for centers\r\n\r\nTudor: which users are which ? currently we don’t have field for processing center … to attribute procfessing center to user ...\r\n\r\nFarrukh: I will get that list now with the processing centre \r\n\r\nT: on processing centers, I will put a textarea to enter this data, and then it will be available on the contact above for each users login, I guess we will be needing a processing center type of user to deal with orders / buybacks, just like in staff, but a little limited, only on his users … right ? \r\n\r\nF: Yes exactly :) The staff account is more supervisory as staff at the centres will only use the processing centre accounts/ their own account which is associated with the processing centre so unable to view all orders. Only superadmin can view all the users/orders\r\n\r\nT: excelent.. \r\n\r\n', '2014-02-01', NULL, 5, 1, 4, NULL, 1, 3, '2014-03-13 12:18:11', '2014-03-13 12:22:08', '2014-01-29', 100, 5, NULL, 1, 1, 2, 0),
(2, 2, 3, '30.01.2014 - Modifications', '1) -Currency drop box to be alphabetical please with EUR, USD and TRY to be displayed at the top and the remaining currencies in alphabetical order\r\n\r\n2) The currency scraper to have more currencies added\r\n - INR - Indian Rupee, \r\n- MAD Moroccan Dirham,\r\n- KYD Caymanian Dollar, \r\n- FJD - Fijian Dollar, \r\n- COP - Columbian Peso, \r\n- BWP - Botswana Pula, \r\n- BMD - Bermudian Dollar, \r\n- BDT - Bangladeshi Taka. \r\n\r\nWe can add them from the rates page ourselves of course but we want to be able to automatically get the rate updates as we do for the other currencies so just need to add these currencies on to the scraper.\r\n\r\n3) Client is viewing the spot rate when ordering T/C’s - for example the rate when I am viewing is 1.21276 for Euros. If I click on Order Cash I see the rate for the Euros with the margin added on. Even though there is a margin on the Euros in the admin panel I see the live rate of 1.21276 and no margin added on top of this for Travellers Cheques even though the margin in the admin panel has been set at 4.8. \r\n\r\n4) Homepage is too big for the screen, the user has to scroll sideways to view the full screen - just need the same fix for the admin page that has been applied for the client page\r\n\r\n5) There seems to be a 70px margin at the top in element styles, could you please reduce this \r\n\r\n6) If it is not a lot of work then please can you change the date from the current format which is YYYYMMDD to DDMMYYYY - this is displayed on the client side when ordering\r\n\r\n7) a) when a user logins in successfully for the first time, they need to be prompted to change their password.\r\nb) needs to be a reset password functionality\r\n\r\n8) PROBLEM, with loading image in get-rates / staff controll panel\r\n', '2014-02-04', NULL, 5, 1, 4, NULL, 1, 1, '2014-03-13 12:23:11', '2014-03-13 12:23:25', '2014-01-30', 100, 5, NULL, 2, 1, 2, 0),
(3, 2, 3, '04.02.2014 - Modifications', 'ON CLIENT LOG IN:\r\n\r\n-Order of TC Tab, does not give the option to order GBP T/C’s\r\n    “ it gives with the term UK”\r\n\r\n-Orders and buy backs are NOT submitting\r\n    “ seems to be working on http://instantwebsitesolutions.co.uk/kanoo “\r\n\r\n-Date format is not consistent on all tabs, as it is still in US format on many Tabs.\r\n\r\n-Orders I have created tab, does not allow user to open & print for both sell and buy transactions\r\n \r\nADMIN LOG IN:\r\n\r\n-Date format is not consistent on all tabs, as it is still in US format on many Tabs\r\n\r\n-Processing centre tab, Does not display our Kanoo locations\r\n\r\n-Margins are not appearing\r\n    “ they must be added manually ”\r\n\r\n-User Maintenance tab, does not display all users\r\n\r\n-Unprocessed orders tab, add order option, demands for both GBP and FX values, which is impossible unless you have the exchange rates to hand\r\n', '2014-02-07', NULL, 5, 1, 4, NULL, 1, 1, '2014-03-13 12:24:14', '2014-03-13 12:24:26', '2014-02-04', 100, 3, NULL, 3, 1, 2, 0),
(4, 2, 3, '16.02.2014 - Modifications', '- Feature to order / buyback multiple currencies in client panel     [ est. 5h ]\r\n\r\n- Add company percentage fee to the final rate, minimum fee needs to clarified     [ est. 1.5h ]\r\n\r\n-  another layer of confirmation for companies, if set a company manager, then he can log in and see incoming orders / buybacks for users of his company, and he must approve or cancel given orders, only then they can apear in the processing center and only for certain companies this feature [ est. 2h ]\r\n\r\n- option to enter maximum of UK amount, and receive calculated amount for it   [ est. 1h ]', '2014-02-19', NULL, 5, 1, 4, NULL, 1, 1, '2014-03-13 12:25:42', '2014-03-13 12:25:54', '2014-02-16', 100, 5, NULL, 4, 1, 2, 0),
(5, 2, 3, '19.02.2014 - Modifications', '- They don''t want the rate minused from the percentage rate they just want another column which says fee, If it''s a percentage fee or a flat fee just display the fee in there\r\n\r\n- And the sterling amount or foreign amount is very important so need that done please.  I got a call saying that the pound sign seems to have gone on to the right hand side and that the number of digits on the exchange rate seems to have increased too\r\n\r\n \r\n- Client ordering Cash:  Rate box now contains 10 digits.  This should be consisted of 4 digits.\r\n\r\n· Commission charges disappeared.  Nomura clients should see a charge 1.5 % in commission line.\r\n\r\n- £ sign appears at the end of the totals rather than front.\r\n\r\n-COMMISSIONS TO BE ADDED CORRECTLY\r\n\r\n-DUAL CONTROL PROCESS, WHEREBY A CREATED ORDER CAN GO TO AN APPROVER (IF REQUIRED BY CLIENT)\r\n\r\n- Client can only put currency amount when placing an order.  They pointed out that they would like to have sterling equivalent option as well.\r\n', '2014-02-22', NULL, 5, 1, 4, NULL, 1, 1, '2014-03-13 12:26:32', '2014-03-13 12:26:41', '2014-02-19', 100, 5, NULL, 5, 1, 2, 0),
(6, 2, 4, 'Slice layout', 'Slice and convert PSD mockups to HTML / CSS / JS\r\nFiles are attached\r\nPSD on google drive', '2014-03-05', NULL, 5, 1, 6, NULL, 1, 3, '2014-03-13 12:36:31', '2014-03-13 12:40:41', '2014-03-05', 100, 8, NULL, 6, 1, 2, 0),
(7, 2, 4, 'Implement ajax amounts calculations', 'Implement ajax amounts calculations, on both ways, for foreign in UK, and for UK in foreign.\r\nAlso display latest rates with margins added.', '2014-03-06', NULL, 5, 1, 6, NULL, 1, 2, '2014-03-13 12:37:46', '2014-03-13 12:40:56', '2014-03-06', 100, 3, NULL, 7, 1, 2, 0),
(8, 2, 4, 'Link orders to CMS', 'Link orders to CMS db to be displayed in administration panel', '2014-03-06', NULL, 5, 1, 6, NULL, 1, 2, '2014-03-13 12:38:55', '2014-03-13 12:41:07', '2014-03-06', 100, 5, NULL, 8, 1, 2, 0),
(9, 2, 3, 'Create instance with ZF1', 'Create project using zend framework 1 with mysql database', '2014-01-19', NULL, 5, 1, 4, NULL, 1, 1, '2014-03-13 13:52:37', '2014-03-13 13:56:08', '2014-01-14', 100, 3, NULL, 9, 1, 2, 0),
(10, 2, 3, 'Design database', 'Design database tables and functionabilities such as create / edit / delete\r\n- centers\r\n- companies\r\n- customers\r\n- margins\r\n- orders\r\n- payments\r\n- rates\r\n- users', NULL, NULL, 5, 1, 4, NULL, 1, 2, '2014-03-13 13:53:55', '2014-03-13 14:05:54', '2014-01-18', 0, 5, NULL, 10, 1, 2, 0),
(11, 2, 3, 'Implement fronted design', 'Implement frontend design using bootstrap framework and responsive design', NULL, NULL, 5, 1, 4, NULL, 1, 2, '2014-03-13 13:54:28', '2014-03-13 14:05:48', '2014-01-17', 100, 4, NULL, 11, 1, 2, 0),
(12, 2, 3, 'Implement rates parser', 'Implement rates parser for getting latest rates', NULL, NULL, 5, 1, 4, NULL, 1, 2, '2014-03-13 13:54:56', '2014-03-13 14:05:39', '2014-01-22', 100, 2, NULL, 12, 1, 2, 0),
(13, 2, 3, 'Client order / buyback', 'Create ordering and buyback functionability available for clients', NULL, NULL, 5, 1, 4, NULL, 1, 2, '2014-03-13 13:55:50', '2014-03-13 14:05:30', '2014-01-20', 100, 5, NULL, 13, 1, 2, 0),
(14, 2, 3, 'Login logic', 'Create login for clients, admin and processing centers', NULL, NULL, 5, 1, 4, NULL, 1, 2, '2014-03-13 14:01:24', '2014-03-13 14:05:23', '2014-01-21', 100, 3, NULL, 14, 1, 2, 0),
(15, 2, 3, 'Client panel', 'Create client panel with orders, latest rates, buybacks, daily limit', NULL, NULL, 5, 1, 4, NULL, 1, 2, '2014-03-13 14:02:49', '2014-03-13 14:05:10', '2014-01-18', 100, 3, NULL, 15, 1, 2, 0),
(2402, 3, 1, 'Sprint 1 - Discussions and planning', 'initial planning', NULL, NULL, 3, 3, 4, 1, 3, 1, '2014-03-13 16:09:20', '2014-03-13 16:18:30', '2014-03-09', 0, NULL, NULL, 2402, 1, 2, 0),
(2403, 3, 1, 'Create basic structure with ZF1', 'Create basic structure and configuration on zend framework 1 with mysql database.\r\nTest linux enviroment, and basic modules', NULL, NULL, 3, 1, 4, 1, 3, 2, '2014-03-13 16:11:14', '2014-03-13 16:21:15', '2014-03-09', 0, 8, NULL, 2403, 1, 2, 0),
(2404, 3, 1, 'Database design ', '', NULL, NULL, 1, 1, 4, 1, 3, 3, '2014-03-13 15:12:08', '2014-03-13 16:23:44', '2014-03-11', 0, 7, NULL, 2404, 1, 2, 0),
(2405, 3, 1, 'basic layout design ', 'Design the basic startup layout with the following links to\r\n''login'',\r\n''logout'',\r\n''my_account'',\r\n''clients'',\r\n''pets'',\r\n''reservations''.\r\n\r\nThe design needs to be responsive and to look good on desktop / tablet and mobile.', NULL, NULL, 1, 1, 4, 1, 3, 0, '2014-03-13 16:15:50', '2014-03-13 16:15:50', '2014-03-12', 0, 9, NULL, 2405, 1, 2, 0),
(2406, 2, 1, 'Implement login feature', 'Implement the posiblity to login using client or administrator.\r\nShow certain control panels for each.\r\nChange account settings and logout functionability\r\n\r\nThe implementation must be made after the attached UML diagram', NULL, NULL, 1, 1, 4, 1, 3, 2, '2014-03-13 16:16:34', '2014-03-13 16:22:17', '2014-03-13', 0, 10, NULL, 2406, 1, 2, 0),
(2407, 2, 1, 'Clients view', 'Create design and functionability for clients to view, add, edit or delete them.', NULL, NULL, 1, 1, 4, 1, 3, 0, '2014-03-13 16:17:55', '2014-03-13 16:17:55', '2014-03-13', 0, 10, NULL, 2407, 1, 2, 0),
(2408, 1, 1, 'Sprint 1 - Testing and bugs', '', NULL, NULL, 1, 8, 4, 1, 3, 0, '2014-03-13 16:20:25', '2014-03-13 16:20:25', '2014-03-13', 0, NULL, NULL, 2408, 1, 2, 0);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
