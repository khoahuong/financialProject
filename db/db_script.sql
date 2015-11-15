-- MySQL Script generated by MySQL Workbench
-- lun 09 nov 2015 15:53:44 HKT
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema financial
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `financial` ;

-- -----------------------------------------------------
-- Schema financial
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `financial` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `financial` ;

-- -----------------------------------------------------
-- Table `financial`.`customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `financial`.`customer` ;

CREATE TABLE IF NOT EXISTS `financial`.`customer` (
  `customer_id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `user_name` VARCHAR(45) NULL COMMENT '',
  `email` VARCHAR(45) NULL COMMENT '',
  `password` VARCHAR(45) NULL COMMENT '',
  `gender` VARCHAR(8) NULL COMMENT '',
  `address` VARCHAR(45) NULL COMMENT '',
  `city` VARCHAR(45) NULL COMMENT '',
  `phone_num` VARCHAR(45) NULL COMMENT '',
  `ID_number` VARCHAR(45) NULL COMMENT '',
  `register_date` DATETIME NULL COMMENT '',
  `flag` ENUM('active', 'created', 'suspended', 'deleted') NULL COMMENT '',
  PRIMARY KEY (`customer_id`)  COMMENT '',
  UNIQUE INDEX `user_id_UNIQUE` (`customer_id` ASC)  COMMENT '',
  UNIQUE INDEX `user_name_UNIQUE` (`user_name` ASC)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `financial`.`branch`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `financial`.`branch` ;

