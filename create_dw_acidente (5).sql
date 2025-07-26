-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema md_dados_dw
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema md_dados_dw
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `md_dados_dw` DEFAULT CHARACTER SET latin1 ;
USE `md_dados_dw` ;

-- -----------------------------------------------------
-- Table `md_dados_dw`.`dimAerodromo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `md_dados_dw`.`dimAerodromo` (
  `idAerodromo` INT(11) NOT NULL AUTO_INCREMENT,
  `icao` VARCHAR(255) NULL DEFAULT NULL,
  `tipoAerodromo` VARCHAR(100) NULL DEFAULT NULL,
  `version` INT NULL,
  `date_to` TIMESTAMP NULL,
  `date_from` TIMESTAMP NULL,
  PRIMARY KEY (`idAerodromo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `md_dados_dw`.`dimAeronave`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `md_dados_dw`.`dimAeronave` (
  `matricula` VARCHAR(100) NULL,
  `modelo` VARCHAR(100) NULL DEFAULT NULL,
  `categoria` VARCHAR(100) NULL DEFAULT NULL,
  `cls` VARCHAR(45) NULL DEFAULT NULL,
  `fabricante` VARCHAR(100) NULL DEFAULT NULL,
  `tipoIcao` VARCHAR(45) NULL DEFAULT NULL,
  `pmd` INT(11) NULL DEFAULT NULL,
  `assentos` INT(11) NULL DEFAULT NULL,
  `idAeronave` INT NOT NULL,
  `version` INT NULL,
  `date_from` TIMESTAMP NULL,
  `date_to` TIMESTAMP NULL,
  PRIMARY KEY (`idAeronave`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `md_dados_dw`.`dimClassificacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `md_dados_dw`.`dimClassificacao` (
  `idClassificacao` INT(11) NOT NULL AUTO_INCREMENT,
  `classificacao` VARCHAR(45) NULL,
  `descricao` TEXT NULL DEFAULT NULL,
  `version` INT NULL,
  `date_to` TIMESTAMP NULL,
  `date_from` TIMESTAMP NULL,
  PRIMARY KEY (`idClassificacao`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `md_dados_dw`.`dimData`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `md_dados_dw`.`dimData` (
  `idData` INT(11) NOT NULL AUTO_INCREMENT,
  `dataCompleta` TIMESTAMP NOT NULL,
  `ano` INT(11) NULL DEFAULT NULL,
  `trimestre` INT(11) NULL DEFAULT NULL,
  `mes` INT(11) NULL DEFAULT NULL,
  `dia` INT(11) NULL DEFAULT NULL,
  `diaSemana` INT(11) NULL DEFAULT NULL,
  `hora` VARCHAR(45) NULL,
  `nomeDiaSemana` VARCHAR(15) NULL DEFAULT NULL,
  `nomeMes` VARCHAR(15) NULL DEFAULT NULL,
  `diaUtil` TINYINT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`idData`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `md_dados_dw`.`dimLocalidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `md_dados_dw`.`dimLocalidade` (
  `localidadeId` INT(11) NOT NULL AUTO_INCREMENT,
  `uf` VARCHAR(45) NULL,
  `regiao` VARCHAR(45) NULL DEFAULT NULL,
  `municipio` VARCHAR(100) NULL DEFAULT NULL,
  `version` INT NULL,
  `date_to` TIMESTAMP NULL,
  `date_from` TIMESTAMP NULL,
  PRIMARY KEY (`localidadeId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `md_dados_dw`.`dimOperador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `md_dados_dw`.`dimOperador` (
  `idOperador` INT(11) NOT NULL AUTO_INCREMENT,
  `nomeOperador` VARCHAR(100) NULL,
  `version` INT NULL,
  `date_from` TIMESTAMP NULL,
  `date_to` TIMESTAMP NULL,
  PRIMARY KEY (`idOperador`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `md_dados_dw`.`dimTipoOcorrencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `md_dados_dw`.`dimTipoOcorrencia` (
  `idTipoOcorrencia` INT(11) NOT NULL AUTO_INCREMENT,
  `tipoOcorrencia` VARCHAR(45) NULL,
  `descricao` TEXT NULL DEFAULT NULL,
  `version` INT NULL,
  `date_from` TIMESTAMP NULL,
  `date_to` TIMESTAMP NULL,
  PRIMARY KEY (`idTipoOcorrencia`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `md_dados_dw`.`dimTipoOperacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `md_dados_dw`.`dimTipoOperacao` (
  `idTipoOperacao` INT(11) NOT NULL AUTO_INCREMENT,
  `tipoOperacao` VARCHAR(150) NULL,
  `version` INT NULL,
  `date_to` TIMESTAMP NULL,
  `date_from` TIMESTAMP NULL,
  PRIMARY KEY (`idTipoOperacao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `md_dados_dw`.`dimFaseOperacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `md_dados_dw`.`dimFaseOperacao` (
  `idFaseOperacao` INT NOT NULL AUTO_INCREMENT,
  `faseOperacao` VARCHAR(150) NULL,
  `version` INT NULL,
  `date_to` TIMESTAMP NULL,
  `date_from` TIMESTAMP NULL,
  PRIMARY KEY (`idFaseOperacao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `md_dados_dw`.`dimHistorico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `md_dados_dw`.`dimHistorico` (
  `idHistorico` INT NOT NULL,
  `historico` VARCHAR(3500) NULL,
  `version` INT NULL,
  `date_from` TIMESTAMP NULL,
  `date_to` TIMESTAMP NULL,
  PRIMARY KEY (`idHistorico`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `md_dados_dw`.`dimDanosAeronave`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `md_dados_dw`.`dimDanosAeronave` (
  `idDanoAeronave` INT NOT NULL,
  `danosAeronave` VARCHAR(255) NULL,
  `version` INT NULL,
  `date_to` TIMESTAMP NULL,
  `date_from` TIMESTAMP NULL,
  PRIMARY KEY (`idDanoAeronave`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `md_dados_dw`.`fatoOcorrencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `md_dados_dw`.`fatoOcorrencia` (
  `idOperador` INT(11) NOT NULL,
  `idClassificacao` INT(11) NOT NULL,
  `idTipoOcorrencia` INT(11) NOT NULL,
  `idData` INT(11) NOT NULL,
  `idAeronave` INT NOT NULL,
  `localidade_ID` INT(11) NOT NULL,
  `idTipoOperacao` INT(11) NOT NULL,
  `idFaseOperacao` INT NOT NULL,
  `idAerodromo` INT(11) NOT NULL,
  `psso` TINYINT(4) NULL DEFAULT NULL,
  `lesoesFataisTripulantes` INT(11) NULL DEFAULT NULL,
  `lesoesFataisPassageiros` INT(11) NULL DEFAULT NULL,
  `lesoesFataisTerceiros` INT(11) NULL DEFAULT NULL,
  `lesoesGravesTripulantes` INT(11) NULL DEFAULT NULL,
  `lesoesGravesPassageiros` INT(11) NULL DEFAULT NULL,
  `lesoesGravesTerceiros` INT(11) NULL DEFAULT NULL,
  `lesoesLevesTripulantes` INT(11) NULL DEFAULT NULL,
  `lesoesLevesPassageiros` INT(11) NULL DEFAULT NULL,
  `lesoesLevesTerceiros` INT(11) NULL DEFAULT NULL,
  `ilesosTripulantes` INT(11) NULL DEFAULT NULL,
  `ilesosPassageiros` INT(11) NULL DEFAULT NULL,
  `totalLesaoDesconhecidas` INT NULL,
  `idHistorico` INT NOT NULL,
  `idDanoAeronave` INT NOT NULL,
  PRIMARY KEY (`idOperador`, `idClassificacao`, `idTipoOcorrencia`, `idData`, `idAeronave`, `localidade_ID`, `idTipoOperacao`, `idFaseOperacao`, `idAerodromo`, `idHistorico`, `idDanoAeronave`),
  INDEX `fk_fato_operador` (`idOperador` ASC) VISIBLE,
  INDEX `fk_fato_classificacao` (`idClassificacao` ASC) VISIBLE,
  INDEX `fk_fato_tipoOcorrencia` (`idTipoOcorrencia` ASC) VISIBLE,
  INDEX `fk_fato_data` (`idData` ASC) VISIBLE,
  INDEX `fk_fato_localidade` (`localidade_ID` ASC) VISIBLE,
  INDEX `fk_fato_aerodromo` (`idAerodromo` ASC) VISIBLE,
  INDEX `fk_fato_tipoOperacao` (`idTipoOperacao` ASC) VISIBLE,
  INDEX `fk_fato_faseOperacao` (`idFaseOperacao` ASC) VISIBLE,
  INDEX `fk_fato_historioc_idx` (`idHistorico` ASC) VISIBLE,
  INDEX `fk_fato_aeronave_idx` (`idAeronave` ASC) VISIBLE,
  INDEX `fk_fato_dano_aeronave_idx` (`idDanoAeronave` ASC) VISIBLE,
  CONSTRAINT `fk_fato_aerodromo`
    FOREIGN KEY (`idAerodromo`)
    REFERENCES `md_dados_dw`.`dimAerodromo` (`idAerodromo`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_fato_aeronave`
    FOREIGN KEY (`idAeronave`)
    REFERENCES `md_dados_dw`.`dimAeronave` (`idAeronave`),
  CONSTRAINT `fk_fato_classificacao`
    FOREIGN KEY (`idClassificacao`)
    REFERENCES `md_dados_dw`.`dimClassificacao` (`idClassificacao`),
  CONSTRAINT `fk_fato_data`
    FOREIGN KEY (`idData`)
    REFERENCES `md_dados_dw`.`dimData` (`idData`),
  CONSTRAINT `fk_fato_localidade`
    FOREIGN KEY (`localidade_ID`)
    REFERENCES `md_dados_dw`.`dimLocalidade` (`localidadeId`),
  CONSTRAINT `fk_fato_operador`
    FOREIGN KEY (`idOperador`)
    REFERENCES `md_dados_dw`.`dimOperador` (`idOperador`),
  CONSTRAINT `fk_fato_tipoOcorrencia`
    FOREIGN KEY (`idTipoOcorrencia`)
    REFERENCES `md_dados_dw`.`dimTipoOcorrencia` (`idTipoOcorrencia`),
  CONSTRAINT `fk_fatoOcorrencia_dimTipoOperacao1`
    FOREIGN KEY (`idTipoOperacao`)
    REFERENCES `md_dados_dw`.`dimTipoOperacao` (`idTipoOperacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fatoOcorrencia_dimFaseOperacao1`
    FOREIGN KEY (`idFaseOperacao`)
    REFERENCES `md_dados_dw`.`dimFaseOperacao` (`idFaseOperacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fato_historico`
    FOREIGN KEY (`idHistorico`)
    REFERENCES `md_dados_dw`.`dimHistorico` (`idHistorico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fato_dano_aeronave`
    FOREIGN KEY (`idDanoAeronave`)
    REFERENCES `md_dados_dw`.`dimDanosAeronave` (`idDanoAeronave`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
