-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema patientenverwaltung
-- -----------------------------------------------------
-- 
-- 

-- -----------------------------------------------------
-- Schema patientenverwaltung
--
-- 
-- 
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `patientenverwaltung` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
USE `patientenverwaltung` ;

-- -----------------------------------------------------
-- Table `patientenverwaltung`.`Sozialversicherung`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `patientenverwaltung`.`Sozialversicherung` (
  `sozID` INT NOT NULL AUTO_INCREMENT,
  `sozname` VARCHAR(45) NULL,
  PRIMARY KEY (`sozID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `patientenverwaltung`.`Arztpraxis`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `patientenverwaltung`.`Arztpraxis` (
  `idArztpraxis` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`idArztpraxis`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `patientenverwaltung`.`Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `patientenverwaltung`.`Patient` (
  `idPatient` INT NOT NULL AUTO_INCREMENT,
  `vorname` VARCHAR(45) NULL,
  `nachname` VARCHAR(45) NULL,
  `geburtstag` DATE NULL,
  `Sozialversicherung_sozID` INT NOT NULL,
  `Arztpraxis_idArztpraxis` INT NOT NULL,
  `svnr` VARCHAR(45) NULL,
  PRIMARY KEY (`idPatient`, `Sozialversicherung_sozID`),
  INDEX `fk_Patient_Sozialversicherung1_idx` (`Sozialversicherung_sozID` ASC) ,
  INDEX `fk_Patient_Arztpraxis1_idx` (`Arztpraxis_idArztpraxis` ASC) ,
  CONSTRAINT `fk_Patient_Sozialversicherung1`
    FOREIGN KEY (`Sozialversicherung_sozID`)
    REFERENCES `patientenverwaltung`.`Sozialversicherung` (`sozID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Patient_Arztpraxis1`
    FOREIGN KEY (`Arztpraxis_idArztpraxis`)
    REFERENCES `patientenverwaltung`.`Arztpraxis` (`idArztpraxis`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `patientenverwaltung`.`Termin`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `patientenverwaltung`.`Termin` (
  `terID` INT NOT NULL AUTO_INCREMENT,
  `datum` DATETIME NULL,
  PRIMARY KEY (`terID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `patientenverwaltung`.`Befund`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `patientenverwaltung`.`Befund` (
  `befID` INT NOT NULL AUTO_INCREMENT,
  `beschreibung` VARCHAR(145) NULL,
  `Termin_terID` INT NOT NULL,
  `Patient_id` INT NOT NULL,
  PRIMARY KEY (`befID`, `Termin_terID`, `Patient_id`),
  INDEX `fk_Befund_Termin1_idx` (`Termin_terID` ASC) ,
  INDEX `fk_Befund_Patient1_idx` (`Patient_id` ASC) ,
  CONSTRAINT `fk_Befund_Termin1`
    FOREIGN KEY (`Termin_terID`)
    REFERENCES `patientenverwaltung`.`Termin` (`terID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Befund_Patient1`
    FOREIGN KEY (`Patient_id`)
    REFERENCES `patientenverwaltung`.`Patient` (`idPatient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `patientenverwaltung`.`Medikament`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `patientenverwaltung`.`Medikament` (
  `medID` INT NOT NULL AUTO_INCREMENT,
  `medname` VARCHAR(45) NULL,
  PRIMARY KEY (`medID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `patientenverwaltung`.`Befund_has_Medikament`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `patientenverwaltung`.`Befund_has_Medikament` (
  `Befund_befID` INT NOT NULL,
  `Medikament_medID` INT NOT NULL,
  `dosierung` VARCHAR(45) NULL,
  PRIMARY KEY (`Befund_befID`, `Medikament_medID`),
  INDEX `fk_Befund_has_Medikament_Medikament1_idx` (`Medikament_medID` ASC) ,
  CONSTRAINT `fk_Befund_has_Medikament_Befund`
    FOREIGN KEY (`Befund_befID`)
    REFERENCES `patientenverwaltung`.`Befund` (`befID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Befund_has_Medikament_Medikament1`
    FOREIGN KEY (`Medikament_medID`)
    REFERENCES `patientenverwaltung`.`Medikament` (`medID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
