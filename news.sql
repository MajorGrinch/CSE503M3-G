/*
 Navicat Premium Data Transfer

 Source Server         : AWS
 Source Server Type    : MySQL
 Source Server Version : 50623
 Source Host           : 54.198.55.156
 Source Database       : news

 Target Server Type    : MySQL
 Target Server Version : 50623
 File Encoding         : utf-8

 Date: 09/30/2017 20:48:30 PM
*/

SET NAMES utf8mb4;
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
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `comments`
-- ----------------------------
BEGIN;
INSERT INTO `comments` VALUES ('41', 'What\'s this????\r\n', '0', '0', '2', '0', null, '38', '2017-09-30 16:41:12'), ('42', 'ni shi bu shi sha', '0', '0', '2', '0', null, '36', '2017-09-30 16:41:32'), ('43', 'OH!!!', '0', '0', '2', '0', null, '33', '2017-09-30 16:41:48'), ('44', 'OH really????', '0', '0', '2', '0', null, '31', '2017-09-30 16:42:08'), ('45', 'I\'m a TA of National University of Pink Pig Empire.', '0', '0', '1', '0', null, '32', '2017-09-30 16:42:51'), ('46', 'Wow, that\'s cool!!!', '0', '0', '1', '0', null, '34', '2017-09-30 16:43:15'), ('47', 'I loooooooooooooooove steam', '0', '0', '2', '0', null, '31', '2017-09-30 16:43:31'), ('48', 'Can\'t believe it!!!', '0', '0', '1', '0', null, '34', '2017-09-30 16:43:36'), ('49', 'What do you want to express???', '0', '0', '1', '0', null, '35', '2017-09-30 16:44:39'), ('50', 'I can\'t get it', '0', '0', '1', '0', null, '35', '2017-09-30 16:44:48'), ('51', 'Miao~', '0', '0', '1', '0', null, '37', '2017-09-30 16:45:02'), ('52', 'ä½ å·²ç»å­¦å‚»äº†', '0', '0', '2', '0', null, '38', '2017-09-30 16:45:02'), ('53', 'Test comment from kevin', '0', '0', '1', '0', null, '37', '2017-09-30 16:45:15'), ('54', 'é—¨å‰å¤§æ¡¥ä¸‹\r\næ¸¸è¿‡ä¸€ç¾¤é¸­\r\nå¿«æ¥å¿«æ¥æ•°ä¸€æ•°\r\näºŒå››å…­ä¸ƒå…«', '0', '0', '2', '0', null, '36', '2017-09-30 16:46:19'), ('55', 'yoo yoo', '0', '0', '2', '0', null, '33', '2017-09-30 16:46:40'), ('56', 'From Yatzer: â€œAdam Listerâ€™s new print series, â€˜Art History 101â€™ is an insightful look into the collective memory o', '0', '0', '1', '0', null, '39', '2017-09-30 16:47:19'), ('57', 'From Yatzer: â€œAdam Listerâ€™s new print series, â€˜Art History 101â€™ is an insightful look into the collective memory of culture and arts through a modern lens. Adam Lister studied at New Yorkâ€™s School of Visual Arts where he graduated in 2003. Through his work, he found a way to explore his love for 8-bit graphics by creating watercolours with pixel-like shapes. Previously, he explored figures from popular culture with his digi', '0', '0', '1', '0', null, '39', '2017-09-30 16:47:31'), ('58', 'Through his work, he found a way to explore his love for 8-bit graphics by creating watercolours with pixel-like shapes. Previously, he explored figures from popular culture with his digital stylings, representing characters from the television and movie world. These include portraits of â€˜Star Warsâ€™ characters like Yoda and Princess Leia, and scenes from â€˜The Godfather.â€™ Now Lister has moved towards the topic of art history, which is something he holds a deep passion and respect for. â€˜Art History 101â€™ deconstructs popular artworks throughout history and represents them as minimal watercolours with pixelated formsâ€¦â€ (For the full story and more images, click here)', '0', '0', '1', '0', null, '39', '2017-09-30 17:02:02');
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
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `stories`
-- ----------------------------
BEGIN;
INSERT INTO `stories` VALUES ('31', 'Fallout Free Limited Time', '2017-09-30 16:36:02', '1', 'Bethesda is giving Fallout: A Post Nuclear Role Playing Game away for FREE on Steam in honor of its 20th birthday! \r\n\r\nGet Fallout FREE on Steam until Saturday at 11:59PM Pacific Time!\r\n\r\nAlso, enjoy up to 50% off Fallout Shelter Bundles through the weekend. Offer ends Monday at 11:59PM Pacific Time.'), ('32', 'PinkPig Empire!!!', '2017-09-30 16:37:35', '2', 'I love Pink Pig Empire!!!!\r\nI love my King!!!'), ('33', 'Trump picks risky Puerto Rico fight', '2017-09-30 16:37:39', '1', 'The natural disaster in Puerto Rico has escalated into a firestorm for President Donald Trump, whose Saturday twitter attack on the mayor of San Juan drew harsh condemnations, new charges of insensitivity, and warnings about political fallout.\r\n\r\nIn a series of Saturday morning tweets, Trump blasted the â€œpoor leadership abilityâ€ of Puerto Rican officials, who he said â€œwant everything to be done for them.â€ Trump also said the islandâ€™s leaders â€œare not able to get their workers to help,â€ and accused the Democratic mayor of San Juanâ€”who has publicly criticized his administrationâ€™s response to Hurricane Mariaâ€”of scoring partisan political points.\r\n\r\nEven Republicans were uncomfortable seeing television images of suffering Puerto Ricans juxtaposed with Trumpâ€™s fighting words, tweeted from his luxury golf course in Bedminster, New Jersey.\r\n\r\nâ€œHe is definitely not helping,â€ said Republican state Rep. Bob Cortes, a Puerto Rico native who lives in Central Florida, which has seen a huge influx of Puerto Rican families in recent years. Cortes added that the controversy â€œgives [Democrats] a platform to register new voters.â€\r\n\r\nOther Republicans also worry that Trumpâ€™s comments could be a godsend to Democrats in Floridaâ€”a swing state whose Puerto Rican population of more than 1 million is expected to swell as people flee the storm\'s aftermath.'), ('34', 'Director Behind â€˜American Mastersâ€™ Tries Something New With â€˜Spielbergâ€™', '2017-09-30 16:38:46', '2', 'When you make a movie called â€œSpielberg,â€ and its subject agrees to sit for what turns out to be 30 hours of interviews â€” and his sisters sit down with you, as do his parents, and half the Hollywood mavericks including Francis Ford Coppola, Brian De Palma, George Lucas and Martin Scorsese â€” youâ€™d better get it right. No one wants to be the director who screwed up the Steven Spielberg documentary.\r\n\r\nâ€œI tried really hard not to think about it,â€ said Susan Lacy, whose two-and-a-half-hour profile of Mr. Spielberg, perhaps the worldâ€™s best known and most successful director, will have its premiere Thursday at the New York Film Festival and make its television debut Saturday on HBO. â€œIf I had spent a lot of time thinking about: â€˜Howâ€™s Steven going to feel about this? Oh my God, is he going to like this?â€™ I would have been absolutely frozen.â€\r\n\r\nPerhaps. But the idea of Ms. Lacyâ€™s being frozen by this challenge, or any other, is hard to accept. Sheâ€™s owned the field of documentary biography for more than 30 years, beginning at PBS â€” where she created the series â€œAmerican Masters,â€ winning 28 Emmy and 11 Peabody Awards â€” and continuing at HBO, where â€œSpielbergâ€ is the first fruit of a multifilm deal.'), ('35', 'New SVA Web Series Debuts with Award-Winning Designer Timothy Goodman', '2017-09-30 16:39:20', '2', 'Sitting in the heart of SVA\'s main campus building is Moe\'s Cafe, a colorful hub where students meet to grab a bite to eat, watch the news orâ€”of courseâ€”get a cup of coffee. In this first installment of our new web series Joes@Moe\'s, host Zipeng Zhu (BFA 2013 Design) chats with SVA faculty member, fellow alumnus and his former teacher Timothy Goodman (BFA 2007 Graphic Design). An award-winning designer, illustrator and art director, Goodman has embarked on a myriad of unique projects, including co-creating the popular blog-turned-book, 40 Days of Dating with fellow BFA Design faculty member Jessica Walsh, and recently authoring Sharpie Art Workshop. In the video below, Goodman talks about his approach to work, what it was like moving from Ohio to attend college in New York City, the key piece of advice he always gives to his students, and more.'), ('36', 'Strings whose hash value starts with 0e', '2017-09-30 16:39:30', '1', 'QNKCDZO\r\n0e830400451993494058024219903391\r\n240610708\r\n0e462097431906509019562988736854\r\ns878926199a\r\n0e545993274517709034328855841020\r\ns155964671a\r\n0e342768416822451524974117254469\r\ns214587387a\r\n0e848240448830537924465865611904\r\ns214587387a\r\n0e848240448830537924465865611904\r\ns878926199a\r\n0e545993274517709034328855841020\r\ns1091221200a\r\n0e940624217856561557816327384675\r\ns1885207154a\r\n0e509367213418206700842008763514'), ('37', 'SVA\'s Guide to NYC: Flatiron District', '2017-09-30 16:40:13', '2', 'Manhattanâ€™s Flatiron Districtâ€”the area surrounding Madison Square Park, from Sixth Avenue to Park Avenue, and 26th Street to 20th Streetâ€”is known for its distinctive architecture (the Flatiron Building, Met Life Tower, Metropolitan Life North Building and New York Life Insurance Building are all landmarks), and was once also known as Silicon Alley for its concentration of tech companies. Though primarily a commercial district, the Flatiron neighborhood still has plenty to offer.\r\n\r\nHere are a few of our favorite things to see, do and taste in the neighborhood, with help from SVA students and alumni.\r\n\r\n10 Things to Do in Flatiron:\r\n\r\nGet in character at Abracadabra â€“ 19 West 21st Street (between Fifth and Sixth avenues)\r\n\r\nThe self-described â€œmost unique store in New York City,â€ Abracadabra offers wigs, costumes, gags, novelties, props and much more.\r\n\r\nTake a break in Madison Square Park â€“ 23rd Street at Broadway\r\n\r\nThe focal point of the neighborhood, Madison Square Park is home to the original Shake Shack, several well-manicured lawns for hanging out and an annual sculpture installation. Currently on view through Sunday, October 8, is Josiah McElheny\'s \"Prismatic Park,\" featuring three large sculptures of painted wood and prismatic glass.\r\n\r\nStock up at Da Vinci Artist Supply and Blick Art Supplies â€“ 132 West 21st Street (between Sixth and Seventh avenues) and 650 Sixth Avenue (on the corner of 20th Street)\r\nWith two art supply stores within walking distance of SVA\'s classrooms and studios on 21st Street, students wonâ€™t have to venture far to be fully equipped for late-night studio sessions.'), ('38', 'How to install MySQL 5.6 on CentOS 7', '2017-09-30 16:40:35', '1', 'wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm\r\nrpm -ivh mysql-community-release-el7-5.noarch.rpm\r\nls -1 /etc/yum.repos.d/mysql-community*\r\ncheck to output is as follows:\r\netc/yum.repos.d/mysql-community.repo\r\n/etc/yum.repos.d/mysql-community-source.repo\r\nyum install mysql-server\r\nsystemctl start mysqld\r\nsystemctl status mysqld\r\nmysql_secure_installation'), ('39', 'Art History Pixelated: New Paintings by SVA Alumnus Adam Lister', '2017-09-30 16:40:46', '2', 'From Yatzer: â€œAdam Listerâ€™s new print series, â€˜Art History 101â€™ is an insightful look into the collective memory of culture and arts through a modern lens.\r\n\r\nAdam Lister studied at New Yorkâ€™s School of Visual Arts where he graduated in 2003. Through his work, he found a way to explore his love for 8-bit graphics by creating watercolours with pixel-like shapes. Previously, he explored figures from popular culture with his digital stylings, representing characters from the television and movie world. These include portraits of â€˜Star Warsâ€™ characters like Yoda and Princess Leia, and scenes from â€˜The Godfather.â€™ Now Lister has moved towards the topic of art history, which is something he holds a deep passion and respect for.\r\n\r\nâ€˜Art History 101â€™ deconstructs popular artworks throughout history and represents them as minimal watercolours with pixelated formsâ€¦â€ (For the full story and more images, click here)');
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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `users`
-- ----------------------------
BEGIN;
INSERT INTO `users` VALUES ('1', 'kevin', '12345'), ('2', 'miao', '54321'), ('13', 'qitao', '111222'), ('14', 'PP00000', 'nibabajiushinibaba'), ('15', 'hanyue', '11111'), ('16', 'xiaoming', '12345');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
