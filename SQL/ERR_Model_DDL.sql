-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


CREATE DATABASE `ermodel_chicagocrime` ;
USE `ermodel_chicagocrime` ;

-- -----------------------------------------------------
-- Table `ermodel_chicagocrime`.`crime`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ermodel_chicagocrime`.`crime` (
  `crime_id` INT NOT NULL,
  `crime_name` VARCHAR(45) NULL,
  PRIMARY KEY (`crime_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ermodel_chicagocrime`.`area`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ermodel_chicagocrime`.`area` (
  `area_id` INT NOT NULL,
  `area_name` VARCHAR(45) NULL,
  PRIMARY KEY (`area_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ermodel_chicagocrime`.`location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ermodel_chicagocrime`.`location` (
  `location_id` INT NOT NULL,
  `location_name` VARCHAR(45) NULL,
  PRIMARY KEY (`location_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ermodel_chicagocrime`.`case`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ermodel_chicagocrime`.`case` (
  `case_id` INT NOT NULL,
  `crime_id` INT NOT NULL,
  `area_id` INT NOT NULL,
  `location_id` INT NOT NULL,
  `date` DATE NULL,
  `arrest` BINARY(8) NULL,
  `domestic` BINARY(8) NULL,
  `latitude` DOUBLE NULL,
  `longitude` DOUBLE NULL,
  PRIMARY KEY (`case_id`),
  CONSTRAINT `fk_case_crime1`
    FOREIGN KEY (`crime_id`)
    REFERENCES `ermodel_chicagocrime`.`crime` (`crime_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_case_area1`
    FOREIGN KEY (`area_id`)
    REFERENCES `ermodel_chicagocrime`.`area` (`area_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_case_location1`
    FOREIGN KEY (`location_id`)
    REFERENCES `ermodel_chicagocrime`.`location` (`location_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_case_crime1_idx` ON `ermodel_chicagocrime`.`case` (`crime_id` ASC) VISIBLE;

CREATE INDEX `fk_case_area1_idx` ON `ermodel_chicagocrime`.`case` (`area_id` ASC) VISIBLE;

CREATE INDEX `fk_case_location1_idx` ON `ermodel_chicagocrime`.`case` (`location_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `ermodel_chicagocrime`.`socio_economic`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ermodel_chicagocrime`.`socio_economic` (
  `socio_economic_id` INT NOT NULL,
  `area_id` INT NOT NULL,
  `teen_population_percent` VARCHAR(45) NULL,
  `middle_age_population_percent` VARCHAR(45) NULL,
  `old_age_population_percent` VARCHAR(45) NULL,
  `no_health_insurance_index` VARCHAR(45) NULL,
  `neighbourhood_safety_index` VARCHAR(45) NOT NULL,
  `household_poverty_index` VARCHAR(45) NULL,
  `college_grad_index` VARCHAR(45) NULL,
  `no_high_school_grad_index` VARCHAR(45) NULL,
  `single_parent_index` VARCHAR(45) NULL,
  `unemployment_index` VARCHAR(45) NULL,
  `alcohol_death_index` VARCHAR(45) NULL,
  `drug_death_index` VARCHAR(45) NULL,
  `health_quality_index` VARCHAR(45) NULL,
  `transportation_index` VARCHAR(45) NULL,
  `housing_burden_index` VARCHAR(45) NULL,
  PRIMARY KEY (`socio_economic_id`),
  CONSTRAINT `fk_socio_economic_area`
    FOREIGN KEY (`area_id`)
    REFERENCES `ermodel_chicagocrime`.`area` (`area_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_socio_economic_area_idx` ON `ermodel_chicagocrime`.`socio_economic` (`area_id` ASC) VISIBLE;

