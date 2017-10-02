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

 Date: 10/01/2017 21:37:50 PM
*/

SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `agreetb`
-- ----------------------------
DROP TABLE IF EXISTS `agreetb`;
CREATE TABLE `agreetb` (
  `comment_id` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `agreed` tinyint(1) NOT NULL,
  PRIMARY KEY (`comment_id`,`userid`),
  KEY `userid` (`userid`),
  CONSTRAINT `agreetb_ibfk_1` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`comment_id`),
  CONSTRAINT `agreetb_ibfk_2` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `agreetb`
-- ----------------------------
BEGIN;
INSERT INTO `agreetb` VALUES ('41', '15', '1'), ('41', '16', '1'), ('43', '15', '1'), ('43', '16', '0'), ('44', '15', '0'), ('47', '15', '0'), ('49', '15', '1'), ('50', '15', '1'), ('51', '15', '1'), ('52', '15', '1'), ('52', '16', '1'), ('53', '15', '1'), ('55', '15', '1'), ('55', '16', '0'), ('57', '2', '0'), ('57', '15', '1'), ('57', '16', '0'), ('60', '2', '1'), ('60', '15', '0'), ('60', '16', '0'), ('85', '1', '1'), ('86', '1', '1');
COMMIT;

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
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `comments`
-- ----------------------------
BEGIN;
INSERT INTO `comments` VALUES ('41', 'What\'s this????\r\n', '2', '0', '2', '0', null, '38', '2017-09-30 16:41:12'), ('42', 'ni shi bu shi sha', '0', '0', '2', '0', null, '36', '2017-09-30 16:41:32'), ('43', 'OH!!!', '1', '1', '2', '0', null, '33', '2017-09-30 16:41:48'), ('44', 'OH really????', '0', '1', '2', '0', null, '31', '2017-09-30 16:42:08'), ('45', 'I\'m a TA of National University of Pink Pig Empire.', '0', '0', '1', '0', null, '32', '2017-09-30 16:42:51'), ('46', 'Wow, that\'s cool!!!', '0', '0', '1', '0', null, '34', '2017-09-30 16:43:15'), ('47', 'I loooooooooooooooove steam', '0', '1', '2', '0', null, '31', '2017-09-30 16:43:31'), ('48', 'Can\'t believe it!!!', '0', '0', '1', '0', null, '34', '2017-09-30 16:43:36'), ('49', 'What do you want to express???', '1', '0', '1', '0', null, '35', '2017-09-30 16:44:39'), ('50', 'I can\'t get it', '1', '0', '1', '0', null, '35', '2017-09-30 16:44:48'), ('51', 'Miao~~~~', '1', '0', '1', '0', null, '37', '2017-09-30 16:45:02'), ('52', '你已经学傻了', '2', '0', '2', '0', null, '38', '2017-09-30 16:45:02'), ('53', 'Test comment from kevin', '1', '0', '1', '0', null, '37', '2017-09-30 16:45:15'), ('54', '门前大桥下\r\n游过一群鸭\r\n快来快来数一数\r\n二四六七八', '0', '0', '2', '0', null, '36', '2017-09-30 16:46:19'), ('55', 'yoo yoo', '1', '1', '2', '0', null, '33', '2017-09-30 16:46:40'), ('57', 'From Yatzer: “Adam Lister’s new print series, ‘Art History 101’ is an insightful look into the collective memory of culture and arts through a modern lens. Adam Lister studied at New York’s School of Visual Arts where he graduated in 2003. Through his work, he found a way to explore his love for 8-bit graphics by creating watercolours with pixel-like shapes. Previously, he explored figures from popular culture', '1', '2', '1', '0', null, '39', '2017-09-30 16:47:31'), ('60', 'I think it is not fair!!!', '1', '2', '16', '0', null, '39', '2017-10-01 00:34:11'), ('61', 'I don\'t think so', '0', '0', '15', '1', '57', null, '2017-10-01 12:56:34'), ('62', 'What\'s hell are you saying', '0', '0', '2', '1', '57', null, '2017-10-01 15:24:31'), ('72', 'hahahahaha', '0', '0', '2', '1', '60', null, '2017-10-01 16:02:24'), ('73', 'lolllllll', '0', '0', '2', '1', '60', null, '2017-10-01 16:15:38'), ('74', 'get out', '0', '0', '2', '1', '57', null, '2017-10-01 16:59:10'), ('75', 'yeah!!!', '0', '0', '2', '1', '43', null, '2017-10-01 17:00:18'), ('76', 'nope', '0', '0', '2', '1', '51', null, '2017-10-01 17:01:26'), ('77', 'hahahah', '0', '0', '2', '1', '51', null, '2017-10-01 17:01:31'), ('79', 'yeah', '0', '0', '2', '1', '51', null, '2017-10-01 17:01:58'), ('80', 'emm...', '0', '0', '2', '1', '51', null, '2017-10-01 17:02:07'), ('81', 'llllll', '0', '0', '15', '1', '51', null, '2017-10-01 18:15:22'), ('82', 'lollll', '0', '0', '15', '1', '53', null, '2017-10-01 18:18:35'), ('83', 'lmao', '0', '0', '15', '1', '51', null, '2017-10-01 18:20:27'), ('84', 'hahaha', '0', '0', '13', '1', '51', null, '2017-10-01 19:34:32'), ('85', 'lolll', '1', '0', '1', '0', null, '41', '2017-10-01 20:18:37'), ('86', 'that\'s awesome!!!', '1', '0', '1', '0', null, '41', '2017-10-01 20:18:48'), ('87', 'test', '0', '0', '1', '1', '85', null, '2017-10-01 20:32:39');
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
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `stories`
-- ----------------------------
BEGIN;
INSERT INTO `stories` VALUES ('31', 'Fallout Free Limited Time', '2017-09-30 16:36:02', '1', 'Bethesda is giving Fallout: A Post Nuclear Role Playing Game away for FREE on Steam in honor of its 20th birthday! \r\n\r\nGet Fallout FREE on Steam until Saturday at 11:59PM Pacific Time!\r\n\r\nAlso, enjoy up to 50% off Fallout Shelter Bundles through the weekend. Offer ends Monday at 11:59PM Pacific Time.'), ('32', 'PinkPig Empire!!!', '2017-09-30 16:37:35', '2', 'I love Pink Pig Empire!!!!\r\nI love my King!!!'), ('33', 'Trump picks risky Puerto Rico fight', '2017-09-30 16:37:39', '1', 'The natural disaster in Puerto Rico has escalated into a firestorm for President Donald Trump, whose Saturday twitter attack on the mayor of San Juan drew harsh condemnations, new charges of insensitivity, and warnings about political fallout.\r\n\r\nIn a series of Saturday morning tweets, Trump blasted the “poor leadership ability” of Puerto Rican officials, who he said “want everything to be done for them.” Trump also said the island’s leaders “are not able to get their workers to help,” and accused the Democratic mayor of San Juan—who has publicly criticized his administration’s response to Hurricane Maria—of scoring partisan political points.\r\n\r\nEven Republicans were uncomfortable seeing television images of suffering Puerto Ricans juxtaposed with Trump’s fighting words, tweeted from his luxury golf course in Bedminster, New Jersey.\r\n\r\n“He is definitely not helping,” said Republican state Rep. Bob Cortes, a Puerto Rico native who lives in Central Florida, which has seen a huge influx of Puerto Rican families in recent years. Cortes added that the controversy “gives [Democrats] a platform to register new voters.”\r\n\r\nOther Republicans also worry that Trump’s comments could be a godsend to Democrats in Florida—a swing state whose Puerto Rican population of more than 1 million is expected to swell as people flee the storm\'s aftermath.'), ('34', 'Director Behind ‘American Masters’ Tries Something New With ‘Spielberg’', '2017-09-30 16:38:46', '2', 'When you make a movie called “Spielberg,” and its subject agrees to sit for what turns out to be 30 hours of interviews — and his sisters sit down with you, as do his parents, and half the Hollywood mavericks including Francis Ford Coppola, Brian De Palma, George Lucas and Martin Scorsese — you’d better get it right. No one wants to be the director who screwed up the Steven Spielberg documentary.\r\n\r\n“I tried really hard not to think about it,” said Susan Lacy, whose two-and-a-half-hour profile of Mr. Spielberg, perhaps the world’s best known and most successful director, will have its premiere Thursday at the New York Film Festival and make its television debut Saturday on HBO. “If I had spent a lot of time thinking about: ‘How’s Steven going to feel about this? Oh my God, is he going to like this?’ I would have been absolutely frozen.”\r\n\r\nPerhaps. But the idea of Ms. Lacy’s being frozen by this challenge, or any other, is hard to accept. She’s owned the field of documentary biography for more than 30 years, beginning at PBS — where she created the series “American Masters,” winning 28 Emmy and 11 Peabody Awards — and continuing at HBO, where “Spielberg” is the first fruit of a multifilm deal.'), ('35', 'New SVA Web Series Debuts with Award-Winning Designer Timothy Goodman', '2017-09-30 16:39:20', '2', 'Sitting in the heart of SVA\'s main campus building is Moe\'s Cafe, a colorful hub where students meet to grab a bite to eat, watch the news or—of course—get a cup of coffee. In this first installment of our new web series Joes@Moe\'s, host Zipeng Zhu (BFA 2013 Design) chats with SVA faculty member, fellow alumnus and his former teacher Timothy Goodman (BFA 2007 Graphic Design). An award-winning designer, illustrator and art director, Goodman has embarked on a myriad of unique projects, including co-creating the popular blog-turned-book, 40 Days of Dating with fellow BFA Design faculty member Jessica Walsh, and recently authoring Sharpie Art Workshop. In the video below, Goodman talks about his approach to work, what it was like moving from Ohio to attend college in New York City, the key piece of advice he always gives to his students, and more.'), ('36', 'Strings whose hash value starts with 0e', '2017-09-30 16:39:30', '1', 'QNKCDZO\r\n0e830400451993494058024219903391\r\n240610708\r\n0e462097431906509019562988736854\r\ns878926199a\r\n0e545993274517709034328855841020\r\ns155964671a\r\n0e342768416822451524974117254469\r\ns214587387a\r\n0e848240448830537924465865611904\r\ns214587387a\r\n0e848240448830537924465865611904\r\ns878926199a\r\n0e545993274517709034328855841020\r\ns1091221200a\r\n0e940624217856561557816327384675\r\ns1885207154a\r\n0e509367213418206700842008763514'), ('37', 'SVA\'s Guide to NYC: Flatiron District', '2017-09-30 16:40:13', '2', 'Manhattan’s Flatiron District—the area surrounding Madison Square Park, from Sixth Avenue to Park Avenue, and 26th Street to 20th Street—is known for its distinctive architecture (the Flatiron Building, Met Life Tower, Metropolitan Life North Building and New York Life Insurance Building are all landmarks), and was once also known as Silicon Alley for its concentration of tech companies. Though primarily a commercial district, the Flatiron neighborhood still has plenty to offer.\r\n\r\nHere are a few of our favorite things to see, do and taste in the neighborhood, with help from SVA students and alumni.\r\n\r\n10 Things to Do in Flatiron:\r\n\r\nGet in character at Abracadabra – 19 West 21st Street (between Fifth and Sixth avenues)\r\n\r\nThe self-described “most unique store in New York City,” Abracadabra offers wigs, costumes, gags, novelties, props and much more.\r\n\r\nTake a break in Madison Square Park – 23rd Street at Broadway\r\n\r\nThe focal point of the neighborhood, Madison Square Park is home to the original Shake Shack, several well-manicured lawns for hanging out and an annual sculpture installation. Currently on view through Sunday, October 8, is Josiah McElheny\'s \"Prismatic Park,\" featuring three large sculptures of painted wood and prismatic glass.\r\n\r\nStock up at Da Vinci Artist Supply and Blick Art Supplies – 132 West 21st Street (between Sixth and Seventh avenues) and 650 Sixth Avenue (on the corner of 20th Street)\r\nWith two art supply stores within walking distance of SVA\'s classrooms and studios on 21st Street, students won’t have to venture far to be fully equipped for late-night studio sessions.'), ('38', 'How to install MySQL 5.6 on CentOS 7', '2017-09-30 16:40:35', '1', 'wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm\r\nrpm -ivh mysql-community-release-el7-5.noarch.rpm\r\nls -1 /etc/yum.repos.d/mysql-community*\r\ncheck to output is as follows:\r\netc/yum.repos.d/mysql-community.repo\r\n/etc/yum.repos.d/mysql-community-source.repo\r\nyum install mysql-server\r\nsystemctl start mysqld\r\nsystemctl status mysqld\r\nmysql_secure_installation'), ('39', 'Art History Pixelated: New Paintings by SVA Alumnus Adam Lister', '2017-09-30 16:40:46', '2', 'From Yatzer: “Adam Lister’s new print series, ‘Art History 101’ is an insightful look into the collective memory of culture and arts through a modern lens.\r\n\r\nAdam Lister studied at New York’s School of Visual Arts where he graduated in 2003. Through his work, he found a way to explore his love for 8-bit graphics by creating watercolours with pixel-like shapes. Previously, he explored figures from popular culture with his digital stylings, representing characters from the television and movie world. These include portraits of ‘Star Wars’ characters like Yoda and Princess Leia, and scenes from ‘The Godfather.’ Now Lister has moved towards the topic of art history, which is something he holds a deep passion and respect for.\r\n\r\n‘Art History 101’ deconstructs popular artworks throughout history and represents them as minimal watercolours with pixelated forms…” (For the full story and more images, click here)'), ('40', 'Test', '2017-10-01 03:44:57', '15', 'INFORMATION_SCHEMA.SCHEMATA提供了数据库的相关信息\r\n1. 查找存取其他数据库信息的数据库\r\nselect schema_name from information_schema.schemata limit 0,1\r\n2. 查询当前数据表\r\nselect table_name from information_schema.tables where table_schema=(select database()) limit 0,1\r\n3. 查看字段\r\nselect column_name from information_schema.columns where table_name=\'***\' limit 0,1'), ('41', 'Test', '2017-10-01 20:17:18', '18', 'This is a test story written by gaomiao');
COMMIT;

