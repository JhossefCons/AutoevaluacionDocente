-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: bdfinalautoevaluacion
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.28-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `archivodocente`
--

DROP TABLE IF EXISTS `archivodocente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `archivodocente` (
  `ARC_ID` int(11) NOT NULL AUTO_INCREMENT,
  `ARC_NOMBRE` varchar(100) DEFAULT NULL,
  `ARC_TIPO` varchar(50) DEFAULT NULL,
  `ARC_RUTA` varchar(255) DEFAULT NULL,
  `USR_IDENTIFICACION` int(11) DEFAULT NULL,
  `EVA_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ARC_ID`),
  KEY `FK_USER_ARCHIVO` (`USR_IDENTIFICACION`),
  KEY `FK_EVA_ARCHIVO` (`EVA_ID`),
  CONSTRAINT `FK_EVA_ARCHIVO` FOREIGN KEY (`EVA_ID`) REFERENCES `autoevaluation` (`eva_ID`),
  CONSTRAINT `FK_USER_ARCHIVO` FOREIGN KEY (`USR_IDENTIFICACION`) REFERENCES `user` (`user_identification`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `archivodocente`
--

LOCK TABLES `archivodocente` WRITE;
/*!40000 ALTER TABLE `archivodocente` DISABLE KEYS */;
/*!40000 ALTER TABLE `archivodocente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `autoevaluation`
--

DROP TABLE IF EXISTS `autoevaluation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `autoevaluation` (
  `eva_ID` int(11) NOT NULL AUTO_INCREMENT,
  `labor_code` int(11) NOT NULL,
  `period_id` int(11) NOT NULL,
  `user_identification` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  `state` varchar(20) DEFAULT NULL,
  `acto` decimal(4,2) DEFAULT NULL,
  `recomendaciones` varchar(1000) DEFAULT NULL,
  `date_init` date DEFAULT NULL,
  `date_finish` date DEFAULT NULL,
  `activo` int(11) DEFAULT NULL,
  PRIMARY KEY (`eva_ID`),
  KEY `TIENE_FK` (`labor_code`),
  KEY `TIENES_PE_FK` (`period_id`),
  KEY `FK_EVALUACI_REFERENCE_USEROL` (`user_identification`,`role_id`),
  CONSTRAINT `FK_EVALUACI_REFERENCE_USEROL` FOREIGN KEY (`user_identification`, `role_id`) REFERENCES `userol` (`user_identification`, `role_id`),
  CONSTRAINT `FK_EVALUACI_TIENE_LABOR` FOREIGN KEY (`labor_code`) REFERENCES `labor` (`labor_code`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autoevaluation`
--

