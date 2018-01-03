-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Worker`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Worker` (
  `SSN` INT NOT NULL,
  `First_n` TINYTEXT NOT NULL,
  `Second_n` TINYTEXT NOT NULL,
  `Salary` INT NOT NULL,
  `Receptionist_SSN` INT NULL,
  `Manager_SSN` INT NULL,
  `Receptionist_Manager_SSN` INT NULL,
  PRIMARY KEY (`SSN`)
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`User` (
  `login` VARCHAR(45) NOT NULL,
  `password`  TINYTEXT NULL,
  `remember_token`  TINYTEXT NOT NULL,
  `Worker_Manager_SSN` INT NULL,
  `Worker_Receptionist_SSN` INT NULL,
  `Client_national_id` INT NULL,
  PRIMARY KEY (`login`)
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Client` (
  `national_id` INT NOT NULL,
  `first_n` TINYTEXT NOT NULL,
  `last_n` TINYTEXT NOT NULL,
  PRIMARY KEY (`national_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Room`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Room` (
  `number` INT NOT NULL,
  `price` INT NOT NULL,
  `num_of_beds` INT NOT NULL,
  PRIMARY KEY (`number`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Reservations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Reservations` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(45) NOT NULL,
  `Worker_Manager_SSN` INT NOT NULL,
  `Room_number` INT NOT NULL,
  `Client_national_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Reservations_Room1_idx` (`Room_number` ASC),
  INDEX `fk_Reservations_Client1_idx` (`Client_national_id` ASC)
    )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Applications`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Applications` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `from_d` DATE NOT NULL,
  `to_d` DATE NOT NULL,
  `price` INT NOT NULL,
  `num_of_beds` INT NOT NULL,
  `Worker_Manager_SSN` INT NULL,
  `Worker_Receptionist_SSN` INT NOT NULL,
  `Client_national_id` INT NOT NULL,
  `Reservations_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Applications_Client1_idx` (`Client_national_id` ASC),
  INDEX `fk_Applications_Reservations1_idx` (`Reservations_id` ASC)
    )
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