-- ----------------------------
--  Table structure for `users`
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `userid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(25) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `users`
-- ----------------------------
BEGIN;
INSERT INTO `users` VALUES ('1', 'kevin', '$2y$10$WGqaa2PydWVYn/OUtrQ4re8UXQan51oalBqMVSTDhgkBRckjcG8ju'), ('2', 'miao', '$2y$10$Wt/dTsMS.C8znaKULh6BfO0WfV0LNR9H4izBykGDnJBSHTCVgI2Au'), ('13', 'qitao', '$2y$10$WAm2JEPyyRBTgK7oJuwz7.Xm4P4.jq1zG.mcxvfnhqxNS5ZfWu7BC'), ('14', 'PP00000', '$2y$10$EK95UNR.ENMFeHU4awY0CuMiXvEZTNGrXcuRQk8BCsy21okPEnGw.'), ('15', 'hanyue', '$2y$10$jO.u.YSF.BMq88hwsSMaROxh82/SmEiih4KjcwgHB7k.yIQgZ6F5a'), ('16', 'xiaoming', '$2y$10$FxIO6hV3LBtFVKjz3FN6NOsiCqvIG1ve4avv.xUJVXVCn.DN/bc5O'), ('17', 'ziyang', '$2y$10$5EH38D256197nB8RDb68K.uS8Hg1aTspP7Z4HyKFIHB3g7c9N8ZlO'), ('18', 'gaomiao', '$2y$10$Fa5qqjbtezNuPMYN3hh01e5s.8RdlgizfkV042KFdZZUivuw8qBR.');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