LOCK TABLES `autoevaluation` WRITE;
/*!40000 ALTER TABLE `autoevaluation` DISABLE KEYS */;
INSERT INTO `autoevaluation` VALUES (2,55,1,100,NULL,'ejecucion',0.00,' hacerlo a tiempo para el jueves','2023-11-22','2023-11-23',1);
/*!40000 ALTER TABLE `autoevaluation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `labor`
--

DROP TABLE IF EXISTS `labor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `labor` (
  `labor_code` int(11) NOT NULL,
  `type_labor_code` varchar(45) DEFAULT NULL,
  `labor_name` varchar(45) NOT NULL,
  `labor_hours` int(11) NOT NULL,
  `labor_descripcion` varchar(45) NOT NULL,
  `activo` int(11) NOT NULL,
  `labor_id` int(11) NOT NULL,
  PRIMARY KEY (`labor_code`),
  KEY `FK_LABOR_REFERENCIA_TYPE_LABOR_idx` (`type_labor_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `labor`
--

LOCK TABLES `labor` WRITE;
/*!40000 ALTER TABLE `labor` DISABLE KEYS */;
INSERT INTO `labor` VALUES (55,'AS','IA grupo B',10,'Clases de inteligencia artificial a los estud',1,0),(123,'D','IA grupo B',35,'Clases de inteligencia artificial a los estud',1,0);
/*!40000 ALTER TABLE `labor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notificacion`
--

DROP TABLE IF EXISTS `notificacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notificacion` (
  `NOT_ID` int(11) NOT NULL AUTO_INCREMENT,
  `USR_IDENTIFICACION` int(11) DEFAULT NULL,
  `NOT_FECHA` date DEFAULT NULL,
  `NOTI_MSJ` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`NOT_ID`),
  KEY `FK_NOTIFICACION` (`USR_IDENTIFICACION`),
  CONSTRAINT `FK_NOTIFICACION` FOREIGN KEY (`USR_IDENTIFICACION`) REFERENCES `user` (`user_identification`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notificacion`
--

LOCK TABLES `notificacion` WRITE;
/*!40000 ALTER TABLE `notificacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `notificacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `period`
--

DROP TABLE IF EXISTS `period`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `period` (
  `period_id` int(11) NOT NULL AUTO_INCREMENT,
  `period_name` varchar(50) DEFAULT NULL,
  `period_dateStart` date DEFAULT NULL,
  `period_dateFinish` date DEFAULT NULL,
  PRIMARY KEY (`period_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `period`
--

LOCK TABLES `period` WRITE;
/*!40000 ALTER TABLE `period` DISABLE KEYS */;
INSERT INTO `period` VALUES (1,'Periodo 1','2023-11-21','2023-12-21'),(2,'Periodo 2','2023-12-22','2024-01-22'),(3,'Periodo 3','2024-01-22','2024-02-22');
/*!40000 ALTER TABLE `period` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rol`
--

DROP TABLE IF EXISTS `rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rol` (
  `role_id` int(11) NOT NULL,
  `role_description` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rol`
--

LOCK TABLES `rol` WRITE;
/*!40000 ALTER TABLE `rol` DISABLE KEYS */;
INSERT INTO `rol` VALUES (1,'docente'),(2,'decano'),(3,'coordinador');
/*!40000 ALTER TABLE `rol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `type_labor`
--

DROP TABLE IF EXISTS `type_labor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `type_labor` (
  `type_labor_id` int(11) NOT NULL AUTO_INCREMENT,
  `type_labor_code` varchar(45) DEFAULT NULL,
  `type_labor_name` varchar(45) NOT NULL,
  PRIMARY KEY (`type_labor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `type_labor`
--

LOCK TABLES `type_labor` WRITE;
/*!40000 ALTER TABLE `type_labor` DISABLE KEYS */;
INSERT INTO `type_labor` VALUES (1,'AD','Administracion'),(2,'AS','Asesoria'),(3,'C','Capacitacion'),(4,'D','Docencia'),(5,'E','Extension'),(6,'OS','Otros Servicios'),(7,'PI','Proyectos Investigacion'),(8,'S','Servicios'),(9,'TD','Trabajos Docencia'),(10,'TI','Trabajos Investigacion');
/*!40000 ALTER TABLE `type_labor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_identification` int(11) NOT NULL,
  `user_name` varchar(50) NOT NULL,
  `user_lastname` varchar(50) DEFAULT NULL,
  `user_gender` varchar(1) NOT NULL,
  `user_studies` varchar(100) DEFAULT NULL,
  `user_email` varchar(100) NOT NULL,
  `user_password` varchar(150) NOT NULL,
  `activo` int(11) NOT NULL,
  `user_tipoDocente` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`user_identification`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (100,'julian','piamba','m','universitario','jufpiamba@unicauca.edu.co','julian26',1,'planta'),(200,'jhossef','constain','m','doctor','jhniconstain@unicauca.edu.co','jhossef26',1,'planta'),(300,'guillermo','pena','m','magister','gupena@unicauca.edu.co','guille26',1,'planta');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userol`
--

DROP TABLE IF EXISTS `userol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userol` (
  `user_identification` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `date_start` date DEFAULT NULL,
  `date_finish` date DEFAULT NULL,
  PRIMARY KEY (`user_identification`,`role_id`),
  KEY `USEROL_FK` (`user_identification`),
  KEY `USEROL2_FK` (`role_id`),
  CONSTRAINT `FK_USEROL_USEROL2_ROL` FOREIGN KEY (`role_id`) REFERENCES `rol` (`role_id`),
  CONSTRAINT `FK_USEROL_USEROL_USUARIO` FOREIGN KEY (`user_identification`) REFERENCES `user` (`user_identification`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userol`
--

LOCK TABLES `userol` WRITE;
/*!40000 ALTER TABLE `userol` DISABLE KEYS */;
INSERT INTO `userol` VALUES (100,1,'2023-05-26','2024-05-26'),(200,2,'2023-05-26','2024-05-26'),(300,3,'2023-05-26','2024-05-26');
/*!40000 ALTER TABLE `userol` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-26 15:51:52
