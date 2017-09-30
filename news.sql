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

 Date: 09/30/2017 02:57:29 AM
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
  KEY `comments_ibfk_2` (`story_id`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`),
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`story_id`) REFERENCES `stories` (`story_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `comments`
-- ----------------------------
BEGIN;
INSERT INTO `comments` VALUES ('7', 'oh my god', '0', '0', '1', '0', null, '4', '2017-09-28 15:00:14'), ('13', 'test comment', '0', '0', '2', '0', null, '4', '2017-09-30 00:59:21'), ('16', 'test', '0', '0', '1', '0', null, '4', '2017-09-30 01:23:33'), ('20', 'sjadfsahflksadhfksjadf', '0', '0', '2', '0', null, '27', '2017-09-30 01:38:19'), ('23', 'This is a testing comment', '0', '0', '2', '0', null, '27', '2017-09-30 01:46:18'), ('24', 'hahahha', '0', '0', '15', '0', null, '4', '2017-09-30 02:44:10'), ('25', 'wtf', '0', '0', '15', '0', null, '27', '2017-09-30 02:45:25');
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
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `stories`
-- ----------------------------
BEGIN;
INSERT INTO `stories` VALUES ('4', 'China postpones food import controls after global outcry', '2017-09-26 02:17:59', '2', 'China has delayed enforcing sweeping new controls on food imports following complaints by the United States, \n                            Europe and other trading partners that they would disrupt billions of dollars in trade.\n                            Rules requiring each food shipment to have an inspection certificate from a foreign government were due to take effect Sunday. \n                            But Beijing has decided to grant a \"transitional period of 2 years\" following comments by other governments, according to a document submitted to the World Trade Organization on Monday and seen by The Associated Press.'), ('6', 'Minecraft', '2017-09-27 21:20:03', '1', 'On Tuesday, voters in Alabama will choose between two very different political styles: a flame-throwing wild card and an Establishment-backed reliable vote.\r\n\r\nBut as the Alabama Republican Senate primary draws to a close, the differences between incumbent Sen. Luther Strange and conservative firebrand Roy Moore amount to whether voters are happy with the status quo in Washington, and how they felt about their last governor.\r\n\r\nStrange, the former state attorney general, was appointed in February by embattled former Gov. Robert Bentley, and is backed by President Trump and Senate Majority Leader Mitch McConnell in a special election to fill Attorney General Jeff Session\'s former Senate seat.\r\n\r\nMoore, the twice-ousted former Chief Justice of the state Supreme Court, was in many ways the underdog in the race. Known for his strong feelings on the Ten Commandments—the Washington Post reported the Biblical edicts are on display in at least three places in his home, including over his bed— and fierce opposition to same-sex marriage, Moore was seen more as a disruptor than a viable candidate. This is a test.'), ('26', 'Prince Harry and Meghan Markle Make Their First Official Public Appearance Together', '2017-09-30 00:55:59', '1', '(TORONTO) — Hand in hand, Prince Harry and girlfriend Meghan Markle made their first official public appearance as a couple. Markle might have even left a wedding hint.\r\n\r\nThe prince and Markle held hands Monday as they walked toward Toronto\'s city hall and attended a wheelchair tennis event at Harry\'s Invictus Games for wounded veterans.\r\n\r\nMarkle wore a white button-down shirt with blue jeans ripped at the knee. The white shirt is called \"The Husband Shirt\" and is by designer Misha Nonoo.\r\n\r\nThe 36-year-old American actress recently told Vanity Fair they\'re in love\r\n\r\nMarkle, who lives in Toronto, appeared at the games\' opening ceremony this weekend, cheering from the stands while Harry sat four rows and a section away beside U.S. first lady Melania Trump.\r\n\r\nThe couple has been photographed together in the past but this is the first time they have appeared together at an official event. The two sat together and took in a match of the wheelchair tennis between Australia and New Zealand at the small venue. Both wore dark sunglasses on an uncommonly hot sunny day for Toronto in late September.\r\n\r\nThey stayed for a half hour and shook hands with the athletes and Invictus volunteers. They left together hand in hand.\r\n\r\nHarry, 33, has been dating Markle since last year. He confirmed the relationship in November when he complained about intrusive press coverage.\r\n\r\nThe Vanity Fair interview prompted British bet-maker Betfair to offer 6-to-4 odds that the couple is engaged by the end of 2017 and 3-to-1 odds that they marry in 2018.\r\n\r\nBest known as paralegal Rachel Zane in the US Network legal drama, \"Suits,\" Markle has appeared on \"General Hospital,\" \'\'CSI: Miami,\" \'\'Without A Trace\" and \"Castle.\" She also is a campaigner for gender equality.\r\n\r\nThe Invictus Games are the creation of Harry, who got the inspiration to help wounded and sick military personnel and their families after his two tours of duty in Afghanistan. This is the third Invictus Games. About 550 competitors from 17 countries are slated to compete in 12 sports over the next week.'), ('27', 'White House statements on Puerto Rico clash with ground reports', '2017-09-30 00:57:39', '1', 'Assessments differ on hospitals and whether they are \'fully operational\'\r\nThe White House says aid and cash are \'on site,\' but they are slow to reach residents\r\n\"Damn it, this is not a good news story,\" San Juan Mayor Carmen Yulín Cruz responded. \"This is a people-are-dying story. This is a life-or-death story.\"\r\nSince Hurricane Maria slammed into the US territory as a Category 4 hurricane earlier this month, much of the island has been devastated -- leaving millions of Americans without electricity and water, and limited access to gas and other vital supplies.\r\nDuke\'s comments weren\'t the first time the White House\'s statements about the recovery effort contradicted ground reports. This week, federal officials and locals clashed on such issues as medical care facilities, aid shipments and the availability of cash.\r\nCritics say the White House has been slow to respond and is portraying the situation in Puerto Rico as better than it really is. Here\'s a snapshot of what the White House is saying compared to what people there are seeing and experiencing.\r\nWhite House: In Puerto Rico, 44 of 69 hospitals were \"fully operational\" as of Thursday afternoon, White House press secretary Sarah Sanders said.\r\nBy Thursday night, White House Homeland Security Adviser Tom Bossert said that 51 hospitals had met the standard of being able to \"see, treat and admit\" patients.\r\nHowever, he clarified that the three-pronged standard for hospitals included many using emergency diesel fuel, which he admitted was \"not necessarily an ideal condition.\"\r\nGround Reports: Because power and communication lines still remain out for much of the island, hospitals rely on diesel fuel -- already in short supply -- and have trouble contacting and coordinating patient care.\r\nCNN chief medical correspondent Sanjay Gupta saw those hospitals\' struggles firsthand. At a shelter an hour outside of San Juan, a woman named Josefina Alvarez, who suffers from diabetes, was in a dire situation. She had an infection and no insulin, water or food.\r\nNo ambulance could take her to a hospital, so Gupta and his team volunteered to drive her to a nearby clinic.\r\n\"There are probably thousands of patients who are in similar shelters with no power, no water, no medications, no way out. There are probably thousands more who are still in their homes and haven\'t even been able to get to a shelter,\" he said. \"She\'s just one example of what\'s happening here.\"\r\nSpeaking on CNN\'s The Situation Room on Thursday, Gupta said that many hospitals listed as operational had no satellite phones, no access to medications, and were unable to admit patients.\r\n\"We\'re seeing diesel fuel being promised for a few hours at a time as opposed to anything that\'s going to be more sustainable for them. And as you might imagine, it\'s very hard to run a hospital that way,\" he said. \"It\'s hard to take care of patients if you say, \'Look, we have six hours of fuel left. We\'re not sure if we\'ll get more fuel after that.\'\"\r\nBecause available diesel fuel was prioritized for hospitals, nursing homes had major issues as well, Mayor Cruz said.\r\nPeople waiting in line to buy gas are seen in Rio Hondo, Bayamon, Puerto Rico, on September 22, 2017.\r\n\"Most of our nursing homes have people that have an inability to move, so they\'re stuck in the 14th floor, they have no water, they have no food, they -- most of them are insulin-dependent,\" she said.\r\nInsulin-dependent patients are \"going crazy for ice\" to keep their medical supplies cold, Cruz said, while other patients haven\'t had their scheduled dialysis or chemotherapy in days.\r\nWhite House: President Donald Trump has tweeted several times over the past few days that food and water are \"on way,\" \"on site\" or \"delivered\" to Puerto Rico.\r\nThe Federal Aviation Administration supported the restoration of services to all eight commercial airports in Puerto Rico, FEMA said on Friday. In addition, five of six FEMA-priority seaports are open or open with restrictions, the Department of Defense said Thursday.');
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
