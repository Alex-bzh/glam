-- MySQL dump 10.13  Distrib 5.6.12, for osx10.7 (x86_64)
--
-- Host: localhost    Database: glam
-- ------------------------------------------------------
-- Server version	5.6.12

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `authors`
--

DROP TABLE IF EXISTS `authors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authors` (
  `id_author` int(5) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `lastname` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id_author`),
  KEY `idx_author` (`firstname`,`lastname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authors`
--

LOCK TABLES `authors` WRITE;
/*!40000 ALTER TABLE `authors` DISABLE KEYS */;
/*!40000 ALTER TABLE `authors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documents`
--

DROP TABLE IF EXISTS `documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documents` (
  `id_document` int(5) NOT NULL AUTO_INCREMENT,
  `ref_type` int(2) NOT NULL,
  `ref_lang` int(3) NOT NULL,
  `online` int(1) NOT NULL DEFAULT '0',
  `metadata` int(1) NOT NULL DEFAULT '0',
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `title_alternate` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `abstract` text COLLATE utf8_unicode_ci,
  `edition` varchar(90) COLLATE utf8_unicode_ci DEFAULT NULL,
  `volume` int(3) DEFAULT NULL,
  `nb_volumes` int(3) DEFAULT NULL,
  `issue` int(4) DEFAULT NULL,
  `pages` int(4) DEFAULT NULL,
  `pages_from` int(4) DEFAULT NULL,
  `pages_to` int(4) DEFAULT NULL,
  `date_year` int(4) DEFAULT NULL,
  `date_month` int(2) DEFAULT NULL,
  `date_day` int(2) DEFAULT NULL,
  `date_alternate` int(10) DEFAULT NULL,
  `place` varchar(90) COLLATE utf8_unicode_ci DEFAULT NULL,
  `support` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `media_type` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `format` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `doi` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `issn` varchar(9) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_document`),
  KEY `idx_title` (`title`),
  KEY `idx_title_alternate` (`title_alternate`),
  KEY `idx_place` (`place`),
  KEY `idx_support` (`support`),
  KEY `idx_format` (`format`),
  KEY `ref_type` (`ref_type`),
  KEY `ref_lang` (`ref_lang`),
  CONSTRAINT `documents_ibfk_1` FOREIGN KEY (`ref_type`) REFERENCES `types` (`id_type`),
  CONSTRAINT `documents_ibfk_2` FOREIGN KEY (`ref_lang`) REFERENCES `languages` (`id_language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documents`
--

LOCK TABLES `documents` WRITE;
/*!40000 ALTER TABLE `documents` DISABLE KEYS */;
/*!40000 ALTER TABLE `documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documents_authors`
--

DROP TABLE IF EXISTS `documents_authors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documents_authors` (
  `ref_document` int(5) NOT NULL,
  `ref_author` int(5) NOT NULL,
  `ref_role` int(1) NOT NULL,
  KEY `ref_author` (`ref_author`),
  KEY `ref_role` (`ref_role`),
  CONSTRAINT `documents_authors_ibfk_1` FOREIGN KEY (`ref_author`) REFERENCES `authors` (`id_author`),
  CONSTRAINT `documents_authors_ibfk_2` FOREIGN KEY (`ref_role`) REFERENCES `roles` (`id_role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documents_authors`
--

LOCK TABLES `documents_authors` WRITE;
/*!40000 ALTER TABLE `documents_authors` DISABLE KEYS */;
/*!40000 ALTER TABLE `documents_authors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documents_languages_topics`
--

DROP TABLE IF EXISTS `documents_languages_topics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documents_languages_topics` (
  `ref_document` int(5) NOT NULL,
  `ref_language` int(3) NOT NULL,
  KEY `ref_document` (`ref_document`),
  KEY `ref_language` (`ref_language`),
  CONSTRAINT `documents_languages_topics_ibfk_1` FOREIGN KEY (`ref_document`) REFERENCES `documents` (`id_document`),
  CONSTRAINT `documents_languages_topics_ibfk_2` FOREIGN KEY (`ref_language`) REFERENCES `languages` (`id_language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documents_languages_topics`
--

LOCK TABLES `documents_languages_topics` WRITE;
/*!40000 ALTER TABLE `documents_languages_topics` DISABLE KEYS */;
/*!40000 ALTER TABLE `documents_languages_topics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documents_related_fields`
--

DROP TABLE IF EXISTS `documents_related_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documents_related_fields` (
  `ref_document` int(5) NOT NULL,
  `ref_field` int(3) NOT NULL,
  KEY `ref_document` (`ref_document`),
  KEY `ref_field` (`ref_field`),
  CONSTRAINT `documents_related_fields_ibfk_1` FOREIGN KEY (`ref_document`) REFERENCES `documents` (`id_document`),
  CONSTRAINT `documents_related_fields_ibfk_2` FOREIGN KEY (`ref_field`) REFERENCES `related_fields` (`id_field`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documents_related_fields`
--

LOCK TABLES `documents_related_fields` WRITE;
/*!40000 ALTER TABLE `documents_related_fields` DISABLE KEYS */;
/*!40000 ALTER TABLE `documents_related_fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documents_themes`
--

DROP TABLE IF EXISTS `documents_themes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documents_themes` (
  `ref_document` int(5) NOT NULL,
  `ref_theme` int(3) NOT NULL,
  KEY `ref_document` (`ref_document`),
  KEY `ref_theme` (`ref_theme`),
  CONSTRAINT `documents_themes_ibfk_1` FOREIGN KEY (`ref_document`) REFERENCES `documents` (`id_document`),
  CONSTRAINT `documents_themes_ibfk_2` FOREIGN KEY (`ref_theme`) REFERENCES `themes` (`id_theme`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documents_themes`
--

LOCK TABLES `documents_themes` WRITE;
/*!40000 ALTER TABLE `documents_themes` DISABLE KEYS */;
/*!40000 ALTER TABLE `documents_themes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS `languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `languages` (
  `id_language` int(3) NOT NULL AUTO_INCREMENT,
  `iso` char(3) COLLATE utf8_unicode_ci NOT NULL,
  `language` varchar(90) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id_language`),
  UNIQUE KEY `idx_language` (`language`,`iso`)
) ENGINE=InnoDB AUTO_INCREMENT=485 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `languages`
--

LOCK TABLES `languages` WRITE;
/*!40000 ALTER TABLE `languages` DISABLE KEYS */;
INSERT INTO `languages` VALUES (2,'abk','Abkhazian'),(3,'ace','Achinese'),(4,'ach','Acoli'),(5,'ada','Adangme'),(6,'ady','Adyghe; Adygei'),(1,'aar','Afar'),(8,'afh','Afrihili'),(9,'afr','Afrikaans'),(7,'afa','Afro-Asiatic languages'),(10,'ain','Ainu'),(11,'aka','Akan'),(12,'akk','Akkadian'),(402,'alb','Albanian'),(13,'ale','Aleut'),(14,'alg','Algonquian languages'),(445,'tut','Altaic languages'),(16,'amh','Amharic'),(18,'anp','Angika'),(19,'apa','Apache languages'),(20,'ara','Arabic'),(22,'arg','Aragonese'),(25,'arp','Arapaho'),(27,'arw','Arawak'),(23,'arm','Armenian'),(362,'rup','Aromanian; Arumanian; Macedo-Romanian'),(26,'art','Artificial languages'),(28,'asm','Assamese'),(29,'ast','Asturian; Bable; Leonese; Asturleonese'),(30,'ath','Athapascan languages'),(31,'aus','Australian languages'),(270,'map','Austronesian languages'),(32,'ava','Avaric'),(33,'ave','Avestan'),(34,'awa','Awadhi'),(35,'aym','Aymara'),(36,'aze','Azerbaijani'),(42,'ban','Balinese'),(45,'bat','Baltic languages'),(40,'bal','Baluchi'),(41,'bam','Bambara'),(38,'bai','Bamileke languages'),(37,'bad','Banda languages'),(57,'bnt','Bantu languages'),(44,'bas','Basa'),(39,'bak','Bashkir'),(43,'baq','Basque'),(62,'btk','Batak languages'),(46,'bej','Beja; Bedawiyet'),(47,'bel','Belarusian'),(48,'bem','Bemba'),(49,'ben','Bengali'),(50,'ber','Berber languages'),(51,'bho','Bhojpuri'),(52,'bih','Bihari'),(53,'bik','Bikol'),(54,'bin','Bini; Edo'),(55,'bis','Bislama'),(66,'byn','Blin; Bilin'),(477,'zbl','Blissymbols; Blissymbolics; Bliss'),(314,'nob','Bokmål, Norwegian; Norwegian Bokmål'),(59,'bos','Bosnian'),(60,'bra','Braj'),(61,'bre','Breton'),(64,'bug','Buginese'),(65,'bul','Bulgarian'),(63,'bua','Buriat'),(295,'bur','Burmese'),(67,'cad','Caddo'),(70,'cat','Catalan; Valencian'),(71,'cau','Caucasian languages'),(72,'ceb','Cebuano'),(73,'cel','Celtic languages'),(68,'cai','Central American Indian languages'),(221,'khm','Central Khmer'),(77,'chg','Chagatai'),(88,'cmc','Chamic languages'),(74,'cha','Chamorro'),(76,'che','Chechen'),(84,'chr','Cherokee'),(87,'chy','Cheyenne'),(75,'chb','Chibcha'),(322,'nya','Chichewa; Chewa; Nyanja'),(78,'chi','Chinese'),(81,'chn','Chinook jargon'),(83,'chp','Chipewyan; Dene Suline'),(82,'cho','Choctaw'),(85,'chu','Church Slavic; Old Slavonic; Church Slavonic; Old Bulgarian; Old Church Slavonic'),(79,'chk','Chuukese'),(86,'chv','Chuvash'),(321,'nwc','Classical Newari; Old Newari; Classical Nepal Bhasa'),(415,'syc','Classical Syriac'),(89,'cop','Coptic'),(90,'cor','Cornish'),(91,'cos','Corsican'),(95,'cre','Cree'),(292,'mus','Creek'),(97,'crp','Creoles and pidgins'),(92,'cpe','Creoles and pidgins, English based'),(93,'cpf','Creoles and pidgins, French-based'),(94,'cpp','Creoles and pidgins, Portuguese-based'),(96,'crh','Crimean Tatar; Crimean Turkish'),(180,'hrv','Croatian'),(99,'cus','Cushitic languages'),(101,'cze','Czech'),(102,'dak','Dakota'),(103,'dan','Danish'),(104,'dar','Dargwa'),(106,'del','Delaware'),(109,'din','Dinka'),(110,'div','Divehi; Dhivehi; Maldivian'),(111,'doi','Dogri'),(108,'dgr','Dogrib'),(112,'dra','Dravidian languages'),(114,'dua','Duala'),(115,'dum','Dutch, Middle (ca.1050-1350)'),(312,'dut','Dutch; Flemish'),(116,'dyu','Dyula'),(117,'dzo','Dzongkha'),(140,'frs','Eastern Frisian'),(118,'efi','Efik'),(119,'egy','Egyptian (Ancient)'),(120,'eka','Ekajuk'),(121,'elx','Elamite'),(122,'eng','English'),(123,'enm','English, Middle (1100-1500)'),(17,'ang','English, Old (ca.450-1100)'),(297,'myv','Erzya'),(124,'epo','Esperanto'),(125,'est','Estonian'),(126,'ewe','Ewe'),(127,'ewo','Ewondo'),(128,'fan','Fang'),(130,'fat','Fanti'),(129,'fao','Faroese'),(131,'fij','Fijian'),(132,'fil','Filipino; Pilipino'),(133,'fin','Finnish'),(134,'fiu','Finno-Ugrian languages'),(135,'fon','Fon'),(136,'fre','French'),(137,'frm','French, Middle (ca.1400-1600)'),(138,'fro','French, Old (842-ca.1400)'),(143,'fur','Friulian'),(142,'ful','Fulah'),(144,'gaa','Ga'),(152,'gla','Gaelic; Scottish Gaelic'),(69,'car','Galibi Carib'),(154,'glg','Galician'),(256,'lug','Ganda'),(145,'gay','Gayo'),(146,'gba','Gbaya'),(150,'gez','Geez'),(148,'geo','Georgian'),(149,'ger','German'),(156,'gmh','German, Middle High (ca.1050-1500)'),(157,'goh','German, Old High (ca.750-1050)'),(147,'gem','Germanic languages'),(151,'gil','Gilbertese'),(158,'gon','Gondi'),(159,'gor','Gorontalo'),(160,'got','Gothic'),(161,'grb','Grebo'),(162,'grc','Greek, Ancient (to 1453)'),(163,'gre','Greek, Modern (1453-)'),(164,'grn','Guarani'),(166,'guj','Gujarati'),(167,'gwi','Gwich\'in'),(168,'hai','Haida'),(169,'hat','Haitian; Haitian Creole'),(170,'hau','Hausa'),(171,'haw','Hawaiian'),(172,'heb','Hebrew'),(173,'her','Herero'),(174,'hil','Hiligaynon'),(175,'him','Himachali'),(176,'hin','Hindi'),(179,'hmo','Hiri Motu'),(177,'hit','Hittite'),(178,'hmn','Hmong'),(182,'hun','Hungarian'),(183,'hup','Hupa'),(184,'iba','Iban'),(186,'ice','Icelandic'),(187,'ido','Ido'),(185,'ibo','Igbo'),(189,'ijo','Ijo languages'),(192,'ilo','Iloko'),(391,'smn','Inari Sami'),(194,'inc','Indic languages'),(196,'ine','Indo-European languages'),(195,'ind','Indonesian'),(197,'inh','Ingush'),(193,'ina','Interlingua (International Auxiliary Language Association)'),(191,'ile','Interlingue; Occidental'),(190,'iku','Inuktitut'),(198,'ipk','Inupiaq'),(199,'ira','Iranian languages'),(153,'gle','Irish'),(276,'mga','Irish, Middle (900-1200)'),(377,'sga','Irish, Old (to 900)'),(200,'iro','Iroquoian languages'),(201,'ita','Italian'),(204,'jpn','Japanese'),(202,'jav','Javanese'),(206,'jrb','Judeo-Arabic'),(205,'jpr','Judeo-Persian'),(218,'kbd','Kabardian'),(208,'kab','Kabyle'),(209,'kac','Kachin; Jingpho'),(210,'kal','Kalaallisut; Greenlandic'),(469,'xal','Kalmyk; Oirat'),(211,'kam','Kamba'),(212,'kan','Kannada'),(215,'kau','Kanuri'),(207,'kaa','Kara-Kalpak'),(233,'krc','Karachay-Balkar'),(234,'krl','Karelian'),(213,'kar','Karen languages'),(214,'kas','Kashmiri'),(98,'csb','Kashubian'),(216,'kaw','Kawi'),(217,'kaz','Kazakh'),(219,'kha','Khasi'),(220,'khi','Khoisan languages'),(222,'kho','Khotanese; Sakan'),(223,'kik','Kikuyu; Gikuyu'),(226,'kmb','Kimbundu'),(224,'kin','Kinyarwanda'),(225,'kir','Kirghiz; Kyrgyz'),(432,'tlh','Klingon; tlhIngan-Hol'),(228,'kom','Komi'),(229,'kon','Kongo'),(227,'kok','Konkani'),(230,'kor','Korean'),(231,'kos','Kosraean'),(232,'kpe','Kpelle'),(235,'kro','Kru languages'),(237,'kua','Kuanyama; Kwanyama'),(238,'kum','Kumyk'),(239,'kur','Kurdish'),(236,'kru','Kurukh'),(240,'kut','Kutenai'),(241,'lad','Ladino'),(242,'lah','Lahnda'),(243,'lam','Lamba'),(105,'day','Land Dayak languages'),(244,'lao','Lao'),(245,'lat','Latin'),(246,'lav','Latvian'),(247,'lez','Lezghian'),(248,'lim','Limburgan; Limburger; Limburgish'),(249,'lin','Lingala'),(250,'lit','Lithuanian'),(203,'jbo','Lojban'),(306,'nds','Low German; Low Saxon; German, Low; Saxon, Low'),(113,'dsb','Lower Sorbian'),(252,'loz','Lozi'),(255,'lub','Luba-Katanga'),(254,'lua','Luba-Lulua'),(257,'lui','Luiseno'),(390,'smj','Lule Sami'),(258,'lun','Lunda'),(259,'luo','Luo (Kenya and Tanzania)'),(260,'lus','Lushai'),(253,'ltz','Luxembourgish; Letzeburgesch'),(261,'mac','Macedonian'),(262,'mad','Madurese'),(263,'mag','Magahi'),(265,'mai','Maithili'),(266,'mak','Makasar'),(281,'mlg','Malagasy'),(289,'may','Malay'),(267,'mal','Malayalam'),(282,'mlt','Maltese'),(283,'mnc','Manchu'),(274,'mdr','Mandar'),(268,'man','Mandingo'),(284,'mni','Manipuri'),(285,'mno','Manobo languages'),(155,'glv','Manx'),(269,'mao','Maori'),(24,'arn','Mapudungun; Mapuche'),(271,'mar','Marathi'),(80,'chm','Mari'),(264,'mah','Marshallese'),(294,'mwr','Marwari'),(272,'mas','Masai'),(296,'myn','Mayan languages'),(275,'men','Mende'),(277,'mic','Mi\'kmaq; Micmac'),(278,'min','Minangkabau'),(293,'mwl','Mirandese'),(286,'moh','Mohawk'),(273,'mdf','Moksha'),(280,'mkh','Mon-Khmer languages'),(251,'lol','Mongo'),(287,'mon','Mongolian'),(288,'mos','Mossi'),(290,'mul','Multiple languages'),(291,'mun','Munda languages'),(318,'nqo','N\'Ko'),(298,'nah','Nahuatl languages'),(301,'nau','Nauru'),(302,'nav','Navajo; Navaho'),(304,'nde','Ndebele, North; North Ndebele'),(303,'nbl','Ndebele, South; South Ndebele'),(305,'ndo','Ndonga'),(300,'nap','Neapolitan'),(308,'new','Nepal Bhasa; Newari'),(307,'nep','Nepali'),(309,'nia','Nias'),(310,'nic','Niger-Kordofanian languages'),(407,'ssa','Nilo-Saharan languages'),(311,'niu','Niuean'),(483,'zxx','No linguistic content; Not applicable'),(315,'nog','Nogai'),(316,'non','Norse, Old'),(299,'nai','North American Indian languages'),(139,'frr','Northern Frisian'),(388,'sme','Northern Sami'),(317,'nor','Norwegian'),(313,'nno','Norwegian Nynorsk; Nynorsk, Norwegian'),(320,'nub','Nubian languages'),(323,'nym','Nyamwezi'),(324,'nyn','Nyankole'),(325,'nyo','Nyoro'),(326,'nzi','Nzima'),(327,'oci','Occitan (post 1500)'),(21,'arc','Official Aramaic (700-300 BCE); Imperial Aramaic (700-300 BCE)'),(328,'oji','Ojibwa'),(329,'ori','Oriya'),(330,'orm','Oromo'),(331,'osa','Osage'),(332,'oss','Ossetian; Ossetic'),(334,'oto','Otomian languages'),(337,'pal','Pahlavi'),(341,'pau','Palauan'),(346,'pli','Pali'),(338,'pam','Pampanga; Kapampangan'),(336,'pag','Pangasinan'),(339,'pan','Panjabi; Punjabi'),(340,'pap','Papiamento'),(335,'paa','Papuan languages'),(319,'nso','Pedi; Sepedi; Northern Sotho'),(343,'per','Persian'),(342,'peo','Persian, Old (ca.600-400 B.C.)'),(344,'phi','Philippine languages'),(345,'phn','Phoenician'),(348,'pon','Pohnpeian'),(347,'pol','Polish'),(349,'por','Portuguese'),(350,'pra','Prakrit languages'),(351,'pro','Provençal, Old (to 1500);Occitan, Old (to 1500)'),(352,'pus','Pushto; Pashto'),(353,'que','Quechua'),(354,'raj','Rajasthani'),(355,'rap','Rapanui'),(356,'rar','Rarotongan; Cook Islands Maori'),(357,'roa','Romance languages'),(360,'rum','Romanian; Moldavian; Moldovan'),(358,'roh','Romansh'),(359,'rom','Romany'),(361,'run','Rundi'),(363,'rus','Russian'),(368,'sal','Salishan languages'),(369,'sam','Samaritan Aramaic'),(389,'smi','Sami languages'),(392,'smo','Samoan'),(364,'sad','Sandawe'),(365,'sag','Sango'),(370,'san','Sanskrit'),(372,'sat','Santali'),(403,'srd','Sardinian'),(371,'sas','Sasak'),(374,'sco','Scots'),(375,'sel','Selkup'),(376,'sem','Semitic languages'),(405,'srp','Serbian'),(406,'srr','Serer'),(379,'shn','Shan'),(394,'sna','Shona'),(188,'iii','Sichuan Yi; Nuosu'),(373,'scn','Sicilian'),(380,'sid','Sidamo'),(378,'sgn','Sign Languages'),(56,'bla','Siksika'),(395,'snd','Sindhi'),(381,'sin','Sinhala; Sinhalese'),(383,'sit','Sino-Tibetan languages'),(382,'sio','Siouan languages'),(393,'sms','Skolt Sami'),(107,'den','Slave (Athapascan)'),(384,'sla','Slavic languages'),(385,'slo','Slovak'),(386,'slv','Slovenian'),(397,'sog','Sogdian'),(398,'som','Somali'),(399,'son','Songhai languages'),(396,'snk','Soninke'),(466,'wen','Sorbian languages'),(400,'sot','Sotho, Southern'),(367,'sai','South American Indian languages'),(15,'alt','Southern Altai'),(387,'sma','Southern Sami'),(401,'spa','Spanish; Castilian'),(404,'srn','Sranan Tongo'),(409,'suk','Sukuma'),(412,'sux','Sumerian'),(410,'sun','Sundanese'),(411,'sus','Susu'),(413,'swa','Swahili'),(408,'ssw','Swati'),(414,'swe','Swedish'),(165,'gsw','Swiss German; Alemannic; Alsatian'),(416,'syr','Syriac'),(426,'tgl','Tagalog'),(417,'tah','Tahitian'),(418,'tai','Tai languages'),(425,'tgk','Tajik'),(434,'tmh','Tamashek'),(419,'tam','Tamil'),(420,'tat','Tatar'),(421,'tel','Telugu'),(423,'ter','Tereno'),(424,'tet','Tetum'),(427,'tha','Thai'),(58,'tib','Tibetan'),(428,'tig','Tigre'),(429,'tir','Tigrinya'),(422,'tem','Timne'),(430,'tiv','Tiv'),(433,'tli','Tlingit'),(437,'tpi','Tok Pisin'),(431,'tkl','Tokelau'),(435,'tog','Tonga (Nyasa)'),(436,'ton','Tonga (Tonga Islands)'),(438,'tsi','Tsimshian'),(440,'tso','Tsonga'),(439,'tsn','Tswana'),(442,'tum','Tumbuka'),(443,'tup','Tupi languages'),(444,'tur','Turkish'),(333,'ota','Turkish, Ottoman (1500-1928)'),(441,'tuk','Turkmen'),(446,'tvl','Tuvalu'),(448,'tyv','Tuvinian'),(447,'twi','Twi'),(449,'udm','Udmurt'),(450,'uga','Ugaritic'),(451,'uig','Uighur; Uyghur'),(452,'ukr','Ukrainian'),(453,'umb','Umbundu'),(279,'mis','Uncoded languages'),(454,'und','Undetermined'),(181,'hsb','Upper Sorbian'),(455,'urd','Urdu'),(456,'uzb','Uzbek'),(457,'vai','Vai'),(458,'ven','Venda'),(459,'vie','Vietnamese'),(460,'vol','Volapük'),(461,'vot','Votic'),(462,'wak','Wakashan languages'),(467,'wln','Walloon'),(464,'war','Waray'),(465,'was','Washo'),(100,'wel','Welsh'),(141,'fry','Western Frisian'),(463,'wal','Wolaitta; Wolaytta'),(468,'wol','Wolof'),(470,'xho','Xhosa'),(366,'sah','Yakut'),(471,'yao','Yao'),(472,'yap','Yapese'),(473,'yid','Yiddish'),(474,'yor','Yoruba'),(475,'ypk','Yupik languages'),(480,'znd','Zande languages'),(476,'zap','Zapotec'),(484,'zza','Zaza; Dimili; Dimli; Kirdki; Kirmanjki; Zazaki'),(478,'zen','Zenaga'),(479,'zha','Zhuang; Chuang'),(481,'zul','Zulu'),(482,'zun','Zuni');
/*!40000 ALTER TABLE `languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `related_fields`
--

DROP TABLE IF EXISTS `related_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `related_fields` (
  `id_field` int(3) NOT NULL AUTO_INCREMENT,
  `ref_parent` int(3) DEFAULT NULL,
  `field` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_field`),
  UNIQUE KEY `idx_field` (`field`),
  KEY `ref_parent` (`ref_parent`)
) ENGINE=InnoDB AUTO_INCREMENT=149 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `related_fields`
--

LOCK TABLES `related_fields` WRITE;
/*!40000 ALTER TABLE `related_fields` DISABLE KEYS */;
INSERT INTO `related_fields` VALUES (1,0,'Sociétés'),(2,0,'Esprit et Langage'),(3,0,'Périodes'),(4,0,'Espaces'),(5,1,'Sociologie'),(6,1,'Ethnologie, anthropologie'),(7,1,'Études des sciences'),(8,1,'Études urbaines'),(9,1,'Géographie'),(10,1,'Histoire'),(11,1,'Économie'),(12,1,'Études du politique'),(13,1,'Droit'),(14,2,'Pensée'),(15,2,'Religions'),(16,2,'Psychisme'),(17,2,'Langage'),(18,2,'Information'),(19,2,'Représentations'),(20,2,'Éducation'),(21,2,'Épistémologie et méthodes'),(22,3,'Préhistoire et antiquité'),(23,3,'Moyen Âge'),(24,3,'Époque moderne'),(25,3,'Époque contemporaine'),(26,4,'Afrique'),(27,4,'Amériques'),(28,4,'Asie'),(29,4,'Europe'),(30,4,'Océanie'),(31,5,'Sociologie du travail'),(32,5,'Étude des genres'),(33,5,'Sport et loisirs'),(34,5,'Sociologie de la consommation'),(35,5,'Sociologie urbaine'),(36,5,'Sociologie de la santé'),(37,5,'Sociologie de la culture'),(38,5,'Sociologie économique'),(39,5,'Âges de la vie'),(40,5,'Démographie'),(41,5,'Criminologie'),(42,6,'Anthropologie sociale'),(43,6,'Anthropologie culturelle'),(44,6,'Anthropologie politique'),(45,6,'Anthropologie religieuse'),(46,7,'Histoire des sciences'),(47,7,'Sociologie des sciences'),(48,7,'Philosophie des sciences'),(49,9,'Migrations, immigrations, minorités'),(50,9,'Géographie urbaine'),(51,9,'Géographie rurale'),(52,9,'Systèmes, modélisation, géostatistiques'),(53,9,'Épistémologie & histoire de la géographie'),(54,9,'Espace, société et territoire'),(55,9,'Géographie : politique, culture et représentation'),(56,9,'Nature, paysage et environnement'),(57,9,'Géographie appliquée et aménagement'),(58,10,'Histoire économique'),(59,10,'Histoire industrielle'),(60,10,'Histoire rurale'),(61,10,'Histoire urbaine'),(62,10,'Histoire des femmes'),(63,10,'Histoire du travail'),(64,10,'Histoire sociale'),(65,11,'Économie politique'),(66,11,'Développement économique'),(67,11,'Travail, emploi'),(68,11,'Gestion'),(69,12,'Sciences politiques'),(70,12,'Histoire politique'),(71,12,'Relations internationales'),(72,12,'Mouvements politiques et sociaux'),(73,12,'Sociologie politique'),(74,12,'Politiques et actions publiques'),(75,12,'Institutions politiques'),(76,12,'Guerres, conflits, violence'),(77,13,'Histoire du droit'),(78,13,'Sociologie du droit'),(79,14,'Philosophie'),(80,14,'Histoire intellectuelle'),(81,14,'Sciences cognitives'),(82,15,'Histoire des religions'),(83,15,'Sociologie des religions'),(84,16,'Psychanalyse'),(85,16,'Psychologie'),(86,17,'Linguistique'),(87,17,'Littératures'),(88,18,'Sciences de l’information'),(89,18,'Édition électronique'),(90,18,'Histoire et sociologie du livre'),(91,18,'Histoire et sociologie de la presse'),(92,18,'Histoire et sociologie des médias'),(93,19,'Histoire culturelle'),(94,19,'Histoire de l’Art'),(95,19,'Patrimoine'),(96,19,'Études visuelles'),(97,19,'Identités culturelles'),(98,19,'Architecture'),(99,20,'Histoire de l’éducation'),(100,20,'Sciences de l’éducation'),(101,21,'Vie de la recherche'),(102,21,'Approches biographiques'),(103,21,'Cartographie, imagerie, SIG'),(104,21,'Épistémologie'),(105,21,'Historiographie'),(106,21,'Sciences auxiliaires de l’Histoire'),(107,21,'Archéologie'),(108,21,'Méthodes de traitement et de représentation'),(109,21,'Approches de corpus, enquêtes, archives'),(110,21,'Digital humanities'),(111,22,'Préhistoire'),(112,22,'Histoire grecque'),(113,22,'Histoire romaine'),(114,22,'Monde oriental'),(115,22,'Égypte ancienne'),(116,23,'Haut Moyen Âge'),(117,23,'Bas Moyen Âge'),(118,24,'XVIe siècle'),(119,24,'XVIIe siècle'),(120,24,'XVIIIe siècle'),(121,24,'Révolution française'),(122,25,'XIXe siècle'),(123,25,'XXe siècle'),(124,25,'XXIe siècle'),(125,25,'Prospectives'),(126,26,'Afrique du nord'),(127,26,'Afrique noire'),(128,27,'États-Unis'),(129,27,'Canada'),(130,27,'Amérique latine'),(131,28,'Proche-Orient'),(132,28,'Moyen-Orient'),(133,28,'Asie centrale'),(134,28,'Monde persan'),(135,28,'Monde indien'),(136,28,'Asie du Sud-Est'),(137,28,'Extrême Orient'),(138,29,'Balkans'),(139,29,'Belgique'),(140,29,'Europe centrale et orientale'),(141,29,'France'),(142,29,'Îles britanniques'),(143,29,'Italie'),(144,29,'Méditerranée'),(145,29,'Monde germanique'),(146,29,'Pays baltes et scandinaves'),(147,29,'Péninsule ibérique'),(148,29,'Suisse');
/*!40000 ALTER TABLE `related_fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id_role` int(1) NOT NULL AUTO_INCREMENT,
  `role` varchar(30) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'NULL',
  PRIMARY KEY (`id_role`),
  KEY `idx_role` (`role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1, 'author'), (2, 'editor');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `themes`
--

DROP TABLE IF EXISTS `themes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `themes` (
  `id_theme` int(3) NOT NULL AUTO_INCREMENT,
  `theme` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `field` int(1) NOT NULL,
  PRIMARY KEY (`id_theme`),
  UNIQUE KEY `idx_theme` (`theme`,`field`)
) ENGINE=InnoDB AUTO_INCREMENT=243 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `themes`
--

LOCK TABLES `themes` WRITE;
/*!40000 ALTER TABLE `themes` DISABLE KEYS */;
INSERT INTO `themes` VALUES (130,'(post-/de-)Colonialism',0),(122,'Academic discourses',0),(123,'Advertisement',0),(211,'Anthropological Linguistics',2),(124,'Antifeminism',0),(125,'Antisexism',0),(127,'Bi-sexualities',0),(128,'Binarity',0),(126,'Biological discourses',0),(129,'Categorization',0),(192,'Colored Feminism',1),(212,'Comparative Linguistics',2),(213,'Computational Linguistics',2),(214,'Conversational Analysis',2),(215,'Corpus Linguistics',2),(191,'Cultural Studies',1),(193,'Deficit Theory',1),(194,'Difference Theory',1),(131,'Digital Discourse',0),(216,'Digital Linguistics',2),(217,'Discourse Analysis',2),(195,'Dominance Theory',1),(132,'Emotions',0),(196,'Feminism',1),(197,'Feminist Critical Discourse Analysis',1),(133,'Feminities',0),(134,'Feminization',0),(218,'Forensic Linguistics',2),(135,'Gay',0),(136,'Gender (general)',0),(137,'Gender Representations',0),(139,'Gender-neutral language',0),(138,'Gender, class, race',0),(140,'Genderlects',0),(219,'General Linguistics',2),(141,'Generic',0),(142,'Grammatical Gender',0),(143,'Heteronormativity',0),(144,'Heterosexualities',0),(220,'Historical Linguistics',2),(221,'History of Linguistics',2),(145,'Homosexualities',0),(146,'Identity',0),(222,'Interactionism',2),(147,'Intersectionality',0),(198,'Intersectionality',1),(223,'Language Acquisition',2),(149,'Language and languages',0),(224,'Language Pathology Studies',2),(150,'Language Planning and Gender/Feminism',0),(151,'Legal discourses',0),(152,'Lesbian',0),(225,'Lexicography',2),(153,'LGBT',0),(199,'Liberal feminism',1),(148,'Linguistic imaginary',0),(226,'Linguistic Theories',2),(227,'Literature',2),(154,'Male and Female Speech arts in private and public settings/i',0),(155,'Male and female writings stylistics',0),(156,'Margins',0),(157,'Masculinities',0),(200,'Materialism',1),(158,'Media, Language and Gender',0),(159,'Metaphors',0),(228,'Morphology',2),(160,'Non-Sexist Language',0),(161,'Norms',0),(162,'Patriarchy',0),(201,'Performativity',1),(229,'Philosophy of Language',2),(230,'Phonetics',2),(231,'Phonology',2),(167,'Policies',0),(163,'Politeness and Gender',0),(165,'Political Correctness',0),(166,'Political Discourse',0),(202,'Political philosophy',1),(164,'Politics',0),(203,'Post-colonial Studies',1),(204,'Post-modernism',1),(205,'Post-structuralism',1),(168,'Power',0),(232,'Pragmatics',2),(170,'Pronoun issues',0),(233,'Prosody',2),(169,'Public Discourse',0),(207,'Queer',1),(208,'Queer Linguistics',1),(171,'Queer writing',0),(206,'Radical feminism',1),(172,'Recommendations / prescriptions / guidelines',0),(234,'Rhetoric',2),(173,'Science / Scientific discourses',0),(235,'Semantics',2),(236,'Semiotics',2),(175,'Sex / Gender',0),(174,'Sex differences',0),(176,'Sex roles',0),(178,'Sexism',0),(179,'Sexist language',0),(177,'Sexualities',0),(237,'Sociolinguistics',2),(180,'Spoken discourse',0),(181,'Stereotypes of gender',0),(209,'Structuralism',1),(182,'Structure (gender structure, language structure)',0),(238,'Stylistics',2),(239,'Syntax',2),(183,'Technology/Technologies',0),(184,'Term of address',0),(240,'Textual Linguistics',2),(185,'Transexualities / Transgender',0),(242,'Translation',2),(210,'Transnational Theory',1),(241,'Typology',2),(186,'Use',0),(187,'Voice',0),(188,'Women/Men/Gender linguistic representations',0),(189,'Women/Men/Gendered Speech',0),(190,'Written Discourse',0);
/*!40000 ALTER TABLE `themes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `types`
--

DROP TABLE IF EXISTS `types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `types` (
  `id_type` int(2) NOT NULL AUTO_INCREMENT,
  `type` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `code` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id_type`),
  UNIQUE KEY `idx_code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `types`
--

LOCK TABLES `types` WRITE;
/*!40000 ALTER TABLE `types` DISABLE KEYS */;
INSERT INTO `types` VALUES (1,'Articles de revue','ART'),(2,'Numéros spéciaux de revue','NUM'),(3,'Articles de colloque','COL'),(4,'Articles de journaux','PRE'),(5,'Notices d’encyclopédie ou de dictionnaire','DIC'),(6,'Billets de blog','BLG'),(7,'Chapitres d’ouvrage','CHA'),(8,'Documents','DOC'),(9,'Corpus','CRP'),(10,'Ouvrages','OUV'),(11,'Ouvrages collectifs','CLB'),(12,'Thèses','THE'),(13,'Mémoires','MEM'),(14,'Sites Web','WEB');
/*!40000 ALTER TABLE `types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(3) NOT NULL AUTO_INCREMENT,
  `email` varchar(45) NOT NULL,
  `password` varchar(60) NOT NULL,
  `firstname` varchar(90) NOT NULL,
  `lastname` varchar(90) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_identity` (`email`,`password`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'alexandre.roulois@u-paris.fr','$2b$10$lPJsMizdIqF/0mC9bZUvz.yf0hmcrteTp7IJ9Nfo8nz38ycrATjQu','Alexandre','Roulois');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-02-23 15:27:09
