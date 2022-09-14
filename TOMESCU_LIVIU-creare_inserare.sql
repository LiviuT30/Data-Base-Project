CREATE TABLE `item` (
  `item_id` int NOT NULL,
  `nume` varchar(45) DEFAULT NULL,
  `tip` varchar(45) DEFAULT NULL,
  `stat_value` int DEFAULT NULL,
  `gold_value` int DEFAULT NULL,
  `rarity` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`item_id`)
);

CREATE TABLE `dungeon` (
  `dungeon_id` int NOT NULL,
  `nume` varchar(45) DEFAULT NULL,
  `mapzonex` int DEFAULT NULL,
  `mapzoney` int DEFAULT NULL,
  `biome` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`dungeon_id`)
);

CREATE TABLE `oras` (
  `oras_id` int NOT NULL,
  `nume` varchar(45) DEFAULT NULL,
  `mapzonex` int DEFAULT NULL,
  `mapzoney` int DEFAULT NULL,
  PRIMARY KEY (`oras_id`)
);

CREATE TABLE `npc` (
  `npc_id` int NOT NULL,
  `oras_id` int NOT NULL,
  `nume` varchar(45) DEFAULT NULL,
  `quest_finished` int DEFAULT NULL,
  PRIMARY KEY (`npc_id`),
  KEY `oras_id_1_idx` (`oras_id`),
  CONSTRAINT `oras_id_1` FOREIGN KEY (`oras_id`) REFERENCES `oras` (`oras_id`)
);

CREATE TABLE `quest` (
  `quest_id` int NOT NULL,
  `nume` varchar(45) DEFAULT NULL,
  `started` tinyint DEFAULT NULL,
  `startdate` datetime DEFAULT NULL,
  `enddate` datetime DEFAULT NULL,
  `npc_id` int NOT NULL,
  PRIMARY KEY (`quest_id`),
  KEY `npc_id_1_idx` (`npc_id`),
  CONSTRAINT `npc_id_1` FOREIGN KEY (`npc_id`) REFERENCES `npc` (`npc_id`)
);

CREATE TABLE `quest_drop` (
  `questdrop_id` int NOT NULL,
  `item_id` int NOT NULL,
  `quest_id` int NOT NULL,
  `gold` int DEFAULT NULL,
  PRIMARY KEY (`questdrop_id`),
  KEY `item_id_2_idx` (`item_id`),
  KEY `quest_id_1_idx` (`quest_id`),
  CONSTRAINT `item_id_2` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`),
  CONSTRAINT `quest_id_1` FOREIGN KEY (`quest_id`) REFERENCES `quest` (`quest_id`)
);

CREATE TABLE `mob` (
  `mob_id` int NOT NULL,
  `dungeon_id` int DEFAULT NULL,
  `nume` varchar(45) DEFAULT NULL,
  `level` int NOT NULL,
  `xp` int DEFAULT NULL,
  `max_hp` int NOT NULL,
  `dmg` int DEFAULT NULL,
  PRIMARY KEY (`mob_id`),
  KEY `dungeon_id_1_idx` (`dungeon_id`),
  CONSTRAINT `dungeon_id_1` FOREIGN KEY (`dungeon_id`) REFERENCES `dungeon` (`dungeon_id`)
);

CREATE TABLE `mob_drop` (
  `mobdrop_id` int NOT NULL,
  `item_id` int NOT NULL,
  `mob_id` int NOT NULL,
  `gold` int DEFAULT NULL,
  PRIMARY KEY (`mobdrop_id`),
  KEY `item_id_3_idx` (`item_id`),
  KEY `mob_id_1_idx` (`mob_id`),
  CONSTRAINT `item_id_3` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`),
  CONSTRAINT `mob_id_1` FOREIGN KEY (`mob_id`) REFERENCES `mob` (`mob_id`)
);

CREATE TABLE `maincharacter` (
  `main_id` int NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `level` int DEFAULT NULL,
  `xp` int DEFAULT NULL,
  `lvlupxp` int DEFAULT NULL,
  `max_hp` int DEFAULT NULL,
  `max_energy` int DEFAULT NULL,
  `gender` int DEFAULT NULL,
  `creation_date` datetime DEFAULT NULL,
  PRIMARY KEY (`main_id`)
);

CREATE TABLE `pet` (
  `pet_id` int NOT NULL,
  `main_id` int NOT NULL,
  `hp` int DEFAULT NULL,
  `gender` int DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  `acquire_date` datetime DEFAULT NULL,
  PRIMARY KEY (`pet_id`),
  KEY `main_id_idx` (`main_id`),
  CONSTRAINT `main_id` FOREIGN KEY (`main_id`) REFERENCES `maincharacter` (`main_id`)
);

CREATE TABLE `inventar` (
  `inventar_id` int NOT NULL,
  `main_id` int NOT NULL,
  `max_capacity` int DEFAULT NULL,
  `gold` int DEFAULT NULL,
  PRIMARY KEY (`inventar_id`),
  KEY `main_id_idx` (`main_id`),
  CONSTRAINT `main_id_2` FOREIGN KEY (`main_id`) REFERENCES `maincharacter` (`main_id`)
);

