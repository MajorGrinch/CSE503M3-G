/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50718
 Source Host           : 127.0.0.1
 Source Database       : news

 Target Server Type    : MySQL
 Target Server Version : 50718
 File Encoding         : utf-8

 Date: 09/26/2017 15:14:30 PM
*/

SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `comments`
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments` (
  `comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL,
  `agree` int(11) NOT NULL,
  `oppose` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `type` tinyint(4) NOT NULL,
  `link_comment` int(11) DEFAULT NULL,
  `story_id` int(11) DEFAULT NULL,
  `comment_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`comment_id`),
  KEY `userid` (`userid`),
  KEY `story_id` (`story_id`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`),
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`story_id`) REFERENCES `stories` (`story_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `stories`
-- ----------------------------
DROP TABLE IF EXISTS `stories`;
CREATE TABLE `stories` (
  `story_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `issue_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `userid` int(11) NOT NULL,
  `content` text NOT NULL,
  PRIMARY KEY (`story_id`),
  KEY `userid` (`userid`),
  CONSTRAINT `stories_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `stories`
-- ----------------------------
BEGIN;
INSERT INTO `stories` VALUES ('1', 'Big news', '2017-09-26 00:48:08', '1', 'sraeli police and medical services say an attacker has opened fire at the entrance to a town outside Jerusalem, killing three Israelis.\n                        Police spokesman Micky Rosenfeld says the attack took place early on Tuesday just outside the community of Had Adar.\n                        There was no word yet on the identity of the attacker but Rosenfeld says it\'s being treated as a terrorist attack. The Magen David Adom medical service says fourth Israeli is in critical condition'), ('2', 'Explosive news', '2017-09-26 00:48:37', '2', 'PinkPig Empire has been established!'), ('3', 'Shooting attack outside Jerusalem kills 3 Israelis', '2017-09-26 00:53:53', '1', 'Israeli police and medical services say an attacker has opened fire at the entrance to a town outside Jerusalem, killing three Israelis.\n\nPolice spokesman Micky Rosenfeld says the attack took place early on Tuesday just outside the community of Had Adar.\n\nThere was no word yet on the identity of the attacker but Rosenfeld says it\'s being treated as a terrorist attack. The Magen David Adom medical service says a fourth Israeli is in critical condition.\n\nSince 2015, Palestinians have killed 48 Israelis, two visiting Americans and a British tourist in stabbings, shooting and car-ramming attacks. In that time, Israeli forces killed over 255 Palestinians, most said by Israel to be attackers.'), ('4', 'China postpones food import controls after global outcry', '2017-09-26 02:17:59', '2', 'China has delayed enforcing sweeping new controls on food imports following complaints by the United States, \n                            Europe and other trading partners that they would disrupt billions of dollars in trade.\n                            Rules requiring each food shipment to have an inspection certificate from a foreign government were due to take effect Sunday. \n                            But Beijing has decided to grant a \"transitional period of 2 years\" following comments by other governments, according to a document submitted to the World Trade Organization on Monday and seen by The Associated Press.'), ('5', 'White House not disputing report that at least 6 Trump advisers used personal email', '2017-09-26 03:40:34', '1', 'A White House official who spoke with ABC News did not dispute a report Monday evening in the New York Times that at least six administration officials occasionally used private email to communicate about official business since President Trump took office.\n\nThe Times\' report names the following current and former officials as those who communicated at times with a personal account: White House Senior Advisor Jared Kushner, former chief strategist Stephen Bannon, Chief Economic Advisor Gary Cohn, Advisor Ivanka Trump, former chief of staff Reince Priebus and Senior Advisor for Policy Stephen Miller.\n\nWhile it is not illegal for White House staffers to use their personal email accounts, they must forward all work-related communications to their official White House email accounts.\n\nWhite House Press Secretary Sarah Sanders confirmed this to ABC News today.\n\n“All White House personnel have been instructed to use official email to conduct all government related work,” she said. “They are further instructed that if they receive work-related communication on personal accounts, they should be forwarded to official email accounts.”\n\nOn Sunday it was confirmed by Kushner’s attorney that he used a private email account to communicate with White House staffers.\n\n\"Mr. Kushner uses his White House email address to conduct White House business. Fewer than a hundred emails from January through August were either sent to or returned by Mr. Kushner to colleagues in the White House from his personal email account,\" attorney Abbe Lowell said in a statement.\n\nLowell said the emails were \"usually forwarded news articles or political commentary\" and \"most often occurred\" when someone \"initiated the exchange by sending an email to his personal\" account. The news of Kushner\'s personal email use was first reported by Politico.\n\nThe statement makes no mention of classified information but says that copies of the emails were sent to his official account for recording.\n\n\"All non-personal emails were forwarded to his official address, and all have been preserved in any event,\" Lowell said.\n\nA White House official conducting business on a personal email account is not unprecedented. Before and even after the presidential election, Trump criticized his opponent Hillary Clinton for handling classified information on a private email server during her tenure as secretary of state. Clinton’s use of that server became a major talking point throughout her presidential campaign; the FBI soon initiated an investigation into her use of the server.');
COMMIT;

-- ----------------------------
--  Table structure for `users`
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `userid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(25) NOT NULL,
  `password` char(255) NOT NULL,
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `users`
-- ----------------------------
BEGIN;
INSERT INTO `users` VALUES ('1', 'kevin', '12345'), ('2', 'miao', '54321');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
