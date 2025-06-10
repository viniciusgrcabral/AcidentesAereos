-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: mydb
-- ------------------------------------------------------
-- Server version	8.0.33

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
-- Table structure for table `acidente`
--
DROP schema IF EXISTS MD_DADOS;
CREATE schema IF NOT EXISTS MD_dados;
use MD_dados;

DROP TABLE IF EXISTS `acidente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `acidente` (
  `NumeroOcorrencia` int NOT NULL,
  `NumeroDaFicha` varchar(100) default null,
  `Operador` varchar(100) DEFAULT NULL,
  `Classificacao` varchar(45) DEFAULT NULL,
  `TipoOcorrencia` varchar(45) DEFAULT NULL,
  `DataOcorrencia` DATETIME DEFAULT NULL,
  `HoraOcorrencia` time DEFAULT NULL,
  `Historico` varchar(3500) DEFAULT NULL,
  `TipoOperacao` varchar(150) DEFAULT NULL,
  `FaseOperacao` varchar(150) DEFAULT NULL,
  `PSSO` tinyint DEFAULT NULL,
  `Descricao` varchar(255) DEFAULT NULL,
  `Aeronave_Matricula` varchar(100) NOT NULL,
  `Localidade_ID` int NOT NULL,
  `IDAerodromo` int DEFAULT NULL,
  `id_consequencia` int default NULL,
  PRIMARY KEY (`NumeroOcorrencia`),
  KEY `fk_Ocorrência_Aeronave1_idx` (`Aeronave_Matricula`),
  KEY `fk_Ocorrência_Localidade1_idx` (`Localidade_ID`),
  KEY `fk_Acidente_Aerodromo` (`IDAerodromo`),
  CONSTRAINT `fk_Acidente_Aerodromo` FOREIGN KEY (`IDAerodromo`) REFERENCES `aerodromo` (`IDAerodromo`),
  CONSTRAINT `fk_Ocorrência_Aeronave1` FOREIGN KEY (`Aeronave_Matricula`) REFERENCES `aeronave` (`Matricula`),
  CONSTRAINT `fk_Ocorrência_Localidade1` FOREIGN KEY (`Localidade_ID`) REFERENCES `localidade` (`Localidade_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acidente`
--



--
-- Table structure for table `aerodromo`
--

DROP TABLE IF EXISTS `aerodromo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aerodromo` (
  `IDAerodromo` int NOT NULL AUTO_INCREMENT,
  `ICAO` varchar(255) DEFAULT NULL,
  `TipoAerodromo` varchar(100) DEFAULT NULL,
  `AerodromoOrigem` varchar(45) DEFAULT NULL,
  `AerodromoDestino` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`IDAerodromo`)
) ENGINE=InnoDB AUTO_INCREMENT=1618 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aerodromo`
--


--
-- Table structure for table `aeronave`
--

DROP TABLE IF EXISTS `aeronave`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aeronave` (
  `Matricula` varchar(100) NOT NULL,
  `TipoOperacao` varchar(150) NOT NULL,
  `Modelo` varchar(100) DEFAULT NULL,
  `Categoria` varchar(100) DEFAULT NULL,
  `Cls` varchar(45) DEFAULT NULL,
  `Fabricante` varchar(100) DEFAULT NULL,
  `TipoICAO` varchar(45) DEFAULT NULL,
  `PMD` int DEFAULT NULL,
  `Assentos` int DEFAULT NULL,
  PRIMARY KEY (`Matricula`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aeronave`
--



--
-- Table structure for table `consequênciasdoacidente`
--

DROP TABLE IF EXISTS `consequenciasdoacidente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consequenciasdoacidente` (
  `id_consequencia` int NOT NULL auto_increment,
  `LesoesFataisTripulantes` int DEFAULT NULL,
  `LesoesFataisPassageiros` int DEFAULT NULL,
  `LesoesFataisTerceiros` int DEFAULT NULL,
  `LesoesGravesTripulantes` int DEFAULT NULL,
  `LesoesGravesPassageiros` int DEFAULT NULL,
  `LesoesGravesTerceiros` int DEFAULT NULL,
  `LesoesLevesTripulantes` int DEFAULT NULL,
  `LesoesLevesPassageiros` int DEFAULT NULL,
  `LesoesLevesTerceiros` int DEFAULT NULL,
  `LesoesDesconhecidasTripulantes` int DEFAULT NULL,
  `LesoesDesconhecidasPassageiros` int DEFAULT NULL,
  `LesoesDesconhecidasTerceiros` int DEFAULT NULL,
  `IlesosTripulantes` int DEFAULT NULL,
  `IlesosPassageiros` int DEFAULT NULL,
  `DanosAeronave` varchar(255) DEFAULT NULL,
  `Acidente_NumeroOcorrencia` int NOT NULL,
  PRIMARY KEY (`id_consequencia`),
  CONSTRAINT `fk_ConsequenciasDoAcidente_Acidente1` FOREIGN KEY (`Acidente_NumeroOcorrencia`) REFERENCES `acidente` (`NumeroOcorrencia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consequênciasdoacidente`
--



--
-- Table structure for table `localidade`
--

DROP TABLE IF EXISTS `localidade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `localidade` (
  `Localidade_ID` int NOT NULL AUTO_INCREMENT,
  `UF` varchar(45) NOT NULL,
  `Regiao` varchar(45) DEFAULT NULL,
  `Municipio` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Localidade_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `localidade`
--



--
-- Table structure for table `staging_ocorrencias`
--



-- Dump completed on 2025-05-15 20:33:10