CREATE TABLE `inventar_continut` (
  `invcont_id` int NOT NULL,
  `inventar_id` int NOT NULL,
  `item_id` int NOT NULL,
  PRIMARY KEY (`invcont_id`),
  KEY `inventar_id_1_idx` (`inventar_id`),
  KEY `item_id_1_idx` (`item_id`),
  CONSTRAINT `inventar_id_1` FOREIGN KEY (`inventar_id`) REFERENCES `inventar` (`inventar_id`),
  CONSTRAINT `item_id_1` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`)
);
INSERT INTO `item` VALUES (1,'Sword','arma',3,10,'common'),(2,'Bow','arma',5,20,'common'),(3,'Sharp axe','arma',10,100,'rare'),
(4,'Divine sword','arma',100,3000,'legendary'),(5,'Iron Chestplate','armura',15,200,'rare'),(6,'Leather boots','armura',1,5,'common'),
(7,'Leather helmet','armura',3,25,'common'),(8,'Golden gauntlets','armura',30,500,'rare'),(9,'Elf bow','arma',70,750,'legendary'),
(10,'Leather Chestplate','armura',5,50,'common'),(11,'Iron boots','armura',10,100,'common'),(12,'Cool axe','arma',30,400,'rare'),
(13,'Troll hammer','arma',50,600,'rare'),(14,'Troll cape','armura',20,200,'common'),(15,'Dragon tooth','arma',80,2000,'rare'),
(16,'God Armor','armura',10000,99999,'egendary'),(17,'God Axe','arma',10000,99999,'legendary');
INSERT INTO `maincharacter` VALUES (1,'Lalitha',5,123,750,100,75,2,'2021-05-23 23:35:48'),(2,'Juan',2,25,100,60,50,1,'2021-03-22 11:01:07'),
(3,'Azura ',15,264,2250,300,110,1,'2021-05-12 04:29:52'),(4,'Nicolai',10,452,1750,200,80,1,'2021-03-18 15:38:03'),(
5,'Aminda',30,1233,5000,600,200,2,'2021-03-27 00:11:13');
INSERT INTO `dungeon` VALUES (1,'The dark forest',1,1,'forest'),(2,'The spooky cave',3,2,'cave'),
(3,'Mountain\'s summit',2,1,'mountain'),(4,'The strange swamp',3,3,'swamp'),(5,'Another forest',4,6,'forest'),(6,'Cristi\'s house',3,4,'cave');
INSERT INTO `oras` VALUES (1,'Bielefeld',1,2),(2,'Aalen',2,3),(3,'Ulm',5,1),(4,'Coburg',5,3),(5,'Passau',3,5);
INSERT INTO `npc` VALUES (1,2,'Alexis Bachelot',NULL),(2,1,'Antonio Vivaldi ',NULL),(3,3,'Nicolas Aubry ',NULL),
(4,4,'Erasmus of Rotterdam ',NULL),(5,5,'Avra',NULL);
INSERT INTO `quest` VALUES (1,'Kill 5 zombies',0,'2021-05-16 01:53:38','2021-05-17 20:11:49',4),(2,'Slay a dragon',1,'2021-05-23 09:49:41',NULL,1),
(3,'Explore the spooky cave',0,NULL,NULL,2),(4,'Defeat Cristi',1,'2021-05-22 10:39:04',NULL,5),(5,'Explore all dungeons',1,'2021-06-29 11:42:47',NULL,3);
INSERT INTO `quest_drop` VALUES (1,3,1,100),(2,5,1,50),(3,8,2,200),(4,12,2,100),(5,10,3,500),(6,2,3,600),(7,4,4,500),(8,13,4,500),
(9,17,5,1000),(10,16,5,1000);
INSERT INTO `inventar` VALUES (1,1,5,NULL),(2,2,5,NULL),(3,3,10,NULL),(4,4,5,NULL),(5,5,10,NULL);
INSERT INTO `inventar_continut` VALUES (1,1,2),(2,1,5),(3,2,1),(4,3,3),(5,3,5),(6,3,7),(7,3,6),(8,4,4),(9,5,16),(10,5,17);
INSERT INTO `pet` VALUES (1,3,50,1,'Cute dog','2021-05-24 11:35:39'),(2,4,75,1,'Aligator','2021-04-28 17:38:40'),
(3,1,50,2,'Another dog','2021-05-27 14:06:04'),(4,2,30,2,'Cat','2021-04-25 23:24:50'),(5,5,20,1,'Fish','2021-05-13 13:14:29');
INSERT INTO `mob` VALUES (1,4,'Slime',1,10,20,3),(2,2,'Skeleton',2,50,100,20),(3,1,'Zombie',3,50,150,15),
(4,4,'BIG Pyranha',8,100,300,50),(5,6,'Cristi',99,9999,9999,999),(6,3,'Troll',20,250,600,90),
(7,5,'Tree spirit',15,250,200,100),(8,2,'BIG Spider',10,300,500,120),(9,3,'Dragon',20,1000,1500,325);
INSERT INTO `mob_drop` VALUES (1,1,1,10),(2,6,1,0),(3,2,2,15),(4,7,2,10),(5,10,3,20),(6,7,3,30),
(7,10,4,60),(8,11,4,100),(9,16,5,0),(10,17,5,0),(11,14,6,23),(12,12,7,51),(13,4,8,100),(14,15,9,200);