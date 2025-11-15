-- phpMyAdmin SQL Dump
-- version 5.2.2-1.el9
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 16, 2025 at 12:36 AM
-- Server version: 10.5.27-MariaDB
-- PHP Version: 8.2.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ojs_3-5_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `announcements`
--

CREATE TABLE `announcements` (
  `announcement_id` bigint(20) NOT NULL,
  `assoc_type` smallint(6) DEFAULT NULL,
  `assoc_id` bigint(20) DEFAULT NULL,
  `type_id` bigint(20) DEFAULT NULL,
  `date_expire` date DEFAULT NULL,
  `date_posted` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Announcements are messages that can be presented to users e.g. on the homepage.';

-- --------------------------------------------------------

--
-- Table structure for table `announcement_settings`
--

CREATE TABLE `announcement_settings` (
  `announcement_setting_id` bigint(20) UNSIGNED NOT NULL,
  `announcement_id` bigint(20) NOT NULL,
  `locale` varchar(28) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='More data about announcements, including localized properties like names and contents.';

-- --------------------------------------------------------

--
-- Table structure for table `announcement_types`
--

CREATE TABLE `announcement_types` (
  `type_id` bigint(20) NOT NULL,
  `context_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Announcement types allow for announcements to optionally be categorized.';

-- --------------------------------------------------------

--
-- Table structure for table `announcement_type_settings`
--

CREATE TABLE `announcement_type_settings` (
  `announcement_type_setting_id` bigint(20) UNSIGNED NOT NULL,
  `type_id` bigint(20) NOT NULL,
  `locale` varchar(28) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL,
  `setting_type` varchar(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='More data about announcement types, including localized properties like their names.';

-- --------------------------------------------------------

--
-- Table structure for table `authors`
--

CREATE TABLE `authors` (
  `author_id` bigint(20) NOT NULL,
  `email` varchar(90) NOT NULL,
  `include_in_browse` smallint(6) NOT NULL DEFAULT 1,
  `publication_id` bigint(20) NOT NULL,
  `seq` double NOT NULL DEFAULT 0,
  `user_group_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='The authors of a publication.';

--
-- Dumping data for table `authors`
--

INSERT INTO `authors` (`author_id`, `email`, `include_in_browse`, `publication_id`, `seq`, `user_group_id`) VALUES
(1, 'author-1@localhost.com', 1, 1, 0, 14);

-- --------------------------------------------------------

--
-- Table structure for table `author_affiliations`
--

CREATE TABLE `author_affiliations` (
  `author_affiliation_id` bigint(20) NOT NULL,
  `author_id` bigint(20) NOT NULL,
  `ror` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Author affiliations';

--
-- Dumping data for table `author_affiliations`
--

INSERT INTO `author_affiliations` (`author_affiliation_id`, `author_id`, `ror`) VALUES
(1, 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `author_affiliation_settings`
--

CREATE TABLE `author_affiliation_settings` (
  `author_affiliation_setting_id` bigint(20) UNSIGNED NOT NULL,
  `author_affiliation_id` bigint(20) NOT NULL,
  `locale` varchar(28) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='More data about author affiliations';

--
-- Dumping data for table `author_affiliation_settings`
--

INSERT INTO `author_affiliation_settings` (`author_affiliation_setting_id`, `author_affiliation_id`, `locale`, `setting_name`, `setting_value`) VALUES
(1, 1, 'en', 'name', 'Murray Group University');

-- --------------------------------------------------------

--
-- Table structure for table `author_settings`
--

CREATE TABLE `author_settings` (
  `author_setting_id` bigint(20) UNSIGNED NOT NULL,
  `author_id` bigint(20) NOT NULL,
  `locale` varchar(28) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='More data about authors, including localized properties such as their name and affiliation.';

--
-- Dumping data for table `author_settings`
--

INSERT INTO `author_settings` (`author_setting_id`, `author_id`, `locale`, `setting_name`, `setting_value`) VALUES
(1, 1, '', 'country', 'SZ'),
(2, 1, 'en', 'familyName', 'Cummings'),
(3, 1, 'en', 'givenName', 'Calista');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` bigint(20) NOT NULL,
  `context_id` bigint(20) NOT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `seq` bigint(20) DEFAULT NULL,
  `path` varchar(255) NOT NULL,
  `image` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Categories permit the organization of submissions into a heirarchical structure.';

-- --------------------------------------------------------

--
-- Table structure for table `category_settings`
--

CREATE TABLE `category_settings` (
  `category_setting_id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) NOT NULL,
  `locale` varchar(28) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='More data about categories, including localized properties such as names.';

-- --------------------------------------------------------

--
-- Table structure for table `citations`
--

CREATE TABLE `citations` (
  `citation_id` bigint(20) NOT NULL,
  `publication_id` bigint(20) NOT NULL,
  `raw_citation` text NOT NULL,
  `seq` bigint(20) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='A citation made by an associated publication.';

-- --------------------------------------------------------

--
-- Table structure for table `citation_settings`
--

CREATE TABLE `citation_settings` (
  `citation_setting_id` bigint(20) UNSIGNED NOT NULL,
  `citation_id` bigint(20) NOT NULL,
  `locale` varchar(28) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL,
  `setting_type` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Additional data about citations, including localized content.';

-- --------------------------------------------------------

--
-- Table structure for table `completed_payments`
--

CREATE TABLE `completed_payments` (
  `completed_payment_id` bigint(20) NOT NULL,
  `timestamp` datetime NOT NULL,
  `payment_type` bigint(20) NOT NULL,
  `context_id` bigint(20) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `assoc_id` bigint(20) DEFAULT NULL,
  `amount` decimal(8,2) UNSIGNED NOT NULL,
  `currency_code_alpha` varchar(3) DEFAULT NULL,
  `payment_method_plugin_name` varchar(80) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='A list of completed (fulfilled) payments relating to a payment type such as a subscription payment.';

-- --------------------------------------------------------

--
-- Table structure for table `controlled_vocabs`
--

CREATE TABLE `controlled_vocabs` (
  `controlled_vocab_id` bigint(20) NOT NULL,
  `symbolic` varchar(64) NOT NULL,
  `assoc_type` bigint(20) NOT NULL DEFAULT 0,
  `assoc_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Every word or phrase used in a controlled vocabulary. Controlled vocabularies are used for submission metadata like keywords and subjects, reviewer interests, and wherever a similar dictionary of words or phrases is required. Each entry corresponds to a word or phrase like "cellular reproduction" and a type like "submissionKeyword".';

--
-- Dumping data for table `controlled_vocabs`
--

INSERT INTO `controlled_vocabs` (`controlled_vocab_id`, `symbolic`, `assoc_type`, `assoc_id`) VALUES
(1, 'interest', 0, NULL),
(5, 'submissionAgency', 1048588, 1),
(4, 'submissionDiscipline', 1048588, 1),
(2, 'submissionKeyword', 1048588, 1),
(3, 'submissionSubject', 1048588, 1);

-- --------------------------------------------------------

--
-- Table structure for table `controlled_vocab_entries`
--

CREATE TABLE `controlled_vocab_entries` (
  `controlled_vocab_entry_id` bigint(20) NOT NULL,
  `controlled_vocab_id` bigint(20) NOT NULL,
  `seq` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='The order that a word or phrase used in a controlled vocabulary should appear. For example, the order of keywords in a publication.';

--
-- Dumping data for table `controlled_vocab_entries`
--

INSERT INTO `controlled_vocab_entries` (`controlled_vocab_entry_id`, `controlled_vocab_id`, `seq`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 1, 4),
(5, 1, 5),
(6, 1, 6),
(32, 2, 1),
(33, 2, 2),
(34, 2, 3),
(35, 2, 4),
(36, 2, 5);

-- --------------------------------------------------------

--
-- Table structure for table `controlled_vocab_entry_settings`
--

CREATE TABLE `controlled_vocab_entry_settings` (
  `controlled_vocab_entry_setting_id` bigint(20) UNSIGNED NOT NULL,
  `controlled_vocab_entry_id` bigint(20) NOT NULL,
  `locale` varchar(28) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='More data about a controlled vocabulary entry, including localized properties such as the actual word or phrase.';

--
-- Dumping data for table `controlled_vocab_entry_settings`
--

INSERT INTO `controlled_vocab_entry_settings` (`controlled_vocab_entry_setting_id`, `controlled_vocab_entry_id`, `locale`, `setting_name`, `setting_value`) VALUES
(1, 1, '', 'name', 'fine arts'),
(2, 2, '', 'name', 'theater'),
(3, 3, '', 'name', 'dance'),
(4, 4, '', 'name', 'music'),
(5, 5, '', 'name', 'design'),
(6, 6, '', 'name', 'architecture'),
(32, 32, 'en', 'name', 'pile'),
(33, 33, 'en', 'name', 'octave'),
(34, 34, 'en', 'name', 'swine'),
(35, 35, 'en', 'name', 'tooth'),
(36, 36, 'en', 'name', 'synergy');

-- --------------------------------------------------------

--
-- Table structure for table `custom_issue_orders`
--

CREATE TABLE `custom_issue_orders` (
  `custom_issue_order_id` bigint(20) UNSIGNED NOT NULL,
  `issue_id` bigint(20) NOT NULL,
  `journal_id` bigint(20) NOT NULL,
  `seq` double NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Ordering information for the issue list, when custom issue ordering is specified.';

-- --------------------------------------------------------

--
-- Table structure for table `custom_section_orders`
--

CREATE TABLE `custom_section_orders` (
  `custom_section_order_id` bigint(20) UNSIGNED NOT NULL,
  `issue_id` bigint(20) NOT NULL,
  `section_id` bigint(20) NOT NULL,
  `seq` double NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Ordering information for sections within issues, when issue-specific section ordering is specified.';

-- --------------------------------------------------------

--
-- Table structure for table `data_object_tombstones`
--

CREATE TABLE `data_object_tombstones` (
  `tombstone_id` bigint(20) NOT NULL,
  `data_object_id` bigint(20) NOT NULL,
  `date_deleted` datetime NOT NULL,
  `set_spec` varchar(255) NOT NULL,
  `set_name` varchar(255) NOT NULL,
  `oai_identifier` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Entries for published data that has been removed. Usually used in the OAI endpoint.';

-- --------------------------------------------------------

--
-- Table structure for table `data_object_tombstone_oai_set_objects`
--

CREATE TABLE `data_object_tombstone_oai_set_objects` (
  `object_id` bigint(20) NOT NULL,
  `tombstone_id` bigint(20) NOT NULL,
  `assoc_type` bigint(20) NOT NULL,
  `assoc_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Relationships between tombstones and other data that can be collected in OAI sets, e.g. sections.';

-- --------------------------------------------------------

--
-- Table structure for table `data_object_tombstone_settings`
--

CREATE TABLE `data_object_tombstone_settings` (
  `tombstone_setting_id` bigint(20) UNSIGNED NOT NULL,
  `tombstone_id` bigint(20) NOT NULL,
  `locale` varchar(28) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL,
  `setting_type` varchar(6) NOT NULL COMMENT '(bool|int|float|string|object)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='More data about data object tombstones, including localized content.';

-- --------------------------------------------------------

--
-- Table structure for table `dois`
--

CREATE TABLE `dois` (
  `doi_id` bigint(20) NOT NULL,
  `context_id` bigint(20) NOT NULL,
  `doi` varchar(255) NOT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Stores all DOIs used in the system.';

-- --------------------------------------------------------

--
-- Table structure for table `doi_settings`
--

CREATE TABLE `doi_settings` (
  `doi_setting_id` bigint(20) UNSIGNED NOT NULL,
  `doi_id` bigint(20) NOT NULL,
  `locale` varchar(28) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='More data about DOIs, including the registration agency.';

-- --------------------------------------------------------

--
-- Table structure for table `edit_decisions`
--

CREATE TABLE `edit_decisions` (
  `edit_decision_id` bigint(20) NOT NULL,
  `submission_id` bigint(20) NOT NULL,
  `review_round_id` bigint(20) DEFAULT NULL,
  `stage_id` bigint(20) DEFAULT NULL,
  `round` smallint(6) DEFAULT NULL,
  `editor_id` bigint(20) NOT NULL,
  `decision` smallint(6) NOT NULL COMMENT 'A numeric constant indicating the decision that was taken. Possible values are listed in the Decision class.',
  `date_decided` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Editorial decisions recorded on a submission, such as decisions to accept or decline the submission, as well as decisions to send for review, send to copyediting, request revisions, and more.';

-- --------------------------------------------------------

--
-- Table structure for table `email_log`
--

CREATE TABLE `email_log` (
  `log_id` bigint(20) NOT NULL,
  `assoc_type` bigint(20) NOT NULL,
  `assoc_id` bigint(20) NOT NULL,
  `sender_id` bigint(20) DEFAULT NULL,
  `date_sent` datetime NOT NULL,
  `event_type` bigint(20) DEFAULT NULL,
  `from_address` varchar(255) DEFAULT NULL,
  `recipients` text DEFAULT NULL,
  `cc_recipients` text DEFAULT NULL,
  `bcc_recipients` text DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `body` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='A record of email messages that are sent in relation to an associated entity, such as a submission.';

--
-- Dumping data for table `email_log`
--

INSERT INTO `email_log` (`log_id`, `assoc_type`, `assoc_id`, `sender_id`, `date_sent`, `event_type`, `from_address`, `recipients`, `cc_recipients`, `bcc_recipients`, `subject`, `body`) VALUES
(1, 1048585, 1, NULL, '2025-11-16 01:29:44', 805306373, '\"Adrian Mróz\" <adrian.mroz@uj.edu.pl>', '\"Adrian STROMIT\" <admin@localhost.com>', '', '', 'A new submission needs an editor to be assigned: \"Volaticus crebro adaugeo cubicularis thalassinus autus\"', '<p>Dear Adrian STROMIT,</p><p>The following submission has been submitted and there is no editor assigned.</p><p><a href=\"https://localhost:8443/index.php/JOP/dashboard/editorial?workflowSubmissionId=1\">\"Volaticus crebro adaugeo cubicularis thalassinus autus\"</a><br />Calista Cummings</p><p><b>Abstract</b></p><p>Suppellex accusator comitatus quasi cunae. Talio adfero vinculum venio solvo audax aer comburo. Antiquus decerno vesper accusamus pariatur clam victus vir.\\nVelut bos cetera casso capio abundans strues ipsum. Denuo caute omnis ustulo casso temperantia creator. Ustilo sodalitas vulariter templum coruscus amplitudo.\\nDefleo ustulo tam audio deleo ea. Dolorum deprecator thema. Trucido accusantium coruscus numquam veritatis crux advenio labore.</p><p>Please assign an editor who will be responsible for the submission by clicking the title above and assigning an editor under the Participants section.</p><hr><p>This is an automated email from <a href=\"https://localhost:8443/index.php/JOP\">Journal of Philosophy</a>.</p>'),
(2, 1048585, 1, NULL, '2025-11-16 01:29:44', 805306373, '\"Adrian Mróz\" <adrian.mroz@uj.edu.pl>', '\"Renato Jordi\" <editor.journal@localhost.com>', '', '', 'A new submission needs an editor to be assigned: \"Volaticus crebro adaugeo cubicularis thalassinus autus\"', '<p>Dear Renato Jordi,</p><p>The following submission has been submitted and there is no editor assigned.</p><p><a href=\"https://localhost:8443/index.php/JOP/dashboard/editorial?workflowSubmissionId=1\">\"Volaticus crebro adaugeo cubicularis thalassinus autus\"</a><br />Calista Cummings</p><p><b>Abstract</b></p><p>Suppellex accusator comitatus quasi cunae. Talio adfero vinculum venio solvo audax aer comburo. Antiquus decerno vesper accusamus pariatur clam victus vir.\\nVelut bos cetera casso capio abundans strues ipsum. Denuo caute omnis ustulo casso temperantia creator. Ustilo sodalitas vulariter templum coruscus amplitudo.\\nDefleo ustulo tam audio deleo ea. Dolorum deprecator thema. Trucido accusantium coruscus numquam veritatis crux advenio labore.</p><p>Please assign an editor who will be responsible for the submission by clicking the title above and assigning an editor under the Participants section.</p><hr><p>This is an automated email from <a href=\"https://localhost:8443/index.php/JOP\">Journal of Philosophy</a>.</p>'),
(3, 1048585, 1, NULL, '2025-11-16 01:29:44', 536870914, '\"Adrian Mróz\" <adrian.mroz@uj.edu.pl>', '\"Calista Cummings\" <author-1@localhost.com>', '', '', 'Thank you for your submission to Journal of Philosophy', '<p>Dear Calista Cummings,</p><p>Thank you for your submission to Journal of Philosophy. We have received your submission, \"Volaticus crebro adaugeo cubicularis thalassinus autus\", and a member of our editorial team will see it soon. You will be sent an email when an initial decision is made, and we may contact you for further information.</p><p>You can view your submission and track its progress through the editorial process at the following location:</p><p>Submission URL: https://localhost:8443/index.php/JOP/dashboard/mySubmissions?workflowSubmissionId=1</p><p>If you have been logged out, you can login again with the username author-1.</p><p>If you have any questions, please contact me from your <a href=\"https://localhost:8443/index.php/JOP/dashboard/mySubmissions?workflowSubmissionId=1\">submission dashboard</a>.</p><p>Thank you for considering Journal of Philosophy as a venue for your work.</p><br><br>—<br><p>This is an automated message from <a href=\"https://localhost:8443/index.php/JOP\">Journal of Philosophy</a>.</p>');

-- --------------------------------------------------------

--
-- Table structure for table `email_log_users`
--

CREATE TABLE `email_log_users` (
  `email_log_user_id` bigint(20) UNSIGNED NOT NULL,
  `email_log_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='A record of users associated with an email log entry.';

--
-- Dumping data for table `email_log_users`
--

INSERT INTO `email_log_users` (`email_log_user_id`, `email_log_id`, `user_id`) VALUES
(1, 1, 1),
(2, 2, 7),
(3, 3, 12);

-- --------------------------------------------------------

--
-- Table structure for table `email_templates`
--

CREATE TABLE `email_templates` (
  `email_id` bigint(20) NOT NULL,
  `email_key` varchar(255) NOT NULL COMMENT 'Unique identifier for this email.',
  `context_id` bigint(20) NOT NULL,
  `alternate_to` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Custom email templates created by each context, and overrides of the default templates.';

--
-- Dumping data for table `email_templates`
--

INSERT INTO `email_templates` (`email_id`, `email_key`, `context_id`, `alternate_to`) VALUES
(1, 'COPYEDIT_REQUEST', 1, 'DISCUSSION_NOTIFICATION_COPYEDITING'),
(2, 'EDITOR_ASSIGN_SUBMISSION', 1, 'DISCUSSION_NOTIFICATION_SUBMISSION'),
(3, 'EDITOR_ASSIGN_REVIEW', 1, 'DISCUSSION_NOTIFICATION_REVIEW'),
(4, 'EDITOR_ASSIGN_PRODUCTION', 1, 'DISCUSSION_NOTIFICATION_PRODUCTION'),
(5, 'LAYOUT_REQUEST', 1, 'DISCUSSION_NOTIFICATION_PRODUCTION'),
(6, 'LAYOUT_COMPLETE', 1, 'DISCUSSION_NOTIFICATION_PRODUCTION');

-- --------------------------------------------------------

--
-- Table structure for table `email_templates_default_data`
--

CREATE TABLE `email_templates_default_data` (
  `email_templates_default_data_id` bigint(20) UNSIGNED NOT NULL,
  `email_key` varchar(255) NOT NULL COMMENT 'Unique identifier for this email.',
  `locale` varchar(28) NOT NULL DEFAULT 'en',
  `name` varchar(255) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `body` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Default email templates created for every installed locale.';

--
-- Dumping data for table `email_templates_default_data`
--

INSERT INTO `email_templates_default_data` (`email_templates_default_data_id`, `email_key`, `locale`, `name`, `subject`, `body`) VALUES
(1, 'PASSWORD_RESET_CONFIRM', 'en', 'Password Reset Confirm', 'Password Reset Confirmation', 'We have received a request to reset your password for the {$siteTitle} web site.<br />\n<br />\nIf you did not make this request, please ignore this email and your password will not be changed. If you wish to reset your password, click on the below URL.<br />\n<br />\nReset my password: {$passwordResetUrl}<br />\n<br />\n{$siteContactName}'),
(2, 'USER_REGISTER', 'en', 'User Created', 'Journal Registration', '{$recipientName}<br />\n<br />\nYou have now been registered as a user with {$journalName}. We have included your username and password in this email, which are needed for all work with this journal through its website. At any point, you can ask to be removed from the journal\'s list of users by contacting me.<br />\n<br />\nUsername: {$recipientUsername}<br />\nPassword: {$password}<br />\n<br />\nThank you,<br />\n{$signature}'),
(3, 'USER_VALIDATE_CONTEXT', 'en', 'Validate Email (Journal Registration)', 'Validate Your Account', '{$recipientName}<br />\n<br />\nYou have created an account with {$journalName}, but before you can start using it, you need to validate your email account. To do this, simply follow the link below:<br />\n<br />\n{$activateUrl}<br />\n<br />\nThank you,<br />\n{$journalSignature}'),
(4, 'USER_VALIDATE_SITE', 'en', 'Validate Email (Site)', 'Validate Your Account', '{$recipientName}<br />\n<br />\nYou have created an account with {$siteTitle}, but before you can start using it, you need to validate your email account. To do this, simply follow the link below:<br />\n<br />\n{$activateUrl}<br />\n<br />\nThank you,<br />\n{$siteSignature}'),
(5, 'REVIEWER_REGISTER', 'en', 'Reviewer Register', 'Registration as Reviewer with {$journalName}', '<p>Dear {$recipientName},</p><p>In light of your expertise, we have registered your name in the reviewer database for {$journalName}. This does not entail any form of commitment on your part, but simply enables us to approach you with a submission to possibly review. On being invited to review, you will have an opportunity to see the title and abstract of the paper in question, and you\'ll always be in a position to accept or decline the invitation. You can also ask at any point to have your name removed from this reviewer list.</p><p>We are providing you with a username and password, which is used in all interactions with the journal through its website. You may wish, for example, to update your profile, including your reviewing interests.</p><p>Username: {$recipientUsername}<br />Password: {$password}</p><p>Thank you,</p>{$signature}'),
(6, 'ISSUE_PUBLISH_NOTIFY', 'en', 'Issue Published Notify', 'Just published: {$issueIdentification} of {$journalName}', '<p>Dear {$recipientName},</p><p>We are pleased to announce the publication of <a href=\"{$issueUrl}\">{$issueIdentification}</a> of {$journalName}.  We invite you to read and share this work with your scholarly community.</p><p>Many thanks to our authors, reviewers, and editors for their valuable contributions, and to our readers for your continued interest.</p><div>{$issueToc}</div><p>Thank you,</p>{$signature}'),
(7, 'SUBMISSION_ACK', 'en', 'Submission Confirmation', 'Thank you for your submission to {$journalName}', '<p>Dear {$recipientName},</p><p>Thank you for your submission to {$journalName}. We have received your submission, \"{$submissionTitle}\", and a member of our editorial team will see it soon. You will be sent an email when an initial decision is made, and we may contact you for further information.</p><p>You can view your submission and track its progress through the editorial process at the following location:</p><p>Submission URL: {$authorSubmissionUrl}</p><p>If you have been logged out, you can login again with the username {$recipientUsername}.</p><p>If you have any questions, please contact me from your <a href=\"{$authorSubmissionUrl}\">submission dashboard</a>.</p><p>Thank you for considering {$journalName} as a venue for your work.</p>{$journalSignature}'),
(8, 'SUBMISSION_ACK_NOT_USER', 'en', 'Submission Confirmation (Other Authors)', 'Submission confirmation', '<p>Dear {$recipientName},</p><p>You have been named as a co-author on a submission to {$journalName}. The submitter, {$submitterName}, provided the following details:</p><p>\"{$submissionTitle}\"<br>{$authorsWithAffiliation}</p><p>If any of these details are incorrect, or you do not wish to be named on this submission, please contact me.</p><p>Thank you for considering {$journalName} as a venue for your work.</p><p>Kind regards,</p>{$journalSignature}'),
(9, 'EDITOR_ASSIGN', 'en', 'Editor Assigned', 'You have been assigned as an editor on a submission to {$journalName}', '<p>Dear {$recipientName},</p><p>The following submission has been assigned to you to see through the editorial process.</p><p><a href=\"{$submissionUrl}\">{$submissionTitle}</a><br />{$authors}</p><p><b>Abstract</b></p>{$submissionAbstract}<p>If you find the submission to be relevant for {$journalName}, please forward the submission to the review stage by selecting \"Send to Review\" and then assign reviewers by clicking \"Add Reviewer\".</p><p>If the submission is not appropriate for this journal, please decline the submission.</p><p>Thank you in advance.</p><p>Kind regards,</p>{$journalSignature}'),
(10, 'REVIEW_CANCEL', 'en', 'Reviewer Unassign', 'Request for Review Cancelled', '<p>Dear {$recipientName},</p><p>Recently, we asked you to review a submission to {$journalName}. We have decided to cancel the request for you to reivew the submission, {$submissionTitle}.</p><p>We apologize any inconvenience this may cause you and hope that we will be able to call on you to assist with this journal\'s review process in the future.</p><p>If you have any questions, please contact me.</p>{$signature}'),
(11, 'REVIEW_REINSTATE', 'en', 'Reviewer Reinstate', 'Can you still review something for {$journalName}?', '<p>Dear {$recipientName},</p><p>We recently cancelled our request for you to review a submission, {$submissionTitle}, for {$journalName}. We\'ve reversed that decision and we hope that you are still able to conduct the review.</p><p>If you are able to assist with this submission\'s review, you can <a href=\"{$reviewAssignmentUrl}\">login to the journal</a> to view the submission, upload review files, and submit your review request.</p><p>If you have any questions, please contact me.</p><p>Kind regards,</p>{$signature}'),
(12, 'REVIEW_RESEND_REQUEST', 'en', 'Resend Review Request to Reviewer', 'Requesting your review again for {$journalName}', '<p>Dear {$recipientName},</p><p>Recently, you declined our request to review a submission, \"{$submissionTitle}\", for {$journalName}. I\'m writing to see if you are able to conduct the review after all.</p><p>We would be grateful if you\'re able to perform this review, but we understand if that is not possible at this time. Either way, please <a href=\"{$reviewAssignmentUrl}\">accept or decline the request</a> by {$responseDueDate}, so that we can find an alternate reviewer.</p><p>If you have any questions, please contact me.</p><p>Kind regards,</p>{$signature}'),
(13, 'REVIEW_REQUEST', 'en', 'Review Request', 'Invitation to review', '<p>Dear {$recipientName},</p><p>I believe that you would serve as an excellent reviewer for a submission  to {$journalName}. The submission\'s title and abstract are below, and I hope that you will consider undertaking this important task for us.</p><p>If you are able to review this submission, your review is due by {$reviewDueDate}. You can view the submission, upload review files, and submit your review by logging into the journal site and following the steps at the link below.</p><p><a href=\"{$reviewAssignmentUrl}\">{$submissionTitle}</a></p><p><b>Abstract</b></p>{$submissionAbstract}<p>Please <a href=\"{$reviewAssignmentUrl}\">accept or decline</a> the review by <b>{$responseDueDate}</b>.</p><p>You may contact me with any questions about the submission or the review process.</p><p>Thank you for considering this request. Your help is much appreciated.</p><p>Kind regards,</p>{$signature}'),
(14, 'REVIEW_REQUEST_SUBSEQUENT', 'en', 'Review Request Subsequent', 'Request to review a revised submission', '<p>Dear {$recipientName},</p><p>Thank you for your review of <a href=\"{$reviewAssignmentUrl}\">{$submissionTitle}</a>. The authors have considered the reviewers\' feedback and have now submitted a revised version of their work. I\'m writing to ask if you would conduct a second round of peer review for this submission.</p><p>If you are able to review this submission, your review is due by {$reviewDueDate}. You can <a href=\"{$reviewAssignmentUrl}\">follow the review steps</a> to view the submission, upload review files, and submit your review comments.<p><p><a href=\"{$reviewAssignmentUrl}\">{$submissionTitle}</a></p><p><b>Abstract</b></p>{$submissionAbstract}<p>Please <a href=\"{$reviewAssignmentUrl}\">accept or decline</a> the review by <b>{$responseDueDate}</b>.</p><p>Please feel free to contact me with any questions about the submission or the review process.</p><p>Thank you for considering this request. Your help is much appreciated.</p><p>Kind regards,</p>{$signature}'),
(15, 'REVIEW_RESPONSE_OVERDUE_AUTO', 'en', 'Review Response Overdue (Automated)', 'Will you be able to review this for us?', '<p>Dear {$recipientName},</p><p>This email is an automated reminder from {$journalName} in regards to our request for your review of the submission, \"{$submissionTitle}.\"</p><p>You are receiving this email because we have not yet received a confirmation from you indicating whether or not you are able to undertake the review of this submission.</p><p>Please let us know whether or not you are able to undertake this review by using our submission management software to accept or decline this request.</p><p>If you are able to review this submission, your review is due by {$reviewDueDate}. You can follow the review steps to view the submission, upload review files, and submit your review comments.</p><p><a href=\"{$reviewAssignmentUrl}\">{$submissionTitle}</a></p><p><b>Abstract</b></p>{$submissionAbstract}<p>Please feel free to contact me with any questions about the submission or the review process.</p><p>Thank you for considering this request. Your help is much appreciated.</p><p>Kind regards,</p>{$journalSignature}'),
(16, 'REVIEW_CONFIRM', 'en', 'Review Confirm', 'Review accepted: {$reviewerName} accepted review assignment for #{$submissionId} {$authorsShort} — \"{$submissionTitle}\"', '<p>Dear {$recipientName},</p><p>{$reviewerName} has accepted the following review:</p><p><a href=\"{$submissionUrl}\">#{$submissionId} {$authorsShort} — \"{$submissionTitle}\"</a><br /><b>Type:</b> {$reviewMethod}</p><p><b>Review Due:</b> {$reviewDueDate}</p><p>Login to <a href=\"{$submissionUrl}\">view all reviewer assignments</a> for this submission.</p><br><br>—<br>This is an automated message from <a href=\"{$journalUrl}\">{$journalName}</a>.'),
(17, 'REVIEW_DECLINE', 'en', 'Review Decline', 'Unable to Review', 'Editors:<br />\n<br />\nI am afraid that at this time I am unable to review the submission, &quot;{$submissionTitle},&quot; for {$journalName}. Thank you for thinking of me, and another time feel free to call on me.<br />\n<br />\n{$senderName}'),
(18, 'REVIEW_ACK', 'en', 'Review Acknowledgement', 'Thank you for your review', '<p>Dear {$recipientName},</p>\n<p>Thank you for completing your review of the submission, \"{$submissionTitle}\", for {$journalName}. We appreciate your time and expertise in contributing to the quality of the work that we publish.</p>\n<p>It has been a pleasure to work with you as a reviewer for {$journalName}, and we hope to have the opportunity to work with you again in the future.</p>\n<p>Kind regards,</p>\n<p>{$signature}</p>'),
(19, 'REVIEW_REMIND', 'en', 'Review Reminder', 'A reminder to please complete your review', '<p>Dear {$recipientName},</p><p>Just a gentle reminder of our request for your review of the submission, \"{$submissionTitle},\" for {$journalName}. We were expecting to have this review by {$reviewDueDate} and we would be pleased to receive it as soon as you are able to prepare it.</p><p>You can <a href=\"{$reviewAssignmentUrl}\">login to the journal</a> and follow the review steps to view the submission, upload review files, and submit your review comments.</p><p>If you need an extension of the deadline, please contact me. I look forward to hearing from you.</p><p>Thank you in advance and kind regards,</p>{$signature}'),
(20, 'REVIEW_REMIND_AUTO', 'en', 'Review Reminder (Automated)', 'A reminder to please complete your review', '<p>Dear {$recipientName}:</p><p>This email is an automated reminder from {$journalName} in regards to our request for your review of the submission, \"{$submissionTitle}.\"</p><p>We were expecting to have this review by {$reviewDueDate} and we would be pleased to receive it as soon as you are able to prepare it.</p><p>Please <a href=\"{$reviewAssignmentUrl}\">login to the journal</a> and follow the review steps to view the submission, upload review files, and submit your review comments.</p><p>If you need an extension of the deadline, please contact me. I look forward to hearing from you.</p><p>Thank you in advance and kind regards,</p>{$journalSignature}'),
(21, 'REVIEW_COMPLETE', 'en', 'Review Completed', 'Review complete: {$reviewerName} recommends {$reviewRecommendation} for #{$submissionId} {$authorsShort} — \"{$submissionTitle}\"', '<p>Dear {$recipientName},</p><p>{$reviewerName} completed the following review:</p><p><a href=\"{$submissionUrl}\">#{$submissionId} {$authorsShort} — \"{$submissionTitle}\"</a><br /><b>Recommendation:</b> {$reviewRecommendation}<br /><b>Type:</b> {$reviewMethod}</p><p>Login to <a href=\"{$submissionUrl}\">view all files and comments</a> provided by this reviewer.</p>'),
(22, 'REVIEW_EDIT', 'en', 'Review Edited', 'Your review assignment has been changed for {$journalName}', '<p>Dear {$recipientName},</p><p>An editor has made changes to your review assignment for {$journalName}. Please review the details below and let us know if you have any questions.</p><p><a href=\"{$reviewAssignmentUrl}\">\"{$submissionTitle}\"</a><br /><b>Type:</b> {$reviewMethod}<br /><b>Accept or Decline By:</b> {$responseDueDate}<br /><b>Submit Review By:</b> {$reviewDueDate}</p><p>You can login to <a href=\"{$reviewAssignmentUrl}\">complete this review</a> at any time.</p>'),
(23, 'EDITOR_DECISION_ACCEPT', 'en', 'Submission Accepted', 'Your submission has been accepted to {$journalName}', '<p>Dear {$recipientName},</p><p>I am pleased to inform you that we have decided to accept your submission without further revision. After careful review, we found your submission, {$submissionTitle}, to meet or exceed our expectations. We are excited to publish your piece in {$journalName} and we thank you for choosing our journal as a venue for your work.</p><p>Your submission is now forthcoming in a future issue of {$journalName} and you are welcome to include it in your list of publications. We recognize the hard work that goes into every successful submission and we want to congratulate you on reaching this stage.</p><p>Your submission will now undergo copy editing and formatting to prepare it for publication.</p><p>You will shortly receive further instructions.</p><p>If you have any questions, please contact me from your <a href=\"{$authorSubmissionUrl}\">submission dashboard</a>.</p><p>Kind regards,</p>{$signature}'),
(24, 'EDITOR_DECISION_SEND_TO_EXTERNAL', 'en', 'Sent to Review', 'Your submission has been sent for review', '<p>Dear {$recipientName},</p><p>I am pleased to inform you that an editor has reviewed your submission, \"{$submissionTitle}\", and has decided to send it for peer review. An editor will identify qualified reviewers who will provide feedback on your submission.</p><p>{$reviewTypeDescription} You will hear from us with feedback from the reviewers and information about the next steps.</p><p>Please note that sending the submission to peer review does not guarantee that it will be published. We will consider the reviewers\' recommendations before deciding to accept the submission for publication. You may be asked to make revisions and respond to the reviewers\' comments before a final decision is made.</p><p>If you have any questions, please contact me from your submission dashboard.</p><p>{$signature}</p>'),
(25, 'EDITOR_DECISION_SEND_TO_PRODUCTION', 'en', 'Sent to Production', 'Next steps for publishing your submission', '<p>Dear {$recipientName},</p><p>I am writing from {$journalName} to let you know that the editing of your submission, \"{$submissionTitle}\", is complete. Your submission will now advance to the production stage, where the final galleys will be prepared for publication. We will contact you if we need any further assistance.</p><p>If you have any questions, please contact me from your <a href=\"{$authorSubmissionUrl}\">submission dashboard</a>.</p><p>Kind regards,</p>{$signature}'),
(26, 'EDITOR_DECISION_REVISIONS', 'en', 'Revisions Requested', 'Your submission has been reviewed and we encourage you to submit revisions', '<p>Dear {$recipientName},</p><p>Your submission \"{$submissionTitle}\" has been reviewed and we would like to encourage you to submit revisions that address the reviewers\' comments. An editor will review these revisions and if they address the concerns adequately, your submission may be accepted for publication.</p><p>The reviewers\' comments are included at the bottom of this email. Please respond to each point in the reviewers\' comments and identify what changes you have made. If you find any of the reviewer\'s comments to be unjustified or inappropriate, please explain your perspective.</p><p>When you have completed your revisions, you can upload revised documents along with your response to the reviewers\' comments at your <a href=\"{$authorSubmissionUrl}\">submission dashboard</a>. If you have been logged out, you can login again with the username {$recipientUsername}.</p><p>If you have any questions, please contact me from your <a href=\"{$authorSubmissionUrl}\">submission dashboard</a>.</p><p>We look forward to receiving your revised submission.</p><p>Kind regards,</p>{$signature}<hr><p>The following comments were received from reviewers.</p>{$allReviewerComments}'),
(27, 'EDITOR_DECISION_RESUBMIT', 'en', 'Resubmit for Review', 'Your submission has been reviewed - please revise and resubmit', '<p>Dear {$recipientName},</p><p>After reviewing your submission, \"{$submissionTitle}\", the reviewers have recommended that your submission cannot be accepted for publication in its current form. However, we would like to encourage you to submit a revised version that addresses the reviewers\' comments. Your revisions will be reviewed by an editor and may be sent out for another round of peer review.</p><p>Please note that resubmitting your work does not guarantee that it will be accepted.</p><p>The reviewers\' comments are included at the bottom of this email. Please respond to each point and identify what changes you have made. If you find any of the reviewer\'s comments inappropriate, please explain your perspective. If you have questions about the recommendations in your review, please include these in your response.</p><p>When you have completed your revisions, you can upload revised documents along with your response to the reviewers\' comments <a href=\"{$authorSubmissionUrl}\">at your submission dashboard</a>. If you have been logged out, you can login again with the username {$recipientUsername}.</p><p>If you have any questions, please contact me from your <a href=\"{$authorSubmissionUrl}\">submission dashboard</a>.</p><p>We look forward to receiving your revised submission.</p><p>Kind regards,</p>{$signature}<hr><p>The following comments were received from reviewers.</p>{$allReviewerComments}'),
(28, 'EDITOR_DECISION_DECLINE', 'en', 'Submission Declined', 'Your submission has been declined', '<p>Dear {$recipientName},</p><p>While we appreciate receiving your submission, we are unable to accept \"{$submissionTitle}\" for publication on the basis of the comments from reviewers.</p><p>The reviewers\' comments are included at the bottom of this email.</p><p>Thank you for submitting to {$journalName}. Although it is disappointing to have a submission declined, I hope you find the reviewers\' comments to be constructive and helpful.</p><p>You are now free to submit the work elsewhere if you choose to do so.</p><p>Kind regards,</p>{$signature}<hr><p>The following comments were received from reviewers.</p>{$allReviewerComments}'),
(29, 'EDITOR_DECISION_INITIAL_DECLINE', 'en', 'Submission Declined (Pre-Review)', 'Your submission has been declined', '<p>Dear {$recipientName},</p><p>I’m sorry to inform you that, after reviewing your submission, \"{$submissionTitle}\", the editor has found that it does not meet our requirements for publication in {$journalName}.</p><p>I wish you success if you consider submitting your work elsewhere.</p><p>Kind regards,</p>{$signature}'),
(30, 'EDITOR_RECOMMENDATION', 'en', 'Recommendation Made', 'Editor Recommendation', '<p>Dear {$recipientName},</p><p>After considering the reviewers\' feedback, I would like to make the following recommendation regarding the submission \"{$submissionTitle}\".</p><p>My recommendation is: {$recommendation}.</p><p>Please visit the submission\'s <a href=\"{$submissionUrl}\">editorial workflow</a> to act on this recommendation.</p><p>Please feel free to contact me with any questions.</p><p>Kind regards,</p><p>{$senderName}</p>'),
(31, 'EDITOR_DECISION_NOTIFY_OTHER_AUTHORS', 'en', 'Notify Other Authors', 'An update regarding your submission', '<p>The following email was sent to {$submittingAuthorName} from {$journalName} regarding \"{$submissionTitle}\".</p>\n<p>You are receiving a copy of this notification because you are identified as an author of the submission. Any instructions in the message below are intended for the submitting author, {$submittingAuthorName}, and no action is required of you at this time.</p>\n\n{$messageToSubmittingAuthor}'),
(32, 'EDITOR_DECISION_NOTIFY_REVIEWERS', 'en', 'Notify Reviewers of Decision', 'Thank you for your review', '<p>Dear {$recipientName},</p>\n<p>Thank you for completing your review of the submission, \"{$submissionTitle}\", for {$journalName}. We appreciate your time and expertise in contributing to the quality of the work that we publish. We have shared your comments with the authors, along with our other reviewers\' comments and the editor\'s decision.</p>\n<p>Based on the feedback we received, we have notified the authors of the following:</p>\n<p>{$decisionDescription}</p>\n<p>Your recommendation was considered alongside the recommendations of other reviewers before coming to a decision. Occasionally the editor\'s decision may differ from the recommendation made by one or more reviewers. The editor considers many factors, and does not take these decisions lightly. We are grateful for our reviewers\' expertise and suggestions.</p>\n<p>It has been a pleasure to work with you as a reviewer for {$journalName}, and we hope to have the opportunity to work with you again in the future.</p>\n<p>Kind regards,</p>\n<p>{$signature}</p>'),
(33, 'EDITOR_DECISION_NEW_ROUND', 'en', 'New Review Round Initiated', 'Your submission has been sent for another round of review', '<p>Dear {$recipientName},</p>\n<p>Your revised submission, \"{$submissionTitle}\", has been sent for a new round of peer review. \nYou will hear from us with feedback from the reviewers and information about the next steps.</p>\n<p>If you have any questions, please contact me from your <a href=\"{$authorSubmissionUrl}\">submission dashboard</a>.</p>\n<p>Kind regards,</p>\n<p>{$signature}</p>\n'),
(34, 'EDITOR_DECISION_REVERT_DECLINE', 'en', 'Reinstate Declined Submission', 'We have reversed the decision to decline your submission', '<p>Dear {$recipientName},</p>\n<p>The decision to decline your submission, \"{$submissionTitle}\", has been reversed. \nAn editor will complete the round of review and you will be notified when a \ndecision is made.</p>\n<p>Occasionally, a decision to decline a submission will be recorded accidentally in \nour system and must be reverted. I apologize for any confusion this may have caused.</p>\n<p>We will contact you if we need any further assistance.</p>\n<p>If you have any questions, please contact me from your <a href=\"{$authorSubmissionUrl}\">submission dashboard</a>.</p>\n<p>Kind regards,</p>\n<p>{$signature}</p>\n'),
(35, 'EDITOR_DECISION_REVERT_INITIAL_DECLINE', 'en', 'Reinstate Submission Declined Without Review', 'We have reversed the decision to decline your submission', '<p>Dear {$recipientName},</p>\n<p>The decision to decline your submission, \"{$submissionTitle}\", has been reversed. \nAn editor will look further at your submission before deciding whether to decline \nthe submission or send it for review.</p>\n<p>Occasionally, a decision to decline a submission will be recorded accidentally in \nour system and must be reverted. I apologize for any confusion this may have caused.</p>\n<p>We will contact you if we need any further assistance.</p>\n<p>If you have any questions, please contact me from your <a href=\"{$authorSubmissionUrl}\">submission dashboard</a>.</p>\n<p>Kind regards,</p>\n<p>{$signature}</p>\n'),
(36, 'EDITOR_DECISION_SKIP_REVIEW', 'en', 'Submission Accepted (Without Review)', 'Your submission has been sent for copyediting', '<p>Dear {$recipientName},</p>\n<p>I am pleased to inform you that we have decided to accept your submission without peer review. We found your submission, {$submissionTitle}, to meet our expectations, and we do not require that work of this type undergo peer review. We are excited to publish your piece in {$journalName} and we thank you for choosing our journal as a venue for your work.</p>\nYour submission is now forthcoming in a future issue of {$journalName} and you are welcome to include it in your list of publications. We recognize the hard work that goes into every successful submission and we want to congratulate you on your efforts.</p>\n<p>Your submission will now undergo copy editing and formatting to prepare it for publication. </p>\n<p>You will shortly receive further instructions.</p>\n<p>If you have any questions, please contact me from your <a href=\"{$authorSubmissionUrl}\">submission dashboard</a>.</p>\n<p>Kind regards,</p>\n<p>{$signature}</p>\n'),
(37, 'EDITOR_DECISION_BACK_FROM_PRODUCTION', 'en', 'Submission Sent Back to Copyediting', 'Your submission has been sent back to copyediting', '<p>Dear {$recipientName},</p><p>Your submission, \"{$submissionTitle}\", has been sent back to the copyediting stage, where it will undergo further copyediting and formatting to prepare it for publication.</p><p>Occasionally, a submission is sent to the production stage before it is ready for the final galleys to be prepared for publication. Your submission is still forthcoming. I apologize for any confusion.</p><p>If you have any questions, please contact me from your <a href=\"{$authorSubmissionUrl}\">submission dashboard</a>.</p><p>We will contact you if we need any further assistance.</p><p>Kind regards,</p><p>{$signature}</p>'),
(38, 'EDITOR_DECISION_BACK_FROM_COPYEDITING', 'en', 'Submission Sent Back from Copyediting', 'Your submission has been sent back to review', '<p>Dear {$recipientName},</p><p>Your submission, \"{$submissionTitle}\", has been sent back to the review stage. It will undergo further review before it can be accepted for publication.</p><p>Occasionally, a decision to accept a submission will be recorded accidentally in our system and we must send it back to review. I apologize for any confusion this has caused. We will work to complete any further review quickly so that you have a final decision as soon as possible.</p><p>We will contact you if we need any further assistance.</p><p>If you have any questions, please contact me from your <a href=\"{$authorSubmissionUrl}\">submission dashboard</a>.</p><p>Kind regards,</p><p>{$signature}</p>'),
(39, 'EDITOR_DECISION_CANCEL_REVIEW_ROUND', 'en', 'Review Round Cancelled', 'A review round for your submission has been cancelled', '<p>Dear {$recipientName},</p><p>We recently opened a new review round for your submission, \"{$submissionTitle}\". We are closing this review round now.</p><p>Occasionally, a decision to open a round of review will be recorded accidentally in our system and we must cancel this review round. I apologize for any confusion this may have caused.</p><p>We will contact you if we need any further assistance.</p><p>If you have any questions, please contact me from your <a href=\"{$authorSubmissionUrl}\">submission dashboard</a>.</p><p>Kind regards,</p><p>{$signature}</p>'),
(40, 'SUBSCRIPTION_NOTIFY', 'en', 'Subscription Notify', 'Subscription Notification', '{$recipientName}:<br />\n<br />\nYou have now been registered as a subscriber in our online journal management system for {$journalName}, with the following subscription:<br />\n<br />\n{$subscriptionType}<br />\n<br />\nTo access content that is available only to subscribers, simply log in to the system with your username, &quot;{$recipientUsername}&quot;.<br />\n<br />\nOnce you have logged in to the system you can change your profile details and password at any point.<br />\n<br />\nPlease note that if you have an institutional subscription, there is no need for users at your institution to log in, since requests for subscription content will be automatically authenticated by the system.<br />\n<br />\nIf you have any questions, please feel free to contact me.<br />\n<br />\n{$subscriptionSignature}'),
(41, 'OPEN_ACCESS_NOTIFY', 'en', 'Open Access Notify', 'Free to read: {$issueIdentification} of {$journalName} is now open access', '<p>Dear {$recipientName},</p><p>We are pleased to inform you that <a href=\"{$issueUrl}\">{$issueIdentification}</a> of {$journalName} is now available under open access.  A subscription is no longer required to read this issue.</p><p>Thank you for your continuing interest in our work.</p>{$journalSignature}'),
(42, 'SUBSCRIPTION_BEFORE_EXPIRY', 'en', 'Subscription Expires Soon', 'Notice of Subscription Expiry', '{$recipientName}:<br />\n<br />\nYour {$journalName} subscription is about to expire.<br />\n<br />\n{$subscriptionType}<br />\nExpiry date: {$expiryDate}<br />\n<br />\nTo ensure the continuity of your access to this journal, please go to the journal website and renew your subscription. You are able to log in to the system with your username, &quot;{$recipientUsername}&quot;.<br />\n<br />\nIf you have any questions, please feel free to contact me.<br />\n<br />\n{$subscriptionSignature}'),
(43, 'SUBSCRIPTION_AFTER_EXPIRY', 'en', 'Subscription Expired', 'Subscription Expired', '{$recipientName}:<br />\n<br />\nYour {$journalName} subscription has expired.<br />\n<br />\n{$subscriptionType}<br />\nExpiry date: {$expiryDate}<br />\n<br />\nTo renew your subscription, please go to the journal website. You are able to log in to the system with your username, &quot;{$recipientUsername}&quot;.<br />\n<br />\nIf you have any questions, please feel free to contact me.<br />\n<br />\n{$subscriptionSignature}'),
(44, 'SUBSCRIPTION_AFTER_EXPIRY_LAST', 'en', 'Subscription Expired Last', 'Subscription Expired - Final Reminder', '{$recipientName}:<br />\n<br />\nYour {$journalName} subscription has expired.<br />\nPlease note that this is the final reminder that will be emailed to you.<br />\n<br />\n{$subscriptionType}<br />\nExpiry date: {$expiryDate}<br />\n<br />\nTo renew your subscription, please go to the journal website. You are able to log in to the system with your username, &quot;{$recipientUsername}&quot;.<br />\n<br />\nIf you have any questions, please feel free to contact me.<br />\n<br />\n{$subscriptionSignature}'),
(45, 'SUBSCRIPTION_PURCHASE_INDL', 'en', 'Purchase Individual Subscription', 'Subscription Purchase: Individual', 'An individual subscription has been purchased online for {$journalName} with the following details.<br />\n<br />\nSubscription Type:<br />\n{$subscriptionType}<br />\n<br />\nUser:<br />\n{$subscriberDetails}<br />\n<br />\nMembership Information (if provided):<br />\n{$membership}<br />\n<br />\nTo view or edit this subscription, please use the following URL.<br />\n<br />\nSubscription URL: {$subscriptionUrl}<br />\n'),
(46, 'SUBSCRIPTION_PURCHASE_INSTL', 'en', 'Purchase Institutional Subscription', 'Subscription Purchase: Institutional', 'An institutional subscription has been purchased online for {$journalName} with the following details. To activate this subscription, please use the provided Subscription URL and set the subscription status to \'Active\'.<br />\n<br />\nSubscription Type:<br />\n{$subscriptionType}<br />\n<br />\nInstitution:<br />\n{$institutionName}<br />\n{$institutionMailingAddress}<br />\n<br />\nDomain (if provided):<br />\n{$domain}<br />\n<br />\nIP Ranges (if provided):<br />\n{$ipRanges}<br />\n<br />\nContact Person:<br />\n{$subscriberDetails}<br />\n<br />\nMembership Information (if provided):<br />\n{$membership}<br />\n<br />\nTo view or edit this subscription, please use the following URL.<br />\n<br />\nSubscription URL: {$subscriptionUrl}<br />\n'),
(47, 'SUBSCRIPTION_RENEW_INDL', 'en', 'Renew Individual Subscription', 'Subscription Renewal: Individual', 'An individual subscription has been renewed online for {$journalName} with the following details.<br />\n<br />\nSubscription Type:<br />\n{$subscriptionType}<br />\n<br />\nUser:<br />\n{$subscriberDetails}<br />\n<br />\nMembership Information (if provided):<br />\n{$membership}<br />\n<br />\nTo view or edit this subscription, please use the following URL.<br />\n<br />\nSubscription URL: {$subscriptionUrl}<br />\n'),
(48, 'SUBSCRIPTION_RENEW_INSTL', 'en', 'Renew Institutional Subscription', 'Subscription Renewal: Institutional', 'An institutional subscription has been renewed online for {$journalName} with the following details.<br />\n<br />\nSubscription Type:<br />\n{$subscriptionType}<br />\n<br />\nInstitution:<br />\n{$institutionName}<br />\n{$institutionMailingAddress}<br />\n<br />\nDomain (if provided):<br />\n{$domain}<br />\n<br />\nIP Ranges (if provided):<br />\n{$ipRanges}<br />\n<br />\nContact Person:<br />\n{$subscriberDetails}<br />\n<br />\nMembership Information (if provided):<br />\n{$membership}<br />\n<br />\nTo view or edit this subscription, please use the following URL.<br />\n<br />\nSubscription URL: {$subscriptionUrl}<br />\n'),
(49, 'REVISED_VERSION_NOTIFY', 'en', 'Revised Version Notification', 'Revised Version Uploaded', '<p>Dear {$recipientName},</p><p>The author has uploaded revisions for the submission, <b>{$authorsShort} — {$submissionTitle}</b>. <p>As an assigned editor, we ask that you login and <a href=\"{$submissionUrl}\">view the revisions</a> and make a decision to accept, decline or send the submission for further review.</p><br><br>—<br>This is an automated message from <a href=\"{$journalUrl}\">{$journalName}</a>.'),
(50, 'STATISTICS_REPORT_NOTIFICATION', 'en', 'Statistics Report Notification', 'Editorial activity for {$month}, {$year}', '\n{$recipientName}, <br />\n<br />\nYour journal health report for {$month}, {$year} is now available. Your key stats for this month are below.<br />\n<ul>\n	<li>New submissions this month: {$newSubmissions}</li>\n	<li>Declined submissions this month: {$declinedSubmissions}</li>\n	<li>Accepted submissions this month: {$acceptedSubmissions}</li>\n	<li>Total submissions in the system: {$totalSubmissions}</li>\n</ul>\nLogin to the journal to view more detailed <a href=\"{$editorialStatsLink}\">editorial trends</a> and <a href=\"{$publicationStatsLink}\">published article stats</a>. A full copy of this month\'s editorial trends is attached.<br />\n<br />\nSincerely,<br />\n{$journalSignature}'),
(51, 'ANNOUNCEMENT', 'en', 'New Announcement', '{$announcementTitle}', '<b>{$announcementTitle}</b><br />\n<br />\n{$announcementSummary}<br />\n<br />\nVisit our website to read the <a href=\"{$announcementUrl}\">full announcement</a>.'),
(52, 'DISCUSSION_NOTIFICATION_SUBMISSION', 'en', 'Discussion (Submission)', 'A message regarding {$journalName}', 'Please enter your message.'),
(53, 'DISCUSSION_NOTIFICATION_REVIEW', 'en', 'Discussion (Review)', 'A message regarding {$journalName}', 'Please enter your message.'),
(54, 'DISCUSSION_NOTIFICATION_COPYEDITING', 'en', 'Discussion (Copyediting)', 'A message regarding {$journalName}', 'Please enter your message.'),
(55, 'DISCUSSION_NOTIFICATION_PRODUCTION', 'en', 'Discussion (Production)', 'A message regarding {$journalName}', 'Please enter your message.'),
(56, 'COPYEDIT_REQUEST', 'en', 'Request Copyedit', 'Submission {$submissionId} is ready to be copyedited for {$contextAcronym}', '<p>Dear {$recipientName},</p><p>A new submission is ready to be copyedited:</p><p><a href\"{$submissionUrl}\">{$submissionId} — \"{$submissionTitle}\"</a><br />{$journalName}</p><p>Please follow these steps to complete this task:</p><ol><li>Click on the Submission URL below.</li><li>Open any files available under Draft Files and edit the files. Use the Copyediting Discussions area if you need to contact the editor(s) or author(s).</li><li>Save the copyedited file(s) and upload them to the Copyedited panel.</li><li>Use the Copyediting Discussions to notify the editor(s) that all files have been prepared, and that the Production process may begin.</li></ol><p>If you are unable to undertake this work at this time or have any questions, please contact me. Thank you for your contribution to {$journalName}.</p><p>Kind regards,</p>{$signature}'),
(57, 'EDITOR_ASSIGN_SUBMISSION', 'en', 'Assign Editor', 'You have been assigned as an editor on a submission to {$journalName}', '<p>Dear {$recipientName},</p><p>The following submission has been assigned to you to see through the editorial process.</p><p><a href=\"{$submissionUrl}\">{$submissionTitle}</a><br />{$authors}</p><p><b>Abstract</b></p>{$submissionAbstract}<p>If you find the submission to be relevant for {$journalName}, please forward the submission to the review stage by selecting \"Send to Review\" and then assign reviewers by clicking \"Add Reviewer\".</p><p>If the submission is not appropriate for this journal, please decline the submission.</p><p>Thank you in advance.</p><p>Kind regards,</p>{$journalSignature}'),
(58, 'EDITOR_ASSIGN_REVIEW', 'en', 'Assign Editor', 'You have been assigned as an editor on a submission to {$journalName}', '<p>Dear {$recipientName},</p><p>The following submission has been assigned to you to see through the peer review process.</p><p><a href=\"{$submissionUrl}\">{$submissionTitle}</a><br />{$authors}</p><p><b>Abstract</b></p>{$submissionAbstract}<p>Please login to <a href=\"{$submissionUrl}\">view the submission</a> and assign qualified reviewers. You can assign a reviewer by clicking \"Add Reviewer\".</p><p>Thank you in advance.</p><p>Kind regards,</p>{$signature}'),
(59, 'EDITOR_ASSIGN_PRODUCTION', 'en', 'Assign Editor', 'You have been assigned as an editor on a submission to {$journalName}', '<p>Dear {$recipientName},</p><p>The following submission has been assigned to you to see through the production stage.</p><p><a href=\"{$submissionUrl}\">{$submissionTitle}</a><br />{$authors}</p><p><b>Abstract</b></p>{$submissionAbstract}<p>Please login to <a href=\"{$submissionUrl}\">view the submission</a>. Once production-ready files are available, upload them under the <strong>Publication > Galleys</strong> section. Then schedule the work for publication by clicking the <strong>Schedule for Publication</strong> button.</p><p>Thank you in advance.</p><p>Kind regards,</p>{$signature}'),
(60, 'LAYOUT_REQUEST', 'en', 'Ready for Production', 'Submission {$submissionId} is ready for production at {$contextAcronym}', '<p>Dear {$recipientName},</p><p>A new submission is ready for layout editing:</p><p><a href=\"{$submissionUrl}\">{$submissionId} — {$submissionTitle}</a><br />{$journalName}</p><ol><li>Click on the Submission URL above.</li><li>Download the Production Ready files and use them to create the galleys according to the journal\'s standards.</li><li>Upload the galleys to the Publication section of the submission.</li><li>Use the  Production Discussions to notify the editor that the galleys are ready.</li></ol><p>If you are unable to undertake this work at this time or have any questions, please contact me. Thank you for your contribution to this journal.</p><p>Kind regards,</p>{$signature}'),
(61, 'LAYOUT_COMPLETE', 'en', 'Galleys Complete', 'Galleys Complete', '<p>Dear {$recipientName},</p><p>Galleys have now been prepared for the following submission and are ready for final review.</p><p><a href=\"{$submissionUrl}\">{$submissionTitle}</a><br />{$journalName}</p><p>If you have any questions, please contact me.</p><p>Kind regards,</p><p>{$signature}</p>'),
(62, 'VERSION_CREATED', 'en', 'Version Created', 'A new version was created for \"{$submissionTitle}\"', '<p>Dear {$recipientName}, </p><p>This is an automated message to inform you that a new version of your submission, \"{$submissionTitle}\", was created. You can view this version from your submission dashboard at the following link:</p><p><a href=\"{$submissionUrl}\">\"{$submissionTitle}\"</a></p><hr><p>This is an automatic email sent from <a href=\"{$journalUrl}\">{$journalName}</a>.</p>'),
(63, 'EDITORIAL_REMINDER', 'en', 'Editorial Reminder', 'Outstanding editorial tasks for {$journalName}', '<p>Dear {$recipientName},</p><p>You are currently assigned to {$numberOfSubmissions} submissions in <a href=\"{$journalUrl}\">{$journalName}</a>. The following submissions are <b>waiting for your response</b>.</p>{$outstandingTasks}<p>View all of your assignments in your <a href=\"{$submissionsUrl}\">submission dashboard</a>.</p><p>If you have any questions about your assignments, please contact {$contactName} at {$contactEmail}.</p>'),
(64, 'SUBMISSION_SAVED_FOR_LATER', 'en', 'Submission Saved for Later', 'Resume your submission to {$journalName}', '<p>Dear {$recipientName},</p><p>Your submission details have been saved in our system, but it has not yet been submitted for consideration. You can return to complete your submission at any time by following the link below.</p><p><a href=\"{$submissionWizardUrl}\">{$authorsShort} — \"{$submissionTitle}\"</a></p><hr><p>This is an automated email from <a href=\"{$journalUrl}\">{$journalName}</a>.</p>'),
(65, 'SUBMISSION_NEEDS_EDITOR', 'en', 'Submission Needs Editor', 'A new submission needs an editor to be assigned: \"{$submissionTitle}\"', '<p>Dear {$recipientName},</p><p>The following submission has been submitted and there is no editor assigned.</p><p><a href=\"{$submissionUrl}\">\"{$submissionTitle}\"</a><br />{$authors}</p><p><b>Abstract</b></p>{$submissionAbstract}<p>Please assign an editor who will be responsible for the submission by clicking the title above and assigning an editor under the Participants section.</p><hr><p>This is an automated email from <a href=\"{$journalUrl}\">{$journalName}</a>.</p>'),
(66, 'PAYMENT_REQUEST_NOTIFICATION', 'en', 'Payment Request', 'Payment Request Notification', '<p>Dear {$recipientName},</p><p>Congratulations on the acceptance of your submission, {$submissionTitle}, to {$journalName}. Now that your submission has been accepted, we would like to request payment of the publication fee.</p><p>This fee covers the production costs of bringing your submission to publication. To make the payment, please visit <a href=\"{$queuedPaymentUrl}\">{$queuedPaymentUrl}</a>.</p><p>If you have any questions, please see our <a href=\"{$submissionGuidelinesUrl}\">Submission Guidelines</a></p>'),
(67, 'CHANGE_EMAIL', 'en', 'Change Email Address Invitation', 'Confirm account contact email change request', '<p>Dear {$recipientName},</p><p>You are receiving this email because someone has requested a change of your email to {$newEmail}.</p><p>If you have made this request please <a href=\"{$acceptInvitationUrl}\">confirm</a> the email change.</p><p>You can always <a href=\"{$declineInvitationUrl}\">reject</a> this email change.</p><p>Please feel free to contact me with any questions about the submission or the review process.</p><p>Kind regards,</p>{$siteContactName}'),
(68, 'ORCID_COLLECT_AUTHOR_ID', 'en', 'orcidCollectAuthorId', 'Submission ORCID', 'Dear {$recipientName},<br/>\n<br/>\nYou have been listed as an author on a manuscript submission to {$journalName}.<br/>\nTo confirm your authorship, please add your ORCID id to this submission by visiting the link provided below.<br/>\n<br/>\n<a href=\"{$authorOrcidUrl}\"><img id=\"orcid-id-logo\" src=\"https://info.orcid.org/wp-content/uploads/2020/12/ORCIDiD_icon16x16.png\" width=\'16\' height=\'16\' alt=\"ORCID iD icon\" style=\"display: block; margin: 0 .5em 0 0; padding: 0; float: left;\"/>Register or connect your ORCID iD</a><br/>\n<br/>\n<br>\n<a href=\"{$orcidAboutUrl}\">More information about ORCID at {$journalName}</a><br/>\n<br/>\nIf you have any questions, please contact me.<br/>\n<br/>\n{$principalContactSignature}<br/>\n'),
(69, 'ORCID_REQUEST_AUTHOR_AUTHORIZATION', 'en', 'orcidRequestAuthorAuthorization', 'Requesting ORCID record access', 'Dear {$recipientName},<br>\n<br>\nYou have been listed as an author on the manuscript submission \"{$submissionTitle}\" to {$journalName}.\n<br>\n<br>\nPlease allow us to add your ORCID id to this submission and also to add the submission to your ORCID profile on publication.<br>\nVisit the link to the official ORCID website, login with your profile and authorize the access by following the instructions.<br>\n<br>\n<a href=\"{$authorOrcidUrl}\" style=\"display: inline-flex; align-items: center; background-color: white; text-align: center; padding: 10px 20px; text-decoration: none; border-radius: 5px; border: 2px solid #d7d4d4;\"><img id=\"orcid-id-logo\" src=\"https://info.orcid.org/wp-content/uploads/2020/12/ORCIDiD_icon16x16.png\" width=\'16\' height=\'16\' alt=\"ORCID iD icon\" style=\"display: block; margin: 0 .5em 0 0; padding: 0; float: left;\"/>Register or Connect your ORCID iD</a><br/>\n<br>\n<br>\nClick here to verify your account with ORCID: <a href=\"{$authorOrcidUrl}\">{$authorOrcidUrl}.</a>\n<br>\n<br>\n<a href=\"{$orcidAboutUrl}\">More about ORCID at {$journalName}</a><br/>\n<br>\n<br>\nIf you have any questions, please contact me.<br>\n<br>\n{$principalContactSignature}<br>\n'),
(70, 'USER_ROLE_ASSIGNMENT_INVITATION', 'en', 'User Invited to Role Notification', 'You are invited to new roles', '<div class=\'email-container\'>    <div class=\'email-header\'>        <h2>Invitation to New Role</h2>    </div>    <div class=\'email-content\'>        <p>Dear {$recipientName},</p>        <p>In light of your expertise, you have been invited by {$inviterName} to take on new roles at {$journalName}</p>        <p>At {$journalName}, we value your privacy. As such, we have taken steps to ensure that we are fully GDPR compliant. These steps include you being accountable to enter your own data and choosing who can see what information. For additional information on how we handled your data, please refer to our Privacy Policy.</p>        <div>{$existingRoles}</div>        <div>{$rolesAdded}</div>        <p>On accepting the invite, you will be redirected to {$journalName}.</p>        <p>Feel free to contact me with any questions about the process.</p>        <p><a href=\'{$acceptUrl}\' class=\'btn btn-accept\'>Accept Invitation</a></p>        <p><a href=\'{$declineUrl}\' class=\'btn btn-decline\'>Decline Invitation</a></p>        <p>Kind regards,</p>        <p>{$journalName}</p>    </div></div><style>{$emailTemplateStyle}</style>'),
(71, 'USER_ROLE_END', 'en', 'User Role Ended Notification', 'You have been removed from a role', '<div class=\'email-container\'>    <div class=\'email-header\'>        <h2>Removed from a Role</h2>    </div>    <div class=\'email-content\'>        <p>Dear {$recipientName},</p>        <p>Thank you very much for your participation in the role of {$roleRemoved} at {$journalName}.</p>        <p>This is a notice to let you know that you have been removed from the following role at {$journalName}: <b>{$roleRemoved}</b>.</p>        <p>Your account with {$journalName} is still active and any other roles you previously held are still active.</p>        <p>Feel free to contact me with any questions about the process.</p>        <p>Kind regards,</p>        <p>{$journalName}</p>    </div></div><style>{$emailTemplateStyle}</style>');
INSERT INTO `email_templates_default_data` (`email_templates_default_data_id`, `email_key`, `locale`, `name`, `subject`, `body`) VALUES
(72, 'ORCID_REQUEST_UPDATE_SCOPE', 'en', 'orcidRequestUpdateScope', 'Requesting updated ORCID record access', 'Dear {$recipientName},<br>\n<br>\nYou are listed as a contributor (author or reviewer) on the manuscript submission \"{$submissionTitle}\" to {$journalName}.\n<br>\n<br>\nYou have previously authorized {$journalName} to list your ORCID id on the site, and we require updateded permissions to add your contribution to your ORCID profile.<br>\nVisit the link to the official ORCID website, login with your profile and authorize the access by following the instructions.<br>\n<br>\n<a href=\"{$authorOrcidUrl}\" style=\"display: inline-flex; align-items: center; background-color: white; text-align: center; padding: 10px 20px; text-decoration: none; border-radius: 5px; border: 2px solid #d7d4d4;\"><img id=\"orcid-id-logo\" src=\"https://info.orcid.org/wp-content/uploads/2020/12/ORCIDiD_icon16x16.png\" width=\'16\' height=\'16\' alt=\"ORCID iD icon\" style=\"display: block; margin: 0 .5em 0 0; padding: 0; float: left;\"/>Register or Connect your ORCID iD</a><br/>\n<br>\n<br>\nClick here to update your account with ORCID: <a href=\"{$authorOrcidUrl}\">{$authorOrcidUrl}.</a>\n<br>\n<br>\n<a href=\"{$orcidAboutUrl}\">More about ORCID at {$journalName}</a><br/>\n<br>\n<br>\nIf you have any questions, please contact me.<br>\n<br>\n{$principalContactSignature}<br>\n'),
(73, 'MANUAL_PAYMENT_NOTIFICATION', 'en', 'Manual Payment Notify', 'Manual Payment Notification', 'A manual payment needs to be processed for the journal {$journalName} and the user &quot;{$senderUsername}&quot;.<br />\n<br />\nThe item being paid for is &quot;{$paymentName}&quot;.<br />\nThe cost is {$paymentAmount} ({$paymentCurrencyCode}).<br />\n<br />\nThis email was generated by Open Journal Systems\' Manual Payment plugin.');

-- --------------------------------------------------------

--
-- Table structure for table `email_templates_settings`
--

CREATE TABLE `email_templates_settings` (
  `email_template_setting_id` bigint(20) UNSIGNED NOT NULL,
  `email_id` bigint(20) NOT NULL,
  `locale` varchar(28) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='More data about custom email templates, including localized properties such as the subject and body.';

-- --------------------------------------------------------

--
-- Table structure for table `event_log`
--

CREATE TABLE `event_log` (
  `log_id` bigint(20) NOT NULL,
  `assoc_type` bigint(20) NOT NULL,
  `assoc_id` bigint(20) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL COMMENT 'NULL if it''s system or automated event',
  `date_logged` datetime NOT NULL,
  `event_type` bigint(20) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `is_translated` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='A log of all events related to an object like a submission.';

--
-- Dumping data for table `event_log`
--

INSERT INTO `event_log` (`log_id`, `assoc_type`, `assoc_id`, `user_id`, `date_logged`, `event_type`, `message`, `is_translated`) VALUES
(1, 1048585, 1, 1, '2025-11-16 01:17:36', 268435458, 'submission.event.general.metadataUpdated', 0),
(2, 1048585, 1, 1, '2025-11-16 01:17:37', 268435458, 'submission.event.general.metadataUpdated', 0),
(3, 1048585, 1, 1, '2025-11-16 01:19:05', 268435458, 'submission.event.general.metadataUpdated', 0),
(4, 1048585, 1, 1, '2025-11-16 01:19:42', 268435458, 'submission.event.general.metadataUpdated', 0),
(5, 1048585, 1, 1, '2025-11-16 01:20:01', 268435458, 'submission.event.general.metadataUpdated', 0),
(6, 515, 1, 1, '2025-11-16 01:21:15', 1342177281, 'submission.event.fileUploaded', 0),
(7, 1048585, 1, 1, '2025-11-16 01:21:15', 1342177288, 'submission.event.fileRevised', 0),
(8, 515, 1, 1, '2025-11-16 01:21:17', 1342177296, 'submission.event.fileEdited', 0),
(9, 1048585, 1, 1, '2025-11-16 01:21:49', 268435458, 'submission.event.general.metadataUpdated', 0),
(10, 1048585, 1, 12, '2025-11-16 01:22:53', 268435458, 'submission.event.general.metadataUpdated', 0),
(11, 1048585, 1, 1, '2025-11-16 01:28:15', 268435458, 'submission.event.general.metadataUpdated', 0),
(12, 1048585, 1, 1, '2025-11-16 01:29:21', 268435458, 'submission.event.general.metadataUpdated', 0),
(13, 1048585, 1, 1, '2025-11-16 01:29:44', 268435457, 'submission.event.submissionSubmitted', 0);

-- --------------------------------------------------------

--
-- Table structure for table `event_log_settings`
--

CREATE TABLE `event_log_settings` (
  `event_log_setting_id` bigint(20) UNSIGNED NOT NULL,
  `log_id` bigint(20) NOT NULL,
  `locale` varchar(28) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Data about an event log entry. This data is commonly used to display information about an event to a user.';

--
-- Dumping data for table `event_log_settings`
--

INSERT INTO `event_log_settings` (`event_log_setting_id`, `log_id`, `locale`, `setting_name`, `setting_value`) VALUES
(1, 6, '', 'fileId', '1'),
(2, 6, 'en', 'filename', 'dummy.docx'),
(3, 6, '', 'fileStage', '2'),
(4, 6, '', 'submissionFileId', '1'),
(5, 6, '', 'submissionId', '1'),
(6, 6, '', 'username', 'author-1'),
(7, 7, '', 'fileId', '1'),
(8, 7, 'en', 'filename', 'dummy.docx'),
(9, 7, '', 'fileStage', '2'),
(10, 7, '', 'submissionFileId', '1'),
(11, 7, '', 'submissionId', '1'),
(12, 7, '', 'username', 'author-1'),
(13, 8, '', 'fileId', '1'),
(14, 8, 'en', 'filename', 'dummy.docx'),
(15, 8, '', 'fileStage', '2'),
(16, 8, '', 'submissionFileId', '1'),
(17, 8, '', 'submissionId', '1'),
(18, 8, '', 'username', 'author-1');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='A log of all failed jobs.';

-- --------------------------------------------------------

--
-- Table structure for table `files`
--

CREATE TABLE `files` (
  `file_id` bigint(20) UNSIGNED NOT NULL,
  `path` varchar(255) NOT NULL,
  `mimetype` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Records information in the database about files tracked by the system, linking them to the local filesystem.';

--
-- Dumping data for table `files`
--

INSERT INTO `files` (`file_id`, `path`, `mimetype`) VALUES
(1, 'journals/1/articles/1/691918fb2af1d.docx', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document');

-- --------------------------------------------------------

--
-- Table structure for table `filters`
--

CREATE TABLE `filters` (
  `filter_id` bigint(20) NOT NULL,
  `filter_group_id` bigint(20) NOT NULL,
  `context_id` bigint(20) DEFAULT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `class_name` varchar(255) DEFAULT NULL,
  `is_template` smallint(6) NOT NULL DEFAULT 0,
  `parent_filter_id` bigint(20) DEFAULT NULL,
  `seq` bigint(20) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Filters represent a transformation of a supported piece of data from one form to another, such as a PHP object into an XML document.';

--
-- Dumping data for table `filters`
--

INSERT INTO `filters` (`filter_id`, `filter_group_id`, `context_id`, `display_name`, `class_name`, `is_template`, `parent_filter_id`, `seq`) VALUES
(1, 1, NULL, 'DataCite XML export', 'APP\\plugins\\generic\\datacite\\filter\\DataciteXmlFilter', 0, NULL, 0),
(2, 2, NULL, 'DataCite XML export', 'APP\\plugins\\generic\\datacite\\filter\\DataciteXmlFilter', 0, NULL, 0),
(3, 3, NULL, 'DataCite XML export', 'APP\\plugins\\generic\\datacite\\filter\\DataciteXmlFilter', 0, NULL, 0),
(4, 4, NULL, 'Crossref XML issue export', 'APP\\plugins\\generic\\crossref\\filter\\IssueCrossrefXmlFilter', 0, NULL, 0),
(5, 5, NULL, 'Crossref XML article export', 'APP\\plugins\\generic\\crossref\\filter\\ArticleCrossrefXmlFilter', 0, NULL, 0),
(6, 6, NULL, 'Extract metadata from a(n) Submission', 'APP\\plugins\\metadata\\dc11\\filter\\Dc11SchemaArticleAdapter', 0, NULL, 0),
(7, 7, NULL, 'User XML user export', 'PKP\\plugins\\importexport\\users\\filter\\PKPUserUserXmlFilter', 0, NULL, 0),
(8, 8, NULL, 'User XML user import', 'PKP\\plugins\\importexport\\users\\filter\\UserXmlPKPUserFilter', 0, NULL, 0),
(9, 9, NULL, 'Native XML user group export', 'PKP\\plugins\\importexport\\users\\filter\\UserGroupNativeXmlFilter', 0, NULL, 0),
(10, 10, NULL, 'Native XML user group import', 'PKP\\plugins\\importexport\\users\\filter\\NativeXmlUserGroupFilter', 0, NULL, 0),
(11, 11, NULL, 'DOAJ XML export', 'APP\\plugins\\importexport\\doaj\\filter\\DOAJXmlFilter', 0, NULL, 0),
(12, 12, NULL, 'DOAJ JSON export', 'APP\\plugins\\importexport\\doaj\\filter\\DOAJJsonFilter', 0, NULL, 0),
(13, 13, NULL, 'Native XML submission export', 'APP\\plugins\\importexport\\native\\filter\\ArticleNativeXmlFilter', 0, NULL, 0),
(14, 14, NULL, 'Native XML submission import', 'APP\\plugins\\importexport\\native\\filter\\NativeXmlArticleFilter', 0, NULL, 0),
(15, 15, NULL, 'Native XML issue export', 'APP\\plugins\\importexport\\native\\filter\\IssueNativeXmlFilter', 0, NULL, 0),
(16, 16, NULL, 'Native XML issue import', 'APP\\plugins\\importexport\\native\\filter\\NativeXmlIssueFilter', 0, NULL, 0),
(17, 17, NULL, 'Native XML issue galley export', 'APP\\plugins\\importexport\\native\\filter\\IssueGalleyNativeXmlFilter', 0, NULL, 0),
(18, 18, NULL, 'Native XML issue galley import', 'APP\\plugins\\importexport\\native\\filter\\NativeXmlIssueGalleyFilter', 0, NULL, 0),
(19, 19, NULL, 'Native XML author export', 'APP\\plugins\\importexport\\native\\filter\\AuthorNativeXmlFilter', 0, NULL, 0),
(20, 20, NULL, 'Native XML author import', 'APP\\plugins\\importexport\\native\\filter\\NativeXmlAuthorFilter', 0, NULL, 0),
(21, 22, NULL, 'Native XML submission file import', 'APP\\plugins\\importexport\\native\\filter\\NativeXmlArticleFileFilter', 0, NULL, 0),
(22, 21, NULL, 'Native XML submission file export', 'PKP\\plugins\\importexport\\native\\filter\\SubmissionFileNativeXmlFilter', 0, NULL, 0),
(23, 23, NULL, 'Native XML representation export', 'APP\\plugins\\importexport\\native\\filter\\ArticleGalleyNativeXmlFilter', 0, NULL, 0),
(24, 24, NULL, 'Native XML representation import', 'APP\\plugins\\importexport\\native\\filter\\NativeXmlArticleGalleyFilter', 0, NULL, 0),
(25, 25, NULL, 'Native XML Publication export', 'APP\\plugins\\importexport\\native\\filter\\PublicationNativeXmlFilter', 0, NULL, 0),
(26, 26, NULL, 'Native XML publication import', 'APP\\plugins\\importexport\\native\\filter\\NativeXmlPublicationFilter', 0, NULL, 0),
(27, 27, NULL, 'APP\\plugins\\importexport\\pubmed\\filter\\ArticlePubMedXmlFilter', 'APP\\plugins\\importexport\\pubmed\\filter\\ArticlePubMedXmlFilter', 0, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `filter_groups`
--

CREATE TABLE `filter_groups` (
  `filter_group_id` bigint(20) NOT NULL,
  `symbolic` varchar(255) DEFAULT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `input_type` varchar(255) DEFAULT NULL,
  `output_type` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Filter groups are used to organized filters into named sets, which can be retrieved by the application for invocation.';

--
-- Dumping data for table `filter_groups`
--

INSERT INTO `filter_groups` (`filter_group_id`, `symbolic`, `display_name`, `description`, `input_type`, `output_type`) VALUES
(1, 'issue=>datacite-xml', 'plugins.importexport.datacite.displayName', 'plugins.importexport.datacite.description', 'class::classes.issue.Issue', 'xml::schema(http://schema.datacite.org/meta/kernel-4/metadata.xsd)'),
(2, 'article=>datacite-xml', 'plugins.importexport.datacite.displayName', 'plugins.importexport.datacite.description', 'class::classes.submission.Submission', 'xml::schema(http://schema.datacite.org/meta/kernel-4/metadata.xsd)'),
(3, 'galley=>datacite-xml', 'plugins.importexport.datacite.displayName', 'plugins.importexport.datacite.description', 'class::lib.pkp.classes.galley.Galley', 'xml::schema(http://schema.datacite.org/meta/kernel-4/metadata.xsd)'),
(4, 'issue=>crossref-xml', 'plugins.importexport.crossref.displayName', 'plugins.importexport.crossref.description', 'class::classes.issue.Issue[]', 'xml::schema(https://www.crossref.org/schemas/crossref5.4.0.xsd)'),
(5, 'article=>crossref-xml', 'plugins.importexport.crossref.displayName', 'plugins.importexport.crossref.description', 'class::classes.submission.Submission[]', 'xml::schema(https://www.crossref.org/schemas/crossref5.4.0.xsd)'),
(6, 'article=>dc11', 'plugins.metadata.dc11.articleAdapter.displayName', 'plugins.metadata.dc11.articleAdapter.description', 'class::classes.submission.Submission', 'metadata::APP\\plugins\\metadata\\dc11\\schema\\Dc11Schema(ARTICLE)'),
(7, 'user=>user-xml', 'plugins.importexport.users.displayName', 'plugins.importexport.users.description', 'class::PKP\\user\\User[]', 'xml::schema(lib/pkp/plugins/importexport/users/pkp-users.xsd)'),
(8, 'user-xml=>user', 'plugins.importexport.users.displayName', 'plugins.importexport.users.description', 'xml::schema(lib/pkp/plugins/importexport/users/pkp-users.xsd)', 'class::PKP\\user\\User[]'),
(9, 'usergroup=>user-xml', 'plugins.importexport.users.displayName', 'plugins.importexport.users.description', 'class::PKP\\userGroup\\UserGroup[]', 'xml::schema(lib/pkp/plugins/importexport/users/pkp-users.xsd)'),
(10, 'user-xml=>usergroup', 'plugins.importexport.native.displayName', 'plugins.importexport.native.description', 'xml::schema(lib/pkp/plugins/importexport/users/pkp-users.xsd)', 'class::PKP\\userGroup\\UserGroup[]'),
(11, 'article=>doaj-xml', 'plugins.importexport.doaj.displayName', 'plugins.importexport.doaj.description', 'class::classes.submission.Submission[]', 'xml::schema(plugins/importexport/doaj/doajArticles.xsd)'),
(12, 'article=>doaj-json', 'plugins.importexport.doaj.displayName', 'plugins.importexport.doaj.description', 'class::classes.submission.Submission', 'primitive::string'),
(13, 'article=>native-xml', 'plugins.importexport.native.displayName', 'plugins.importexport.native.description', 'class::classes.submission.Submission[]', 'xml::schema(plugins/importexport/native/native.xsd)'),
(14, 'native-xml=>article', 'plugins.importexport.native.displayName', 'plugins.importexport.native.description', 'xml::schema(plugins/importexport/native/native.xsd)', 'class::classes.submission.Submission[]'),
(15, 'issue=>native-xml', 'plugins.importexport.native.displayName', 'plugins.importexport.native.description', 'class::classes.issue.Issue[]', 'xml::schema(plugins/importexport/native/native.xsd)'),
(16, 'native-xml=>issue', 'plugins.importexport.native.displayName', 'plugins.importexport.native.description', 'xml::schema(plugins/importexport/native/native.xsd)', 'class::classes.issue.Issue[]'),
(17, 'issuegalley=>native-xml', 'plugins.importexport.native.displayName', 'plugins.importexport.native.description', 'class::classes.issue.IssueGalley[]', 'xml::schema(plugins/importexport/native/native.xsd)'),
(18, 'native-xml=>issuegalley', 'plugins.importexport.native.displayName', 'plugins.importexport.native.description', 'xml::schema(plugins/importexport/native/native.xsd)', 'class::classes.issue.IssueGalley[]'),
(19, 'author=>native-xml', 'plugins.importexport.native.displayName', 'plugins.importexport.native.description', 'class::classes.author.Author[]', 'xml::schema(plugins/importexport/native/native.xsd)'),
(20, 'native-xml=>author', 'plugins.importexport.native.displayName', 'plugins.importexport.native.description', 'xml::schema(plugins/importexport/native/native.xsd)', 'class::classes.author.Author[]'),
(21, 'SubmissionFile=>native-xml', 'plugins.importexport.native.displayName', 'plugins.importexport.native.description', 'class::lib.pkp.classes.submissionFile.SubmissionFile', 'xml::schema(plugins/importexport/native/native.xsd)'),
(22, 'native-xml=>SubmissionFile', 'plugins.importexport.native.displayName', 'plugins.importexport.native.description', 'xml::schema(plugins/importexport/native/native.xsd)', 'class::lib.pkp.classes.submissionFile.SubmissionFile[]'),
(23, 'article-galley=>native-xml', 'plugins.importexport.native.displayName', 'plugins.importexport.native.description', 'class::lib.pkp.classes.galley.Galley', 'xml::schema(plugins/importexport/native/native.xsd)'),
(24, 'native-xml=>ArticleGalley', 'plugins.importexport.native.displayName', 'plugins.importexport.native.description', 'xml::schema(plugins/importexport/native/native.xsd)', 'class::lib.pkp.classes.galley.Galley[]'),
(25, 'publication=>native-xml', 'plugins.importexport.native.displayName', 'plugins.importexport.native.description', 'class::classes.publication.Publication', 'xml::schema(plugins/importexport/native/native.xsd)'),
(26, 'native-xml=>Publication', 'plugins.importexport.native.displayName', 'plugins.importexport.native.description', 'xml::schema(plugins/importexport/native/native.xsd)', 'class::classes.publication.Publication[]'),
(27, 'article=>pubmed-xml', 'plugins.importexport.pubmed.displayName', 'plugins.importexport.pubmed.description', 'class::classes.submission.Submission[]', 'xml::dtd');

-- --------------------------------------------------------

--
-- Table structure for table `filter_settings`
--

CREATE TABLE `filter_settings` (
  `filter_setting_id` bigint(20) UNSIGNED NOT NULL,
  `filter_id` bigint(20) NOT NULL,
  `locale` varchar(28) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL,
  `setting_type` varchar(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='More data about filters, including localized content.';

-- --------------------------------------------------------

--
-- Table structure for table `genres`
--

CREATE TABLE `genres` (
  `genre_id` bigint(20) NOT NULL,
  `context_id` bigint(20) NOT NULL,
  `seq` bigint(20) NOT NULL,
  `enabled` smallint(6) NOT NULL DEFAULT 1,
  `category` bigint(20) NOT NULL DEFAULT 1,
  `dependent` smallint(6) NOT NULL DEFAULT 0,
  `supplementary` smallint(6) NOT NULL DEFAULT 0,
  `required` smallint(6) NOT NULL DEFAULT 0 COMMENT 'Whether or not at least one file of this genre is required for a new submission.',
  `entry_key` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='The types of submission files configured for each context, such as Article Text, Data Set, Transcript, etc.';

--
-- Dumping data for table `genres`
--

INSERT INTO `genres` (`genre_id`, `context_id`, `seq`, `enabled`, `category`, `dependent`, `supplementary`, `required`, `entry_key`) VALUES
(1, 1, 0, 1, 1, 0, 0, 1, 'SUBMISSION'),
(2, 1, 1, 1, 3, 0, 1, 0, 'RESEARCHINSTRUMENT'),
(3, 1, 2, 1, 3, 0, 1, 0, 'RESEARCHMATERIALS'),
(4, 1, 3, 1, 3, 0, 1, 0, 'RESEARCHRESULTS'),
(5, 1, 4, 1, 3, 0, 1, 0, 'TRANSCRIPTS'),
(6, 1, 5, 1, 3, 0, 1, 0, 'DATAANALYSIS'),
(7, 1, 6, 1, 3, 0, 1, 0, 'DATASET'),
(8, 1, 7, 1, 3, 0, 1, 0, 'SOURCETEXTS'),
(9, 1, 8, 1, 1, 1, 1, 0, 'MULTIMEDIA'),
(10, 1, 9, 1, 2, 1, 0, 0, 'IMAGE'),
(11, 1, 10, 1, 1, 1, 0, 0, 'STYLE'),
(12, 1, 11, 1, 3, 0, 1, 0, 'OTHER');

-- --------------------------------------------------------

--
-- Table structure for table `genre_settings`
--

CREATE TABLE `genre_settings` (
  `genre_setting_id` bigint(20) UNSIGNED NOT NULL,
  `genre_id` bigint(20) NOT NULL,
  `locale` varchar(28) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL,
  `setting_type` varchar(6) NOT NULL COMMENT '(bool|int|float|string|object)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='More data about file genres, including localized properties such as the genre name.';

--
-- Dumping data for table `genre_settings`
--

INSERT INTO `genre_settings` (`genre_setting_id`, `genre_id`, `locale`, `setting_name`, `setting_value`, `setting_type`) VALUES
(1, 1, 'en', 'name', 'Article Text', 'string'),
(2, 2, 'en', 'name', 'Research Instrument', 'string'),
(3, 3, 'en', 'name', 'Research Materials', 'string'),
(4, 4, 'en', 'name', 'Research Results', 'string'),
(5, 5, 'en', 'name', 'Transcripts', 'string'),
(6, 6, 'en', 'name', 'Data Analysis', 'string'),
(7, 7, 'en', 'name', 'Data Set', 'string'),
(8, 8, 'en', 'name', 'Source Texts', 'string'),
(9, 9, 'en', 'name', 'Multimedia', 'string'),
(10, 10, 'en', 'name', 'Image', 'string'),
(11, 11, 'en', 'name', 'HTML Stylesheet', 'string'),
(12, 12, 'en', 'name', 'Other', 'string');

-- --------------------------------------------------------

--
-- Table structure for table `highlights`
--

CREATE TABLE `highlights` (
  `highlight_id` bigint(20) NOT NULL,
  `context_id` bigint(20) DEFAULT NULL,
  `sequence` bigint(20) NOT NULL,
  `url` varchar(2047) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Highlights are featured items that can be presented to users, for example on the homepage.';

-- --------------------------------------------------------

--
-- Table structure for table `highlight_settings`
--

CREATE TABLE `highlight_settings` (
  `highlight_setting_id` bigint(20) UNSIGNED NOT NULL,
  `highlight_id` bigint(20) NOT NULL,
  `locale` varchar(28) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='More data about highlights, including localized properties like title and description.';

-- --------------------------------------------------------

--
-- Table structure for table `institutional_subscriptions`
--

CREATE TABLE `institutional_subscriptions` (
  `institutional_subscription_id` bigint(20) NOT NULL,
  `subscription_id` bigint(20) NOT NULL,
  `institution_id` bigint(20) NOT NULL,
  `mailing_address` varchar(255) DEFAULT NULL,
  `domain` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='A list of institutional subscriptions, linking a subscription with an institution.';

-- --------------------------------------------------------

--
-- Table structure for table `institutions`
--

CREATE TABLE `institutions` (
  `institution_id` bigint(20) NOT NULL,
  `context_id` bigint(20) NOT NULL,
  `ror` varchar(255) DEFAULT NULL COMMENT 'ROR (Research Organization Registry) ID',
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Institutions for statistics and subscriptions.';

-- --------------------------------------------------------

--
-- Table structure for table `institution_ip`
--

CREATE TABLE `institution_ip` (
  `institution_ip_id` bigint(20) NOT NULL,
  `institution_id` bigint(20) NOT NULL,
  `ip_string` varchar(40) NOT NULL,
  `ip_start` bigint(20) NOT NULL,
  `ip_end` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Records IP address ranges and associates them with institutions.';

-- --------------------------------------------------------

--
-- Table structure for table `institution_settings`
--

CREATE TABLE `institution_settings` (
  `institution_setting_id` bigint(20) UNSIGNED NOT NULL,
  `institution_id` bigint(20) NOT NULL,
  `locale` varchar(28) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='More data about institutions, including localized properties like names.';

-- --------------------------------------------------------

--
-- Table structure for table `invitations`
--

CREATE TABLE `invitations` (
  `invitation_id` bigint(20) NOT NULL,
  `key_hash` varchar(255) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `inviter_id` bigint(20) DEFAULT NULL,
  `expiry_date` datetime DEFAULT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`payload`)),
  `status` enum('INITIALIZED','PENDING','ACCEPTED','DECLINED','CANCELLED') NOT NULL,
  `email` varchar(255) DEFAULT NULL COMMENT 'When present, the email address of the invitation recipient; when null, user_id must be set and the email can be fetched from the users table.',
  `context_id` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Invitations are sent to request a person (by email) to allow them to accept or reject an operation or position, such as a board membership or a submission peer review.';

--
-- Dumping data for table `invitations`
--

INSERT INTO `invitations` (`invitation_id`, `key_hash`, `type`, `user_id`, `inviter_id`, `expiry_date`, `payload`, `status`, `email`, `context_id`, `created_at`, `updated_at`) VALUES
(2, '$2y$10$zCsNdm63Xi1JlTux9iluzOcQou5HEOm7ZS3NZzRaMnbka.3LRGExu', 'userRoleAssignment', NULL, 1, '2025-11-22 23:50:58', '{\"orcid\":null,\"orcidAccessDenied\":null,\"orcidAccessExpiresOn\":null,\"orcidAccessScope\":null,\"orcidAccessToken\":null,\"orcidIsVerified\":null,\"orcidRefreshToken\":null,\"givenName\":{\"en\":\"Soren\"},\"familyName\":{\"en\":\"Ceditto\"},\"affiliation\":{\"en\":null},\"userCountry\":\"SE\",\"username\":\"editor.section\",\"password\":\"$2y$10$Jxi0410X.hFcZr6.1buKxuDTetzDlsbE4Dp3gfYSX98sc\\/9c70iEy\",\"emailSubject\":null,\"emailBody\":null,\"userGroupsToAdd\":[{\"userGroupId\":5,\"dateStart\":\"2020-01-01\",\"dateEnd\":null,\"masthead\":true}],\"passwordHashed\":true,\"sendEmailAddress\":\"editor.section@localhost.com\",\"inviteStagePayload\":{\"orcid\":null,\"orcidAccessDenied\":null,\"orcidAccessExpiresOn\":null,\"orcidAccessScope\":null,\"orcidAccessToken\":null,\"orcidIsVerified\":null,\"orcidRefreshToken\":null,\"givenName\":{\"en\":\"Soren\"},\"familyName\":{\"en\":\"Ceditto\"},\"affiliation\":null,\"userCountry\":null,\"username\":null,\"password\":null,\"emailSubject\":null,\"emailBody\":null,\"userGroupsToAdd\":[{\"userGroupId\":5,\"dateStart\":\"2020-01-01\",\"dateEnd\":null,\"masthead\":true}],\"passwordHashed\":null,\"sendEmailAddress\":\"editor.section@localhost.com\",\"inviteStagePayload\":null,\"shouldUseInviteData\":null},\"shouldUseInviteData\":null}', 'ACCEPTED', 'editor.section@localhost.com', 1, '2025-11-15 22:50:58', '2025-11-15 22:57:01'),
(4, '$2y$10$5xo5kmy1MKLMkAndX3NyZOJbmTUTkrxI5SoJ4hBXmztad4wcP2kt2', 'userRoleAssignment', NULL, 1, '2025-11-23 00:08:50', '{\"orcid\":null,\"orcidAccessDenied\":null,\"orcidAccessExpiresOn\":null,\"orcidAccessScope\":null,\"orcidAccessToken\":null,\"orcidIsVerified\":null,\"orcidRefreshToken\":null,\"givenName\":{\"en\":\"Sergio\"},\"familyName\":{\"en\":\"Tudet\"},\"affiliation\":{\"en\":null},\"userCountry\":\"ES\",\"username\":\"editor.guest\",\"password\":\"$2y$10$1OZkTg146hSuk8iH33vM1ee67BSH\\/ZofPs.CyRz1JqVMS4hOQy2V.\",\"emailSubject\":null,\"emailBody\":null,\"userGroupsToAdd\":[{\"userGroupId\":6,\"dateStart\":\"2025-11-15\",\"dateEnd\":null,\"masthead\":false}],\"passwordHashed\":true,\"sendEmailAddress\":\"editor.guest@localhost.com\",\"inviteStagePayload\":{\"orcid\":null,\"orcidAccessDenied\":null,\"orcidAccessExpiresOn\":null,\"orcidAccessScope\":null,\"orcidAccessToken\":null,\"orcidIsVerified\":null,\"orcidRefreshToken\":null,\"givenName\":{\"en\":\"Sergio\"},\"familyName\":{\"en\":\"Tudet\"},\"affiliation\":null,\"userCountry\":null,\"username\":null,\"password\":null,\"emailSubject\":null,\"emailBody\":null,\"userGroupsToAdd\":[{\"userGroupId\":6,\"dateStart\":\"2025-11-15\",\"dateEnd\":null,\"masthead\":false}],\"passwordHashed\":null,\"sendEmailAddress\":\"editor.guest@localhost.com\",\"inviteStagePayload\":null,\"shouldUseInviteData\":null},\"shouldUseInviteData\":null}', 'ACCEPTED', 'editor.guest@localhost.com', 1, '2025-11-15 23:08:49', '2025-11-15 23:09:56'),
(6, '$2y$10$/6NvPThV6/.4F6Npm2UjB.zVBWY9EMN0BhHtWjMPSkpyHYodpheIS', 'userRoleAssignment', NULL, 1, '2025-11-23 00:12:47', '{\"orcid\":null,\"orcidAccessDenied\":null,\"orcidAccessExpiresOn\":null,\"orcidAccessScope\":null,\"orcidAccessToken\":null,\"orcidIsVerified\":null,\"orcidRefreshToken\":null,\"givenName\":{\"en\":\"Cory\"},\"familyName\":{\"en\":\"Pedit\"},\"affiliation\":{\"en\":null},\"userCountry\":\"US\",\"username\":\"copyeditor\",\"password\":\"$2y$10$l0RrJEuxwxGrfxGUGUuYwuG9fMG92TBF32jct9swqKf.ezQqtU2rm\",\"emailSubject\":null,\"emailBody\":null,\"userGroupsToAdd\":[{\"userGroupId\":7,\"dateStart\":\"2020-10-01\",\"dateEnd\":null,\"masthead\":false}],\"passwordHashed\":true,\"sendEmailAddress\":\"copyeditor@localhost.com\",\"inviteStagePayload\":{\"orcid\":null,\"orcidAccessDenied\":null,\"orcidAccessExpiresOn\":null,\"orcidAccessScope\":null,\"orcidAccessToken\":null,\"orcidIsVerified\":null,\"orcidRefreshToken\":null,\"givenName\":{\"en\":\"Cory\"},\"familyName\":{\"en\":\"Pedit\"},\"affiliation\":null,\"userCountry\":null,\"username\":null,\"password\":null,\"emailSubject\":null,\"emailBody\":null,\"userGroupsToAdd\":[{\"userGroupId\":7,\"dateStart\":\"2020-10-01\",\"dateEnd\":null,\"masthead\":false}],\"passwordHashed\":null,\"sendEmailAddress\":\"copyeditor@localhost.com\",\"inviteStagePayload\":null,\"shouldUseInviteData\":null},\"shouldUseInviteData\":null}', 'ACCEPTED', 'copyeditor@localhost.com', 1, '2025-11-15 23:12:46', '2025-11-15 23:13:57'),
(8, '$2y$10$44FlbFrpy5nzN46CY0Vnvuxqkk56QnUDWNvs.qjdbjVnLJ8KDBica', 'userRoleAssignment', NULL, 1, '2025-11-23 00:15:45', '{\"orcid\":null,\"orcidAccessDenied\":null,\"orcidAccessExpiresOn\":null,\"orcidAccessScope\":null,\"orcidAccessToken\":null,\"orcidIsVerified\":null,\"orcidRefreshToken\":null,\"givenName\":{\"en\":\"Reni\"},\"familyName\":{\"en\":\"Wever\"},\"affiliation\":{\"en\":null},\"userCountry\":\"UA\",\"username\":\"reviewer\",\"password\":\"$2y$10$CnKXMb7XuuSr6ZzODFgDfuFYgdiTcletFVbBvi52qibOFxDiXoDKa\",\"emailSubject\":null,\"emailBody\":null,\"userGroupsToAdd\":[{\"userGroupId\":16,\"dateStart\":\"2025-11-01\",\"dateEnd\":null,\"masthead\":true}],\"passwordHashed\":true,\"sendEmailAddress\":\"reviewer@localhost.com\",\"inviteStagePayload\":{\"orcid\":null,\"orcidAccessDenied\":null,\"orcidAccessExpiresOn\":null,\"orcidAccessScope\":null,\"orcidAccessToken\":null,\"orcidIsVerified\":null,\"orcidRefreshToken\":null,\"givenName\":{\"en\":\"Reni\"},\"familyName\":{\"en\":\"Wever\"},\"affiliation\":null,\"userCountry\":null,\"username\":null,\"password\":null,\"emailSubject\":null,\"emailBody\":null,\"userGroupsToAdd\":[{\"userGroupId\":16,\"dateStart\":\"2025-11-01\",\"dateEnd\":null,\"masthead\":true}],\"passwordHashed\":null,\"sendEmailAddress\":\"reviewer@localhost.com\",\"inviteStagePayload\":null,\"shouldUseInviteData\":null},\"shouldUseInviteData\":null}', 'ACCEPTED', 'reviewer@localhost.com', 1, '2025-11-15 23:15:45', '2025-11-15 23:16:41'),
(10, '$2y$10$BnYGLIw846Kdga6L2RA6JeIPZeK3pJims0CeZPtitLUXZ7BpZDEBy', 'userRoleAssignment', NULL, 1, '2025-11-23 00:18:35', '{\"orcid\":null,\"orcidAccessDenied\":null,\"orcidAccessExpiresOn\":null,\"orcidAccessScope\":null,\"orcidAccessToken\":null,\"orcidIsVerified\":null,\"orcidRefreshToken\":null,\"givenName\":{\"en\":\"Lydia\"},\"familyName\":{\"en\":\"Touret\"},\"affiliation\":{\"en\":null},\"userCountry\":\"GB\",\"username\":\"editor.layout\",\"password\":\"$2y$10$kTqupVa\\/LfNViXbQtpx.FuldUXHhq1TQDBeb.2RUoXdwfaZV3HSfe\",\"emailSubject\":null,\"emailBody\":null,\"userGroupsToAdd\":[{\"userGroupId\":11,\"dateStart\":\"2023-06-01\",\"dateEnd\":null,\"masthead\":false}],\"passwordHashed\":true,\"sendEmailAddress\":\"editor.layout@localhost.com\",\"inviteStagePayload\":{\"orcid\":null,\"orcidAccessDenied\":null,\"orcidAccessExpiresOn\":null,\"orcidAccessScope\":null,\"orcidAccessToken\":null,\"orcidIsVerified\":null,\"orcidRefreshToken\":null,\"givenName\":{\"en\":\"Lydia\"},\"familyName\":{\"en\":\"Touret\"},\"affiliation\":null,\"userCountry\":null,\"username\":null,\"password\":null,\"emailSubject\":null,\"emailBody\":null,\"userGroupsToAdd\":[{\"userGroupId\":11,\"dateStart\":\"2023-06-01\",\"dateEnd\":null,\"masthead\":false}],\"passwordHashed\":null,\"sendEmailAddress\":\"editor.layout@localhost.com\",\"inviteStagePayload\":null,\"shouldUseInviteData\":null},\"shouldUseInviteData\":null}', 'ACCEPTED', 'editor.layout@localhost.com', 1, '2025-11-15 23:18:35', '2025-11-15 23:19:15'),
(12, '$2y$10$EaWBUnhSGFiMloTa.7OApuWgV2KD/TealJXOSQOBE1r9hVnx2.TzO', 'userRoleAssignment', NULL, 1, '2025-11-23 00:21:03', '{\"orcid\":null,\"orcidAccessDenied\":null,\"orcidAccessExpiresOn\":null,\"orcidAccessScope\":null,\"orcidAccessToken\":null,\"orcidIsVerified\":null,\"orcidRefreshToken\":null,\"givenName\":{\"en\":\"Renato\"},\"familyName\":{\"en\":\"Jordi\"},\"affiliation\":{\"en\":null},\"userCountry\":\"IT\",\"username\":\"editor.journal\",\"password\":\"$2y$10$kO8efC3NOxvz9GP.CTGsBuGG.UwGvxayo1A8Zbew3TTfQ4su8CM4a\",\"emailSubject\":null,\"emailBody\":null,\"userGroupsToAdd\":[{\"userGroupId\":3,\"dateStart\":\"2000-09-03\",\"dateEnd\":null,\"masthead\":true}],\"passwordHashed\":true,\"sendEmailAddress\":\"editor.journal@localhost.com\",\"inviteStagePayload\":{\"orcid\":null,\"orcidAccessDenied\":null,\"orcidAccessExpiresOn\":null,\"orcidAccessScope\":null,\"orcidAccessToken\":null,\"orcidIsVerified\":null,\"orcidRefreshToken\":null,\"givenName\":{\"en\":\"Renato\"},\"familyName\":{\"en\":\"Jordi\"},\"affiliation\":null,\"userCountry\":null,\"username\":null,\"password\":null,\"emailSubject\":null,\"emailBody\":null,\"userGroupsToAdd\":[{\"userGroupId\":3,\"dateStart\":\"2000-09-03\",\"dateEnd\":null,\"masthead\":true}],\"passwordHashed\":null,\"sendEmailAddress\":\"editor.journal@localhost.com\",\"inviteStagePayload\":null,\"shouldUseInviteData\":null},\"shouldUseInviteData\":null}', 'ACCEPTED', 'editor.journal@localhost.com', 1, '2025-11-15 23:21:03', '2025-11-15 23:21:40'),
(13, '$2y$10$DrAxw1WPljPas2mF9OhNj.QN.jxlJ1zmp69M1osjFxZ7XbrJZ5Ktq', 'registrationAccess', 8, NULL, '2025-11-23 00:27:22', '{}', 'ACCEPTED', NULL, 1, '2025-11-15 23:27:22', '2025-11-15 23:27:52'),
(14, '$2y$10$w7duRI9AVh5M61NgSAJsVuG.hh8pKBwqkin9qbDNdbuCmecLZdy6e', 'changeProfileEmail', 1, NULL, '2025-11-23 00:30:41', '{\"newEmail\":\"admin@localhost.com\"}', 'ACCEPTED', NULL, NULL, '2025-11-15 23:30:41', '2025-11-15 23:31:09'),
(16, '$2y$10$Zh54eXLVKHd1lPg9nIt9GuY0AhxqnNlzNVok8NikgQLs.lNc0IDIi', 'userRoleAssignment', NULL, 1, '2025-11-23 01:05:02', '{\"orcid\":null,\"orcidAccessDenied\":null,\"orcidAccessExpiresOn\":null,\"orcidAccessScope\":null,\"orcidAccessToken\":null,\"orcidIsVerified\":null,\"orcidRefreshToken\":null,\"givenName\":{\"en\":\"Holden\"},\"familyName\":{\"en\":\"Rau\"},\"affiliation\":{\"en\":\"Schaefer - Swaniawski University\"},\"userCountry\":\"AM\",\"username\":\"editor.guest-1\",\"password\":\"$2y$10$jWahCDdqRElsr8l4\\/Vx6VeMv\\/Lsx8BroOT8GbxZJgtvbnfYlIg6eq\",\"emailSubject\":null,\"emailBody\":null,\"userGroupsToAdd\":[{\"userGroupId\":6,\"dateStart\":\"2025-10-05\",\"dateEnd\":null,\"masthead\":true}],\"passwordHashed\":true,\"sendEmailAddress\":\"editor.guest-1@localhost.com\",\"inviteStagePayload\":{\"orcid\":null,\"orcidAccessDenied\":null,\"orcidAccessExpiresOn\":null,\"orcidAccessScope\":null,\"orcidAccessToken\":null,\"orcidIsVerified\":null,\"orcidRefreshToken\":null,\"givenName\":{\"en\":\"Holden\"},\"familyName\":{\"en\":\"Rau\"},\"affiliation\":null,\"userCountry\":null,\"username\":null,\"password\":null,\"emailSubject\":null,\"emailBody\":null,\"userGroupsToAdd\":[{\"userGroupId\":6,\"dateStart\":\"2025-10-05\",\"dateEnd\":null,\"masthead\":true}],\"passwordHashed\":null,\"sendEmailAddress\":\"editor.guest-1@localhost.com\",\"inviteStagePayload\":null,\"shouldUseInviteData\":null},\"shouldUseInviteData\":null}', 'ACCEPTED', 'editor.guest-1@localhost.com', 1, '2025-11-16 00:05:01', '2025-11-16 00:06:12'),
(18, '$2y$10$SupqbNe3RPo89YdeCO.pe.Y2pQba18bK4S6r87IVRVXP9bruBEubq', 'userRoleAssignment', NULL, 1, '2025-11-23 01:07:49', '{\"orcid\":null,\"orcidAccessDenied\":null,\"orcidAccessExpiresOn\":null,\"orcidAccessScope\":null,\"orcidAccessToken\":null,\"orcidIsVerified\":null,\"orcidRefreshToken\":null,\"givenName\":{\"en\":\"Angel\"},\"familyName\":{\"en\":\"Jaskolski\"},\"affiliation\":{\"en\":\"Hessel - Hintz University\"},\"userCountry\":\"TN\",\"username\":\"editor.guest-2\",\"password\":\"$2y$10$yoKzrNZ8W97mTESmBDNlhO2\\/0OOgImMxLp.9xf8xmDBCXAuXmqaQe\",\"emailSubject\":null,\"emailBody\":null,\"userGroupsToAdd\":[{\"userGroupId\":6,\"dateStart\":\"2025-07-18\",\"dateEnd\":null,\"masthead\":true}],\"passwordHashed\":true,\"sendEmailAddress\":\"editor.guest-2@localhost.com\",\"inviteStagePayload\":{\"orcid\":null,\"orcidAccessDenied\":null,\"orcidAccessExpiresOn\":null,\"orcidAccessScope\":null,\"orcidAccessToken\":null,\"orcidIsVerified\":null,\"orcidRefreshToken\":null,\"givenName\":{\"en\":\"Angel\"},\"familyName\":{\"en\":\"Jaskolski\"},\"affiliation\":null,\"userCountry\":null,\"username\":null,\"password\":null,\"emailSubject\":null,\"emailBody\":null,\"userGroupsToAdd\":[{\"userGroupId\":6,\"dateStart\":\"2025-07-18\",\"dateEnd\":null,\"masthead\":true}],\"passwordHashed\":null,\"sendEmailAddress\":\"editor.guest-2@localhost.com\",\"inviteStagePayload\":null,\"shouldUseInviteData\":null},\"shouldUseInviteData\":null}', 'ACCEPTED', 'editor.guest-2@localhost.com', 1, '2025-11-16 00:07:48', '2025-11-16 00:08:48'),
(20, '$2y$10$92rrCgPwwaHWTxtZylCzW..7lNmOjy3ibrKTcfjEEqEx144dDcXYG', 'userRoleAssignment', NULL, 1, '2025-11-23 01:11:07', '{\"orcid\":null,\"orcidAccessDenied\":null,\"orcidAccessExpiresOn\":null,\"orcidAccessScope\":null,\"orcidAccessToken\":null,\"orcidIsVerified\":null,\"orcidRefreshToken\":null,\"givenName\":{\"en\":\"Alvina\"},\"familyName\":{\"en\":\"Wintheiser\"},\"affiliation\":{\"en\":\"Kilback Group University\"},\"userCountry\":\"SA\",\"username\":\"reviewer-1\",\"password\":\"$2y$10$5Ol0qBN5KhdMkSZ\\/IHDwzejRLx5g.tlN2yS4PN8lbCMnSA2qp5GYW\",\"emailSubject\":null,\"emailBody\":null,\"userGroupsToAdd\":[{\"userGroupId\":16,\"dateStart\":\"2025-04-01\",\"dateEnd\":null,\"masthead\":true}],\"passwordHashed\":true,\"sendEmailAddress\":\"reviewer-1@localhost.com\",\"inviteStagePayload\":{\"orcid\":null,\"orcidAccessDenied\":null,\"orcidAccessExpiresOn\":null,\"orcidAccessScope\":null,\"orcidAccessToken\":null,\"orcidIsVerified\":null,\"orcidRefreshToken\":null,\"givenName\":{\"en\":\"Alvina\"},\"familyName\":{\"en\":\"Wintheiser\"},\"affiliation\":null,\"userCountry\":null,\"username\":null,\"password\":null,\"emailSubject\":null,\"emailBody\":null,\"userGroupsToAdd\":[{\"userGroupId\":16,\"dateStart\":\"2025-04-01\",\"dateEnd\":null,\"masthead\":true}],\"passwordHashed\":null,\"sendEmailAddress\":\"reviewer-1@localhost.com\",\"inviteStagePayload\":null,\"shouldUseInviteData\":null},\"shouldUseInviteData\":null}', 'ACCEPTED', 'reviewer-1@localhost.com', 1, '2025-11-16 00:11:07', '2025-11-16 00:12:07'),
(21, '$2y$10$CgcGUIqQ63phuDCE6.uJkut/3CSywFBgE6DH52AyTGqZhc9GZlPFO', 'registrationAccess', 12, NULL, '2025-11-23 01:13:40', '{}', 'ACCEPTED', NULL, 1, '2025-11-16 00:13:40', '2025-11-16 00:13:51');

-- --------------------------------------------------------

--
-- Table structure for table `issues`
--

CREATE TABLE `issues` (
  `issue_id` bigint(20) NOT NULL,
  `journal_id` bigint(20) NOT NULL,
  `volume` smallint(6) DEFAULT NULL,
  `number` varchar(40) DEFAULT NULL,
  `year` smallint(6) DEFAULT NULL,
  `published` smallint(6) NOT NULL DEFAULT 0,
  `date_published` datetime DEFAULT NULL,
  `date_notified` datetime DEFAULT NULL,
  `last_modified` datetime DEFAULT NULL,
  `access_status` smallint(6) NOT NULL DEFAULT 1,
  `open_access_date` datetime DEFAULT NULL,
  `show_volume` smallint(6) NOT NULL DEFAULT 0,
  `show_number` smallint(6) NOT NULL DEFAULT 0,
  `show_year` smallint(6) NOT NULL DEFAULT 0,
  `show_title` smallint(6) NOT NULL DEFAULT 0,
  `style_file_name` varchar(90) DEFAULT NULL,
  `original_style_file_name` varchar(255) DEFAULT NULL,
  `url_path` varchar(64) DEFAULT NULL,
  `doi_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='A list of all journal issues, with identifying information like year, number, volume, etc.';

--
-- Dumping data for table `issues`
--

INSERT INTO `issues` (`issue_id`, `journal_id`, `volume`, `number`, `year`, `published`, `date_published`, `date_notified`, `last_modified`, `access_status`, `open_access_date`, `show_volume`, `show_number`, `show_year`, `show_title`, `style_file_name`, `original_style_file_name`, `url_path`, `doi_id`) VALUES
(1, 1, 1, '1', 2024, 0, '2024-06-24 00:00:00', NULL, '2025-11-16 01:32:43', 1, NULL, 1, 1, 1, 1, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `issue_files`
--

CREATE TABLE `issue_files` (
  `file_id` bigint(20) NOT NULL,
  `issue_id` bigint(20) NOT NULL,
  `file_name` varchar(90) NOT NULL,
  `file_type` varchar(255) NOT NULL,
  `file_size` bigint(20) NOT NULL,
  `content_type` bigint(20) NOT NULL,
  `original_file_name` varchar(127) DEFAULT NULL,
  `date_uploaded` datetime NOT NULL,
  `date_modified` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Relationships between issues and issue files, such as cover images.';

-- --------------------------------------------------------

--
-- Table structure for table `issue_galleys`
--

CREATE TABLE `issue_galleys` (
  `galley_id` bigint(20) NOT NULL,
  `locale` varchar(28) DEFAULT NULL,
  `issue_id` bigint(20) NOT NULL,
  `file_id` bigint(20) NOT NULL,
  `label` varchar(255) DEFAULT NULL,
  `seq` double NOT NULL DEFAULT 0,
  `url_path` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Issue galleys are representations of the entire issue in a single file, such as a complete issue PDF.';

-- --------------------------------------------------------

--
-- Table structure for table `issue_galley_settings`
--

CREATE TABLE `issue_galley_settings` (
  `issue_galley_setting_id` bigint(20) UNSIGNED NOT NULL,
  `galley_id` bigint(20) NOT NULL,
  `locale` varchar(28) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL,
  `setting_type` varchar(6) NOT NULL COMMENT '(bool|int|float|string|object)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='More data about issue galleys, including localized content such as labels.';

-- --------------------------------------------------------

--
-- Table structure for table `issue_settings`
--

CREATE TABLE `issue_settings` (
  `issue_setting_id` bigint(20) UNSIGNED NOT NULL,
  `issue_id` bigint(20) NOT NULL,
  `locale` varchar(28) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='More data about issues, including localized properties such as issue titles.';

--
-- Dumping data for table `issue_settings`
--

INSERT INTO `issue_settings` (`issue_setting_id`, `issue_id`, `locale`, `setting_name`, `setting_value`) VALUES
(1, 1, 'en', 'description', '<p>Sol veniam maxime adicio aegre id antepono dolorem curo. Cognomen delicate amita dapifer cursus. Admiratio demergo coma cilicium laborum.\\nCuppedia torqueo ait tendo occaecati accommodo. Currus provident enim. Porro ara una attero voco valens cras auditor delinquo.\\nVis ancilla corpus torqueo. Thorax denuo error. Thorax aequus corrumpo absens torrens veritatis viridis viscus angulus.</p>'),
(2, 1, 'en', 'title', 'Nobis numquam textor');

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='All pending or in-progress jobs.';

--
-- Dumping data for table `jobs`
--

INSERT INTO `jobs` (`id`, `queue`, `payload`, `attempts`, `reserved_at`, `available_at`, `created_at`) VALUES
(1, 'queue', '{\"uuid\":\"a521a35d-beff-4055-be1b-549fd3764000\",\"displayName\":\"PKP\\\\jobs\\\\metadata\\\\MetadataChangedJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":3,\"failOnTimeout\":true,\"backoff\":\"5\",\"timeout\":60,\"retryUntil\":null,\"data\":{\"commandName\":\"PKP\\\\jobs\\\\metadata\\\\MetadataChangedJob\",\"command\":\"O:36:\\\"PKP\\\\jobs\\\\metadata\\\\MetadataChangedJob\\\":3:{s:15:\\\"\\u0000*\\u0000submissionId\\\";i:1;s:10:\\\"connection\\\";s:8:\\\"database\\\";s:5:\\\"queue\\\";s:5:\\\"queue\\\";}\"}}', 0, NULL, 1763252257, 1763252257),
(2, 'queue', '{\"uuid\":\"22b695c6-1293-49a8-b56f-03b842fec198\",\"displayName\":\"PKP\\\\jobs\\\\metadata\\\\MetadataChangedJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":3,\"failOnTimeout\":true,\"backoff\":\"5\",\"timeout\":60,\"retryUntil\":null,\"data\":{\"commandName\":\"PKP\\\\jobs\\\\metadata\\\\MetadataChangedJob\",\"command\":\"O:36:\\\"PKP\\\\jobs\\\\metadata\\\\MetadataChangedJob\\\":3:{s:15:\\\"\\u0000*\\u0000submissionId\\\";i:1;s:10:\\\"connection\\\";s:8:\\\"database\\\";s:5:\\\"queue\\\";s:5:\\\"queue\\\";}\"}}', 0, NULL, 1763252345, 1763252345),
(3, 'queue', '{\"uuid\":\"3e7afe86-0fdc-4761-9d57-d7755c2ca6eb\",\"displayName\":\"PKP\\\\jobs\\\\metadata\\\\MetadataChangedJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":3,\"failOnTimeout\":true,\"backoff\":\"5\",\"timeout\":60,\"retryUntil\":null,\"data\":{\"commandName\":\"PKP\\\\jobs\\\\metadata\\\\MetadataChangedJob\",\"command\":\"O:36:\\\"PKP\\\\jobs\\\\metadata\\\\MetadataChangedJob\\\":3:{s:15:\\\"\\u0000*\\u0000submissionId\\\";i:1;s:10:\\\"connection\\\";s:8:\\\"database\\\";s:5:\\\"queue\\\";s:5:\\\"queue\\\";}\"}}', 0, NULL, 1763252382, 1763252382),
(4, 'queue', '{\"uuid\":\"eb2afacf-9fef-4425-87c1-4c7d1959f157\",\"displayName\":\"PKP\\\\jobs\\\\metadata\\\\MetadataChangedJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":3,\"failOnTimeout\":true,\"backoff\":\"5\",\"timeout\":60,\"retryUntil\":null,\"data\":{\"commandName\":\"PKP\\\\jobs\\\\metadata\\\\MetadataChangedJob\",\"command\":\"O:36:\\\"PKP\\\\jobs\\\\metadata\\\\MetadataChangedJob\\\":3:{s:15:\\\"\\u0000*\\u0000submissionId\\\";i:1;s:10:\\\"connection\\\";s:8:\\\"database\\\";s:5:\\\"queue\\\";s:5:\\\"queue\\\";}\"}}', 0, NULL, 1763252401, 1763252401),
(5, 'queue', '{\"uuid\":\"275f979f-c687-4581-bc45-a5fe5a95b9d7\",\"displayName\":\"PKP\\\\jobs\\\\metadata\\\\MetadataChangedJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":3,\"failOnTimeout\":true,\"backoff\":\"5\",\"timeout\":60,\"retryUntil\":null,\"data\":{\"commandName\":\"PKP\\\\jobs\\\\metadata\\\\MetadataChangedJob\",\"command\":\"O:36:\\\"PKP\\\\jobs\\\\metadata\\\\MetadataChangedJob\\\":3:{s:15:\\\"\\u0000*\\u0000submissionId\\\";i:1;s:10:\\\"connection\\\";s:8:\\\"database\\\";s:5:\\\"queue\\\";s:5:\\\"queue\\\";}\"}}', 0, NULL, 1763252509, 1763252509),
(6, 'queue', '{\"uuid\":\"1cf1a905-db52-4e54-b5f6-0217d8d6d4c1\",\"displayName\":\"PKP\\\\jobs\\\\metadata\\\\MetadataChangedJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":3,\"failOnTimeout\":true,\"backoff\":\"5\",\"timeout\":60,\"retryUntil\":null,\"data\":{\"commandName\":\"PKP\\\\jobs\\\\metadata\\\\MetadataChangedJob\",\"command\":\"O:36:\\\"PKP\\\\jobs\\\\metadata\\\\MetadataChangedJob\\\":3:{s:15:\\\"\\u0000*\\u0000submissionId\\\";i:1;s:10:\\\"connection\\\";s:8:\\\"database\\\";s:5:\\\"queue\\\";s:5:\\\"queue\\\";}\"}}', 0, NULL, 1763252573, 1763252573),
(7, 'queue', '{\"uuid\":\"999088f7-16a8-470c-8cff-f0b9df3dc5f5\",\"displayName\":\"PKP\\\\jobs\\\\metadata\\\\MetadataChangedJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":3,\"failOnTimeout\":true,\"backoff\":\"5\",\"timeout\":60,\"retryUntil\":null,\"data\":{\"commandName\":\"PKP\\\\jobs\\\\metadata\\\\MetadataChangedJob\",\"command\":\"O:36:\\\"PKP\\\\jobs\\\\metadata\\\\MetadataChangedJob\\\":3:{s:15:\\\"\\u0000*\\u0000submissionId\\\";i:1;s:10:\\\"connection\\\";s:8:\\\"database\\\";s:5:\\\"queue\\\";s:5:\\\"queue\\\";}\"}}', 0, NULL, 1763252895, 1763252895),
(8, 'queue', '{\"uuid\":\"e134f128-7882-453d-9e52-babda5c1cd90\",\"displayName\":\"PKP\\\\jobs\\\\metadata\\\\MetadataChangedJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":3,\"failOnTimeout\":true,\"backoff\":\"5\",\"timeout\":60,\"retryUntil\":null,\"data\":{\"commandName\":\"PKP\\\\jobs\\\\metadata\\\\MetadataChangedJob\",\"command\":\"O:36:\\\"PKP\\\\jobs\\\\metadata\\\\MetadataChangedJob\\\":3:{s:15:\\\"\\u0000*\\u0000submissionId\\\";i:1;s:10:\\\"connection\\\";s:8:\\\"database\\\";s:5:\\\"queue\\\";s:5:\\\"queue\\\";}\"}}', 0, NULL, 1763252961, 1763252961);

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` text NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Job batches allow jobs to be collected into groups for managed processing.';

-- --------------------------------------------------------

--
-- Table structure for table `journals`
--

CREATE TABLE `journals` (
  `journal_id` bigint(20) NOT NULL,
  `path` varchar(32) NOT NULL,
  `seq` double NOT NULL DEFAULT 0 COMMENT 'Used to order lists of journals',
  `primary_locale` varchar(28) NOT NULL,
  `enabled` smallint(6) NOT NULL DEFAULT 1 COMMENT 'Controls whether or not the journal is considered "live" and will appear on the website. (Note that disabled journals may still be accessible, but only if the user knows the URL.)',
  `current_issue_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='A list of all journals in the installation of OJS.';

--
-- Dumping data for table `journals`
--

INSERT INTO `journals` (`journal_id`, `path`, `seq`, `primary_locale`, `enabled`, `current_issue_id`) VALUES
(1, 'JOP', 1, 'en', 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `journal_settings`
--

CREATE TABLE `journal_settings` (
  `journal_setting_id` bigint(20) UNSIGNED NOT NULL,
  `journal_id` bigint(20) NOT NULL,
  `locale` varchar(28) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='More data about journals, including localized properties like policies.';

--
-- Dumping data for table `journal_settings`
--

INSERT INTO `journal_settings` (`journal_setting_id`, `journal_id`, `locale`, `setting_name`, `setting_value`) VALUES
(1, 1, 'en', 'acronym', 'JOP'),
(2, 1, 'en', 'authorGuidelines', '<p>Authors are invited to make a submission to this journal. All submissions will be assessed by an editor to determine whether they meet the aims and scope of this journal. Those considered to be a good fit will be sent for peer review before determining whether they will be accepted or rejected.</p><p>Before making a submission, authors are responsible for obtaining permission to publish any material included with the submission, such as photos, documents and datasets. All authors identified on the submission must consent to be identified as an author. Where appropriate, research should be approved by an appropriate ethics committee in accordance with the legal requirements of the study\'s country.</p><p>An editor may desk reject a submission if it does not meet minimum standards of quality. Before submitting, please ensure that the study design and research argument are structured and articulated properly. The title should be concise and the abstract should be able to stand on its own. This will increase the likelihood of reviewers agreeing to review the paper. When you\'re satisfied that your submission meets this standard, please follow the checklist below to prepare your submission.</p>'),
(3, 1, 'en', 'authorInformation', 'Interested in submitting to this journal? We recommend that you review the <a href=\"https://localhost:8443/index.php/JOP/about\">About the Journal</a> page for the journal\'s section policies, as well as the <a href=\"https://localhost:8443/index.php/JOP/about/submissions#authorGuidelines\">Author Guidelines</a>. Authors need to <a href=\"https://localhost:8443/index.php/JOP/user/register\">register</a> with the journal prior to submitting or, if already registered, can simply <a href=\"https://localhost:8443/index.php/index/login\">log in</a> and begin the five-step process.'),
(4, 1, 'en', 'beginSubmissionHelp', '<p>Thank you for submitting to the Journal of Philosophy. You will be asked to upload files, identify co-authors, and provide information such as the title and abstract.<p><p>Please read our <a href=\"https://localhost:8443/index.php/JOP/about/submissions\" target=\"_blank\">Submission Guidelines</a> if you have not done so already. When filling out the forms, provide as many details as possible in order to help our editors evaluate your work.</p><p>Once you begin, you can save your submission and come back to it later. You will be able to review and correct any information before you submit.</p>'),
(5, 1, '', 'contactEmail', 'adrian.mroz@uj.edu.pl'),
(6, 1, '', 'contactName', 'Adrian Mróz'),
(7, 1, 'en', 'contributorsHelp', '<p>Add details for all of the contributors to this submission. Contributors added here will be sent an email confirmation of the submission, as well as a copy of all editorial decisions recorded against this submission.</p><p>If a contributor can not be contacted by email, because they must remain anonymous or do not have an email account, please do not enter a fake email address. You can add information about this contributor in a message to the editor at a later step in the submission process.</p>'),
(8, 1, '', 'country', 'PL'),
(9, 1, '', 'defaultReviewMode', '2'),
(10, 1, 'en', 'description', '<div class=\"elementor-element elementor-element-411d741 e-con-full e-flex e-con e-child\" data-id=\"411d741\" data-element_type=\"container\">\n<div class=\"elementor-element elementor-element-a121d63 e-con-full e-flex e-con e-child\" data-id=\"a121d63\" data-element_type=\"container\">\n<div class=\"elementor-element elementor-element-972ac3b e-con-full e-flex e-con e-child\" data-id=\"972ac3b\" data-element_type=\"container\">\n<div class=\"elementor-element elementor-element-8db6885 e-con-full lp_con e-flex e-con e-child\" data-id=\"8db6885\" data-element_type=\"container\">\n<div class=\"elementor-element elementor-element-182f0a9 elementor-widget-tablet__width-inherit elementor-widget elementor-widget-text-editor\" data-id=\"182f0a9\" data-element_type=\"widget\" data-widget_type=\"text-editor.default\">\n<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n</div>\n</div>\n</div>\n</div>\n</div>'),
(11, 1, 'en', 'detailsHelp', '<p>Please provide the following details to help us manage your submission in our system.</p>'),
(12, 1, '', 'copySubmissionAckPrimaryContact', '0'),
(13, 1, '', 'copySubmissionAckAddress', ''),
(14, 1, '', 'emailSignature', '<br><br>—<br><p>This is an automated message from <a href=\"https://localhost:8443/index.php/JOP\">Journal of Philosophy</a>.</p>'),
(15, 1, '', 'enableDois', '1'),
(16, 1, '', 'doiSuffixType', 'default'),
(17, 1, '', 'registrationAgency', ''),
(18, 1, '', 'disableSubmissions', '0'),
(19, 1, '', 'editorialStatsEmail', '1'),
(20, 1, 'en', 'forTheEditorsHelp', '<p>Please provide the following details in order to help our editorial team manage your submission.</p><p>When entering metadata, provide entries that you think would be most helpful to the person managing your submission. This information can be changed before publication.</p>'),
(21, 1, '', 'itemsPerPage', '25'),
(22, 1, '', 'keywords', 'request'),
(23, 1, 'en', 'librarianInformation', 'We encourage research librarians to list this journal among their library\'s electronic journal holdings. As well, it may be worth noting that this journal\'s open source publishing system is suitable for libraries to host for their faculty members to use with journals they are involved in editing (see <a href=\"https://pkp.sfu.ca/ojs\">Open Journal Systems</a>).'),
(24, 1, 'en', 'name', 'Journal of Philosophy'),
(25, 1, '', 'notifyAllAuthors', '1'),
(26, 1, '', 'numPageLinks', '10'),
(27, 1, '', 'numWeeksPerResponse', '4'),
(28, 1, '', 'numWeeksPerReview', '4'),
(29, 1, '', 'numReviewsPerSubmission', '0'),
(30, 1, 'en', 'openAccessPolicy', 'This journal provides immediate open access to its content on the principle that making research freely available to the public supports a greater global exchange of knowledge.'),
(31, 1, '', 'orcidCity', ''),
(32, 1, '', 'orcidClientId', ''),
(33, 1, '', 'orcidClientSecret', ''),
(34, 1, '', 'orcidEnabled', '0'),
(35, 1, '', 'orcidLogLevel', 'ERROR'),
(36, 1, '', 'orcidSendMailToAuthorsOnPublication', '0'),
(37, 1, 'en', 'privacyStatement', '<p>The names and email addresses entered in this journal site will be used exclusively for the stated purposes of this journal and will not be made available for any other purpose or to any other party.</p>'),
(38, 1, 'en', 'readerInformation', 'We encourage readers to sign up for the publishing notification service for this journal. Use the <a href=\"https://localhost:8443/index.php/JOP/user/register\">Register</a> link at the top of the home page for the journal. This registration will result in the reader receiving the Table of Contents by email for each new issue of the journal. This list also allows the journal to claim a certain level of support or readership. See the journal\'s <a href=\"https://localhost:8443/index.php/JOP/about/submissions#privacyStatement\">Privacy Statement</a>, which assures readers that their name and email address will not be used for other purposes.'),
(39, 1, 'en', 'reviewHelp', '<p>Review the information you have entered before you complete your submission. You can change any of the details displayed here by clicking the edit button at the top of each section.</p><p>Once you complete your submission, a member of our editorial team will be assigned to review it. Please ensure the details you have entered here are as accurate as possible.</p>'),
(40, 1, '', 'submissionAcknowledgement', 'allAuthors'),
(41, 1, 'en', 'submissionChecklist', '<p>All submissions must meet the following requirements.</p><ul><li>This submission meets the requirements outlined in the <a href=\"https://localhost:8443/index.php/JOP/about/submissions\">Author Guidelines</a>.</li><li>This submission has not been previously published, nor is it before another journal for consideration.</li><li>All references have been checked for accuracy and completeness.</li><li>All tables and figures have been numbered and labeled.</li><li>Permission has been obtained to publish all photos, datasets and other material provided with this submission.</li></ul>'),
(42, 1, '', 'submitWithCategories', '0'),
(43, 1, '', 'supportedAddedSubmissionLocales', '[\"en\"]'),
(44, 1, '', 'supportedDefaultSubmissionLocale', 'en'),
(45, 1, '', 'supportedFormLocales', '[\"en\"]'),
(46, 1, '', 'supportedLocales', '[\"en\"]'),
(47, 1, '', 'supportedSubmissionLocales', '[\"en\"]'),
(48, 1, '', 'supportedSubmissionMetadataLocales', '[\"en\"]'),
(49, 1, '', 'themePluginPath', 'default'),
(50, 1, 'en', 'uploadFilesHelp', '<p>Provide any files our editorial team may need to evaluate your submission. In addition to the main work, you may wish to submit data sets, conflict of interest statements, or other supplementary files if these will be helpful for our editors.</p>'),
(51, 1, '', 'enableGeoUsageStats', 'disabled'),
(52, 1, '', 'enableInstitutionUsageStats', '0'),
(53, 1, '', 'isSushiApiPublic', '1'),
(54, 1, 'en', 'abbreviation', 'JOP'),
(55, 1, 'en', 'clockssLicense', 'This journal utilizes the CLOCKSS system to create a distributed archiving system among participating libraries and permits those libraries to create permanent archives of the journal for purposes of preservation and restoration. <a href=\"https://clockss.org\">More...</a>'),
(56, 1, '', 'copyrightYearBasis', 'issue'),
(57, 1, '', 'enabledDoiTypes', '[\"publication\"]'),
(58, 1, '', 'doiCreationTime', 'copyEditCreationTime'),
(59, 1, '', 'enableOai', '1'),
(60, 1, 'en', 'lockssLicense', 'This journal utilizes the LOCKSS system to create a distributed archiving system among participating libraries and permits those libraries to create permanent archives of the journal for purposes of preservation and restoration. <a href=\"https://www.lockss.org\">More...</a>'),
(61, 1, '', 'membershipFee', '0'),
(62, 1, '', 'publicationFee', '0'),
(63, 1, '', 'purchaseArticleFee', '0'),
(64, 1, '', 'doiVersioning', '0'),
(65, 1, 'en', 'reviewerSuggestionsHelp', '<p>When submitting, you have the option to suggest several potential reviewers. This can help streamline the review process and provide valueable input for the editorial team. Please choose reviewers who are expert in your field and have no conflict of interest with your work. This feature aims to enhance the review process and support a more efficient experience for both authors and editorial team.</p>'),
(66, 1, '', 'supportEmail', 'adrian.mroz@uj.edu.pl'),
(67, 1, '', 'supportName', 'Adrian Mróz'),
(68, 1, 'en', 'dateFormatLong', 'F j, Y'),
(69, 1, 'en', 'dateFormatShort', 'Y-m-d'),
(70, 1, 'en', 'datetimeFormatLong', 'F j, Y - H:i'),
(71, 1, 'en', 'datetimeFormatShort', 'Y-m-d H:i'),
(72, 1, 'en', 'timeFormat', 'H:i');

-- --------------------------------------------------------

--
-- Table structure for table `library_files`
--

CREATE TABLE `library_files` (
  `file_id` bigint(20) NOT NULL,
  `context_id` bigint(20) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `original_file_name` varchar(255) NOT NULL,
  `file_type` varchar(255) NOT NULL,
  `file_size` bigint(20) NOT NULL,
  `type` smallint(6) NOT NULL,
  `date_uploaded` datetime NOT NULL,
  `date_modified` datetime NOT NULL,
  `submission_id` bigint(20) DEFAULT NULL,
  `public_access` smallint(6) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Library files can be associated with the context (press/server/journal) or with individual submissions, and are typically forms, agreements, and other administrative documents that are not part of the scholarly content.';

-- --------------------------------------------------------

--
-- Table structure for table `library_file_settings`
--

CREATE TABLE `library_file_settings` (
  `library_file_setting_id` bigint(20) UNSIGNED NOT NULL,
  `file_id` bigint(20) NOT NULL,
  `locale` varchar(28) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL,
  `setting_type` varchar(6) NOT NULL COMMENT '(bool|int|float|string|object|date)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='More data about library files, including localized content such as names.';

-- --------------------------------------------------------

--
-- Table structure for table `metrics_context`
--

CREATE TABLE `metrics_context` (
  `metrics_context_id` bigint(20) UNSIGNED NOT NULL,
  `load_id` varchar(50) NOT NULL,
  `context_id` bigint(20) NOT NULL,
  `date` date NOT NULL,
  `metric` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Daily statistics for views of the homepage.';

-- --------------------------------------------------------

--
-- Table structure for table `metrics_counter_submission_daily`
--

CREATE TABLE `metrics_counter_submission_daily` (
  `metrics_counter_submission_daily_id` bigint(20) UNSIGNED NOT NULL,
  `load_id` varchar(50) NOT NULL,
  `context_id` bigint(20) NOT NULL,
  `submission_id` bigint(20) NOT NULL,
  `date` date NOT NULL,
  `metric_investigations` int(11) NOT NULL,
  `metric_investigations_unique` int(11) NOT NULL,
  `metric_requests` int(11) NOT NULL,
  `metric_requests_unique` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Daily statistics matching the COUNTER R5 protocol for views and downloads of published submissions and galleys.';

-- --------------------------------------------------------

--
-- Table structure for table `metrics_counter_submission_institution_daily`
--

CREATE TABLE `metrics_counter_submission_institution_daily` (
  `metrics_counter_submission_institution_daily_id` bigint(20) UNSIGNED NOT NULL,
  `load_id` varchar(50) NOT NULL,
  `context_id` bigint(20) NOT NULL,
  `submission_id` bigint(20) NOT NULL,
  `institution_id` bigint(20) NOT NULL,
  `date` date NOT NULL,
  `metric_investigations` int(11) NOT NULL,
  `metric_investigations_unique` int(11) NOT NULL,
  `metric_requests` int(11) NOT NULL,
  `metric_requests_unique` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Daily statistics matching the COUNTER R5 protocol for views and downloads from institutions.';

-- --------------------------------------------------------

--
-- Table structure for table `metrics_counter_submission_institution_monthly`
--

CREATE TABLE `metrics_counter_submission_institution_monthly` (
  `metrics_counter_submission_institution_monthly_id` bigint(20) UNSIGNED NOT NULL,
  `context_id` bigint(20) NOT NULL,
  `submission_id` bigint(20) NOT NULL,
  `institution_id` bigint(20) NOT NULL,
  `month` int(11) NOT NULL,
  `metric_investigations` int(11) NOT NULL,
  `metric_investigations_unique` int(11) NOT NULL,
  `metric_requests` int(11) NOT NULL,
  `metric_requests_unique` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Monthly statistics matching the COUNTER R5 protocol for views and downloads from institutions.';

-- --------------------------------------------------------

--
-- Table structure for table `metrics_counter_submission_monthly`
--

CREATE TABLE `metrics_counter_submission_monthly` (
  `metrics_counter_submission_monthly_id` bigint(20) UNSIGNED NOT NULL,
  `context_id` bigint(20) NOT NULL,
  `submission_id` bigint(20) NOT NULL,
  `month` int(11) NOT NULL,
  `metric_investigations` int(11) NOT NULL,
  `metric_investigations_unique` int(11) NOT NULL,
  `metric_requests` int(11) NOT NULL,
  `metric_requests_unique` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Monthly statistics matching the COUNTER R5 protocol for views and downloads of published submissions and galleys.';

-- --------------------------------------------------------

--
-- Table structure for table `metrics_issue`
--

CREATE TABLE `metrics_issue` (
  `metrics_issue_id` bigint(20) UNSIGNED NOT NULL,
  `load_id` varchar(50) NOT NULL,
  `context_id` bigint(20) NOT NULL,
  `issue_id` bigint(20) NOT NULL,
  `issue_galley_id` bigint(20) DEFAULT NULL,
  `date` date NOT NULL,
  `metric` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Daily statistics for views and downloads of published issues.';

-- --------------------------------------------------------

--
-- Table structure for table `metrics_submission`
--

CREATE TABLE `metrics_submission` (
  `metrics_submission_id` bigint(20) UNSIGNED NOT NULL,
  `load_id` varchar(50) NOT NULL,
  `context_id` bigint(20) NOT NULL,
  `submission_id` bigint(20) NOT NULL,
  `representation_id` bigint(20) DEFAULT NULL,
  `submission_file_id` bigint(20) UNSIGNED DEFAULT NULL,
  `file_type` bigint(20) DEFAULT NULL,
  `assoc_type` bigint(20) NOT NULL,
  `date` date NOT NULL,
  `metric` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Daily statistics for views and downloads of published submissions and galleys.';

-- --------------------------------------------------------

--
-- Table structure for table `metrics_submission_geo_daily`
--

CREATE TABLE `metrics_submission_geo_daily` (
  `metrics_submission_geo_daily_id` bigint(20) UNSIGNED NOT NULL,
  `load_id` varchar(50) NOT NULL,
  `context_id` bigint(20) NOT NULL,
  `submission_id` bigint(20) NOT NULL,
  `country` varchar(2) NOT NULL DEFAULT '',
  `region` varchar(3) NOT NULL DEFAULT '',
  `city` varchar(255) NOT NULL DEFAULT '',
  `date` date NOT NULL,
  `metric` int(11) NOT NULL,
  `metric_unique` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Daily statistics by country, region and city for views and downloads of published submissions and galleys.';

-- --------------------------------------------------------

--
-- Table structure for table `metrics_submission_geo_monthly`
--

CREATE TABLE `metrics_submission_geo_monthly` (
  `metrics_submission_geo_monthly_id` bigint(20) UNSIGNED NOT NULL,
  `context_id` bigint(20) NOT NULL,
  `submission_id` bigint(20) NOT NULL,
  `country` varchar(2) NOT NULL DEFAULT '',
  `region` varchar(3) NOT NULL DEFAULT '',
  `city` varchar(255) NOT NULL DEFAULT '',
  `month` int(11) NOT NULL,
  `metric` int(11) NOT NULL,
  `metric_unique` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Monthly statistics by country, region and city for views and downloads of published submissions and galleys.';

-- --------------------------------------------------------

--
-- Table structure for table `navigation_menus`
--

CREATE TABLE `navigation_menus` (
  `navigation_menu_id` bigint(20) NOT NULL,
  `context_id` bigint(20) DEFAULT NULL,
  `area_name` varchar(255) DEFAULT '',
  `title` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Navigation menus on the website are installed with the software as a default set, and can be customized.';

--
-- Dumping data for table `navigation_menus`
--

INSERT INTO `navigation_menus` (`navigation_menu_id`, `context_id`, `area_name`, `title`) VALUES
(1, NULL, 'user', 'User Navigation Menu'),
(2, 1, 'user', 'User Navigation Menu'),
(3, 1, 'primary', 'Primary Navigation Menu');

-- --------------------------------------------------------

--
-- Table structure for table `navigation_menu_items`
--

CREATE TABLE `navigation_menu_items` (
  `navigation_menu_item_id` bigint(20) NOT NULL,
  `context_id` bigint(20) DEFAULT NULL,
  `path` varchar(255) DEFAULT '',
  `type` varchar(255) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Navigation menu items are single elements within a navigation menu.';

--
-- Dumping data for table `navigation_menu_items`
--

INSERT INTO `navigation_menu_items` (`navigation_menu_item_id`, `context_id`, `path`, `type`) VALUES
(1, NULL, NULL, 'NMI_TYPE_USER_REGISTER'),
(2, NULL, NULL, 'NMI_TYPE_USER_LOGIN'),
(3, NULL, NULL, 'NMI_TYPE_USER_DASHBOARD'),
(4, NULL, NULL, 'NMI_TYPE_USER_DASHBOARD'),
(5, NULL, NULL, 'NMI_TYPE_USER_PROFILE'),
(6, NULL, NULL, 'NMI_TYPE_ADMINISTRATION'),
(7, NULL, NULL, 'NMI_TYPE_USER_LOGOUT'),
(8, 1, NULL, 'NMI_TYPE_USER_REGISTER'),
(9, 1, NULL, 'NMI_TYPE_USER_LOGIN'),
(10, 1, NULL, 'NMI_TYPE_USER_DASHBOARD'),
(11, 1, NULL, 'NMI_TYPE_USER_DASHBOARD'),
(12, 1, NULL, 'NMI_TYPE_USER_PROFILE'),
(13, 1, NULL, 'NMI_TYPE_ADMINISTRATION'),
(14, 1, NULL, 'NMI_TYPE_USER_LOGOUT'),
(15, 1, NULL, 'NMI_TYPE_CURRENT'),
(16, 1, NULL, 'NMI_TYPE_ARCHIVES'),
(17, 1, NULL, 'NMI_TYPE_ANNOUNCEMENTS'),
(18, 1, NULL, 'NMI_TYPE_ABOUT'),
(19, 1, NULL, 'NMI_TYPE_ABOUT'),
(20, 1, NULL, 'NMI_TYPE_SUBMISSIONS'),
(21, 1, NULL, 'NMI_TYPE_MASTHEAD'),
(22, 1, NULL, 'NMI_TYPE_PRIVACY'),
(23, 1, NULL, 'NMI_TYPE_CONTACT'),
(24, 1, NULL, 'NMI_TYPE_SEARCH');

-- --------------------------------------------------------

--
-- Table structure for table `navigation_menu_item_assignments`
--

CREATE TABLE `navigation_menu_item_assignments` (
  `navigation_menu_item_assignment_id` bigint(20) NOT NULL,
  `navigation_menu_id` bigint(20) NOT NULL,
  `navigation_menu_item_id` bigint(20) NOT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `seq` bigint(20) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Links navigation menu items to navigation menus.';

--
-- Dumping data for table `navigation_menu_item_assignments`
--

INSERT INTO `navigation_menu_item_assignments` (`navigation_menu_item_assignment_id`, `navigation_menu_id`, `navigation_menu_item_id`, `parent_id`, `seq`) VALUES
(1, 1, 1, NULL, 0),
(2, 1, 2, NULL, 1),
(3, 1, 3, NULL, 2),
(4, 1, 4, 3, 0),
(5, 1, 5, 3, 1),
(6, 1, 6, 3, 2),
(7, 1, 7, 3, 3),
(8, 2, 8, NULL, 0),
(9, 2, 9, NULL, 1),
(10, 2, 10, NULL, 2),
(11, 2, 11, 10, 0),
(12, 2, 12, 10, 1),
(13, 2, 13, 10, 2),
(14, 2, 14, 10, 3),
(15, 3, 15, NULL, 0),
(16, 3, 16, NULL, 1),
(17, 3, 17, NULL, 2),
(18, 3, 18, NULL, 3),
(19, 3, 19, 18, 0),
(20, 3, 20, 18, 1),
(21, 3, 21, 18, 2),
(22, 3, 22, 18, 3),
(23, 3, 23, 18, 4);

-- --------------------------------------------------------

--
-- Table structure for table `navigation_menu_item_assignment_settings`
--

CREATE TABLE `navigation_menu_item_assignment_settings` (
  `navigation_menu_item_assignment_setting_id` bigint(20) UNSIGNED NOT NULL,
  `navigation_menu_item_assignment_id` bigint(20) NOT NULL,
  `locale` varchar(28) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL,
  `setting_type` varchar(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='More data about navigation menu item assignments to navigation menus, including localized content.';

-- --------------------------------------------------------

--
-- Table structure for table `navigation_menu_item_settings`
--

CREATE TABLE `navigation_menu_item_settings` (
  `navigation_menu_item_setting_id` bigint(20) UNSIGNED NOT NULL,
  `navigation_menu_item_id` bigint(20) NOT NULL,
  `locale` varchar(28) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` longtext DEFAULT NULL,
  `setting_type` varchar(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='More data about navigation menu items, including localized content such as names.';

--
-- Dumping data for table `navigation_menu_item_settings`
--

INSERT INTO `navigation_menu_item_settings` (`navigation_menu_item_setting_id`, `navigation_menu_item_id`, `locale`, `setting_name`, `setting_value`, `setting_type`) VALUES
(1, 1, '', 'titleLocaleKey', 'navigation.register', 'string'),
(2, 2, '', 'titleLocaleKey', 'navigation.login', 'string'),
(3, 3, '', 'titleLocaleKey', '{$loggedInUsername}', 'string'),
(4, 4, '', 'titleLocaleKey', 'navigation.dashboard', 'string'),
(5, 5, '', 'titleLocaleKey', 'common.viewProfile', 'string'),
(6, 6, '', 'titleLocaleKey', 'navigation.admin', 'string'),
(7, 7, '', 'titleLocaleKey', 'user.logOut', 'string'),
(8, 8, '', 'titleLocaleKey', 'navigation.register', 'string'),
(9, 9, '', 'titleLocaleKey', 'navigation.login', 'string'),
(10, 10, '', 'titleLocaleKey', '{$loggedInUsername}', 'string'),
(11, 11, '', 'titleLocaleKey', 'navigation.dashboard', 'string'),
(12, 12, '', 'titleLocaleKey', 'common.viewProfile', 'string'),
(13, 13, '', 'titleLocaleKey', 'navigation.admin', 'string'),
(14, 14, '', 'titleLocaleKey', 'user.logOut', 'string'),
(15, 15, '', 'titleLocaleKey', 'navigation.current', 'string'),
(16, 16, '', 'titleLocaleKey', 'navigation.archives', 'string'),
(17, 17, '', 'titleLocaleKey', 'manager.announcements', 'string'),
(18, 18, '', 'titleLocaleKey', 'navigation.about', 'string'),
(19, 19, '', 'titleLocaleKey', 'about.aboutContext', 'string'),
(20, 20, '', 'titleLocaleKey', 'about.submissions', 'string'),
(21, 21, '', 'titleLocaleKey', 'common.editorialMasthead', 'string'),
(22, 22, '', 'titleLocaleKey', 'manager.setup.privacyStatement', 'string'),
(23, 23, '', 'titleLocaleKey', 'about.contact', 'string'),
(24, 24, '', 'titleLocaleKey', 'common.search', 'string');

-- --------------------------------------------------------

--
-- Table structure for table `notes`
--

CREATE TABLE `notes` (
  `note_id` bigint(20) NOT NULL,
  `assoc_type` bigint(20) NOT NULL,
  `assoc_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_modified` datetime DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `contents` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Notes allow users to annotate associated entities, such as submissions.';

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `notification_id` bigint(20) NOT NULL,
  `context_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `level` bigint(20) NOT NULL,
  `type` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_read` datetime DEFAULT NULL,
  `assoc_type` bigint(20) DEFAULT NULL,
  `assoc_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='User notifications created during certain operations.';

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`notification_id`, `context_id`, `user_id`, `level`, `type`, `date_created`, `date_read`, `assoc_type`, `assoc_id`) VALUES
(6, 1, NULL, 3, 16777220, '2025-11-16 01:29:44', NULL, 1048585, 1),
(7, 1, NULL, 3, 16777222, '2025-11-16 01:29:44', NULL, 1048585, 1),
(8, 1, NULL, 3, 16777223, '2025-11-16 01:29:44', NULL, 1048585, 1),
(9, 1, NULL, 3, 16777224, '2025-11-16 01:29:44', NULL, 1048585, 1),
(10, 1, 1, 3, 16777247, '2025-11-16 01:29:44', NULL, 1048585, 1),
(11, 1, 7, 3, 16777247, '2025-11-16 01:29:44', NULL, 1048585, 1),
(12, 1, NULL, 2, 16777243, '2025-11-16 01:29:44', NULL, 1048585, 1),
(13, 1, NULL, 2, 16777245, '2025-11-16 01:29:44', NULL, 1048585, 1);

-- --------------------------------------------------------

--
-- Table structure for table `notification_settings`
--

CREATE TABLE `notification_settings` (
  `notification_setting_id` bigint(20) UNSIGNED NOT NULL,
  `notification_id` bigint(20) NOT NULL,
  `locale` varchar(28) DEFAULT NULL,
  `setting_name` varchar(64) NOT NULL,
  `setting_value` mediumtext NOT NULL,
  `setting_type` varchar(6) NOT NULL COMMENT '(bool|int|float|string|object)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='More data about notifications, including localized properties.';

-- --------------------------------------------------------

--
-- Table structure for table `notification_subscription_settings`
--

CREATE TABLE `notification_subscription_settings` (
  `setting_id` bigint(20) NOT NULL,
  `setting_name` varchar(64) NOT NULL,
  `setting_value` mediumtext NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `context_id` bigint(20) DEFAULT NULL,
  `setting_type` varchar(6) NOT NULL COMMENT '(bool|int|float|string|object)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Which email notifications a user has chosen to unsubscribe from.';

-- --------------------------------------------------------

--
-- Table structure for table `oai_resumption_tokens`
--

CREATE TABLE `oai_resumption_tokens` (
  `oai_resumption_token_id` bigint(20) UNSIGNED NOT NULL,
  `token` varchar(32) NOT NULL,
  `expire` bigint(20) NOT NULL,
  `record_offset` int(11) NOT NULL,
  `params` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='OAI resumption tokens are used to allow for pagination of large result sets into manageable pieces.';

-- --------------------------------------------------------

--
-- Table structure for table `plugin_settings`
--

CREATE TABLE `plugin_settings` (
  `plugin_setting_id` bigint(20) UNSIGNED NOT NULL,
  `plugin_name` varchar(80) NOT NULL,
  `context_id` bigint(20) DEFAULT NULL,
  `setting_name` varchar(80) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL,
  `setting_type` varchar(6) NOT NULL COMMENT '(bool|int|float|string|object)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='More data about plugins, including localized properties. This table is frequently used to store plugin-specific configuration.';

--
-- Dumping data for table `plugin_settings`
--

INSERT INTO `plugin_settings` (`plugin_setting_id`, `plugin_name`, `context_id`, `setting_name`, `setting_value`, `setting_type`) VALUES
(1, 'defaultthemeplugin', NULL, 'enabled', '1', 'bool'),
(2, 'tinymceplugin', NULL, 'enabled', '1', 'bool'),
(3, 'usageeventplugin', NULL, 'enabled', '1', 'bool'),
(4, 'languagetoggleblockplugin', NULL, 'enabled', '1', 'bool'),
(5, 'languagetoggleblockplugin', NULL, 'seq', '4', 'int'),
(6, 'developedbyblockplugin', NULL, 'enabled', '0', 'bool'),
(7, 'developedbyblockplugin', NULL, 'seq', '0', 'int'),
(8, 'tinymceplugin', 1, 'enabled', '1', 'bool'),
(9, 'defaultthemeplugin', 1, 'enabled', '1', 'bool'),
(10, 'languagetoggleblockplugin', 1, 'enabled', '1', 'bool'),
(11, 'languagetoggleblockplugin', 1, 'seq', '4', 'int'),
(12, 'informationblockplugin', 1, 'enabled', '1', 'bool'),
(13, 'informationblockplugin', 1, 'seq', '7', 'int'),
(14, 'developedbyblockplugin', 1, 'enabled', '0', 'bool'),
(15, 'developedbyblockplugin', 1, 'seq', '0', 'int'),
(16, 'subscriptionblockplugin', 1, 'enabled', '1', 'bool'),
(17, 'subscriptionblockplugin', 1, 'seq', '2', 'int'),
(18, 'webfeedplugin', 1, 'enabled', '1', 'bool'),
(19, 'webfeedplugin', 1, 'displayPage', 'homepage', 'string'),
(20, 'webfeedplugin', 1, 'displayItems', '1', 'bool'),
(21, 'webfeedplugin', 1, 'recentItems', '30', 'int'),
(22, 'webfeedplugin', 1, 'includeIdentifiers', '0', 'bool'),
(23, 'jatstemplateplugin', 1, 'enabled', '1', 'bool'),
(24, 'dublincoremetaplugin', 1, 'enabled', '1', 'bool'),
(25, 'pdfjsviewerplugin', 1, 'enabled', '1', 'bool'),
(26, 'googlescholarplugin', 1, 'enabled', '1', 'bool'),
(27, 'htmlarticlegalleyplugin', 1, 'enabled', '1', 'bool'),
(28, 'lensgalleyplugin', 1, 'enabled', '1', 'bool'),
(29, 'issuepreselectionplugin', 1, 'enabled', '0', 'bool');

-- --------------------------------------------------------

--
-- Table structure for table `publications`
--

CREATE TABLE `publications` (
  `publication_id` bigint(20) NOT NULL,
  `access_status` bigint(20) DEFAULT 0,
  `date_published` date DEFAULT NULL,
  `last_modified` datetime DEFAULT NULL,
  `primary_contact_id` bigint(20) DEFAULT NULL,
  `section_id` bigint(20) DEFAULT NULL,
  `seq` double NOT NULL DEFAULT 0,
  `submission_id` bigint(20) NOT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1,
  `url_path` varchar(64) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `doi_id` bigint(20) DEFAULT NULL,
  `issue_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Each publication is one version of a submission.';

--
-- Dumping data for table `publications`
--

INSERT INTO `publications` (`publication_id`, `access_status`, `date_published`, `last_modified`, `primary_contact_id`, `section_id`, `seq`, `submission_id`, `status`, `url_path`, `version`, `doi_id`, `issue_id`) VALUES
(1, 0, NULL, '2025-11-16 01:29:20', 1, 1, 0, 1, 1, NULL, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `publication_categories`
--

CREATE TABLE `publication_categories` (
  `publication_category_id` bigint(20) UNSIGNED NOT NULL,
  `publication_id` bigint(20) NOT NULL,
  `category_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Associates publications (and thus submissions) with categories.';

-- --------------------------------------------------------

--
-- Table structure for table `publication_galleys`
--

CREATE TABLE `publication_galleys` (
  `galley_id` bigint(20) NOT NULL,
  `locale` varchar(28) DEFAULT NULL,
  `publication_id` bigint(20) NOT NULL,
  `label` varchar(255) DEFAULT NULL,
  `submission_file_id` bigint(20) UNSIGNED DEFAULT NULL,
  `seq` double NOT NULL DEFAULT 0,
  `remote_url` varchar(2047) DEFAULT NULL,
  `is_approved` smallint(6) NOT NULL DEFAULT 0,
  `url_path` varchar(64) DEFAULT NULL,
  `doi_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Publication galleys are representations of a publication in a specific format, e.g. a PDF.';

-- --------------------------------------------------------

--
-- Table structure for table `publication_galley_settings`
--

CREATE TABLE `publication_galley_settings` (
  `publication_galley_setting_id` bigint(20) UNSIGNED NOT NULL,
  `galley_id` bigint(20) NOT NULL,
  `locale` varchar(28) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='More data about publication galleys, including localized content such as labels.';

-- --------------------------------------------------------

--
-- Table structure for table `publication_settings`
--

CREATE TABLE `publication_settings` (
  `publication_setting_id` bigint(20) UNSIGNED NOT NULL,
  `publication_id` bigint(20) NOT NULL,
  `locale` varchar(28) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='More data about publications, including localized properties such as the title and abstract.';

--
-- Dumping data for table `publication_settings`
--

INSERT INTO `publication_settings` (`publication_setting_id`, `publication_id`, `locale`, `setting_name`, `setting_value`) VALUES
(1, 1, 'en', 'title', 'Volaticus crebro adaugeo cubicularis thalassinus autus'),
(2, 1, 'en', 'abstract', '<p>Suppellex accusator comitatus quasi cunae. Talio adfero vinculum venio solvo audax aer comburo. Antiquus decerno vesper accusamus pariatur clam victus vir.\\nVelut bos cetera casso capio abundans strues ipsum. Denuo caute omnis ustulo casso temperantia creator. Ustilo sodalitas vulariter templum coruscus amplitudo.\\nDefleo ustulo tam audio deleo ea. Dolorum deprecator thema. Trucido accusantium coruscus numquam veritatis crux advenio labore.</p>');

-- --------------------------------------------------------

--
-- Table structure for table `queries`
--

CREATE TABLE `queries` (
  `query_id` bigint(20) NOT NULL,
  `assoc_type` bigint(20) NOT NULL,
  `assoc_id` bigint(20) NOT NULL,
  `stage_id` smallint(6) NOT NULL,
  `seq` double NOT NULL DEFAULT 0,
  `date_posted` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `closed` smallint(6) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Discussions, usually related to a submission, created by editors, authors and other editorial staff.';

-- --------------------------------------------------------

--
-- Table structure for table `query_participants`
--

CREATE TABLE `query_participants` (
  `query_participant_id` bigint(20) UNSIGNED NOT NULL,
  `query_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='The users assigned to a discussion.';

-- --------------------------------------------------------

--
-- Table structure for table `queued_payments`
--

CREATE TABLE `queued_payments` (
  `queued_payment_id` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_modified` datetime NOT NULL,
  `expiry_date` date DEFAULT NULL,
  `payment_data` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Unfulfilled (queued) payments, i.e. payments that have not yet been completed via an online payment system.';

-- --------------------------------------------------------

--
-- Table structure for table `reviewer_suggestions`
--

CREATE TABLE `reviewer_suggestions` (
  `reviewer_suggestion_id` bigint(20) NOT NULL,
  `suggesting_user_id` bigint(20) DEFAULT NULL COMMENT 'The user/author who has made the suggestion',
  `submission_id` bigint(20) NOT NULL COMMENT 'Submission at which the suggestion was made',
  `email` varchar(255) NOT NULL COMMENT 'Suggested reviewer email address',
  `orcid_id` varchar(255) DEFAULT NULL COMMENT 'Suggested reviewer optional Orcid Id',
  `approved_at` timestamp NULL DEFAULT NULL COMMENT 'If and when the suggestion approved to add/invite suggested_reviewer',
  `approver_id` bigint(20) DEFAULT NULL COMMENT 'The user who has approved the suggestion',
  `reviewer_id` bigint(20) DEFAULT NULL COMMENT 'The reviewer who has been added/invited through this suggestion',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Author suggested reviewers at the submission time';

-- --------------------------------------------------------

--
-- Table structure for table `reviewer_suggestion_settings`
--

CREATE TABLE `reviewer_suggestion_settings` (
  `reviewer_suggestion_id` bigint(20) NOT NULL COMMENT 'The foreign key mapping of this setting to reviewer_suggestions table',
  `locale` varchar(28) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Reviewer suggestion settings table to contain multilingual or extra information';

-- --------------------------------------------------------

--
-- Table structure for table `review_assignments`
--

CREATE TABLE `review_assignments` (
  `review_id` bigint(20) NOT NULL,
  `submission_id` bigint(20) NOT NULL,
  `reviewer_id` bigint(20) NOT NULL,
  `competing_interests` text DEFAULT NULL,
  `recommendation` smallint(6) DEFAULT NULL,
  `date_assigned` datetime DEFAULT NULL,
  `date_notified` datetime DEFAULT NULL,
  `date_confirmed` datetime DEFAULT NULL,
  `date_completed` datetime DEFAULT NULL,
  `date_considered` datetime DEFAULT NULL,
  `date_acknowledged` datetime DEFAULT NULL,
  `date_due` datetime DEFAULT NULL,
  `date_response_due` datetime DEFAULT NULL,
  `last_modified` datetime DEFAULT NULL,
  `reminder_was_automatic` smallint(6) NOT NULL DEFAULT 0,
  `declined` smallint(6) NOT NULL DEFAULT 0,
  `cancelled` smallint(6) NOT NULL DEFAULT 0,
  `date_cancelled` datetime DEFAULT NULL,
  `date_rated` datetime DEFAULT NULL,
  `date_reminded` datetime DEFAULT NULL,
  `quality` smallint(6) DEFAULT NULL,
  `review_round_id` bigint(20) NOT NULL,
  `stage_id` smallint(6) NOT NULL,
  `review_method` smallint(6) NOT NULL DEFAULT 1,
  `round` smallint(6) NOT NULL DEFAULT 1,
  `step` smallint(6) NOT NULL DEFAULT 1,
  `review_form_id` bigint(20) DEFAULT NULL,
  `considered` smallint(6) DEFAULT NULL,
  `request_resent` smallint(6) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Data about peer review assignments for all submissions.';

-- --------------------------------------------------------

--
-- Table structure for table `review_assignment_settings`
--

CREATE TABLE `review_assignment_settings` (
  `review_assignment_settings_id` bigint(20) UNSIGNED NOT NULL COMMENT 'Primary key.',
  `review_id` bigint(20) NOT NULL COMMENT 'Foreign key referencing record in review_assignments table',
  `locale` varchar(28) DEFAULT NULL COMMENT 'Locale key.',
  `setting_name` varchar(255) NOT NULL COMMENT 'Name of settings record.',
  `setting_value` mediumtext DEFAULT NULL COMMENT 'Settings value.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `review_files`
--

CREATE TABLE `review_files` (
  `review_file_id` bigint(20) UNSIGNED NOT NULL,
  `review_id` bigint(20) NOT NULL,
  `submission_file_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='A list of the submission files made available to each assigned reviewer.';

-- --------------------------------------------------------

--
-- Table structure for table `review_forms`
--

CREATE TABLE `review_forms` (
  `review_form_id` bigint(20) NOT NULL,
  `assoc_type` bigint(20) NOT NULL,
  `assoc_id` bigint(20) NOT NULL,
  `seq` double DEFAULT NULL,
  `is_active` smallint(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Review forms provide custom templates for peer reviews with several types of questions.';

-- --------------------------------------------------------

--
-- Table structure for table `review_form_elements`
--

CREATE TABLE `review_form_elements` (
  `review_form_element_id` bigint(20) NOT NULL,
  `review_form_id` bigint(20) NOT NULL,
  `seq` double DEFAULT NULL,
  `element_type` bigint(20) DEFAULT NULL,
  `required` smallint(6) DEFAULT NULL,
  `included` smallint(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Each review form element represents a single question on a review form.';

-- --------------------------------------------------------

--
-- Table structure for table `review_form_element_settings`
--

CREATE TABLE `review_form_element_settings` (
  `review_form_element_setting_id` bigint(20) UNSIGNED NOT NULL,
  `review_form_element_id` bigint(20) NOT NULL,
  `locale` varchar(28) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL,
  `setting_type` varchar(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='More data about review form elements, including localized content such as question text.';

-- --------------------------------------------------------

--
-- Table structure for table `review_form_responses`
--

CREATE TABLE `review_form_responses` (
  `review_form_response_id` bigint(20) UNSIGNED NOT NULL,
  `review_form_element_id` bigint(20) NOT NULL,
  `review_id` bigint(20) NOT NULL,
  `response_type` varchar(6) DEFAULT NULL,
  `response_value` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Each review form response records a reviewer''s answer to a review form element associated with a peer review.';

-- --------------------------------------------------------

--
-- Table structure for table `review_form_settings`
--

CREATE TABLE `review_form_settings` (
  `review_form_setting_id` bigint(20) UNSIGNED NOT NULL,
  `review_form_id` bigint(20) NOT NULL,
  `locale` varchar(28) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL,
  `setting_type` varchar(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='More data about review forms, including localized content such as names.';

-- --------------------------------------------------------

--
-- Table structure for table `review_rounds`
--

CREATE TABLE `review_rounds` (
  `review_round_id` bigint(20) NOT NULL,
  `submission_id` bigint(20) NOT NULL,
  `stage_id` bigint(20) DEFAULT NULL,
  `round` smallint(6) NOT NULL,
  `review_revision` bigint(20) DEFAULT NULL,
  `status` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Peer review assignments are organized into multiple rounds on a submission.';

-- --------------------------------------------------------

--
-- Table structure for table `review_round_files`
--

CREATE TABLE `review_round_files` (
  `review_round_file_id` bigint(20) UNSIGNED NOT NULL,
  `submission_id` bigint(20) NOT NULL,
  `review_round_id` bigint(20) NOT NULL,
  `stage_id` smallint(6) NOT NULL,
  `submission_file_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Records the files made available to reviewers for a round of reviews. These can be further customized on a per review basis with review_files.';

-- --------------------------------------------------------

--
-- Table structure for table `rors`
--

CREATE TABLE `rors` (
  `ror_id` bigint(20) NOT NULL,
  `ror` varchar(255) NOT NULL,
  `display_locale` varchar(28) NOT NULL,
  `is_active` smallint(6) NOT NULL DEFAULT 1,
  `search_phrase` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Ror registry dataset cache';

-- --------------------------------------------------------

--
-- Table structure for table `ror_settings`
--

CREATE TABLE `ror_settings` (
  `ror_setting_id` bigint(20) UNSIGNED NOT NULL,
  `ror_id` bigint(20) NOT NULL,
  `locale` varchar(28) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='More data about Ror registry dataset cache';

-- --------------------------------------------------------

--
-- Table structure for table `sections`
--

CREATE TABLE `sections` (
  `section_id` bigint(20) NOT NULL,
  `journal_id` bigint(20) NOT NULL,
  `review_form_id` bigint(20) DEFAULT NULL,
  `seq` double NOT NULL DEFAULT 0,
  `editor_restricted` smallint(6) NOT NULL DEFAULT 0,
  `meta_indexed` smallint(6) NOT NULL DEFAULT 0,
  `meta_reviewed` smallint(6) NOT NULL DEFAULT 1,
  `abstracts_not_required` smallint(6) NOT NULL DEFAULT 0,
  `hide_title` smallint(6) NOT NULL DEFAULT 0,
  `hide_author` smallint(6) NOT NULL DEFAULT 0,
  `is_inactive` smallint(6) NOT NULL DEFAULT 0,
  `abstract_word_count` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='A list of all sections into which submissions can be organized, forming the table of contents.';

--
-- Dumping data for table `sections`
--

INSERT INTO `sections` (`section_id`, `journal_id`, `review_form_id`, `seq`, `editor_restricted`, `meta_indexed`, `meta_reviewed`, `abstracts_not_required`, `hide_title`, `hide_author`, `is_inactive`, `abstract_word_count`) VALUES
(1, 1, NULL, 0, 0, 1, 1, 0, 0, 0, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `section_settings`
--

CREATE TABLE `section_settings` (
  `section_setting_id` bigint(20) UNSIGNED NOT NULL,
  `section_id` bigint(20) NOT NULL,
  `locale` varchar(28) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='More data about sections, including localized properties like section titles.';

--
-- Dumping data for table `section_settings`
--

INSERT INTO `section_settings` (`section_setting_id`, `section_id`, `locale`, `setting_name`, `setting_value`) VALUES
(1, 1, 'en', 'title', 'Articles'),
(2, 1, 'en', 'abbrev', 'ART'),
(3, 1, 'en', 'policy', 'Section default policy');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `last_activity` int(11) NOT NULL,
  `payload` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Session data for logged-in users.';

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `last_activity`, `payload`) VALUES
('ayLXoua4QeNoJ2x6k4LQxgPN3ZQdmRQvgOIQc0fc', 1, '10.0.2.2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36 Edg/143.0.0.0', 1763253366, 'YTo3OntzOjY6Il90b2tlbiI7czo0MDoidGloaDZWSFhNcjFzZHkzYXFIdkRtY2FZVzNjRDhZNGpuSGJyREF2QiI7czo4OiJ1c2VybmFtZSI7czo1OiJhZG1pbiI7czo1OiJlbWFpbCI7czoxOToiYWRtaW5AbG9jYWxob3N0LmNvbSI7czo1MDoibG9naW5fd2ViX2MxYTI2YmMwMDI0OWRjNjIxZjAzYzQxNzc4ZDU1ZmUzMzFlN2U5MTIiO2k6MTtzOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjY6InVzZXJJZCI7aToxO3M6MTc6InBhc3N3b3JkX2hhc2hfd2ViIjtzOjYwOiIkMnkkMTAkZm9CeXZwTERjdFJLTVZNWU5WSjg0ZS5GYklwTXFkUGZPcmpmdHNVUHFyckpzemp1ZXdWdXEiO30='),
('BpIaezE2NM73jJhG6QzbZfIMZj8Nuy9Ewk5Ar59M', NULL, '10.0.2.2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36 Edg/143.0.0.0', 1763247963, 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiNEhDeDlQWTh2Q0ZBeUh0d3p1ODlCQUNFRFlua2ZLRVpIdDQzdm43cSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ=='),
('EoCKHwSm7Yvok86o0D6qcjvFrtm8gtHBMoY8IA2u', NULL, '10.0.2.2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36 Edg/143.0.0.0', 1763244090, 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiUFQwMllZOTNCMHVLVWNHbkx0ZXAwb0JhVFk0RUZKVWVVdEdDQ1ZJeCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ=='),
('iEtUOmFMLzsREHudon9JMl3oi7UYpych0BQa1Zl1', 2, '10.0.2.2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36 Edg/143.0.0.0', 1763247963, 'YToyOntzOjY6Il90b2tlbiI7czo0MDoibWRrOFh3TVRacTFkakFlZHhldzJwSzNPT2ZpWWRudThubHAwQnNyTiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==');

-- --------------------------------------------------------

--
-- Table structure for table `site`
--

CREATE TABLE `site` (
  `site_id` bigint(20) UNSIGNED NOT NULL,
  `redirect_context_id` bigint(20) DEFAULT NULL COMMENT 'If not null, redirect to the specified journal/conference/... site.',
  `primary_locale` varchar(28) NOT NULL COMMENT 'Primary locale for the site.',
  `min_password_length` smallint(6) NOT NULL DEFAULT 6,
  `installed_locales` varchar(1024) NOT NULL DEFAULT 'en' COMMENT 'Locales for which support has been installed.',
  `supported_locales` varchar(1024) DEFAULT NULL COMMENT 'Locales supported by the site (for hosted journals/conferences/...).',
  `original_style_file_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='A singleton table describing basic information about the site.';

--
-- Dumping data for table `site`
--

INSERT INTO `site` (`site_id`, `redirect_context_id`, `primary_locale`, `min_password_length`, `installed_locales`, `supported_locales`, `original_style_file_name`) VALUES
(1, NULL, 'en', 6, '[\"en\"]', '[\"en\"]', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `site_settings`
--

CREATE TABLE `site_settings` (
  `site_setting_id` bigint(20) UNSIGNED NOT NULL,
  `setting_name` varchar(255) NOT NULL,
  `locale` varchar(28) NOT NULL DEFAULT '',
  `setting_value` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='More data about the site, including localized properties such as its name.';

--
-- Dumping data for table `site_settings`
--

INSERT INTO `site_settings` (`site_setting_id`, `setting_name`, `locale`, `setting_value`) VALUES
(1, 'contactEmail', 'en', 'amroz.muzyka@gmail.com'),
(2, 'contactName', 'en', 'Open Journal Systems'),
(3, 'compressStatsLogs', '', '0'),
(4, 'enableGeoUsageStats', '', 'disabled'),
(5, 'enableInstitutionUsageStats', '', '0'),
(6, 'keepDailyUsageStats', '', '0'),
(7, 'isSiteSushiPlatform', '', '0'),
(8, 'isSushiApiPublic', '', '1'),
(9, 'disableSharedReviewerStatistics', '', '0'),
(10, 'orcidClientId', '', ''),
(11, 'orcidClientSecret', '', ''),
(12, 'orcidEnabled', '', '0'),
(13, 'themePluginPath', '', 'default'),
(14, 'uniqueSiteId', '', '52674D73-890E-4D89-B74A-A9E9F3191C28');

-- --------------------------------------------------------

--
-- Table structure for table `stage_assignments`
--

CREATE TABLE `stage_assignments` (
  `stage_assignment_id` bigint(20) NOT NULL,
  `submission_id` bigint(20) NOT NULL,
  `user_group_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `date_assigned` datetime NOT NULL,
  `recommend_only` smallint(6) NOT NULL DEFAULT 0,
  `can_change_metadata` smallint(6) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Who can access a submission while it is in the editorial workflow. Includes all editorial and author assignments. For reviewers, see review_assignments.';

--
-- Dumping data for table `stage_assignments`
--

INSERT INTO `stage_assignments` (`stage_assignment_id`, `submission_id`, `user_group_id`, `user_id`, `date_assigned`, `recommend_only`, `can_change_metadata`) VALUES
(1, 1, 14, 12, '2025-11-16 01:17:36', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `static_pages`
--

CREATE TABLE `static_pages` (
  `static_page_id` bigint(20) NOT NULL,
  `path` varchar(255) NOT NULL,
  `context_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `static_page_settings`
--

CREATE TABLE `static_page_settings` (
  `static_page_setting_id` bigint(20) UNSIGNED NOT NULL,
  `static_page_id` bigint(20) NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` longtext DEFAULT NULL,
  `setting_type` varchar(6) NOT NULL COMMENT '(bool|int|float|string|object)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subeditor_submission_group`
--

CREATE TABLE `subeditor_submission_group` (
  `subeditor_submission_group_id` bigint(20) UNSIGNED NOT NULL,
  `context_id` bigint(20) NOT NULL,
  `assoc_id` bigint(20) NOT NULL,
  `assoc_type` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `user_group_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Subeditor assignments to e.g. sections and categories';

-- --------------------------------------------------------

--
-- Table structure for table `submissions`
--

CREATE TABLE `submissions` (
  `submission_id` bigint(20) NOT NULL,
  `context_id` bigint(20) NOT NULL,
  `current_publication_id` bigint(20) DEFAULT NULL,
  `date_last_activity` datetime DEFAULT NULL,
  `date_submitted` datetime DEFAULT NULL,
  `last_modified` datetime DEFAULT NULL,
  `stage_id` bigint(20) NOT NULL DEFAULT 1,
  `locale` varchar(28) DEFAULT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1,
  `submission_progress` varchar(50) NOT NULL DEFAULT 'start',
  `work_type` smallint(6) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='All submissions submitted to the context, including incomplete, declined and unpublished submissions.';

--
-- Dumping data for table `submissions`
--

INSERT INTO `submissions` (`submission_id`, `context_id`, `current_publication_id`, `date_last_activity`, `date_submitted`, `last_modified`, `stage_id`, `locale`, `status`, `submission_progress`, `work_type`) VALUES
(1, 1, 1, '2025-11-16 01:29:44', '2025-11-16 01:29:44', '2025-11-16 01:29:44', 1, 'en', 1, '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `submission_comments`
--

CREATE TABLE `submission_comments` (
  `comment_id` bigint(20) NOT NULL,
  `comment_type` bigint(20) DEFAULT NULL,
  `role_id` bigint(20) NOT NULL,
  `submission_id` bigint(20) NOT NULL,
  `assoc_id` bigint(20) NOT NULL,
  `author_id` bigint(20) NOT NULL,
  `comment_title` text NOT NULL,
  `comments` text DEFAULT NULL,
  `date_posted` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `viewable` smallint(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Comments on a submission, e.g. peer review comments';

-- --------------------------------------------------------

--
-- Table structure for table `submission_files`
--

CREATE TABLE `submission_files` (
  `submission_file_id` bigint(20) UNSIGNED NOT NULL,
  `submission_id` bigint(20) NOT NULL,
  `file_id` bigint(20) UNSIGNED NOT NULL,
  `source_submission_file_id` bigint(20) UNSIGNED DEFAULT NULL,
  `genre_id` bigint(20) DEFAULT NULL,
  `file_stage` bigint(20) NOT NULL,
  `direct_sales_price` varchar(255) DEFAULT NULL,
  `sales_type` varchar(255) DEFAULT NULL,
  `viewable` smallint(6) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `uploader_user_id` bigint(20) DEFAULT NULL,
  `assoc_type` bigint(20) DEFAULT NULL,
  `assoc_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='All files associated with a submission, such as those uploaded during submission, as revisions, or by copyeditors or layout editors for production.';

--
-- Dumping data for table `submission_files`
--

INSERT INTO `submission_files` (`submission_file_id`, `submission_id`, `file_id`, `source_submission_file_id`, `genre_id`, `file_stage`, `direct_sales_price`, `sales_type`, `viewable`, `created_at`, `updated_at`, `uploader_user_id`, `assoc_type`, `assoc_id`) VALUES
(1, 1, 1, NULL, 1, 2, NULL, NULL, NULL, '2025-11-16 01:21:15', '2025-11-16 01:21:17', 12, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `submission_file_revisions`
--

CREATE TABLE `submission_file_revisions` (
  `revision_id` bigint(20) UNSIGNED NOT NULL,
  `submission_file_id` bigint(20) UNSIGNED NOT NULL,
  `file_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Revisions map submission_file entries to files on the data store.';

--
-- Dumping data for table `submission_file_revisions`
--

INSERT INTO `submission_file_revisions` (`revision_id`, `submission_file_id`, `file_id`) VALUES
(1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `submission_file_settings`
--

CREATE TABLE `submission_file_settings` (
  `submission_file_setting_id` bigint(20) UNSIGNED NOT NULL,
  `submission_file_id` bigint(20) UNSIGNED NOT NULL,
  `locale` varchar(28) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Localized data about submission files like published metadata.';

--
-- Dumping data for table `submission_file_settings`
--

INSERT INTO `submission_file_settings` (`submission_file_setting_id`, `submission_file_id`, `locale`, `setting_name`, `setting_value`) VALUES
(1, 1, 'en', 'name', 'dummy.docx');

-- --------------------------------------------------------

--
-- Table structure for table `submission_search_keyword_list`
--

CREATE TABLE `submission_search_keyword_list` (
  `keyword_id` bigint(20) NOT NULL,
  `keyword_text` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='A list of all keywords used in the search index';

-- --------------------------------------------------------

--
-- Table structure for table `submission_search_objects`
--

CREATE TABLE `submission_search_objects` (
  `object_id` bigint(20) NOT NULL,
  `submission_id` bigint(20) NOT NULL,
  `type` int(11) NOT NULL COMMENT 'Type of item. E.g., abstract, fulltext, etc.',
  `assoc_id` bigint(20) DEFAULT NULL COMMENT 'Optional ID of an associated record (e.g., a file_id)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='A list of all search objects indexed in the search index';

-- --------------------------------------------------------

--
-- Table structure for table `submission_search_object_keywords`
--

CREATE TABLE `submission_search_object_keywords` (
  `submission_search_object_keyword_id` bigint(20) UNSIGNED NOT NULL,
  `object_id` bigint(20) NOT NULL,
  `keyword_id` bigint(20) NOT NULL,
  `pos` int(11) NOT NULL COMMENT 'Word position of the keyword in the object.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Relationships between search objects and keywords in the search index';

-- --------------------------------------------------------

--
-- Table structure for table `submission_settings`
--

CREATE TABLE `submission_settings` (
  `submission_setting_id` bigint(20) UNSIGNED NOT NULL,
  `submission_id` bigint(20) NOT NULL,
  `locale` varchar(28) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Localized data about submissions';

-- --------------------------------------------------------

--
-- Table structure for table `subscriptions`
--

CREATE TABLE `subscriptions` (
  `subscription_id` bigint(20) NOT NULL,
  `journal_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `type_id` bigint(20) NOT NULL,
  `date_start` date DEFAULT NULL,
  `date_end` datetime DEFAULT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1,
  `membership` varchar(40) DEFAULT NULL,
  `reference_number` varchar(40) DEFAULT NULL,
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='A list of subscriptions, both institutional and individual, for journals that use subscription-based publishing.';

-- --------------------------------------------------------

--
-- Table structure for table `subscription_types`
--

CREATE TABLE `subscription_types` (
  `type_id` bigint(20) NOT NULL,
  `journal_id` bigint(20) NOT NULL,
  `cost` decimal(8,2) UNSIGNED NOT NULL,
  `currency_code_alpha` varchar(3) NOT NULL,
  `duration` smallint(6) DEFAULT NULL,
  `format` smallint(6) NOT NULL,
  `institutional` smallint(6) NOT NULL DEFAULT 0,
  `membership` smallint(6) NOT NULL DEFAULT 0,
  `disable_public_display` smallint(6) NOT NULL,
  `seq` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Subscription types represent the kinds of subscriptions that a user or institution may have, such as an annual subscription or a discounted subscription.';

-- --------------------------------------------------------

--
-- Table structure for table `subscription_type_settings`
--

CREATE TABLE `subscription_type_settings` (
  `subscription_type_setting_id` bigint(20) UNSIGNED NOT NULL,
  `type_id` bigint(20) NOT NULL,
  `locale` varchar(28) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL,
  `setting_type` varchar(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='More data about subscription types, including localized properties such as names.';

-- --------------------------------------------------------

--
-- Table structure for table `temporary_files`
--

CREATE TABLE `temporary_files` (
  `file_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `file_name` varchar(90) NOT NULL,
  `file_type` varchar(255) DEFAULT NULL,
  `file_size` bigint(20) NOT NULL,
  `original_file_name` varchar(127) DEFAULT NULL,
  `date_uploaded` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Temporary files, e.g. where files are kept during an upload process before they are moved somewhere more appropriate.';

-- --------------------------------------------------------

--
-- Table structure for table `usage_stats_institution_temporary_records`
--

CREATE TABLE `usage_stats_institution_temporary_records` (
  `usage_stats_temp_institution_id` bigint(20) UNSIGNED NOT NULL,
  `load_id` varchar(50) NOT NULL,
  `line_number` bigint(20) NOT NULL,
  `institution_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Temporary stats for views and downloads from institutions based on visitor log records. Data in this table is provisional. See the metrics_* tables for compiled stats.';

-- --------------------------------------------------------

--
-- Table structure for table `usage_stats_total_temporary_records`
--

CREATE TABLE `usage_stats_total_temporary_records` (
  `usage_stats_temp_total_id` bigint(20) UNSIGNED NOT NULL,
  `date` datetime NOT NULL,
  `ip` varchar(64) NOT NULL,
  `user_agent` varchar(255) NOT NULL,
  `line_number` bigint(20) NOT NULL,
  `canonical_url` varchar(255) NOT NULL,
  `issue_id` bigint(20) DEFAULT NULL,
  `issue_galley_id` bigint(20) DEFAULT NULL,
  `context_id` bigint(20) NOT NULL,
  `submission_id` bigint(20) DEFAULT NULL,
  `representation_id` bigint(20) DEFAULT NULL,
  `submission_file_id` bigint(20) UNSIGNED DEFAULT NULL,
  `assoc_type` bigint(20) NOT NULL,
  `file_type` smallint(6) DEFAULT NULL,
  `country` varchar(2) NOT NULL DEFAULT '',
  `region` varchar(3) NOT NULL DEFAULT '',
  `city` varchar(255) NOT NULL DEFAULT '',
  `load_id` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Temporary stats totals based on visitor log records. Data in this table is provisional. See the metrics_* tables for compiled stats.';

-- --------------------------------------------------------

--
-- Table structure for table `usage_stats_unique_item_investigations_temporary_records`
--

CREATE TABLE `usage_stats_unique_item_investigations_temporary_records` (
  `usage_stats_temp_unique_item_id` bigint(20) UNSIGNED NOT NULL,
  `date` datetime NOT NULL,
  `ip` varchar(64) NOT NULL,
  `user_agent` varchar(255) NOT NULL,
  `line_number` bigint(20) NOT NULL,
  `context_id` bigint(20) NOT NULL,
  `submission_id` bigint(20) NOT NULL,
  `representation_id` bigint(20) DEFAULT NULL,
  `submission_file_id` bigint(20) UNSIGNED DEFAULT NULL,
  `assoc_type` bigint(20) NOT NULL,
  `file_type` smallint(6) DEFAULT NULL,
  `country` varchar(2) NOT NULL DEFAULT '',
  `region` varchar(3) NOT NULL DEFAULT '',
  `city` varchar(255) NOT NULL DEFAULT '',
  `load_id` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Temporary stats on unique downloads based on visitor log records. Data in this table is provisional. See the metrics_* tables for compiled stats.';

-- --------------------------------------------------------

--
-- Table structure for table `usage_stats_unique_item_requests_temporary_records`
--

CREATE TABLE `usage_stats_unique_item_requests_temporary_records` (
  `usage_stats_temp_item_id` bigint(20) UNSIGNED NOT NULL,
  `date` datetime NOT NULL,
  `ip` varchar(64) NOT NULL,
  `user_agent` varchar(255) NOT NULL,
  `line_number` bigint(20) NOT NULL,
  `context_id` bigint(20) NOT NULL,
  `submission_id` bigint(20) NOT NULL,
  `representation_id` bigint(20) DEFAULT NULL,
  `submission_file_id` bigint(20) UNSIGNED DEFAULT NULL,
  `assoc_type` bigint(20) NOT NULL,
  `file_type` smallint(6) DEFAULT NULL,
  `country` varchar(2) NOT NULL DEFAULT '',
  `region` varchar(3) NOT NULL DEFAULT '',
  `city` varchar(255) NOT NULL DEFAULT '',
  `load_id` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Temporary stats on unique views based on visitor log records. Data in this table is provisional. See the metrics_* tables for compiled stats.';

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` bigint(20) NOT NULL,
  `username` varchar(32) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `url` varchar(2047) DEFAULT NULL,
  `phone` varchar(32) DEFAULT NULL,
  `mailing_address` varchar(255) DEFAULT NULL,
  `billing_address` varchar(255) DEFAULT NULL,
  `country` varchar(90) DEFAULT NULL,
  `locales` varchar(255) NOT NULL DEFAULT '[]',
  `gossip` text DEFAULT NULL,
  `date_last_email` datetime DEFAULT NULL,
  `date_registered` datetime NOT NULL,
  `date_validated` datetime DEFAULT NULL,
  `date_last_login` datetime DEFAULT NULL,
  `must_change_password` smallint(6) DEFAULT NULL,
  `auth_id` bigint(20) DEFAULT NULL,
  `auth_str` varchar(255) DEFAULT NULL,
  `disabled` smallint(6) NOT NULL DEFAULT 0,
  `disabled_reason` text DEFAULT NULL,
  `inline_help` smallint(6) DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='All registered users, including authentication data and profile data.';

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `password`, `email`, `url`, `phone`, `mailing_address`, `billing_address`, `country`, `locales`, `gossip`, `date_last_email`, `date_registered`, `date_validated`, `date_last_login`, `must_change_password`, `auth_id`, `auth_str`, `disabled`, `disabled_reason`, `inline_help`, `remember_token`) VALUES
(1, 'admin', '$2y$10$foByvpLDctRKMVMYNVJ84e.FbIpMqdPfOrjftsUPqrrJszjuewVuq', 'admin@localhost.com', NULL, '', '', NULL, 'PL', '[]', NULL, NULL, '2025-11-15 23:01:21', NULL, '2025-11-16 01:24:47', NULL, NULL, NULL, 0, NULL, 1, 'wvFJY2SjSlNYInDEUkdYhKLnoUiID7hcrqjEaN87FuxV0VS7BcAMCtpFzFn7'),
(2, 'editor.section', '$2y$10$0zkRaCQ0D1tWYrUIHvdLuu4d1I9Ib.IzQat5D7vlXgzTCqtC0R4ki', 'editor.section@localhost.com', NULL, NULL, NULL, NULL, 'SE', '[]', NULL, NULL, '2025-11-15 23:57:01', NULL, '2025-11-16 00:07:25', 0, NULL, NULL, 0, NULL, 1, 'uXojKmS8y4YPkV6mDbp28ToXSN2eb9AHM2QpPbY0qY1G4XNYXY5WN1G8DDMx'),
(3, 'editor.guest', '$2y$10$o3md1gzy6CY6/dg33qd0sOTN0vAnzLQB0Q7hL7n4R0Q9oqdhgReIa', 'editor.guest@localhost.com', NULL, NULL, NULL, NULL, 'ES', '[]', NULL, NULL, '2025-11-16 00:09:56', NULL, '2025-11-16 00:10:09', NULL, NULL, NULL, 0, NULL, 1, 'lV3pd1EX7HWfx3tHbA03g4BVqG09mXjNk23OFRQUH6BeH6e9ub4WgXOUFPaZ'),
(4, 'copyeditor', '$2y$10$l0RrJEuxwxGrfxGUGUuYwuG9fMG92TBF32jct9swqKf.ezQqtU2rm', 'copyeditor@localhost.com', NULL, NULL, NULL, NULL, 'US', '[]', NULL, NULL, '2025-11-16 00:13:57', NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL),
(5, 'reviewer', '$2y$10$CnKXMb7XuuSr6ZzODFgDfuFYgdiTcletFVbBvi52qibOFxDiXoDKa', 'reviewer@localhost.com', NULL, NULL, NULL, NULL, 'UA', '[]', NULL, NULL, '2025-11-16 00:16:41', NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL),
(6, 'editor.layout', '$2y$10$kTqupVa/LfNViXbQtpx.FuldUXHhq1TQDBeb.2RUoXdwfaZV3HSfe', 'editor.layout@localhost.com', NULL, NULL, NULL, NULL, 'GB', '[]', NULL, NULL, '2025-11-16 00:19:15', NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL),
(7, 'editor.journal', '$2y$10$kO8efC3NOxvz9GP.CTGsBuGG.UwGvxayo1A8Zbew3TTfQ4su8CM4a', 'editor.journal@localhost.com', NULL, NULL, NULL, NULL, 'IT', '[]', NULL, NULL, '2025-11-16 00:21:40', NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL),
(8, 'author', '$2y$10$P47fW6WZsg02dfuVr4.hs.x01LZuZX4.DP796v9ckdM/3Q4bSaG0y', 'author@localhost.com', NULL, NULL, NULL, NULL, 'IS', '[]', NULL, NULL, '2025-11-16 00:27:21', '2025-11-16 00:27:52', '2025-11-16 00:28:03', NULL, NULL, NULL, 0, '', 1, 'zrXjAG7b3dHJu1CnrbU64M4dpzrutcQ0sRRTrcU9xfSEK5se9sIBO6lSXr9E'),
(9, 'editor.guest-1', '$2y$10$jWahCDdqRElsr8l4/Vx6VeMv/Lsx8BroOT8GbxZJgtvbnfYlIg6eq', 'editor.guest-1@localhost.com', NULL, NULL, NULL, NULL, 'AM', '[]', NULL, NULL, '2025-11-16 01:06:12', NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL),
(10, 'editor.guest-2', '$2y$10$yoKzrNZ8W97mTESmBDNlhO2/0OOgImMxLp.9xf8xmDBCXAuXmqaQe', 'editor.guest-2@localhost.com', NULL, NULL, NULL, NULL, 'TN', '[]', NULL, NULL, '2025-11-16 01:08:48', NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL),
(11, 'reviewer-1', '$2y$10$5Ol0qBN5KhdMkSZ/IHDwzejRLx5g.tlN2yS4PN8lbCMnSA2qp5GYW', 'reviewer-1@localhost.com', NULL, NULL, NULL, NULL, 'SA', '[]', NULL, NULL, '2025-11-16 01:12:07', NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL),
(12, 'author-1', '$2y$10$KDdk4bKOBpRBvcRjeRn5S.p3tkbHCbjQ2FyTGMKq2V1vG2b0fX5ia', 'author-1@localhost.com', NULL, NULL, NULL, NULL, 'SZ', '[]', NULL, NULL, '2025-11-16 01:13:40', '2025-11-16 01:13:51', '2025-11-16 01:22:29', NULL, NULL, NULL, 0, '', 1, '0ko5b1buqQxyujNyV8cYlOcOobDlmbqrDbDEjSr95qZFD3tDb5u8mhFIC1XR');

-- --------------------------------------------------------

--
-- Table structure for table `user_groups`
--

CREATE TABLE `user_groups` (
  `user_group_id` bigint(20) NOT NULL,
  `context_id` bigint(20) DEFAULT NULL,
  `role_id` bigint(20) NOT NULL,
  `is_default` smallint(6) NOT NULL DEFAULT 0,
  `show_title` smallint(6) NOT NULL DEFAULT 1,
  `permit_self_registration` smallint(6) NOT NULL DEFAULT 0,
  `permit_metadata_edit` smallint(6) NOT NULL DEFAULT 0,
  `permit_settings` smallint(6) NOT NULL DEFAULT 0,
  `masthead` smallint(6) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='All defined user roles in a context, such as Author, Reviewer, Section Editor and Journal Manager.';

--
-- Dumping data for table `user_groups`
--

INSERT INTO `user_groups` (`user_group_id`, `context_id`, `role_id`, `is_default`, `show_title`, `permit_self_registration`, `permit_metadata_edit`, `permit_settings`, `masthead`) VALUES
(1, NULL, 1, 1, 1, 0, 0, 1, 0),
(2, 1, 16, 1, 1, 0, 1, 1, 0),
(3, 1, 16, 1, 1, 0, 1, 1, 1),
(4, 1, 16, 1, 1, 0, 1, 1, 0),
(5, 1, 17, 1, 1, 0, 1, 0, 1),
(6, 1, 17, 1, 1, 0, 0, 0, 0),
(7, 1, 4097, 1, 1, 0, 0, 0, 0),
(8, 1, 4097, 1, 1, 0, 0, 0, 0),
(9, 1, 4097, 1, 1, 0, 0, 0, 0),
(10, 1, 4097, 1, 1, 0, 0, 0, 0),
(11, 1, 4097, 1, 1, 0, 0, 0, 0),
(12, 1, 4097, 1, 1, 0, 0, 0, 0),
(13, 1, 4097, 1, 1, 0, 0, 0, 0),
(14, 1, 65536, 1, 1, 1, 0, 0, 0),
(15, 1, 65536, 1, 1, 0, 0, 0, 0),
(16, 1, 4096, 1, 1, 1, 0, 0, 1),
(17, 1, 1048576, 1, 1, 1, 0, 0, 0),
(18, 1, 2097152, 1, 1, 0, 0, 0, 0),
(19, 1, 4097, 1, 1, 0, 0, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_group_settings`
--

CREATE TABLE `user_group_settings` (
  `user_group_setting_id` bigint(20) UNSIGNED NOT NULL,
  `user_group_id` bigint(20) NOT NULL,
  `locale` varchar(28) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='More data about user groups, including localized properties such as the name.';

--
-- Dumping data for table `user_group_settings`
--

INSERT INTO `user_group_settings` (`user_group_setting_id`, `user_group_id`, `locale`, `setting_name`, `setting_value`) VALUES
(1, 2, '', 'nameLocaleKey', 'default.groups.name.manager'),
(2, 2, '', 'abbrevLocaleKey', 'default.groups.abbrev.manager'),
(3, 2, 'en', 'name', 'Journal manager'),
(4, 2, 'en', 'abbrev', 'JM'),
(5, 3, '', 'nameLocaleKey', 'default.groups.name.editor'),
(6, 3, '', 'abbrevLocaleKey', 'default.groups.abbrev.editor'),
(7, 3, 'en', 'name', 'Journal editor'),
(8, 3, 'en', 'abbrev', 'JE'),
(9, 4, '', 'nameLocaleKey', 'default.groups.name.productionEditor'),
(10, 4, '', 'abbrevLocaleKey', 'default.groups.abbrev.productionEditor'),
(11, 4, 'en', 'name', 'Production editor'),
(12, 4, 'en', 'abbrev', 'ProdE'),
(13, 5, '', 'nameLocaleKey', 'default.groups.name.sectionEditor'),
(14, 5, '', 'abbrevLocaleKey', 'default.groups.abbrev.sectionEditor'),
(15, 5, 'en', 'name', 'Section editor'),
(16, 5, 'en', 'abbrev', 'SecE'),
(17, 6, '', 'nameLocaleKey', 'default.groups.name.guestEditor'),
(18, 6, '', 'abbrevLocaleKey', 'default.groups.abbrev.guestEditor'),
(19, 6, 'en', 'name', 'Guest editor'),
(20, 6, 'en', 'abbrev', 'GE'),
(21, 7, '', 'nameLocaleKey', 'default.groups.name.copyeditor'),
(22, 7, '', 'abbrevLocaleKey', 'default.groups.abbrev.copyeditor'),
(23, 7, 'en', 'name', 'Copyeditor'),
(24, 7, 'en', 'abbrev', 'CE'),
(25, 8, '', 'nameLocaleKey', 'default.groups.name.designer'),
(26, 8, '', 'abbrevLocaleKey', 'default.groups.abbrev.designer'),
(27, 8, 'en', 'name', 'Designer'),
(28, 8, 'en', 'abbrev', 'Design'),
(29, 9, '', 'nameLocaleKey', 'default.groups.name.funding'),
(30, 9, '', 'abbrevLocaleKey', 'default.groups.abbrev.funding'),
(31, 9, 'en', 'name', 'Funding coordinator'),
(32, 9, 'en', 'abbrev', 'FC'),
(33, 10, '', 'nameLocaleKey', 'default.groups.name.indexer'),
(34, 10, '', 'abbrevLocaleKey', 'default.groups.abbrev.indexer'),
(35, 10, 'en', 'name', 'Indexer'),
(36, 10, 'en', 'abbrev', 'IND'),
(37, 11, '', 'nameLocaleKey', 'default.groups.name.layoutEditor'),
(38, 11, '', 'abbrevLocaleKey', 'default.groups.abbrev.layoutEditor'),
(39, 11, 'en', 'name', 'Layout Editor'),
(40, 11, 'en', 'abbrev', 'LE'),
(41, 12, '', 'nameLocaleKey', 'default.groups.name.marketing'),
(42, 12, '', 'abbrevLocaleKey', 'default.groups.abbrev.marketing'),
(43, 12, 'en', 'name', 'Marketing and sales coordinator'),
(44, 12, 'en', 'abbrev', 'MS'),
(45, 13, '', 'nameLocaleKey', 'default.groups.name.proofreader'),
(46, 13, '', 'abbrevLocaleKey', 'default.groups.abbrev.proofreader'),
(47, 13, 'en', 'name', 'Proofreader'),
(48, 13, 'en', 'abbrev', 'PR'),
(49, 14, '', 'nameLocaleKey', 'default.groups.name.author'),
(50, 14, '', 'abbrevLocaleKey', 'default.groups.abbrev.author'),
(51, 14, 'en', 'name', 'Author'),
(52, 14, 'en', 'abbrev', 'AU'),
(53, 15, '', 'nameLocaleKey', 'default.groups.name.translator'),
(54, 15, '', 'abbrevLocaleKey', 'default.groups.abbrev.translator'),
(55, 15, 'en', 'name', 'Translator'),
(56, 15, 'en', 'abbrev', 'Trans'),
(57, 16, '', 'nameLocaleKey', 'default.groups.name.externalReviewer'),
(58, 16, '', 'abbrevLocaleKey', 'default.groups.abbrev.externalReviewer'),
(59, 16, 'en', 'name', 'Reviewer'),
(60, 16, 'en', 'abbrev', 'R'),
(61, 17, '', 'nameLocaleKey', 'default.groups.name.reader'),
(62, 17, '', 'abbrevLocaleKey', 'default.groups.abbrev.reader'),
(63, 17, 'en', 'name', 'Reader'),
(64, 17, 'en', 'abbrev', 'Read'),
(65, 18, '', 'nameLocaleKey', 'default.groups.name.subscriptionManager'),
(66, 18, '', 'abbrevLocaleKey', 'default.groups.abbrev.subscriptionManager'),
(67, 18, 'en', 'name', 'Subscription Manager'),
(68, 18, 'en', 'abbrev', 'SubM'),
(69, 19, '', 'nameLocaleKey', 'default.groups.name.editorialBoardMember'),
(70, 19, '', 'abbrevLocaleKey', 'default.groups.abbrev.editorialBoardMember'),
(71, 19, 'en', 'name', 'Editorial Board Member'),
(72, 19, 'en', 'abbrev', 'EBM');

-- --------------------------------------------------------

--
-- Table structure for table `user_group_stage`
--

CREATE TABLE `user_group_stage` (
  `user_group_stage_id` bigint(20) UNSIGNED NOT NULL,
  `context_id` bigint(20) NOT NULL,
  `user_group_id` bigint(20) NOT NULL,
  `stage_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Which stages of the editorial workflow the user_groups can access.';

--
-- Dumping data for table `user_group_stage`
--

INSERT INTO `user_group_stage` (`user_group_stage_id`, `context_id`, `user_group_id`, `stage_id`) VALUES
(1, 1, 3, 1),
(2, 1, 3, 3),
(3, 1, 3, 4),
(4, 1, 3, 5),
(5, 1, 4, 4),
(6, 1, 4, 5),
(7, 1, 5, 1),
(8, 1, 5, 3),
(9, 1, 5, 4),
(10, 1, 5, 5),
(11, 1, 6, 1),
(12, 1, 6, 3),
(13, 1, 6, 4),
(14, 1, 6, 5),
(15, 1, 7, 4),
(16, 1, 8, 5),
(17, 1, 9, 1),
(18, 1, 9, 3),
(19, 1, 10, 5),
(20, 1, 11, 5),
(21, 1, 12, 4),
(22, 1, 13, 5),
(23, 1, 14, 1),
(24, 1, 14, 3),
(25, 1, 14, 4),
(26, 1, 14, 5),
(27, 1, 15, 1),
(28, 1, 15, 3),
(29, 1, 15, 4),
(30, 1, 15, 5),
(31, 1, 16, 3);

-- --------------------------------------------------------

--
-- Table structure for table `user_interests`
--

CREATE TABLE `user_interests` (
  `user_interest_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `controlled_vocab_entry_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Associates users with user interests (which are stored in the controlled vocabulary tables).';

--
-- Dumping data for table `user_interests`
--

INSERT INTO `user_interests` (`user_interest_id`, `user_id`, `controlled_vocab_entry_id`) VALUES
(1, 8, 1),
(2, 8, 2),
(3, 8, 3),
(4, 8, 4),
(5, 8, 5),
(6, 8, 6);

-- --------------------------------------------------------

--
-- Table structure for table `user_settings`
--

CREATE TABLE `user_settings` (
  `user_setting_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `locale` varchar(28) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='More data about users, including localized properties like their name and affiliation.';

--
-- Dumping data for table `user_settings`
--

INSERT INTO `user_settings` (`user_setting_id`, `user_id`, `locale`, `setting_name`, `setting_value`) VALUES
(1, 1, 'en', 'familyName', 'STROMIT'),
(2, 1, 'en', 'givenName', 'Adrian'),
(4, 2, 'en', 'familyName', 'Ceditto'),
(5, 2, 'en', 'givenName', 'Soren'),
(7, 3, 'en', 'familyName', 'Tudet'),
(8, 3, 'en', 'givenName', 'Sergio'),
(9, 4, 'en', 'affiliation', NULL),
(10, 4, 'en', 'familyName', 'Pedit'),
(11, 4, 'en', 'givenName', 'Cory'),
(12, 5, 'en', 'affiliation', NULL),
(13, 5, 'en', 'familyName', 'Wever'),
(14, 5, 'en', 'givenName', 'Reni'),
(15, 6, 'en', 'affiliation', NULL),
(16, 6, 'en', 'familyName', 'Touret'),
(17, 6, 'en', 'givenName', 'Lydia'),
(18, 7, 'en', 'affiliation', NULL),
(19, 7, 'en', 'familyName', 'Jordi'),
(20, 7, 'en', 'givenName', 'Renato'),
(21, 8, 'en', 'affiliation', 'Iceland University of the Arts'),
(22, 8, 'en', 'familyName', 'Ure'),
(23, 8, 'en', 'givenName', 'Thora'),
(24, 1, 'en', 'preferredPublicName', ''),
(25, 1, '', 'preferredAvatarInitials', ''),
(26, 1, 'en', 'affiliation', ''),
(27, 1, 'en', 'signature', ''),
(28, 9, 'en', 'affiliation', 'Schaefer - Swaniawski University'),
(29, 9, 'en', 'familyName', 'Rau'),
(30, 9, 'en', 'givenName', 'Holden'),
(31, 10, 'en', 'affiliation', 'Hessel - Hintz University'),
(32, 10, 'en', 'familyName', 'Jaskolski'),
(33, 10, 'en', 'givenName', 'Angel'),
(34, 11, 'en', 'affiliation', 'Kilback Group University'),
(35, 11, 'en', 'familyName', 'Wintheiser'),
(36, 11, 'en', 'givenName', 'Alvina'),
(37, 12, 'en', 'affiliation', 'Murray Group University'),
(38, 12, 'en', 'familyName', 'Cummings'),
(39, 12, 'en', 'givenName', 'Calista');

-- --------------------------------------------------------

--
-- Table structure for table `user_user_groups`
--

CREATE TABLE `user_user_groups` (
  `user_user_group_id` bigint(20) UNSIGNED NOT NULL,
  `user_group_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `date_start` datetime DEFAULT NULL,
  `date_end` datetime DEFAULT NULL,
  `masthead` smallint(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Maps users to their assigned user_groups.';

--
-- Dumping data for table `user_user_groups`
--

INSERT INTO `user_user_groups` (`user_user_group_id`, `user_group_id`, `user_id`, `date_start`, `date_end`, `masthead`) VALUES
(1, 1, 1, '2025-11-15 23:01:21', NULL, NULL),
(2, 2, 1, NULL, NULL, NULL),
(3, 5, 2, '2025-11-15 00:00:00', NULL, 1),
(4, 6, 3, '2025-11-16 00:00:00', NULL, 0),
(5, 7, 4, '2025-11-16 00:00:00', NULL, 0),
(6, 16, 5, '2025-11-16 00:00:00', NULL, 1),
(7, 11, 6, '2025-11-16 00:00:00', NULL, 0),
(8, 3, 7, '2025-11-16 00:00:00', NULL, 1),
(9, 16, 8, '2025-11-16 00:27:22', NULL, NULL),
(10, 6, 9, '2025-11-16 00:00:00', NULL, 1),
(11, 6, 10, '2025-11-16 00:00:00', NULL, 1),
(12, 16, 11, '2025-11-16 00:00:00', NULL, 1),
(13, 17, 12, '2025-11-16 01:13:40', NULL, NULL),
(14, 14, 12, '2025-11-16 01:14:51', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `versions`
--

CREATE TABLE `versions` (
  `version_id` bigint(20) UNSIGNED NOT NULL,
  `major` int(11) NOT NULL DEFAULT 0 COMMENT 'Major component of version number, e.g. the 2 in OJS 2.3.8-0',
  `minor` int(11) NOT NULL DEFAULT 0 COMMENT 'Minor component of version number, e.g. the 3 in OJS 2.3.8-0',
  `revision` int(11) NOT NULL DEFAULT 0 COMMENT 'Revision component of version number, e.g. the 8 in OJS 2.3.8-0',
  `build` int(11) NOT NULL DEFAULT 0 COMMENT 'Build component of version number, e.g. the 0 in OJS 2.3.8-0',
  `date_installed` datetime NOT NULL,
  `current` smallint(6) NOT NULL DEFAULT 0 COMMENT '1 iff the version entry being described is currently active. This permits the table to store past installation history for forensic purposes.',
  `product_type` varchar(30) DEFAULT NULL COMMENT 'Describes the type of product this row describes, e.g. "plugins.generic" (for a generic plugin) or "core" for the application itself',
  `product` varchar(30) DEFAULT NULL COMMENT 'Uniquely identifies the product this version row describes, e.g. "ojs2" for OJS 2.x, "languageToggle" for the language toggle block plugin, etc.',
  `product_class_name` varchar(80) DEFAULT NULL COMMENT 'Specifies the class name associated with this product, for plugins, or the empty string where not applicable.',
  `lazy_load` smallint(6) NOT NULL DEFAULT 0 COMMENT '1 iff the row describes a lazy-load plugin; 0 otherwise',
  `sitewide` smallint(6) NOT NULL DEFAULT 0 COMMENT '1 iff the row describes a site-wide plugin; 0 otherwise'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Describes the installation and upgrade version history for the application and all installed plugins.';

--
-- Dumping data for table `versions`
--

INSERT INTO `versions` (`version_id`, `major`, `minor`, `revision`, `build`, `date_installed`, `current`, `product_type`, `product`, `product_class_name`, `lazy_load`, `sitewide`) VALUES
(1, 1, 0, 0, 0, '2025-11-15 23:01:23', 1, 'plugins.metadata', 'dc11', '', 0, 0),
(2, 1, 0, 0, 0, '2025-11-15 23:01:23', 1, 'plugins.blocks', 'languageToggle', 'LanguageToggleBlockPlugin', 1, 0),
(3, 1, 0, 1, 0, '2025-11-15 23:01:23', 1, 'plugins.blocks', 'browse', 'BrowseBlockPlugin', 1, 0),
(4, 1, 0, 0, 0, '2025-11-15 23:01:23', 1, 'plugins.blocks', 'makeSubmission', 'MakeSubmissionBlockPlugin', 1, 0),
(5, 1, 0, 0, 0, '2025-11-15 23:01:23', 1, 'plugins.blocks', 'information', 'InformationBlockPlugin', 1, 0),
(6, 1, 0, 0, 0, '2025-11-15 23:01:23', 1, 'plugins.blocks', 'developedBy', 'DevelopedByBlockPlugin', 1, 0),
(7, 1, 1, 0, 0, '2025-11-15 23:01:23', 1, 'plugins.blocks', 'subscription', 'SubscriptionBlockPlugin', 1, 0),
(8, 1, 0, 0, 0, '2025-11-15 23:01:23', 1, 'plugins.generic', 'webFeed', 'WebFeedPlugin', 1, 0),
(9, 0, 1, 0, 0, '2025-11-15 23:01:23', 1, 'plugins.generic', 'citationStyleLanguage', 'CitationStyleLanguagePlugin', 1, 0),
(10, 1, 0, 8, 0, '2025-11-15 23:01:23', 1, 'plugins.generic', 'jatsTemplate', 'JatsTemplatePlugin', 1, 0),
(11, 1, 0, 0, 0, '2025-11-15 23:01:23', 1, 'plugins.generic', 'dublinCoreMeta', 'DublinCoreMetaPlugin', 1, 0),
(12, 1, 0, 1, 0, '2025-11-15 23:01:23', 1, 'plugins.generic', 'pdfJsViewer', 'PdfJsViewerPlugin', 1, 0),
(13, 1, 2, 0, 0, '2025-11-15 23:01:23', 1, 'plugins.generic', 'credit', 'CreditPlugin', 1, 0),
(14, 1, 0, 0, 1, '2025-11-15 23:01:23', 1, 'plugins.generic', 'recommendByAuthor', 'RecommendByAuthorPlugin', 1, 1),
(15, 1, 0, 0, 0, '2025-11-15 23:01:23', 1, 'plugins.generic', 'tinymce', 'TinyMCEPlugin', 1, 0),
(16, 1, 2, 0, 0, '2025-11-15 23:01:23', 1, 'plugins.generic', 'staticPages', 'StaticPagesPlugin', 1, 0),
(17, 1, 0, 0, 0, '2025-11-15 23:01:23', 1, 'plugins.generic', 'googleAnalytics', 'GoogleAnalyticsPlugin', 1, 0),
(18, 1, 0, 0, 0, '2025-11-15 23:01:24', 1, 'plugins.generic', 'recommendBySimilarity', 'RecommendBySimilarityPlugin', 1, 1),
(19, 2, 0, 0, 0, '2025-11-15 23:01:24', 1, 'plugins.generic', 'datacite', 'DatacitePlugin', 0, 0),
(20, 1, 1, 0, 0, '2025-11-15 23:01:24', 1, 'plugins.generic', 'googleScholar', 'GoogleScholarPlugin', 1, 0),
(21, 1, 0, 0, 0, '2025-11-15 23:01:24', 1, 'plugins.generic', 'driver', 'DRIVERPlugin', 1, 0),
(22, 1, 0, 0, 0, '2025-11-15 23:01:24', 1, 'plugins.generic', 'htmlArticleGalley', 'HtmlArticleGalleyPlugin', 1, 0),
(23, 1, 0, 0, 0, '2025-11-15 23:01:24', 1, 'plugins.generic', 'announcementFeed', 'AnnouncementFeedPlugin', 1, 0),
(24, 1, 0, 1, 0, '2025-11-15 23:01:24', 1, 'plugins.generic', 'lensGalley', 'LensGalleyPlugin', 1, 0),
(25, 1, 2, 0, 0, '2025-11-15 23:01:24', 1, 'plugins.generic', 'customBlockManager', 'CustomBlockManagerPlugin', 1, 0),
(26, 1, 0, 0, 0, '2025-11-15 23:01:24', 1, 'plugins.generic', 'usageEvent', '', 0, 0),
(27, 3, 0, 0, 0, '2025-11-15 23:01:24', 1, 'plugins.generic', 'crossref', 'CrossrefPlugin', 0, 0),
(28, 1, 5, 4, 0, '2025-11-15 23:01:24', 0, 'plugins.generic', 'issuePreselection', 'APP\\plugins\\generic\\issuePreselection\\IssuePreselectionPlugin', 0, 0),
(29, 1, 0, 0, 0, '2025-11-15 23:01:24', 1, 'plugins.importexport', 'users', '', 0, 0),
(30, 1, 1, 0, 0, '2025-11-15 23:01:24', 1, 'plugins.importexport', 'doaj', '', 0, 0),
(31, 1, 0, 0, 0, '2025-11-15 23:01:24', 1, 'plugins.importexport', 'native', '', 0, 0),
(32, 1, 0, 0, 0, '2025-11-15 23:01:24', 1, 'plugins.importexport', 'pubmed', '', 0, 0),
(33, 1, 0, 0, 0, '2025-11-15 23:01:24', 1, 'plugins.oaiMetadataFormats', 'rfc1807', '', 0, 0),
(34, 1, 0, 6, 0, '2025-11-15 23:01:24', 1, 'plugins.oaiMetadataFormats', 'oaiJats', '', 0, 0),
(35, 1, 0, 0, 0, '2025-11-15 23:01:24', 1, 'plugins.oaiMetadataFormats', 'dc', '', 0, 0),
(36, 1, 0, 0, 0, '2025-11-15 23:01:24', 1, 'plugins.oaiMetadataFormats', 'marc', '', 0, 0),
(37, 1, 0, 0, 0, '2025-11-15 23:01:24', 1, 'plugins.oaiMetadataFormats', 'marcxml', '', 0, 0),
(38, 1, 0, 0, 0, '2025-11-15 23:01:24', 1, 'plugins.paymethod', 'manual', '', 0, 0),
(39, 1, 0, 0, 0, '2025-11-15 23:01:24', 1, 'plugins.paymethod', 'paypal', '', 0, 0),
(40, 1, 0, 0, 0, '2025-11-15 23:01:24', 1, 'plugins.pubIds', 'urn', 'URNPubIdPlugin', 1, 0),
(41, 1, 1, 0, 0, '2025-11-15 23:01:24', 1, 'plugins.reports', 'counterReport', '', 0, 0),
(42, 1, 0, 0, 0, '2025-11-15 23:01:24', 1, 'plugins.reports', 'articles', '', 0, 0),
(43, 2, 0, 1, 0, '2025-11-15 23:01:24', 1, 'plugins.reports', 'reviewReport', '', 0, 0),
(44, 1, 0, 0, 0, '2025-11-15 23:01:24', 1, 'plugins.reports', 'subscriptions', '', 0, 0),
(45, 1, 0, 0, 0, '2025-11-15 23:01:24', 1, 'plugins.themes', 'default', 'DefaultThemePlugin', 1, 0),
(46, 3, 5, 0, 1, '2025-11-15 23:00:40', 1, 'core', 'ojs2', '', 0, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `announcements`
--
ALTER TABLE `announcements`
  ADD PRIMARY KEY (`announcement_id`),
  ADD KEY `announcements_type_id` (`type_id`),
  ADD KEY `announcements_assoc` (`assoc_type`,`assoc_id`);

--
-- Indexes for table `announcement_settings`
--
ALTER TABLE `announcement_settings`
  ADD PRIMARY KEY (`announcement_setting_id`),
  ADD UNIQUE KEY `announcement_settings_unique` (`announcement_id`,`locale`,`setting_name`),
  ADD KEY `announcement_settings_announcement_id` (`announcement_id`);

--
-- Indexes for table `announcement_types`
--
ALTER TABLE `announcement_types`
  ADD PRIMARY KEY (`type_id`),
  ADD KEY `announcement_types_context_id` (`context_id`);

--
-- Indexes for table `announcement_type_settings`
--
ALTER TABLE `announcement_type_settings`
  ADD PRIMARY KEY (`announcement_type_setting_id`),
  ADD UNIQUE KEY `announcement_type_settings_unique` (`type_id`,`locale`,`setting_name`),
  ADD KEY `announcement_type_settings_type_id` (`type_id`);

--
-- Indexes for table `authors`
--
ALTER TABLE `authors`
  ADD PRIMARY KEY (`author_id`),
  ADD KEY `authors_user_group_id` (`user_group_id`),
  ADD KEY `authors_publication_id` (`publication_id`);

--
-- Indexes for table `author_affiliations`
--
ALTER TABLE `author_affiliations`
  ADD PRIMARY KEY (`author_affiliation_id`),
  ADD KEY `author_affiliations_ror` (`ror`),
  ADD KEY `author_affiliations_author_id_foreign` (`author_id`);

--
-- Indexes for table `author_affiliation_settings`
--
ALTER TABLE `author_affiliation_settings`
  ADD PRIMARY KEY (`author_affiliation_setting_id`),
  ADD UNIQUE KEY `author_affiliation_settings_unique` (`author_affiliation_id`,`locale`,`setting_name`);

--
-- Indexes for table `author_settings`
--
ALTER TABLE `author_settings`
  ADD PRIMARY KEY (`author_setting_id`),
  ADD UNIQUE KEY `author_settings_unique` (`author_id`,`locale`,`setting_name`),
  ADD KEY `author_settings_author_id` (`author_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`),
  ADD UNIQUE KEY `category_path` (`context_id`,`path`),
  ADD KEY `category_context_id` (`context_id`),
  ADD KEY `category_context_parent_id` (`context_id`,`parent_id`),
  ADD KEY `category_parent_id` (`parent_id`);

--
-- Indexes for table `category_settings`
--
ALTER TABLE `category_settings`
  ADD PRIMARY KEY (`category_setting_id`),
  ADD UNIQUE KEY `category_settings_unique` (`category_id`,`locale`,`setting_name`),
  ADD KEY `category_settings_category_id` (`category_id`);

--
-- Indexes for table `citations`
--
ALTER TABLE `citations`
  ADD PRIMARY KEY (`citation_id`),
  ADD UNIQUE KEY `citations_publication_seq` (`publication_id`,`seq`),
  ADD KEY `citations_publication` (`publication_id`);

--
-- Indexes for table `citation_settings`
--
ALTER TABLE `citation_settings`
  ADD PRIMARY KEY (`citation_setting_id`),
  ADD UNIQUE KEY `citation_settings_unique` (`citation_id`,`locale`,`setting_name`),
  ADD KEY `citation_settings_citation_id` (`citation_id`);

--
-- Indexes for table `completed_payments`
--
ALTER TABLE `completed_payments`
  ADD PRIMARY KEY (`completed_payment_id`),
  ADD KEY `completed_payments_context_id` (`context_id`),
  ADD KEY `completed_payments_user_id` (`user_id`);

--
-- Indexes for table `controlled_vocabs`
--
ALTER TABLE `controlled_vocabs`
  ADD PRIMARY KEY (`controlled_vocab_id`),
  ADD UNIQUE KEY `controlled_vocab_symbolic` (`symbolic`,`assoc_type`,`assoc_id`);

--
-- Indexes for table `controlled_vocab_entries`
--
ALTER TABLE `controlled_vocab_entries`
  ADD PRIMARY KEY (`controlled_vocab_entry_id`),
  ADD KEY `controlled_vocab_entries_controlled_vocab_id` (`controlled_vocab_id`),
  ADD KEY `controlled_vocab_entries_cv_id` (`controlled_vocab_id`,`seq`);

--
-- Indexes for table `controlled_vocab_entry_settings`
--
ALTER TABLE `controlled_vocab_entry_settings`
  ADD PRIMARY KEY (`controlled_vocab_entry_setting_id`),
  ADD UNIQUE KEY `c_v_e_s_pkey` (`controlled_vocab_entry_id`,`locale`,`setting_name`),
  ADD KEY `c_v_e_s_entry_id` (`controlled_vocab_entry_id`);

--
-- Indexes for table `custom_issue_orders`
--
ALTER TABLE `custom_issue_orders`
  ADD PRIMARY KEY (`custom_issue_order_id`),
  ADD UNIQUE KEY `custom_issue_orders_unique` (`issue_id`),
  ADD KEY `custom_issue_orders_issue_id` (`issue_id`),
  ADD KEY `custom_issue_orders_journal_id` (`journal_id`);

--
-- Indexes for table `custom_section_orders`
--
ALTER TABLE `custom_section_orders`
  ADD PRIMARY KEY (`custom_section_order_id`),
  ADD UNIQUE KEY `custom_section_orders_unique` (`issue_id`,`section_id`),
  ADD KEY `custom_section_orders_issue_id` (`issue_id`),
  ADD KEY `custom_section_orders_section_id` (`section_id`);

--
-- Indexes for table `data_object_tombstones`
--
ALTER TABLE `data_object_tombstones`
  ADD PRIMARY KEY (`tombstone_id`),
  ADD KEY `data_object_tombstones_data_object_id` (`data_object_id`);

--
-- Indexes for table `data_object_tombstone_oai_set_objects`
--
ALTER TABLE `data_object_tombstone_oai_set_objects`
  ADD PRIMARY KEY (`object_id`),
  ADD KEY `data_object_tombstone_oai_set_objects_tombstone_id` (`tombstone_id`);

--
-- Indexes for table `data_object_tombstone_settings`
--
ALTER TABLE `data_object_tombstone_settings`
  ADD PRIMARY KEY (`tombstone_setting_id`),
  ADD UNIQUE KEY `data_object_tombstone_settings_unique` (`tombstone_id`,`locale`,`setting_name`),
  ADD KEY `data_object_tombstone_settings_tombstone_id` (`tombstone_id`);

--
-- Indexes for table `dois`
--
ALTER TABLE `dois`
  ADD PRIMARY KEY (`doi_id`),
  ADD KEY `dois_context_id` (`context_id`);

--
-- Indexes for table `doi_settings`
--
ALTER TABLE `doi_settings`
  ADD PRIMARY KEY (`doi_setting_id`),
  ADD UNIQUE KEY `doi_settings_unique` (`doi_id`,`locale`,`setting_name`),
  ADD KEY `doi_settings_doi_id` (`doi_id`);

--
-- Indexes for table `edit_decisions`
--
ALTER TABLE `edit_decisions`
  ADD PRIMARY KEY (`edit_decision_id`),
  ADD KEY `edit_decisions_submission_id` (`submission_id`),
  ADD KEY `edit_decisions_editor_id` (`editor_id`),
  ADD KEY `edit_decisions_review_round_id` (`review_round_id`);

--
-- Indexes for table `email_log`
--
ALTER TABLE `email_log`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `email_log_sender_id` (`sender_id`),
  ADD KEY `email_log_assoc` (`assoc_type`,`assoc_id`);

--
-- Indexes for table `email_log_users`
--
ALTER TABLE `email_log_users`
  ADD PRIMARY KEY (`email_log_user_id`),
  ADD UNIQUE KEY `email_log_user_id` (`email_log_id`,`user_id`),
  ADD KEY `email_log_users_email_log_id` (`email_log_id`),
  ADD KEY `email_log_users_user_id` (`user_id`);

--
-- Indexes for table `email_templates`
--
ALTER TABLE `email_templates`
  ADD PRIMARY KEY (`email_id`),
  ADD UNIQUE KEY `email_templates_email_key` (`email_key`,`context_id`),
  ADD KEY `email_templates_context_id` (`context_id`),
  ADD KEY `email_templates_alternate_to` (`alternate_to`);

--
-- Indexes for table `email_templates_default_data`
--
ALTER TABLE `email_templates_default_data`
  ADD PRIMARY KEY (`email_templates_default_data_id`),
  ADD UNIQUE KEY `email_templates_default_data_unique` (`email_key`,`locale`);

--
-- Indexes for table `email_templates_settings`
--
ALTER TABLE `email_templates_settings`
  ADD PRIMARY KEY (`email_template_setting_id`),
  ADD UNIQUE KEY `email_templates_settings_unique` (`email_id`,`locale`,`setting_name`),
  ADD KEY `email_templates_settings_email_id` (`email_id`);

--
-- Indexes for table `event_log`
--
ALTER TABLE `event_log`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `event_log_user_id` (`user_id`),
  ADD KEY `event_log_assoc` (`assoc_type`,`assoc_id`);

--
-- Indexes for table `event_log_settings`
--
ALTER TABLE `event_log_settings`
  ADD PRIMARY KEY (`event_log_setting_id`),
  ADD UNIQUE KEY `event_log_settings_unique` (`log_id`,`setting_name`,`locale`),
  ADD KEY `event_log_settings_log_id` (`log_id`),
  ADD KEY `event_log_settings_name_value` (`setting_name`(50),`setting_value`(150));

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `files`
--
ALTER TABLE `files`
  ADD PRIMARY KEY (`file_id`);

--
-- Indexes for table `filters`
--
ALTER TABLE `filters`
  ADD PRIMARY KEY (`filter_id`),
  ADD KEY `filters_filter_group_id` (`filter_group_id`),
  ADD KEY `filters_context_id` (`context_id`),
  ADD KEY `filters_parent_filter_id` (`parent_filter_id`);

--
-- Indexes for table `filter_groups`
--
ALTER TABLE `filter_groups`
  ADD PRIMARY KEY (`filter_group_id`),
  ADD UNIQUE KEY `filter_groups_symbolic` (`symbolic`);

--
-- Indexes for table `filter_settings`
--
ALTER TABLE `filter_settings`
  ADD PRIMARY KEY (`filter_setting_id`),
  ADD UNIQUE KEY `filter_settings_unique` (`filter_id`,`locale`,`setting_name`),
  ADD KEY `filter_settings_id` (`filter_id`);

--
-- Indexes for table `genres`
--
ALTER TABLE `genres`
  ADD PRIMARY KEY (`genre_id`),
  ADD KEY `genres_context_id` (`context_id`);

--
-- Indexes for table `genre_settings`
--
ALTER TABLE `genre_settings`
  ADD PRIMARY KEY (`genre_setting_id`),
  ADD UNIQUE KEY `genre_settings_unique` (`genre_id`,`locale`,`setting_name`),
  ADD KEY `genre_settings_genre_id` (`genre_id`);

--
-- Indexes for table `highlights`
--
ALTER TABLE `highlights`
  ADD PRIMARY KEY (`highlight_id`),
  ADD KEY `highlights_context_id` (`context_id`);

--
-- Indexes for table `highlight_settings`
--
ALTER TABLE `highlight_settings`
  ADD PRIMARY KEY (`highlight_setting_id`),
  ADD UNIQUE KEY `highlight_settings_unique` (`highlight_id`,`locale`,`setting_name`),
  ADD KEY `highlight_settings_highlight_id` (`highlight_id`);

--
-- Indexes for table `institutional_subscriptions`
--
ALTER TABLE `institutional_subscriptions`
  ADD PRIMARY KEY (`institutional_subscription_id`),
  ADD KEY `institutional_subscriptions_subscription_id` (`subscription_id`),
  ADD KEY `institutional_subscriptions_institution_id` (`institution_id`),
  ADD KEY `institutional_subscriptions_domain` (`domain`);

--
-- Indexes for table `institutions`
--
ALTER TABLE `institutions`
  ADD PRIMARY KEY (`institution_id`),
  ADD KEY `institutions_context_id` (`context_id`);

--
-- Indexes for table `institution_ip`
--
ALTER TABLE `institution_ip`
  ADD PRIMARY KEY (`institution_ip_id`),
  ADD KEY `institution_ip_institution_id` (`institution_id`),
  ADD KEY `institution_ip_start` (`ip_start`),
  ADD KEY `institution_ip_end` (`ip_end`);

--
-- Indexes for table `institution_settings`
--
ALTER TABLE `institution_settings`
  ADD PRIMARY KEY (`institution_setting_id`),
  ADD UNIQUE KEY `institution_settings_unique` (`institution_id`,`locale`,`setting_name`),
  ADD KEY `institution_settings_institution_id` (`institution_id`);

--
-- Indexes for table `invitations`
--
ALTER TABLE `invitations`
  ADD PRIMARY KEY (`invitation_id`),
  ADD KEY `invitations_user_id` (`user_id`),
  ADD KEY `invitations_inviter_id` (`inviter_id`),
  ADD KEY `invitations_context_id` (`context_id`),
  ADD KEY `invitations_status_context_id_user_id_type_index` (`status`,`context_id`,`user_id`,`type`),
  ADD KEY `invitations_expiry_date_index` (`expiry_date`);

--
-- Indexes for table `issues`
--
ALTER TABLE `issues`
  ADD PRIMARY KEY (`issue_id`),
  ADD KEY `issues_journal_id` (`journal_id`),
  ADD KEY `issues_doi_id` (`doi_id`),
  ADD KEY `issues_url_path` (`url_path`);

--
-- Indexes for table `issue_files`
--
ALTER TABLE `issue_files`
  ADD PRIMARY KEY (`file_id`),
  ADD KEY `issue_files_issue_id` (`issue_id`);

--
-- Indexes for table `issue_galleys`
--
ALTER TABLE `issue_galleys`
  ADD PRIMARY KEY (`galley_id`),
  ADD KEY `issue_galleys_issue_id` (`issue_id`),
  ADD KEY `issue_galleys_file_id` (`file_id`),
  ADD KEY `issue_galleys_url_path` (`url_path`);

--
-- Indexes for table `issue_galley_settings`
--
ALTER TABLE `issue_galley_settings`
  ADD PRIMARY KEY (`issue_galley_setting_id`),
  ADD UNIQUE KEY `issue_galley_settings_unique` (`galley_id`,`locale`,`setting_name`),
  ADD KEY `issue_galley_settings_galley_id` (`galley_id`);

--
-- Indexes for table `issue_settings`
--
ALTER TABLE `issue_settings`
  ADD PRIMARY KEY (`issue_setting_id`),
  ADD UNIQUE KEY `issue_settings_unique` (`issue_id`,`locale`,`setting_name`),
  ADD KEY `issue_settings_issue_id` (`issue_id`),
  ADD KEY `issue_settings_name_value` (`setting_name`(50),`setting_value`(150));

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_reserved_at_index` (`queue`,`reserved_at`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `journals`
--
ALTER TABLE `journals`
  ADD PRIMARY KEY (`journal_id`),
  ADD UNIQUE KEY `journals_path` (`path`),
  ADD KEY `journals_issue_id` (`current_issue_id`);

--
-- Indexes for table `journal_settings`
--
ALTER TABLE `journal_settings`
  ADD PRIMARY KEY (`journal_setting_id`),
  ADD UNIQUE KEY `journal_settings_unique` (`journal_id`,`locale`,`setting_name`),
  ADD KEY `journal_settings_journal_id` (`journal_id`);

--
-- Indexes for table `library_files`
--
ALTER TABLE `library_files`
  ADD PRIMARY KEY (`file_id`),
  ADD KEY `library_files_context_id` (`context_id`),
  ADD KEY `library_files_submission_id` (`submission_id`);

--
-- Indexes for table `library_file_settings`
--
ALTER TABLE `library_file_settings`
  ADD PRIMARY KEY (`library_file_setting_id`),
  ADD UNIQUE KEY `library_file_settings_unique` (`file_id`,`locale`,`setting_name`),
  ADD KEY `library_file_settings_file_id` (`file_id`);

--
-- Indexes for table `metrics_context`
--
ALTER TABLE `metrics_context`
  ADD PRIMARY KEY (`metrics_context_id`),
  ADD KEY `metrics_context_load_id` (`load_id`),
  ADD KEY `metrics_context_context_id` (`context_id`);

--
-- Indexes for table `metrics_counter_submission_daily`
--
ALTER TABLE `metrics_counter_submission_daily`
  ADD PRIMARY KEY (`metrics_counter_submission_daily_id`),
  ADD UNIQUE KEY `msd_uc_load_id_context_id_submission_id_date` (`load_id`,`context_id`,`submission_id`,`date`),
  ADD KEY `msd_load_id` (`load_id`),
  ADD KEY `metrics_counter_submission_daily_context_id` (`context_id`),
  ADD KEY `metrics_counter_submission_daily_submission_id` (`submission_id`),
  ADD KEY `msd_context_id_submission_id` (`context_id`,`submission_id`);

--
-- Indexes for table `metrics_counter_submission_institution_daily`
--
ALTER TABLE `metrics_counter_submission_institution_daily`
  ADD PRIMARY KEY (`metrics_counter_submission_institution_daily_id`),
  ADD UNIQUE KEY `msid_uc_load_id_context_id_submission_id_institution_id_date` (`load_id`,`context_id`,`submission_id`,`institution_id`,`date`),
  ADD KEY `msid_load_id` (`load_id`),
  ADD KEY `metrics_counter_submission_institution_daily_context_id` (`context_id`),
  ADD KEY `metrics_counter_submission_institution_daily_submission_id` (`submission_id`),
  ADD KEY `metrics_counter_submission_institution_daily_institution_id` (`institution_id`),
  ADD KEY `msid_context_id_submission_id` (`context_id`,`submission_id`);

--
-- Indexes for table `metrics_counter_submission_institution_monthly`
--
ALTER TABLE `metrics_counter_submission_institution_monthly`
  ADD PRIMARY KEY (`metrics_counter_submission_institution_monthly_id`),
  ADD UNIQUE KEY `msim_uc_context_id_submission_id_institution_id_month` (`context_id`,`submission_id`,`institution_id`,`month`),
  ADD KEY `metrics_counter_submission_institution_monthly_context_id` (`context_id`),
  ADD KEY `metrics_counter_submission_institution_monthly_submission_id` (`submission_id`),
  ADD KEY `metrics_counter_submission_institution_monthly_institution_id` (`institution_id`),
  ADD KEY `msim_context_id_submission_id` (`context_id`,`submission_id`);

--
-- Indexes for table `metrics_counter_submission_monthly`
--
ALTER TABLE `metrics_counter_submission_monthly`
  ADD PRIMARY KEY (`metrics_counter_submission_monthly_id`),
  ADD UNIQUE KEY `msm_uc_context_id_submission_id_month` (`context_id`,`submission_id`,`month`),
  ADD KEY `metrics_counter_submission_monthly_context_id` (`context_id`),
  ADD KEY `metrics_counter_submission_monthly_submission_id` (`submission_id`),
  ADD KEY `msm_context_id_submission_id` (`context_id`,`submission_id`);

--
-- Indexes for table `metrics_issue`
--
ALTER TABLE `metrics_issue`
  ADD PRIMARY KEY (`metrics_issue_id`),
  ADD KEY `metrics_issue_load_id` (`load_id`),
  ADD KEY `metrics_issue_context_id` (`context_id`),
  ADD KEY `metrics_issue_issue_id` (`issue_id`),
  ADD KEY `metrics_issue_issue_galley_id` (`issue_galley_id`),
  ADD KEY `metrics_issue_context_id_issue_id` (`context_id`,`issue_id`);

--
-- Indexes for table `metrics_submission`
--
ALTER TABLE `metrics_submission`
  ADD PRIMARY KEY (`metrics_submission_id`),
  ADD KEY `ms_load_id` (`load_id`),
  ADD KEY `metrics_submission_context_id` (`context_id`),
  ADD KEY `metrics_submission_submission_id` (`submission_id`),
  ADD KEY `metrics_submission_representation_id` (`representation_id`),
  ADD KEY `metrics_submission_submission_file_id` (`submission_file_id`),
  ADD KEY `ms_context_id_submission_id_assoc_type_file_type` (`context_id`,`submission_id`,`assoc_type`,`file_type`);

--
-- Indexes for table `metrics_submission_geo_daily`
--
ALTER TABLE `metrics_submission_geo_daily`
  ADD PRIMARY KEY (`metrics_submission_geo_daily_id`),
  ADD UNIQUE KEY `msgd_uc_load_context_submission_c_r_c_date` (`load_id`,`context_id`,`submission_id`,`country`,`region`,`city`(80),`date`),
  ADD KEY `msgd_load_id` (`load_id`),
  ADD KEY `metrics_submission_geo_daily_context_id` (`context_id`),
  ADD KEY `metrics_submission_geo_daily_submission_id` (`submission_id`),
  ADD KEY `msgd_context_id_submission_id` (`context_id`,`submission_id`);

--
-- Indexes for table `metrics_submission_geo_monthly`
--
ALTER TABLE `metrics_submission_geo_monthly`
  ADD PRIMARY KEY (`metrics_submission_geo_monthly_id`),
  ADD UNIQUE KEY `msgm_uc_context_submission_c_r_c_month` (`context_id`,`submission_id`,`country`,`region`,`city`(80),`month`),
  ADD KEY `metrics_submission_geo_monthly_context_id` (`context_id`),
  ADD KEY `metrics_submission_geo_monthly_submission_id` (`submission_id`),
  ADD KEY `msgm_context_id_submission_id` (`context_id`,`submission_id`);

--
-- Indexes for table `navigation_menus`
--
ALTER TABLE `navigation_menus`
  ADD PRIMARY KEY (`navigation_menu_id`),
  ADD KEY `navigation_menus_context_id` (`context_id`);

--
-- Indexes for table `navigation_menu_items`
--
ALTER TABLE `navigation_menu_items`
  ADD PRIMARY KEY (`navigation_menu_item_id`),
  ADD KEY `navigation_menu_items_context_id` (`context_id`);

--
-- Indexes for table `navigation_menu_item_assignments`
--
ALTER TABLE `navigation_menu_item_assignments`
  ADD PRIMARY KEY (`navigation_menu_item_assignment_id`),
  ADD KEY `navigation_menu_item_assignments_navigation_menu_id` (`navigation_menu_id`),
  ADD KEY `navigation_menu_item_assignments_navigation_menu_item_id` (`navigation_menu_item_id`),
  ADD KEY `navigation_menu_item_assignments_parent_id` (`parent_id`);

--
-- Indexes for table `navigation_menu_item_assignment_settings`
--
ALTER TABLE `navigation_menu_item_assignment_settings`
  ADD PRIMARY KEY (`navigation_menu_item_assignment_setting_id`),
  ADD UNIQUE KEY `navigation_menu_item_assignment_settings_unique` (`navigation_menu_item_assignment_id`,`locale`,`setting_name`),
  ADD KEY `navigation_menu_item_assignment_settings_n_m_i_a_id` (`navigation_menu_item_assignment_id`);

--
-- Indexes for table `navigation_menu_item_settings`
--
ALTER TABLE `navigation_menu_item_settings`
  ADD PRIMARY KEY (`navigation_menu_item_setting_id`),
  ADD UNIQUE KEY `navigation_menu_item_settings_unique` (`navigation_menu_item_id`,`locale`,`setting_name`),
  ADD KEY `navigation_menu_item_settings_navigation_menu_item_id` (`navigation_menu_item_id`);

--
-- Indexes for table `notes`
--
ALTER TABLE `notes`
  ADD PRIMARY KEY (`note_id`),
  ADD KEY `notes_user_id` (`user_id`),
  ADD KEY `notes_assoc` (`assoc_type`,`assoc_id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`notification_id`),
  ADD KEY `notifications_context_id` (`context_id`),
  ADD KEY `notifications_user_id` (`user_id`),
  ADD KEY `notifications_context_id_user_id` (`context_id`,`user_id`,`level`),
  ADD KEY `notifications_context_id_level` (`context_id`,`level`),
  ADD KEY `notifications_assoc` (`assoc_type`,`assoc_id`),
  ADD KEY `notifications_user_id_level` (`user_id`,`level`);

--
-- Indexes for table `notification_settings`
--
ALTER TABLE `notification_settings`
  ADD PRIMARY KEY (`notification_setting_id`),
  ADD UNIQUE KEY `notification_settings_unique` (`notification_id`,`locale`,`setting_name`),
  ADD KEY `notification_settings_notification_id` (`notification_id`);

--
-- Indexes for table `notification_subscription_settings`
--
ALTER TABLE `notification_subscription_settings`
  ADD PRIMARY KEY (`setting_id`),
  ADD KEY `notification_subscription_settings_user_id` (`user_id`),
  ADD KEY `notification_subscription_settings_context` (`context_id`);

--
-- Indexes for table `oai_resumption_tokens`
--
ALTER TABLE `oai_resumption_tokens`
  ADD PRIMARY KEY (`oai_resumption_token_id`),
  ADD UNIQUE KEY `oai_resumption_tokens_unique` (`token`);

--
-- Indexes for table `plugin_settings`
--
ALTER TABLE `plugin_settings`
  ADD PRIMARY KEY (`plugin_setting_id`),
  ADD UNIQUE KEY `plugin_settings_unique` (`plugin_name`,`context_id`,`setting_name`),
  ADD KEY `plugin_settings_context_id` (`context_id`),
  ADD KEY `plugin_settings_plugin_name` (`plugin_name`);

--
-- Indexes for table `publications`
--
ALTER TABLE `publications`
  ADD PRIMARY KEY (`publication_id`),
  ADD KEY `publications_primary_contact_id` (`primary_contact_id`),
  ADD KEY `publications_section_id` (`section_id`),
  ADD KEY `publications_submission_id` (`submission_id`),
  ADD KEY `publications_doi_id` (`doi_id`),
  ADD KEY `publications_issue_id_index` (`issue_id`),
  ADD KEY `publications_url_path` (`url_path`);

--
-- Indexes for table `publication_categories`
--
ALTER TABLE `publication_categories`
  ADD PRIMARY KEY (`publication_category_id`),
  ADD UNIQUE KEY `publication_categories_id` (`publication_id`,`category_id`),
  ADD KEY `publication_categories_publication_id` (`publication_id`),
  ADD KEY `publication_categories_category_id` (`category_id`);

--
-- Indexes for table `publication_galleys`
--
ALTER TABLE `publication_galleys`
  ADD PRIMARY KEY (`galley_id`),
  ADD KEY `publication_galleys_publication_id` (`publication_id`),
  ADD KEY `publication_galleys_submission_file_id` (`submission_file_id`),
  ADD KEY `publication_galleys_doi_id` (`doi_id`),
  ADD KEY `publication_galleys_url_path` (`url_path`);

--
-- Indexes for table `publication_galley_settings`
--
ALTER TABLE `publication_galley_settings`
  ADD PRIMARY KEY (`publication_galley_setting_id`),
  ADD UNIQUE KEY `publication_galley_settings_unique` (`galley_id`,`locale`,`setting_name`),
  ADD KEY `publication_galley_settings_galley_id` (`galley_id`),
  ADD KEY `publication_galley_settings_name_value` (`setting_name`(50),`setting_value`(150));

--
-- Indexes for table `publication_settings`
--
ALTER TABLE `publication_settings`
  ADD PRIMARY KEY (`publication_setting_id`),
  ADD UNIQUE KEY `publication_settings_unique` (`publication_id`,`locale`,`setting_name`),
  ADD KEY `publication_settings_name_value` (`setting_name`(50),`setting_value`(150)),
  ADD KEY `publication_settings_publication_id` (`publication_id`);

--
-- Indexes for table `queries`
--
ALTER TABLE `queries`
  ADD PRIMARY KEY (`query_id`),
  ADD KEY `queries_assoc_id` (`assoc_type`,`assoc_id`);

--
-- Indexes for table `query_participants`
--
ALTER TABLE `query_participants`
  ADD PRIMARY KEY (`query_participant_id`),
  ADD UNIQUE KEY `query_participants_unique` (`query_id`,`user_id`),
  ADD KEY `query_participants_query_id` (`query_id`),
  ADD KEY `query_participants_user_id` (`user_id`);

--
-- Indexes for table `queued_payments`
--
ALTER TABLE `queued_payments`
  ADD PRIMARY KEY (`queued_payment_id`);

--
-- Indexes for table `reviewer_suggestions`
--
ALTER TABLE `reviewer_suggestions`
  ADD PRIMARY KEY (`reviewer_suggestion_id`),
  ADD KEY `reviewer_suggestions_suggesting_user_id` (`suggesting_user_id`),
  ADD KEY `reviewer_suggestions_submission_id` (`submission_id`),
  ADD KEY `reviewer_suggestions_approver_id_foreign` (`approver_id`),
  ADD KEY `reviewer_suggestions_reviewer_id_foreign` (`reviewer_id`);

--
-- Indexes for table `reviewer_suggestion_settings`
--
ALTER TABLE `reviewer_suggestion_settings`
  ADD UNIQUE KEY `reviewer_suggestion_settings_unique` (`reviewer_suggestion_id`,`locale`,`setting_name`),
  ADD KEY `reviewer_suggestion_settings_reviewer_suggestion_id` (`reviewer_suggestion_id`),
  ADD KEY `reviewer_suggestion_settings_locale_setting_name_index` (`setting_name`,`locale`);

--
-- Indexes for table `review_assignments`
--
ALTER TABLE `review_assignments`
  ADD PRIMARY KEY (`review_id`),
  ADD KEY `review_assignments_submission_id` (`submission_id`),
  ADD KEY `review_assignments_reviewer_id` (`reviewer_id`),
  ADD KEY `review_assignment_reviewer_round` (`review_round_id`,`reviewer_id`),
  ADD KEY `review_assignments_form_id` (`review_form_id`),
  ADD KEY `review_assignments_reviewer_review` (`reviewer_id`,`review_id`);

--
-- Indexes for table `review_assignment_settings`
--
ALTER TABLE `review_assignment_settings`
  ADD PRIMARY KEY (`review_assignment_settings_id`),
  ADD UNIQUE KEY `review_assignment_settings_unique` (`review_id`,`locale`,`setting_name`),
  ADD KEY `review_assignment_settings_review_id` (`review_id`);

--
-- Indexes for table `review_files`
--
ALTER TABLE `review_files`
  ADD PRIMARY KEY (`review_file_id`),
  ADD UNIQUE KEY `review_files_unique` (`review_id`,`submission_file_id`),
  ADD KEY `review_files_review_id` (`review_id`),
  ADD KEY `review_files_submission_file_id` (`submission_file_id`);

--
-- Indexes for table `review_forms`
--
ALTER TABLE `review_forms`
  ADD PRIMARY KEY (`review_form_id`);

--
-- Indexes for table `review_form_elements`
--
ALTER TABLE `review_form_elements`
  ADD PRIMARY KEY (`review_form_element_id`),
  ADD KEY `review_form_elements_review_form_id` (`review_form_id`);

--
-- Indexes for table `review_form_element_settings`
--
ALTER TABLE `review_form_element_settings`
  ADD PRIMARY KEY (`review_form_element_setting_id`),
  ADD UNIQUE KEY `review_form_element_settings_unique` (`review_form_element_id`,`locale`,`setting_name`),
  ADD KEY `review_form_element_settings_review_form_element_id` (`review_form_element_id`);

--
-- Indexes for table `review_form_responses`
--
ALTER TABLE `review_form_responses`
  ADD PRIMARY KEY (`review_form_response_id`),
  ADD KEY `review_form_responses_review_form_element_id` (`review_form_element_id`),
  ADD KEY `review_form_responses_review_id` (`review_id`),
  ADD KEY `review_form_responses_unique` (`review_form_element_id`,`review_id`);

--
-- Indexes for table `review_form_settings`
--
ALTER TABLE `review_form_settings`
  ADD PRIMARY KEY (`review_form_setting_id`),
  ADD UNIQUE KEY `review_form_settings_unique` (`review_form_id`,`locale`,`setting_name`),
  ADD KEY `review_form_settings_review_form_id` (`review_form_id`);

--
-- Indexes for table `review_rounds`
--
ALTER TABLE `review_rounds`
  ADD PRIMARY KEY (`review_round_id`),
  ADD UNIQUE KEY `review_rounds_submission_id_stage_id_round_pkey` (`submission_id`,`stage_id`,`round`),
  ADD KEY `review_rounds_submission_id` (`submission_id`);

--
-- Indexes for table `review_round_files`
--
ALTER TABLE `review_round_files`
  ADD PRIMARY KEY (`review_round_file_id`),
  ADD UNIQUE KEY `review_round_files_unique` (`submission_id`,`review_round_id`,`submission_file_id`),
  ADD KEY `review_round_files_submission_id` (`submission_id`),
  ADD KEY `review_round_files_review_round_id` (`review_round_id`),
  ADD KEY `review_round_files_submission_file_id` (`submission_file_id`);

--
-- Indexes for table `rors`
--
ALTER TABLE `rors`
  ADD PRIMARY KEY (`ror_id`),
  ADD UNIQUE KEY `rors_unique` (`ror`),
  ADD KEY `rors_display_locale` (`display_locale`),
  ADD KEY `rors_is_active` (`is_active`);

--
-- Indexes for table `ror_settings`
--
ALTER TABLE `ror_settings`
  ADD PRIMARY KEY (`ror_setting_id`),
  ADD UNIQUE KEY `ror_settings_unique` (`ror_id`,`locale`,`setting_name`);

--
-- Indexes for table `sections`
--
ALTER TABLE `sections`
  ADD PRIMARY KEY (`section_id`),
  ADD KEY `sections_journal_id` (`journal_id`),
  ADD KEY `sections_review_form_id` (`review_form_id`);

--
-- Indexes for table `section_settings`
--
ALTER TABLE `section_settings`
  ADD PRIMARY KEY (`section_setting_id`),
  ADD UNIQUE KEY `section_settings_unique` (`section_id`,`locale`,`setting_name`),
  ADD KEY `section_settings_section_id` (`section_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `site`
--
ALTER TABLE `site`
  ADD PRIMARY KEY (`site_id`),
  ADD KEY `site_context_id` (`redirect_context_id`);

--
-- Indexes for table `site_settings`
--
ALTER TABLE `site_settings`
  ADD PRIMARY KEY (`site_setting_id`),
  ADD UNIQUE KEY `site_settings_unique` (`setting_name`,`locale`);

--
-- Indexes for table `stage_assignments`
--
ALTER TABLE `stage_assignments`
  ADD PRIMARY KEY (`stage_assignment_id`),
  ADD UNIQUE KEY `stage_assignment` (`submission_id`,`user_group_id`,`user_id`),
  ADD KEY `stage_assignments_user_group_id` (`user_group_id`),
  ADD KEY `stage_assignments_user_id` (`user_id`),
  ADD KEY `stage_assignments_submission_id` (`submission_id`);

--
-- Indexes for table `static_pages`
--
ALTER TABLE `static_pages`
  ADD PRIMARY KEY (`static_page_id`),
  ADD KEY `static_pages_context_id` (`context_id`);

--
-- Indexes for table `static_page_settings`
--
ALTER TABLE `static_page_settings`
  ADD PRIMARY KEY (`static_page_setting_id`),
  ADD UNIQUE KEY `static_page_settings_unique` (`static_page_id`,`locale`,`setting_name`),
  ADD KEY `static_page_settings_static_page_id` (`static_page_id`);

--
-- Indexes for table `subeditor_submission_group`
--
ALTER TABLE `subeditor_submission_group`
  ADD PRIMARY KEY (`subeditor_submission_group_id`),
  ADD UNIQUE KEY `section_editors_unique` (`context_id`,`assoc_id`,`assoc_type`,`user_id`,`user_group_id`),
  ADD KEY `subeditor_submission_group_context_id` (`context_id`),
  ADD KEY `subeditor_submission_group_user_id` (`user_id`),
  ADD KEY `subeditor_submission_group_user_group_id` (`user_group_id`),
  ADD KEY `subeditor_submission_group_assoc_id` (`assoc_id`,`assoc_type`);

--
-- Indexes for table `submissions`
--
ALTER TABLE `submissions`
  ADD PRIMARY KEY (`submission_id`),
  ADD KEY `submissions_context_id` (`context_id`),
  ADD KEY `submissions_publication_id` (`current_publication_id`);

--
-- Indexes for table `submission_comments`
--
ALTER TABLE `submission_comments`
  ADD PRIMARY KEY (`comment_id`),
  ADD KEY `submission_comments_submission_id` (`submission_id`),
  ADD KEY `submission_comments_author_id` (`author_id`);

--
-- Indexes for table `submission_files`
--
ALTER TABLE `submission_files`
  ADD PRIMARY KEY (`submission_file_id`),
  ADD KEY `submission_files_submission_id` (`submission_id`),
  ADD KEY `submission_files_file_id` (`file_id`),
  ADD KEY `submission_files_genre_id` (`genre_id`),
  ADD KEY `submission_files_uploader_user_id` (`uploader_user_id`),
  ADD KEY `submission_files_stage_assoc` (`file_stage`,`assoc_type`,`assoc_id`),
  ADD KEY `submission_files_source_submission_file_id` (`source_submission_file_id`);

--
-- Indexes for table `submission_file_revisions`
--
ALTER TABLE `submission_file_revisions`
  ADD PRIMARY KEY (`revision_id`),
  ADD KEY `submission_file_revisions_submission_file_id` (`submission_file_id`),
  ADD KEY `submission_file_revisions_file_id` (`file_id`);

--
-- Indexes for table `submission_file_settings`
--
ALTER TABLE `submission_file_settings`
  ADD PRIMARY KEY (`submission_file_setting_id`),
  ADD UNIQUE KEY `submission_file_settings_unique` (`submission_file_id`,`locale`,`setting_name`),
  ADD KEY `submission_file_settings_submission_file_id` (`submission_file_id`);

--
-- Indexes for table `submission_search_keyword_list`
--
ALTER TABLE `submission_search_keyword_list`
  ADD PRIMARY KEY (`keyword_id`),
  ADD UNIQUE KEY `submission_search_keyword_text` (`keyword_text`);

--
-- Indexes for table `submission_search_objects`
--
ALTER TABLE `submission_search_objects`
  ADD PRIMARY KEY (`object_id`),
  ADD KEY `submission_search_objects_submission_id` (`submission_id`);

--
-- Indexes for table `submission_search_object_keywords`
--
ALTER TABLE `submission_search_object_keywords`
  ADD PRIMARY KEY (`submission_search_object_keyword_id`),
  ADD UNIQUE KEY `submission_search_object_keywords_unique` (`object_id`,`pos`),
  ADD KEY `submission_search_object_keywords_object_id` (`object_id`),
  ADD KEY `submission_search_object_keywords_keyword_id` (`keyword_id`);

--
-- Indexes for table `submission_settings`
--
ALTER TABLE `submission_settings`
  ADD PRIMARY KEY (`submission_setting_id`),
  ADD UNIQUE KEY `submission_settings_unique` (`submission_id`,`locale`,`setting_name`),
  ADD KEY `submission_settings_submission_id` (`submission_id`);

--
-- Indexes for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD PRIMARY KEY (`subscription_id`),
  ADD KEY `subscriptions_journal_id` (`journal_id`),
  ADD KEY `subscriptions_user_id` (`user_id`),
  ADD KEY `subscriptions_type_id` (`type_id`);

--
-- Indexes for table `subscription_types`
--
ALTER TABLE `subscription_types`
  ADD PRIMARY KEY (`type_id`),
  ADD KEY `subscription_types_journal_id` (`journal_id`);

--
-- Indexes for table `subscription_type_settings`
--
ALTER TABLE `subscription_type_settings`
  ADD PRIMARY KEY (`subscription_type_setting_id`),
  ADD UNIQUE KEY `subscription_type_settings_unique` (`type_id`,`locale`,`setting_name`),
  ADD KEY `subscription_type_settings_type_id` (`type_id`);

--
-- Indexes for table `temporary_files`
--
ALTER TABLE `temporary_files`
  ADD PRIMARY KEY (`file_id`),
  ADD KEY `temporary_files_user_id` (`user_id`);

--
-- Indexes for table `usage_stats_institution_temporary_records`
--
ALTER TABLE `usage_stats_institution_temporary_records`
  ADD PRIMARY KEY (`usage_stats_temp_institution_id`),
  ADD UNIQUE KEY `usitr_load_id_line_number_institution_id` (`load_id`,`line_number`,`institution_id`),
  ADD KEY `usi_institution_id` (`institution_id`);

--
-- Indexes for table `usage_stats_total_temporary_records`
--
ALTER TABLE `usage_stats_total_temporary_records`
  ADD PRIMARY KEY (`usage_stats_temp_total_id`),
  ADD KEY `usage_stats_total_temporary_records_issue_id` (`issue_id`),
  ADD KEY `usage_stats_total_temporary_records_issue_galley_id` (`issue_galley_id`),
  ADD KEY `usage_stats_total_temporary_records_context_id` (`context_id`),
  ADD KEY `usage_stats_total_temporary_records_submission_id` (`submission_id`),
  ADD KEY `usage_stats_total_temporary_records_representation_id` (`representation_id`),
  ADD KEY `usage_stats_total_temporary_records_submission_file_id` (`submission_file_id`),
  ADD KEY `ust_load_id_context_id_ip_ua_url` (`load_id`,`context_id`,`ip`,`user_agent`,`canonical_url`);

--
-- Indexes for table `usage_stats_unique_item_investigations_temporary_records`
--
ALTER TABLE `usage_stats_unique_item_investigations_temporary_records`
  ADD PRIMARY KEY (`usage_stats_temp_unique_item_id`),
  ADD KEY `usii_context_id` (`context_id`),
  ADD KEY `usii_submission_id` (`submission_id`),
  ADD KEY `usii_representation_id` (`representation_id`),
  ADD KEY `usii_submission_file_id` (`submission_file_id`),
  ADD KEY `usii_load_id_context_id_ip_ua` (`load_id`,`context_id`,`ip`,`user_agent`);

--
-- Indexes for table `usage_stats_unique_item_requests_temporary_records`
--
ALTER TABLE `usage_stats_unique_item_requests_temporary_records`
  ADD PRIMARY KEY (`usage_stats_temp_item_id`),
  ADD KEY `usir_context_id` (`context_id`),
  ADD KEY `usir_submission_id` (`submission_id`),
  ADD KEY `usir_representation_id` (`representation_id`),
  ADD KEY `usir_submission_file_id` (`submission_file_id`),
  ADD KEY `usir_load_id_context_id_ip_ua` (`load_id`,`context_id`,`ip`,`user_agent`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `users_username` (`username`),
  ADD UNIQUE KEY `users_email` (`email`);

--
-- Indexes for table `user_groups`
--
ALTER TABLE `user_groups`
  ADD PRIMARY KEY (`user_group_id`),
  ADD KEY `user_groups_context_id` (`context_id`),
  ADD KEY `user_groups_user_group_id` (`user_group_id`),
  ADD KEY `user_groups_role_id` (`role_id`);

--
-- Indexes for table `user_group_settings`
--
ALTER TABLE `user_group_settings`
  ADD PRIMARY KEY (`user_group_setting_id`),
  ADD UNIQUE KEY `user_group_settings_unique` (`user_group_id`,`locale`,`setting_name`),
  ADD KEY `user_group_settings_user_group_id` (`user_group_id`);

--
-- Indexes for table `user_group_stage`
--
ALTER TABLE `user_group_stage`
  ADD PRIMARY KEY (`user_group_stage_id`),
  ADD UNIQUE KEY `user_group_stage_unique` (`context_id`,`user_group_id`,`stage_id`),
  ADD KEY `user_group_stage_context_id` (`context_id`),
  ADD KEY `user_group_stage_user_group_id` (`user_group_id`),
  ADD KEY `user_group_stage_stage_id` (`stage_id`);

--
-- Indexes for table `user_interests`
--
ALTER TABLE `user_interests`
  ADD PRIMARY KEY (`user_interest_id`),
  ADD UNIQUE KEY `u_e_pkey` (`user_id`,`controlled_vocab_entry_id`),
  ADD KEY `user_interests_user_id` (`user_id`),
  ADD KEY `user_interests_controlled_vocab_entry_id` (`controlled_vocab_entry_id`);

--
-- Indexes for table `user_settings`
--
ALTER TABLE `user_settings`
  ADD PRIMARY KEY (`user_setting_id`),
  ADD UNIQUE KEY `user_settings_unique` (`user_id`,`locale`,`setting_name`),
  ADD KEY `user_settings_user_id` (`user_id`),
  ADD KEY `user_settings_locale_setting_name_index` (`setting_name`,`locale`);

--
-- Indexes for table `user_user_groups`
--
ALTER TABLE `user_user_groups`
  ADD PRIMARY KEY (`user_user_group_id`),
  ADD KEY `user_user_groups_user_group_id` (`user_group_id`),
  ADD KEY `user_user_groups_user_id` (`user_id`);

--
-- Indexes for table `versions`
--
ALTER TABLE `versions`
  ADD PRIMARY KEY (`version_id`),
  ADD UNIQUE KEY `versions_unique` (`product_type`,`product`,`major`,`minor`,`revision`,`build`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `announcements`
--
ALTER TABLE `announcements`
  MODIFY `announcement_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `announcement_settings`
--
ALTER TABLE `announcement_settings`
  MODIFY `announcement_setting_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `announcement_types`
--
ALTER TABLE `announcement_types`
  MODIFY `type_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `announcement_type_settings`
--
ALTER TABLE `announcement_type_settings`
  MODIFY `announcement_type_setting_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `authors`
--
ALTER TABLE `authors`
  MODIFY `author_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `author_affiliations`
--
ALTER TABLE `author_affiliations`
  MODIFY `author_affiliation_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `author_affiliation_settings`
--
ALTER TABLE `author_affiliation_settings`
  MODIFY `author_affiliation_setting_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `author_settings`
--
ALTER TABLE `author_settings`
  MODIFY `author_setting_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `category_settings`
--
ALTER TABLE `category_settings`
  MODIFY `category_setting_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `citations`
--
ALTER TABLE `citations`
  MODIFY `citation_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `citation_settings`
--
ALTER TABLE `citation_settings`
  MODIFY `citation_setting_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `completed_payments`
--
ALTER TABLE `completed_payments`
  MODIFY `completed_payment_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `controlled_vocabs`
--
ALTER TABLE `controlled_vocabs`
  MODIFY `controlled_vocab_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `controlled_vocab_entries`
--
ALTER TABLE `controlled_vocab_entries`
  MODIFY `controlled_vocab_entry_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `controlled_vocab_entry_settings`
--
ALTER TABLE `controlled_vocab_entry_settings`
  MODIFY `controlled_vocab_entry_setting_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `custom_issue_orders`
--
ALTER TABLE `custom_issue_orders`
  MODIFY `custom_issue_order_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `custom_section_orders`
--
ALTER TABLE `custom_section_orders`
  MODIFY `custom_section_order_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `data_object_tombstones`
--
ALTER TABLE `data_object_tombstones`
  MODIFY `tombstone_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `data_object_tombstone_oai_set_objects`
--
ALTER TABLE `data_object_tombstone_oai_set_objects`
  MODIFY `object_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `data_object_tombstone_settings`
--
ALTER TABLE `data_object_tombstone_settings`
  MODIFY `tombstone_setting_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dois`
--
ALTER TABLE `dois`
  MODIFY `doi_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `doi_settings`
--
ALTER TABLE `doi_settings`
  MODIFY `doi_setting_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `edit_decisions`
--
ALTER TABLE `edit_decisions`
  MODIFY `edit_decision_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `email_log`
--
ALTER TABLE `email_log`
  MODIFY `log_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `email_log_users`
--
ALTER TABLE `email_log_users`
  MODIFY `email_log_user_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `email_templates`
--
ALTER TABLE `email_templates`
  MODIFY `email_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `email_templates_default_data`
--
ALTER TABLE `email_templates_default_data`
  MODIFY `email_templates_default_data_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT for table `email_templates_settings`
--
ALTER TABLE `email_templates_settings`
  MODIFY `email_template_setting_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `event_log`
--
ALTER TABLE `event_log`
  MODIFY `log_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `event_log_settings`
--
ALTER TABLE `event_log_settings`
  MODIFY `event_log_setting_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `files`
--
ALTER TABLE `files`
  MODIFY `file_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `filters`
--
ALTER TABLE `filters`
  MODIFY `filter_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `filter_groups`
--
ALTER TABLE `filter_groups`
  MODIFY `filter_group_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `filter_settings`
--
ALTER TABLE `filter_settings`
  MODIFY `filter_setting_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `genres`
--
ALTER TABLE `genres`
  MODIFY `genre_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `genre_settings`
--
ALTER TABLE `genre_settings`
  MODIFY `genre_setting_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `highlights`
--
ALTER TABLE `highlights`
  MODIFY `highlight_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `highlight_settings`
--
ALTER TABLE `highlight_settings`
  MODIFY `highlight_setting_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `institutional_subscriptions`
--
ALTER TABLE `institutional_subscriptions`
  MODIFY `institutional_subscription_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `institutions`
--
ALTER TABLE `institutions`
  MODIFY `institution_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `institution_ip`
--
ALTER TABLE `institution_ip`
  MODIFY `institution_ip_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `institution_settings`
--
ALTER TABLE `institution_settings`
  MODIFY `institution_setting_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `invitations`
--
ALTER TABLE `invitations`
  MODIFY `invitation_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `issues`
--
ALTER TABLE `issues`
  MODIFY `issue_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `issue_files`
--
ALTER TABLE `issue_files`
  MODIFY `file_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `issue_galleys`
--
ALTER TABLE `issue_galleys`
  MODIFY `galley_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `issue_galley_settings`
--
ALTER TABLE `issue_galley_settings`
  MODIFY `issue_galley_setting_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `issue_settings`
--
ALTER TABLE `issue_settings`
  MODIFY `issue_setting_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `journals`
--
ALTER TABLE `journals`
  MODIFY `journal_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `journal_settings`
--
ALTER TABLE `journal_settings`
  MODIFY `journal_setting_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT for table `library_files`
--
ALTER TABLE `library_files`
  MODIFY `file_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `library_file_settings`
--
ALTER TABLE `library_file_settings`
  MODIFY `library_file_setting_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `metrics_context`
--
ALTER TABLE `metrics_context`
  MODIFY `metrics_context_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `metrics_counter_submission_daily`
--
ALTER TABLE `metrics_counter_submission_daily`
  MODIFY `metrics_counter_submission_daily_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `metrics_counter_submission_institution_daily`
--
ALTER TABLE `metrics_counter_submission_institution_daily`
  MODIFY `metrics_counter_submission_institution_daily_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `metrics_counter_submission_institution_monthly`
--
ALTER TABLE `metrics_counter_submission_institution_monthly`
  MODIFY `metrics_counter_submission_institution_monthly_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `metrics_counter_submission_monthly`
--
ALTER TABLE `metrics_counter_submission_monthly`
  MODIFY `metrics_counter_submission_monthly_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `metrics_issue`
--
ALTER TABLE `metrics_issue`
  MODIFY `metrics_issue_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `metrics_submission`
--
ALTER TABLE `metrics_submission`
  MODIFY `metrics_submission_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `metrics_submission_geo_daily`
--
ALTER TABLE `metrics_submission_geo_daily`
  MODIFY `metrics_submission_geo_daily_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `metrics_submission_geo_monthly`
--
ALTER TABLE `metrics_submission_geo_monthly`
  MODIFY `metrics_submission_geo_monthly_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `navigation_menus`
--
ALTER TABLE `navigation_menus`
  MODIFY `navigation_menu_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `navigation_menu_items`
--
ALTER TABLE `navigation_menu_items`
  MODIFY `navigation_menu_item_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `navigation_menu_item_assignments`
--
ALTER TABLE `navigation_menu_item_assignments`
  MODIFY `navigation_menu_item_assignment_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `navigation_menu_item_assignment_settings`
--
ALTER TABLE `navigation_menu_item_assignment_settings`
  MODIFY `navigation_menu_item_assignment_setting_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `navigation_menu_item_settings`
--
ALTER TABLE `navigation_menu_item_settings`
  MODIFY `navigation_menu_item_setting_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `notes`
--
ALTER TABLE `notes`
  MODIFY `note_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `notification_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `notification_settings`
--
ALTER TABLE `notification_settings`
  MODIFY `notification_setting_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `notification_subscription_settings`
--
ALTER TABLE `notification_subscription_settings`
  MODIFY `setting_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oai_resumption_tokens`
--
ALTER TABLE `oai_resumption_tokens`
  MODIFY `oai_resumption_token_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `plugin_settings`
--
ALTER TABLE `plugin_settings`
  MODIFY `plugin_setting_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `publications`
--
ALTER TABLE `publications`
  MODIFY `publication_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `publication_categories`
--
ALTER TABLE `publication_categories`
  MODIFY `publication_category_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `publication_galleys`
--
ALTER TABLE `publication_galleys`
  MODIFY `galley_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `publication_galley_settings`
--
ALTER TABLE `publication_galley_settings`
  MODIFY `publication_galley_setting_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `publication_settings`
--
ALTER TABLE `publication_settings`
  MODIFY `publication_setting_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `queries`
--
ALTER TABLE `queries`
  MODIFY `query_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `query_participants`
--
ALTER TABLE `query_participants`
  MODIFY `query_participant_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `queued_payments`
--
ALTER TABLE `queued_payments`
  MODIFY `queued_payment_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reviewer_suggestions`
--
ALTER TABLE `reviewer_suggestions`
  MODIFY `reviewer_suggestion_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `review_assignments`
--
ALTER TABLE `review_assignments`
  MODIFY `review_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `review_assignment_settings`
--
ALTER TABLE `review_assignment_settings`
  MODIFY `review_assignment_settings_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Primary key.';

--
-- AUTO_INCREMENT for table `review_files`
--
ALTER TABLE `review_files`
  MODIFY `review_file_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `review_forms`
--
ALTER TABLE `review_forms`
  MODIFY `review_form_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `review_form_elements`
--
ALTER TABLE `review_form_elements`
  MODIFY `review_form_element_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `review_form_element_settings`
--
ALTER TABLE `review_form_element_settings`
  MODIFY `review_form_element_setting_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `review_form_responses`
--
ALTER TABLE `review_form_responses`
  MODIFY `review_form_response_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `review_form_settings`
--
ALTER TABLE `review_form_settings`
  MODIFY `review_form_setting_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `review_rounds`
--
ALTER TABLE `review_rounds`
  MODIFY `review_round_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `review_round_files`
--
ALTER TABLE `review_round_files`
  MODIFY `review_round_file_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rors`
--
ALTER TABLE `rors`
  MODIFY `ror_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ror_settings`
--
ALTER TABLE `ror_settings`
  MODIFY `ror_setting_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sections`
--
ALTER TABLE `sections`
  MODIFY `section_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `section_settings`
--
ALTER TABLE `section_settings`
  MODIFY `section_setting_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `site`
--
ALTER TABLE `site`
  MODIFY `site_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `site_settings`
--
ALTER TABLE `site_settings`
  MODIFY `site_setting_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `stage_assignments`
--
ALTER TABLE `stage_assignments`
  MODIFY `stage_assignment_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `static_pages`
--
ALTER TABLE `static_pages`
  MODIFY `static_page_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `static_page_settings`
--
ALTER TABLE `static_page_settings`
  MODIFY `static_page_setting_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subeditor_submission_group`
--
ALTER TABLE `subeditor_submission_group`
  MODIFY `subeditor_submission_group_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `submissions`
--
ALTER TABLE `submissions`
  MODIFY `submission_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `submission_comments`
--
ALTER TABLE `submission_comments`
  MODIFY `comment_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `submission_files`
--
ALTER TABLE `submission_files`
  MODIFY `submission_file_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `submission_file_revisions`
--
ALTER TABLE `submission_file_revisions`
  MODIFY `revision_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `submission_file_settings`
--
ALTER TABLE `submission_file_settings`
  MODIFY `submission_file_setting_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `submission_search_keyword_list`
--
ALTER TABLE `submission_search_keyword_list`
  MODIFY `keyword_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `submission_search_objects`
--
ALTER TABLE `submission_search_objects`
  MODIFY `object_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `submission_search_object_keywords`
--
ALTER TABLE `submission_search_object_keywords`
  MODIFY `submission_search_object_keyword_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `submission_settings`
--
ALTER TABLE `submission_settings`
  MODIFY `submission_setting_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subscriptions`
--
ALTER TABLE `subscriptions`
  MODIFY `subscription_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subscription_types`
--
ALTER TABLE `subscription_types`
  MODIFY `type_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subscription_type_settings`
--
ALTER TABLE `subscription_type_settings`
  MODIFY `subscription_type_setting_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `temporary_files`
--
ALTER TABLE `temporary_files`
  MODIFY `file_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `usage_stats_institution_temporary_records`
--
ALTER TABLE `usage_stats_institution_temporary_records`
  MODIFY `usage_stats_temp_institution_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `usage_stats_total_temporary_records`
--
ALTER TABLE `usage_stats_total_temporary_records`
  MODIFY `usage_stats_temp_total_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `usage_stats_unique_item_investigations_temporary_records`
--
ALTER TABLE `usage_stats_unique_item_investigations_temporary_records`
  MODIFY `usage_stats_temp_unique_item_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `usage_stats_unique_item_requests_temporary_records`
--
ALTER TABLE `usage_stats_unique_item_requests_temporary_records`
  MODIFY `usage_stats_temp_item_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `user_groups`
--
ALTER TABLE `user_groups`
  MODIFY `user_group_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `user_group_settings`
--
ALTER TABLE `user_group_settings`
  MODIFY `user_group_setting_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT for table `user_group_stage`
--
ALTER TABLE `user_group_stage`
  MODIFY `user_group_stage_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `user_interests`
--
ALTER TABLE `user_interests`
  MODIFY `user_interest_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `user_settings`
--
ALTER TABLE `user_settings`
  MODIFY `user_setting_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `user_user_groups`
--
ALTER TABLE `user_user_groups`
  MODIFY `user_user_group_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `versions`
--
ALTER TABLE `versions`
  MODIFY `version_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `announcements`
--
ALTER TABLE `announcements`
  ADD CONSTRAINT `announcements_type_id_foreign` FOREIGN KEY (`type_id`) REFERENCES `announcement_types` (`type_id`) ON DELETE SET NULL;

--
-- Constraints for table `announcement_settings`
--
ALTER TABLE `announcement_settings`
  ADD CONSTRAINT `announcement_settings_announcement_id_foreign` FOREIGN KEY (`announcement_id`) REFERENCES `announcements` (`announcement_id`) ON DELETE CASCADE;

--
-- Constraints for table `announcement_types`
--
ALTER TABLE `announcement_types`
  ADD CONSTRAINT `announcement_types_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE;

--
-- Constraints for table `announcement_type_settings`
--
ALTER TABLE `announcement_type_settings`
  ADD CONSTRAINT `announcement_type_settings_type_id_foreign` FOREIGN KEY (`type_id`) REFERENCES `announcement_types` (`type_id`) ON DELETE CASCADE;

--
-- Constraints for table `authors`
--
ALTER TABLE `authors`
  ADD CONSTRAINT `authors_publication_id_foreign` FOREIGN KEY (`publication_id`) REFERENCES `publications` (`publication_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `authors_user_group_id_foreign` FOREIGN KEY (`user_group_id`) REFERENCES `user_groups` (`user_group_id`) ON DELETE CASCADE;

--
-- Constraints for table `author_affiliations`
--
ALTER TABLE `author_affiliations`
  ADD CONSTRAINT `author_affiliations_author_id_foreign` FOREIGN KEY (`author_id`) REFERENCES `authors` (`author_id`) ON DELETE CASCADE;

--
-- Constraints for table `author_affiliation_settings`
--
ALTER TABLE `author_affiliation_settings`
  ADD CONSTRAINT `author_affiliation_settings_author_affiliation_id_foreign` FOREIGN KEY (`author_affiliation_id`) REFERENCES `author_affiliations` (`author_affiliation_id`) ON DELETE CASCADE;

--
-- Constraints for table `author_settings`
--
ALTER TABLE `author_settings`
  ADD CONSTRAINT `author_settings_author_id` FOREIGN KEY (`author_id`) REFERENCES `authors` (`author_id`) ON DELETE CASCADE;

--
-- Constraints for table `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `categories_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `categories_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`category_id`) ON DELETE SET NULL;

--
-- Constraints for table `category_settings`
--
ALTER TABLE `category_settings`
  ADD CONSTRAINT `category_settings_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE CASCADE;

--
-- Constraints for table `citations`
--
ALTER TABLE `citations`
  ADD CONSTRAINT `citations_publication` FOREIGN KEY (`publication_id`) REFERENCES `publications` (`publication_id`) ON DELETE CASCADE;

--
-- Constraints for table `citation_settings`
--
ALTER TABLE `citation_settings`
  ADD CONSTRAINT `citation_settings_citation_id` FOREIGN KEY (`citation_id`) REFERENCES `citations` (`citation_id`) ON DELETE CASCADE;

--
-- Constraints for table `completed_payments`
--
ALTER TABLE `completed_payments`
  ADD CONSTRAINT `completed_payments_context_id` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `completed_payments_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;

--
-- Constraints for table `controlled_vocab_entries`
--
ALTER TABLE `controlled_vocab_entries`
  ADD CONSTRAINT `controlled_vocab_entries_controlled_vocab_id_foreign` FOREIGN KEY (`controlled_vocab_id`) REFERENCES `controlled_vocabs` (`controlled_vocab_id`) ON DELETE CASCADE;

--
-- Constraints for table `controlled_vocab_entry_settings`
--
ALTER TABLE `controlled_vocab_entry_settings`
  ADD CONSTRAINT `c_v_e_s_entry_id` FOREIGN KEY (`controlled_vocab_entry_id`) REFERENCES `controlled_vocab_entries` (`controlled_vocab_entry_id`) ON DELETE CASCADE;

--
-- Constraints for table `custom_issue_orders`
--
ALTER TABLE `custom_issue_orders`
  ADD CONSTRAINT `custom_issue_orders_issue_id` FOREIGN KEY (`issue_id`) REFERENCES `issues` (`issue_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `custom_issue_orders_journal_id` FOREIGN KEY (`journal_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE;

--
-- Constraints for table `custom_section_orders`
--
ALTER TABLE `custom_section_orders`
  ADD CONSTRAINT `custom_section_orders_issue_id` FOREIGN KEY (`issue_id`) REFERENCES `issues` (`issue_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `custom_section_orders_section_id` FOREIGN KEY (`section_id`) REFERENCES `sections` (`section_id`) ON DELETE CASCADE;

--
-- Constraints for table `data_object_tombstone_oai_set_objects`
--
ALTER TABLE `data_object_tombstone_oai_set_objects`
  ADD CONSTRAINT `data_object_tombstone_oai_set_objects_tombstone_id` FOREIGN KEY (`tombstone_id`) REFERENCES `data_object_tombstones` (`tombstone_id`) ON DELETE CASCADE;

--
-- Constraints for table `data_object_tombstone_settings`
--
ALTER TABLE `data_object_tombstone_settings`
  ADD CONSTRAINT `data_object_tombstone_settings_tombstone_id` FOREIGN KEY (`tombstone_id`) REFERENCES `data_object_tombstones` (`tombstone_id`) ON DELETE CASCADE;

--
-- Constraints for table `dois`
--
ALTER TABLE `dois`
  ADD CONSTRAINT `dois_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE;

--
-- Constraints for table `doi_settings`
--
ALTER TABLE `doi_settings`
  ADD CONSTRAINT `doi_settings_doi_id_foreign` FOREIGN KEY (`doi_id`) REFERENCES `dois` (`doi_id`) ON DELETE CASCADE;

--
-- Constraints for table `edit_decisions`
--
ALTER TABLE `edit_decisions`
  ADD CONSTRAINT `edit_decisions_editor_id` FOREIGN KEY (`editor_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `edit_decisions_review_round_id_foreign` FOREIGN KEY (`review_round_id`) REFERENCES `review_rounds` (`review_round_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `edit_decisions_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE;

--
-- Constraints for table `email_log`
--
ALTER TABLE `email_log`
  ADD CONSTRAINT `email_log_sender_id_foreign` FOREIGN KEY (`sender_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;

--
-- Constraints for table `email_log_users`
--
ALTER TABLE `email_log_users`
  ADD CONSTRAINT `email_log_users_email_log_id_foreign` FOREIGN KEY (`email_log_id`) REFERENCES `email_log` (`log_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `email_log_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `email_templates`
--
ALTER TABLE `email_templates`
  ADD CONSTRAINT `email_templates_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE;

--
-- Constraints for table `email_templates_settings`
--
ALTER TABLE `email_templates_settings`
  ADD CONSTRAINT `email_templates_settings_email_id` FOREIGN KEY (`email_id`) REFERENCES `email_templates` (`email_id`) ON DELETE CASCADE;

--
-- Constraints for table `event_log`
--
ALTER TABLE `event_log`
  ADD CONSTRAINT `event_log_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `event_log_settings`
--
ALTER TABLE `event_log_settings`
  ADD CONSTRAINT `event_log_settings_log_id` FOREIGN KEY (`log_id`) REFERENCES `event_log` (`log_id`) ON DELETE CASCADE;

--
-- Constraints for table `filters`
--
ALTER TABLE `filters`
  ADD CONSTRAINT `filters_context_id` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `filters_filter_group_id_foreign` FOREIGN KEY (`filter_group_id`) REFERENCES `filter_groups` (`filter_group_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `filters_parent_filter_id_foreign` FOREIGN KEY (`parent_filter_id`) REFERENCES `filters` (`filter_id`) ON DELETE CASCADE;

--
-- Constraints for table `filter_settings`
--
ALTER TABLE `filter_settings`
  ADD CONSTRAINT `filter_settings_filter_id_foreign` FOREIGN KEY (`filter_id`) REFERENCES `filters` (`filter_id`) ON DELETE CASCADE;

--
-- Constraints for table `genres`
--
ALTER TABLE `genres`
  ADD CONSTRAINT `genres_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE;

--
-- Constraints for table `genre_settings`
--
ALTER TABLE `genre_settings`
  ADD CONSTRAINT `genre_settings_genre_id_foreign` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`genre_id`) ON DELETE CASCADE;

--
-- Constraints for table `highlights`
--
ALTER TABLE `highlights`
  ADD CONSTRAINT `highlights_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE;

--
-- Constraints for table `highlight_settings`
--
ALTER TABLE `highlight_settings`
  ADD CONSTRAINT `highlight_settings_highlight_id_foreign` FOREIGN KEY (`highlight_id`) REFERENCES `highlights` (`highlight_id`) ON DELETE CASCADE;

--
-- Constraints for table `institutional_subscriptions`
--
ALTER TABLE `institutional_subscriptions`
  ADD CONSTRAINT `institutional_subscriptions_institution_id_foreign` FOREIGN KEY (`institution_id`) REFERENCES `institutions` (`institution_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `institutional_subscriptions_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `subscriptions` (`subscription_id`) ON DELETE CASCADE;

--
-- Constraints for table `institutions`
--
ALTER TABLE `institutions`
  ADD CONSTRAINT `institutions_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE;

--
-- Constraints for table `institution_ip`
--
ALTER TABLE `institution_ip`
  ADD CONSTRAINT `institution_ip_institution_id_foreign` FOREIGN KEY (`institution_id`) REFERENCES `institutions` (`institution_id`) ON DELETE CASCADE;

--
-- Constraints for table `institution_settings`
--
ALTER TABLE `institution_settings`
  ADD CONSTRAINT `institution_settings_institution_id_foreign` FOREIGN KEY (`institution_id`) REFERENCES `institutions` (`institution_id`) ON DELETE CASCADE;

--
-- Constraints for table `invitations`
--
ALTER TABLE `invitations`
  ADD CONSTRAINT `invitations_context_id` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `invitations_inviter_id_foreign` FOREIGN KEY (`inviter_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `invitations_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `issues`
--
ALTER TABLE `issues`
  ADD CONSTRAINT `issues_doi_id_foreign` FOREIGN KEY (`doi_id`) REFERENCES `dois` (`doi_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `issues_journal_id` FOREIGN KEY (`journal_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE;

--
-- Constraints for table `issue_files`
--
ALTER TABLE `issue_files`
  ADD CONSTRAINT `issue_files_issue_id` FOREIGN KEY (`issue_id`) REFERENCES `issues` (`issue_id`) ON DELETE CASCADE;

--
-- Constraints for table `issue_galleys`
--
ALTER TABLE `issue_galleys`
  ADD CONSTRAINT `issue_galleys_file_id` FOREIGN KEY (`file_id`) REFERENCES `issue_files` (`file_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `issue_galleys_issue_id` FOREIGN KEY (`issue_id`) REFERENCES `issues` (`issue_id`) ON DELETE CASCADE;

--
-- Constraints for table `issue_galley_settings`
--
ALTER TABLE `issue_galley_settings`
  ADD CONSTRAINT `issue_galleys_settings_galley_id` FOREIGN KEY (`galley_id`) REFERENCES `issue_galleys` (`galley_id`) ON DELETE CASCADE;

--
-- Constraints for table `issue_settings`
--
ALTER TABLE `issue_settings`
  ADD CONSTRAINT `issue_settings_issue_id` FOREIGN KEY (`issue_id`) REFERENCES `issues` (`issue_id`) ON DELETE CASCADE;

--
-- Constraints for table `journals`
--
ALTER TABLE `journals`
  ADD CONSTRAINT `journals_current_issue_id_foreign` FOREIGN KEY (`current_issue_id`) REFERENCES `issues` (`issue_id`) ON DELETE SET NULL;

--
-- Constraints for table `journal_settings`
--
ALTER TABLE `journal_settings`
  ADD CONSTRAINT `journal_settings_journal_id` FOREIGN KEY (`journal_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE;

--
-- Constraints for table `library_files`
--
ALTER TABLE `library_files`
  ADD CONSTRAINT `library_files_context_id` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `library_files_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE;

--
-- Constraints for table `library_file_settings`
--
ALTER TABLE `library_file_settings`
  ADD CONSTRAINT `library_file_settings_file_id_foreign` FOREIGN KEY (`file_id`) REFERENCES `library_files` (`file_id`) ON DELETE CASCADE;

--
-- Constraints for table `metrics_context`
--
ALTER TABLE `metrics_context`
  ADD CONSTRAINT `metrics_context_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE;

--
-- Constraints for table `metrics_counter_submission_daily`
--
ALTER TABLE `metrics_counter_submission_daily`
  ADD CONSTRAINT `msd_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `msd_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE;

--
-- Constraints for table `metrics_counter_submission_institution_daily`
--
ALTER TABLE `metrics_counter_submission_institution_daily`
  ADD CONSTRAINT `msid_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `msid_institution_id_foreign` FOREIGN KEY (`institution_id`) REFERENCES `institutions` (`institution_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `msid_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE;

--
-- Constraints for table `metrics_counter_submission_institution_monthly`
--
ALTER TABLE `metrics_counter_submission_institution_monthly`
  ADD CONSTRAINT `msim_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `msim_institution_id_foreign` FOREIGN KEY (`institution_id`) REFERENCES `institutions` (`institution_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `msim_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE;

--
-- Constraints for table `metrics_counter_submission_monthly`
--
ALTER TABLE `metrics_counter_submission_monthly`
  ADD CONSTRAINT `msm_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `msm_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE;

--
-- Constraints for table `metrics_issue`
--
ALTER TABLE `metrics_issue`
  ADD CONSTRAINT `metrics_issue_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `metrics_issue_issue_galley_id_foreign` FOREIGN KEY (`issue_galley_id`) REFERENCES `issue_galleys` (`galley_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `metrics_issue_issue_id_foreign` FOREIGN KEY (`issue_id`) REFERENCES `issues` (`issue_id`) ON DELETE CASCADE;

--
-- Constraints for table `metrics_submission`
--
ALTER TABLE `metrics_submission`
  ADD CONSTRAINT `metrics_submission_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `metrics_submission_representation_id_foreign` FOREIGN KEY (`representation_id`) REFERENCES `publication_galleys` (`galley_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `metrics_submission_submission_file_id_foreign` FOREIGN KEY (`submission_file_id`) REFERENCES `submission_files` (`submission_file_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `metrics_submission_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE;

--
-- Constraints for table `metrics_submission_geo_daily`
--
ALTER TABLE `metrics_submission_geo_daily`
  ADD CONSTRAINT `msgd_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `msgd_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE;

--
-- Constraints for table `metrics_submission_geo_monthly`
--
ALTER TABLE `metrics_submission_geo_monthly`
  ADD CONSTRAINT `msgm_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `msgm_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE;

--
-- Constraints for table `navigation_menus`
--
ALTER TABLE `navigation_menus`
  ADD CONSTRAINT `navigation_menus_context_id` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE;

--
-- Constraints for table `navigation_menu_items`
--
ALTER TABLE `navigation_menu_items`
  ADD CONSTRAINT `navigation_menu_items_context_id` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE;

--
-- Constraints for table `navigation_menu_item_assignments`
--
ALTER TABLE `navigation_menu_item_assignments`
  ADD CONSTRAINT `navigation_menu_item_assignments_navigation_menu_id_foreign` FOREIGN KEY (`navigation_menu_id`) REFERENCES `navigation_menus` (`navigation_menu_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `navigation_menu_item_assignments_navigation_menu_item_id_foreign` FOREIGN KEY (`navigation_menu_item_id`) REFERENCES `navigation_menu_items` (`navigation_menu_item_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `navigation_menu_item_assignments_parent_id` FOREIGN KEY (`parent_id`) REFERENCES `navigation_menu_items` (`navigation_menu_item_id`) ON DELETE CASCADE;

--
-- Constraints for table `navigation_menu_item_assignment_settings`
--
ALTER TABLE `navigation_menu_item_assignment_settings`
  ADD CONSTRAINT `assignment_settings_navigation_menu_item_assignment_id` FOREIGN KEY (`navigation_menu_item_assignment_id`) REFERENCES `navigation_menu_item_assignments` (`navigation_menu_item_assignment_id`) ON DELETE CASCADE;

--
-- Constraints for table `navigation_menu_item_settings`
--
ALTER TABLE `navigation_menu_item_settings`
  ADD CONSTRAINT `navigation_menu_item_settings_navigation_menu_id` FOREIGN KEY (`navigation_menu_item_id`) REFERENCES `navigation_menu_items` (`navigation_menu_item_id`) ON DELETE CASCADE;

--
-- Constraints for table `notes`
--
ALTER TABLE `notes`
  ADD CONSTRAINT `notes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `notifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `notification_settings`
--
ALTER TABLE `notification_settings`
  ADD CONSTRAINT `notification_settings_notification_id_foreign` FOREIGN KEY (`notification_id`) REFERENCES `notifications` (`notification_id`) ON DELETE CASCADE;

--
-- Constraints for table `notification_subscription_settings`
--
ALTER TABLE `notification_subscription_settings`
  ADD CONSTRAINT `notification_subscription_settings_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `notification_subscription_settings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `plugin_settings`
--
ALTER TABLE `plugin_settings`
  ADD CONSTRAINT `plugin_settings_context_id` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE;

--
-- Constraints for table `publications`
--
ALTER TABLE `publications`
  ADD CONSTRAINT `publications_doi_id_foreign` FOREIGN KEY (`doi_id`) REFERENCES `dois` (`doi_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `publications_issue_id_foreign` FOREIGN KEY (`issue_id`) REFERENCES `issues` (`issue_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `publications_primary_contact_id` FOREIGN KEY (`primary_contact_id`) REFERENCES `authors` (`author_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `publications_section_id` FOREIGN KEY (`section_id`) REFERENCES `sections` (`section_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `publications_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE;

--
-- Constraints for table `publication_categories`
--
ALTER TABLE `publication_categories`
  ADD CONSTRAINT `publication_categories_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `publication_categories_publication_id_foreign` FOREIGN KEY (`publication_id`) REFERENCES `publications` (`publication_id`) ON DELETE CASCADE;

--
-- Constraints for table `publication_galleys`
--
ALTER TABLE `publication_galleys`
  ADD CONSTRAINT `publication_galleys_doi_id_foreign` FOREIGN KEY (`doi_id`) REFERENCES `dois` (`doi_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `publication_galleys_publication_id` FOREIGN KEY (`publication_id`) REFERENCES `publications` (`publication_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `publication_galleys_submission_file_id_foreign` FOREIGN KEY (`submission_file_id`) REFERENCES `submission_files` (`submission_file_id`);

--
-- Constraints for table `publication_galley_settings`
--
ALTER TABLE `publication_galley_settings`
  ADD CONSTRAINT `publication_galley_settings_galley_id` FOREIGN KEY (`galley_id`) REFERENCES `publication_galleys` (`galley_id`) ON DELETE CASCADE;

--
-- Constraints for table `publication_settings`
--
ALTER TABLE `publication_settings`
  ADD CONSTRAINT `publication_settings_publication_id` FOREIGN KEY (`publication_id`) REFERENCES `publications` (`publication_id`) ON DELETE CASCADE;

--
-- Constraints for table `query_participants`
--
ALTER TABLE `query_participants`
  ADD CONSTRAINT `query_participants_query_id_foreign` FOREIGN KEY (`query_id`) REFERENCES `queries` (`query_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `query_participants_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `reviewer_suggestions`
--
ALTER TABLE `reviewer_suggestions`
  ADD CONSTRAINT `reviewer_suggestions_approver_id_foreign` FOREIGN KEY (`approver_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `reviewer_suggestions_reviewer_id_foreign` FOREIGN KEY (`reviewer_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `reviewer_suggestions_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reviewer_suggestions_suggesting_user_id_foreign` FOREIGN KEY (`suggesting_user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;

--
-- Constraints for table `reviewer_suggestion_settings`
--
ALTER TABLE `reviewer_suggestion_settings`
  ADD CONSTRAINT `reviewer_suggestion_settings_reviewer_suggestion_id_foreign` FOREIGN KEY (`reviewer_suggestion_id`) REFERENCES `reviewer_suggestions` (`reviewer_suggestion_id`) ON DELETE CASCADE;

--
-- Constraints for table `review_assignments`
--
ALTER TABLE `review_assignments`
  ADD CONSTRAINT `review_assignments_review_form_id_foreign` FOREIGN KEY (`review_form_id`) REFERENCES `review_forms` (`review_form_id`),
  ADD CONSTRAINT `review_assignments_review_round_id_foreign` FOREIGN KEY (`review_round_id`) REFERENCES `review_rounds` (`review_round_id`),
  ADD CONSTRAINT `review_assignments_reviewer_id_foreign` FOREIGN KEY (`reviewer_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `review_assignments_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`);

--
-- Constraints for table `review_assignment_settings`
--
ALTER TABLE `review_assignment_settings`
  ADD CONSTRAINT `review_assignment_settings_review_id_foreign` FOREIGN KEY (`review_id`) REFERENCES `review_assignments` (`review_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `review_files`
--
ALTER TABLE `review_files`
  ADD CONSTRAINT `review_files_review_id_foreign` FOREIGN KEY (`review_id`) REFERENCES `review_assignments` (`review_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `review_files_submission_file_id_foreign` FOREIGN KEY (`submission_file_id`) REFERENCES `submission_files` (`submission_file_id`) ON DELETE CASCADE;

--
-- Constraints for table `review_form_elements`
--
ALTER TABLE `review_form_elements`
  ADD CONSTRAINT `review_form_elements_review_form_id` FOREIGN KEY (`review_form_id`) REFERENCES `review_forms` (`review_form_id`) ON DELETE CASCADE;

--
-- Constraints for table `review_form_element_settings`
--
ALTER TABLE `review_form_element_settings`
  ADD CONSTRAINT `review_form_element_settings_review_form_element_id` FOREIGN KEY (`review_form_element_id`) REFERENCES `review_form_elements` (`review_form_element_id`) ON DELETE CASCADE;

--
-- Constraints for table `review_form_responses`
--
ALTER TABLE `review_form_responses`
  ADD CONSTRAINT `review_form_responses_review_form_element_id_foreign` FOREIGN KEY (`review_form_element_id`) REFERENCES `review_form_elements` (`review_form_element_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `review_form_responses_review_id_foreign` FOREIGN KEY (`review_id`) REFERENCES `review_assignments` (`review_id`) ON DELETE CASCADE;

--
-- Constraints for table `review_form_settings`
--
ALTER TABLE `review_form_settings`
  ADD CONSTRAINT `review_form_settings_review_form_id` FOREIGN KEY (`review_form_id`) REFERENCES `review_forms` (`review_form_id`) ON DELETE CASCADE;

--
-- Constraints for table `review_rounds`
--
ALTER TABLE `review_rounds`
  ADD CONSTRAINT `review_rounds_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`);

--
-- Constraints for table `review_round_files`
--
ALTER TABLE `review_round_files`
  ADD CONSTRAINT `review_round_files_review_round_id_foreign` FOREIGN KEY (`review_round_id`) REFERENCES `review_rounds` (`review_round_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `review_round_files_submission_file_id_foreign` FOREIGN KEY (`submission_file_id`) REFERENCES `submission_files` (`submission_file_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `review_round_files_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE;

--
-- Constraints for table `ror_settings`
--
ALTER TABLE `ror_settings`
  ADD CONSTRAINT `ror_settings_ror_id_foreign` FOREIGN KEY (`ror_id`) REFERENCES `rors` (`ror_id`) ON DELETE CASCADE;

--
-- Constraints for table `sections`
--
ALTER TABLE `sections`
  ADD CONSTRAINT `sections_journal_id` FOREIGN KEY (`journal_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sections_review_form_id` FOREIGN KEY (`review_form_id`) REFERENCES `review_forms` (`review_form_id`) ON DELETE SET NULL;

--
-- Constraints for table `section_settings`
--
ALTER TABLE `section_settings`
  ADD CONSTRAINT `section_settings_section_id` FOREIGN KEY (`section_id`) REFERENCES `sections` (`section_id`) ON DELETE CASCADE;

--
-- Constraints for table `sessions`
--
ALTER TABLE `sessions`
  ADD CONSTRAINT `sessions_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `site`
--
ALTER TABLE `site`
  ADD CONSTRAINT `site_redirect_context_id_foreign` FOREIGN KEY (`redirect_context_id`) REFERENCES `journals` (`journal_id`) ON DELETE SET NULL;

--
-- Constraints for table `stage_assignments`
--
ALTER TABLE `stage_assignments`
  ADD CONSTRAINT `stage_assignments_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `stage_assignments_user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_groups` (`user_group_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `stage_assignments_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `static_pages`
--
ALTER TABLE `static_pages`
  ADD CONSTRAINT `static_pages_context_id` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE;

--
-- Constraints for table `static_page_settings`
--
ALTER TABLE `static_page_settings`
  ADD CONSTRAINT `static_page_settings_static_page_id` FOREIGN KEY (`static_page_id`) REFERENCES `static_pages` (`static_page_id`) ON DELETE CASCADE;

--
-- Constraints for table `subeditor_submission_group`
--
ALTER TABLE `subeditor_submission_group`
  ADD CONSTRAINT `section_editors_context_id` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `subeditor_submission_group_user_group_id_foreign` FOREIGN KEY (`user_group_id`) REFERENCES `user_groups` (`user_group_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `subeditor_submission_group_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `submissions`
--
ALTER TABLE `submissions`
  ADD CONSTRAINT `submissions_context_id` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `submissions_publication_id` FOREIGN KEY (`current_publication_id`) REFERENCES `publications` (`publication_id`) ON DELETE SET NULL;

--
-- Constraints for table `submission_comments`
--
ALTER TABLE `submission_comments`
  ADD CONSTRAINT `submission_comments_author_id_foreign` FOREIGN KEY (`author_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `submission_comments_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE;

--
-- Constraints for table `submission_files`
--
ALTER TABLE `submission_files`
  ADD CONSTRAINT `submission_files_file_id_foreign` FOREIGN KEY (`file_id`) REFERENCES `files` (`file_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `submission_files_genre_id_foreign` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`genre_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `submission_files_source_submission_file_id_foreign` FOREIGN KEY (`source_submission_file_id`) REFERENCES `submission_files` (`submission_file_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `submission_files_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `submission_files_uploader_user_id_foreign` FOREIGN KEY (`uploader_user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;

--
-- Constraints for table `submission_file_revisions`
--
ALTER TABLE `submission_file_revisions`
  ADD CONSTRAINT `submission_file_revisions_file_id_foreign` FOREIGN KEY (`file_id`) REFERENCES `files` (`file_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `submission_file_revisions_submission_file_id_foreign` FOREIGN KEY (`submission_file_id`) REFERENCES `submission_files` (`submission_file_id`) ON DELETE CASCADE;

--
-- Constraints for table `submission_file_settings`
--
ALTER TABLE `submission_file_settings`
  ADD CONSTRAINT `submission_file_settings_submission_file_id_foreign` FOREIGN KEY (`submission_file_id`) REFERENCES `submission_files` (`submission_file_id`) ON DELETE CASCADE;

--
-- Constraints for table `submission_search_objects`
--
ALTER TABLE `submission_search_objects`
  ADD CONSTRAINT `submission_search_object_submission` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE;

--
-- Constraints for table `submission_search_object_keywords`
--
ALTER TABLE `submission_search_object_keywords`
  ADD CONSTRAINT `submission_search_object_keywords_keyword_id` FOREIGN KEY (`keyword_id`) REFERENCES `submission_search_keyword_list` (`keyword_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `submission_search_object_keywords_object_id_foreign` FOREIGN KEY (`object_id`) REFERENCES `submission_search_objects` (`object_id`) ON DELETE CASCADE;

--
-- Constraints for table `submission_settings`
--
ALTER TABLE `submission_settings`
  ADD CONSTRAINT `submission_settings_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE;

--
-- Constraints for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD CONSTRAINT `subscriptions_journal_id` FOREIGN KEY (`journal_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `subscriptions_type_id` FOREIGN KEY (`type_id`) REFERENCES `subscription_types` (`type_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `subscriptions_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `subscription_types`
--
ALTER TABLE `subscription_types`
  ADD CONSTRAINT `subscription_types_journal_id` FOREIGN KEY (`journal_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE;

--
-- Constraints for table `subscription_type_settings`
--
ALTER TABLE `subscription_type_settings`
  ADD CONSTRAINT `subscription_type_settings_type_id` FOREIGN KEY (`type_id`) REFERENCES `subscription_types` (`type_id`) ON DELETE CASCADE;

--
-- Constraints for table `temporary_files`
--
ALTER TABLE `temporary_files`
  ADD CONSTRAINT `temporary_files_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `usage_stats_institution_temporary_records`
--
ALTER TABLE `usage_stats_institution_temporary_records`
  ADD CONSTRAINT `usi_institution_id_foreign` FOREIGN KEY (`institution_id`) REFERENCES `institutions` (`institution_id`) ON DELETE CASCADE;

--
-- Constraints for table `usage_stats_total_temporary_records`
--
ALTER TABLE `usage_stats_total_temporary_records`
  ADD CONSTRAINT `ust_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ust_issue_galley_id_foreign` FOREIGN KEY (`issue_galley_id`) REFERENCES `issue_galleys` (`galley_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ust_issue_id_foreign` FOREIGN KEY (`issue_id`) REFERENCES `issues` (`issue_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ust_representation_id_foreign` FOREIGN KEY (`representation_id`) REFERENCES `publication_galleys` (`galley_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ust_submission_file_id_foreign` FOREIGN KEY (`submission_file_id`) REFERENCES `submission_files` (`submission_file_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ust_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE;

--
-- Constraints for table `usage_stats_unique_item_investigations_temporary_records`
--
ALTER TABLE `usage_stats_unique_item_investigations_temporary_records`
  ADD CONSTRAINT `usii_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `usii_representation_id_foreign` FOREIGN KEY (`representation_id`) REFERENCES `publication_galleys` (`galley_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `usii_submission_file_id_foreign` FOREIGN KEY (`submission_file_id`) REFERENCES `submission_files` (`submission_file_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `usii_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE;

--
-- Constraints for table `usage_stats_unique_item_requests_temporary_records`
--
ALTER TABLE `usage_stats_unique_item_requests_temporary_records`
  ADD CONSTRAINT `usir_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `usir_representation_id_foreign` FOREIGN KEY (`representation_id`) REFERENCES `publication_galleys` (`galley_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `usir_submission_file_id_foreign` FOREIGN KEY (`submission_file_id`) REFERENCES `submission_files` (`submission_file_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `usir_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE;

--
-- Constraints for table `user_groups`
--
ALTER TABLE `user_groups`
  ADD CONSTRAINT `user_groups_context_id` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE;

--
-- Constraints for table `user_group_settings`
--
ALTER TABLE `user_group_settings`
  ADD CONSTRAINT `user_group_settings_user_group_id_foreign` FOREIGN KEY (`user_group_id`) REFERENCES `user_groups` (`user_group_id`) ON DELETE CASCADE;

--
-- Constraints for table `user_group_stage`
--
ALTER TABLE `user_group_stage`
  ADD CONSTRAINT `user_group_stage_context_id` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_group_stage_user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_groups` (`user_group_id`) ON DELETE CASCADE;

--
-- Constraints for table `user_interests`
--
ALTER TABLE `user_interests`
  ADD CONSTRAINT `user_interests_controlled_vocab_entry_id_foreign` FOREIGN KEY (`controlled_vocab_entry_id`) REFERENCES `controlled_vocab_entries` (`controlled_vocab_entry_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_interests_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `user_settings`
--
ALTER TABLE `user_settings`
  ADD CONSTRAINT `user_settings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `user_user_groups`
--
ALTER TABLE `user_user_groups`
  ADD CONSTRAINT `user_user_groups_user_group_id_foreign` FOREIGN KEY (`user_group_id`) REFERENCES `user_groups` (`user_group_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_user_groups_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