CREATE TABLE IF NOT EXISTS `financial`.`branch` (
  `branch_id` INT NOT NULL COMMENT '',
  `latitude` DOUBLE NULL COMMENT '',
  `longitude` DOUBLE NULL COMMENT '',
  `address` VARCHAR(45) NULL COMMENT '',
  `city` VARCHAR(45) NULL COMMENT '',
  `phone` VARCHAR(45) NULL COMMENT '',
  PRIMARY KEY (`branch_id`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `financial`.`account_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `financial`.`account_type` ;

CREATE TABLE IF NOT EXISTS `financial`.`account_type` (
  `id_type` INT NOT NULL COMMENT '',
  `type_name` VARCHAR(45) NULL COMMENT '',
  `description` VARCHAR(45) NULL COMMENT '',
  PRIMARY KEY (`id_type`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `financial`.`account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `financial`.`account` ;

CREATE TABLE IF NOT EXISTS `financial`.`account` (
  `account_number` INT NOT NULL COMMENT '',
  `branch_id` INT NULL COMMENT '',
  `customer_id` INT NULL COMMENT '',
  `account_type` INT NULL COMMENT '',
  `currency` VARCHAR(45) NULL COMMENT '',
  `balance` DOUBLE NULL COMMENT '',
  `activation_date` DATETIME NULL COMMENT '',
  `flag` ENUM('active', 'created', 'suspended', 'deleted') NULL COMMENT '',
  `rate` DOUBLE NULL COMMENT '',
  PRIMARY KEY (`account_number`)  COMMENT '',
  INDEX `fk_account_1_idx` (`branch_id` ASC)  COMMENT '',
  INDEX `fk_account_2_idx` (`customer_id` ASC)  COMMENT '',
  INDEX `fk_account_3_idx` (`account_type` ASC)  COMMENT '',
  CONSTRAINT `fk_account_1`
    FOREIGN KEY (`branch_id`)
    REFERENCES `financial`.`branch` (`branch_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_account_2`
    FOREIGN KEY (`customer_id`)
    REFERENCES `financial`.`customer` (`customer_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_account_3`
    FOREIGN KEY (`account_type`)
    REFERENCES `financial`.`account_type` (`id_type`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `financial`.`card`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `financial`.`card` ;

CREATE TABLE IF NOT EXISTS `financial`.`card` (
  `card_number` VARCHAR(12) NOT NULL COMMENT '',
  `card_circuit` ENUM('visa', 'mastercard') NULL COMMENT '',
  `card_type` ENUM('debit', 'credit') NULL COMMENT '',
  `account_id` INT NULL COMMENT '',
  `issue_date` DATE NULL COMMENT '',
  `expire_date` DATE NULL COMMENT '',
  `crc` INT(8) NULL COMMENT '',
  `account_number` INT NULL COMMENT '',
  `flag` ENUM('active', 'created', 'suspended', 'deleted') NULL COMMENT '',
  PRIMARY KEY (`card_number`)  COMMENT '',
  INDEX `fk_card_1_idx` (`account_id` ASC)  COMMENT '',
  CONSTRAINT `fk_card_1`
    FOREIGN KEY (`account_id`)
    REFERENCES `financial`.`account` (`account_number`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `financial`.`transaction_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `financial`.`transaction_type` ;

CREATE TABLE IF NOT EXISTS `financial`.`transaction_type` (
  `transaction_type` INT NOT NULL COMMENT '',
  `name` VARCHAR(45) NULL COMMENT '',
  `description` VARCHAR(45) NULL COMMENT '',
  PRIMARY KEY (`transaction_type`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `financial`.`transaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `financial`.`transaction` ;

CREATE TABLE IF NOT EXISTS `financial`.`transaction` (
  `operation_time_date` DATETIME NOT NULL COMMENT '',
  `account_id` INT NOT NULL COMMENT '',
  `transaction_amount` DOUBLE NULL COMMENT '',
  `flag` ENUM('active', 'executed', 'aborted', 'suspended') NULL COMMENT '',
  `dest_account_id` INT NULL COMMENT '',
  `transaction_type` INT NULL COMMENT '',
  `ip_address` VARCHAR(45) NULL COMMENT '',
  PRIMARY KEY (`operation_time_date`, `account_id`)  COMMENT '',
  INDEX `fk_transaction_1_idx` (`account_id` ASC)  COMMENT '',
  INDEX `fk_transaction_2_idx` (`transaction_type` ASC)  COMMENT '',
  CONSTRAINT `fk_transaction_1`
    FOREIGN KEY (`account_id`)
    REFERENCES `financial`.`account` (`account_number`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_transaction_2`
    FOREIGN KEY (`transaction_type`)
    REFERENCES `financial`.`transaction_type` (`transaction_type`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_transaction_3`
    FOREIGN KEY (`account_id`)
    REFERENCES `financial`.`account` (`account_number`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `financial`.`atm`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `financial`.`atm` ;

CREATE TABLE IF NOT EXISTS `financial`.`atm` (
  `id_atm` INT NOT NULL COMMENT '',
  `longitude` DOUBLE NULL COMMENT '',
  `latitude` DOUBLE NULL COMMENT '',
  `address` VARCHAR(45) NULL COMMENT '',
  `state` ENUM('working', 'not available', 'busy') NULL COMMENT '',
  `id_branch` INT NOT NULL COMMENT '',
  PRIMARY KEY (`id_atm`)  COMMENT '',
  INDEX `fk_atm_1_idx` (`id_branch` ASC)  COMMENT '',
  CONSTRAINT `fk_atm_1`
    FOREIGN KEY (`id_branch`)
    REFERENCES `financial`.`branch` (`branch_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `financial`.`matrix`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `financial`.`matrix` ;

CREATE TABLE IF NOT EXISTS `financial`.`matrix` (
  `customer_id` INT NOT NULL COMMENT '',
  `a11` VARCHAR(45) NULL COMMENT '',
  `a12` VARCHAR(45) NULL COMMENT '',
  `a13` VARCHAR(45) NULL COMMENT '',
  `a21` VARCHAR(45) NULL COMMENT '',
  `a22` VARCHAR(45) NULL COMMENT '',
  `a23` VARCHAR(45) NULL COMMENT '',
  `a31` VARCHAR(45) NULL COMMENT '',
  `a32` VARCHAR(45) NULL COMMENT '',
  `a33` VARCHAR(45) NULL COMMENT '',
  PRIMARY KEY (`customer_id`)  COMMENT '',
  CONSTRAINT `fk_matrix_1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `financial`.`customer` (`customer_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `financial`.`session`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `financial`.`session` ;

CREATE TABLE IF NOT EXISTS `financial`.`session` (
  `id_user` INT NOT NULL COMMENT '',
  `session_name` VARCHAR(45) NULL COMMENT '',
  `session_id` VARCHAR(45) NULL COMMENT '',
  `flag` ENUM('active', 'expired') NULL COMMENT '',
  PRIMARY KEY (`id_user`)  COMMENT '',
  CONSTRAINT `fk_session_1`
    FOREIGN KEY (`id_user`)
    REFERENCES `financial`.`customer` (`customer_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
