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

 Date: 09/29/2017 14:24:43 PM
*/

SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `comments`
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments` (
  `comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL,
  `agree` int(11) NOT NULL DEFAULT '0',
  `oppose` int(11) NOT NULL DEFAULT '0',
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `comments`
-- ----------------------------
BEGIN;
INSERT INTO `comments` VALUES ('1', 'oh my god', '0', '0', '13', '0', null, '3', '2017-09-27 15:39:50'), ('2', 'god bless them', '0', '0', '2', '0', null, '3', '2017-09-27 16:01:39'), ('3', 'hahahahahah', '0', '0', '1', '0', null, '3', '2017-09-27 20:19:20'), ('4', 'test the comment', '0', '0', '1', '0', null, '3', '2017-09-27 20:19:56'), ('5', 'test', '0', '0', '1', '0', null, '3', '2017-09-27 20:45:06'), ('6', 'wtf', '0', '0', '1', '0', null, '6', '2017-09-27 21:20:15'), ('7', 'oh my god', '0', '0', '1', '0', null, '4', '2017-09-28 15:00:14'), ('8', 'hahahaha', '0', '0', '1', '0', null, '5', '2017-09-28 15:07:11');
COMMIT;

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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `stories`
-- ----------------------------
BEGIN;
INSERT INTO `stories` VALUES ('1', 'Big news', '2017-09-26 00:48:08', '1', 'sraeli police and medical services say an attacker has opened fire at the entrance to a town outside Jerusalem, killing three Israelis.\n                        Police spokesman Micky Rosenfeld says the attack took place early on Tuesday just outside the community of Had Adar.\n                        There was no word yet on the identity of the attacker but Rosenfeld says it\'s being treated as a terrorist attack. The Magen David Adom medical service says fourth Israeli is in critical condition'), ('2', 'MC', '2017-09-26 00:48:37', '2', 'hahahah'), ('3', 'Shooting attack outside Jerusalem kills 3 Israelis', '2017-09-26 00:53:53', '1', 'Israeli police and medical services say an attacker has opened fire at the entrance to a town outside Jerusalem, killing three Israelis.\n\nPolice spokesman Micky Rosenfeld says the attack took place early on Tuesday just outside the community of Had Adar.\n\nThere was no word yet on the identity of the attacker but Rosenfeld says it\'s being treated as a terrorist attack. The Magen David Adom medical service says a fourth Israeli is in critical condition.\n\nSince 2015, Palestinians have killed 48 Israelis, two visiting Americans and a British tourist in stabbings, shooting and car-ramming attacks. In that time, Israeli forces killed over 255 Palestinians, most said by Israel to be attackers.'), ('4', 'China postpones food import controls after global outcry', '2017-09-26 02:17:59', '2', 'China has delayed enforcing sweeping new controls on food imports following complaints by the United States, \n                            Europe and other trading partners that they would disrupt billions of dollars in trade.\n                            Rules requiring each food shipment to have an inspection certificate from a foreign government were due to take effect Sunday. \n                            But Beijing has decided to grant a \"transitional period of 2 years\" following comments by other governments, according to a document submitted to the World Trade Organization on Monday and seen by The Associated Press.'), ('5', 'White House not disputing report that at least 6 Trump advisers used personal email', '2017-09-26 03:40:34', '1', 'A White House official who spoke with ABC News did not dispute a report Monday evening in the New York Times that at least six administration officials occasionally used private email to communicate about official business since President Trump took office.\r\n\r\nThe Times\' report names the following current and former officials as those who communicated at times with a personal account: White House Senior Advisor Jared Kushner, former chief strategist Stephen Bannon, Chief Economic Advisor Gary Cohn, Advisor Ivanka Trump, former chief of staff Reince Priebus and Senior Advisor for Policy Stephen Miller.\r\n\r\nWhile it is not illegal for White House staffers to use their personal email accounts, they must forward all work-related communications to their official White House email accounts.\r\n\r\nWhite House Press Secretary Sarah Sanders confirmed this to ABC News today.\r\n\r\n“All White House personnel have been instructed to use official email to conduct all government related work,” she said. “They are further instructed that if they receive work-related communication on personal accounts, they should be forwarded to official email accounts.”\r\n\r\nOn Sunday it was confirmed by Kushner’s attorney that he used a private email account to communicate with White House staffers.\r\n\r\n\"Mr. Kushner uses his White House email address to conduct White House business. Fewer than a hundred emails from January through August were either sent to or returned by Mr. Kushner to colleagues in the White House from his personal email account,\" attorney Abbe Lowell said in a statement.\r\n\r\nLowell said the emails were \"usually forwarded news articles or political commentary\" and \"most often occurred\" when someone \"initiated the exchange by sending an email to his personal\" account. The news of Kushner\'s personal email use was first reported by Politico.\r\n\r\nThe statement makes no mention of classified information but says that copies of the emails were sent to his official account for recording.\r\n\r\n\"All non-personal emails were forwarded to his official address, and all have been preserved in any event,\" Lowell said. test\r\n\r\nA White House official conducting business on a personal email account is not unprecedented. Before and even after the presidential election, Trump criticized his opponent Hillary Clinton for handling classified information on a private email server during her tenure as secretary of state. Clinton’s use of that server became a major talking point throughout her presidential campaign; the FBI soon initiated an investigation into her use of the server.'), ('6', 'Minecraft', '2017-09-27 21:20:03', '1', 'On Tuesday, voters in Alabama will choose between two very different political styles: a flame-throwing wild card and an Establishment-backed reliable vote.\r\n\r\nBut as the Alabama Republican Senate primary draws to a close, the differences between incumbent Sen. Luther Strange and conservative firebrand Roy Moore amount to whether voters are happy with the status quo in Washington, and how they felt about their last governor.\r\n\r\nStrange, the former state attorney general, was appointed in February by embattled former Gov. Robert Bentley, and is backed by President Trump and Senate Majority Leader Mitch McConnell in a special election to fill Attorney General Jeff Session\'s former Senate seat.\r\n\r\nMoore, the twice-ousted former Chief Justice of the state Supreme Court, was in many ways the underdog in the race. Known for his strong feelings on the Ten Commandments—the Washington Post reported the Biblical edicts are on display in at least three places in his home, including over his bed— and fierce opposition to same-sex marriage, Moore was seen more as a disruptor than a viable candidate. This is a test.');
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `users`
-- ----------------------------
BEGIN;
INSERT INTO `users` VALUES ('1', 'kevin', '12345'), ('2', 'miao', '54321'), ('13', 'qitao', '111222'), ('14', 'PP00000', 'nibabajiushinibaba'), ('15', 'hanyue', '11111');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
