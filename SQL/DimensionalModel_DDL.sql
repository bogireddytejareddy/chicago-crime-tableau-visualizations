-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE DATABASE `chicagocrime` ;
USE `chicagocrime` ;


CREATE TABLE IF NOT EXISTS `chicagocrime`.`sub_dim_socio_economic` (
  `socio_economic_id` INT NOT NULL,
  `teen_population_percent` DOUBLE NOT NULL,
  `middle_age_population_percent` DOUBLE NOT NULL,
  `old_age_population_percent` DOUBLE NOT NULL,
  `no_health_insurance_index` DOUBLE NOT NULL,
  `neighbourhood_safety_index` DOUBLE NOT NULL,
  `household_poverty_index` DOUBLE NOT NULL,
  `college_grad_index` DOUBLE NOT NULL,
  `no_high_school_grad_index` DOUBLE NOT NULL,
  `single_parent_index` DOUBLE NOT NULL,
  `unemployment_index` DOUBLE NOT NULL,
  `alcohol_death_index` DOUBLE NOT NULL,
  `drug_death_index` DOUBLE NOT NULL,
  `health_quality_index` DOUBLE NOT NULL,
  `transportation_index` DOUBLE NOT NULL,
  `housing_burden_index` DOUBLE NOT NULL,
  `area_id` INT NOT NULL,
  PRIMARY KEY (`socio_economic_id`),
  CONSTRAINT `fk_sub_dim_socio_economic_dim_area`
    FOREIGN KEY (`area_id`)
    REFERENCES `chicagocrime`.`dim_area` (`area_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_sub_dim_socio_economic_dim_area_idx` ON `chicagocrime`.`sub_dim_socio_economic` (`area_id` ASC);



CREATE TABLE IF NOT EXISTS `chicagocrime`.`dim_area` (
  `area_id` INT NOT NULL,
  `area_name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`area_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4 ;



-- -----------------------------------------------------
-- Table `chicagocrime`.`dim_crime`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `chicagocrime`.`dim_crime` (
  `crime_id` INT NOT NULL,
  `crime_name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`crime_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4 ;


-- -----------------------------------------------------
-- Table `chicagocrime`.`dim_date`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `chicagocrime`.`dim_date` (
  `date_id` INT NOT NULL,
  `date` DATE NOT NULL,
  `weekend` VARCHAR(45) NOT NULL,
  `day_of_week` VARCHAR(45) NOT NULL,
  `month` VARCHAR(45) NOT NULL,
  `month_day` VARCHAR(45) NOT NULL,
  `year` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`date_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4 ;


-- -----------------------------------------------------
-- Table `chicagocrime`.`dim_location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `chicagocrime`.`dim_location` (
  `location_id` INT NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`location_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4 ;


-- -----------------------------------------------------
-- Table `chicagocrime`.`dim_time`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `chicagocrime`.`dim_time` (
  `time_id` INT NOT NULL,
  `time_of_day` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`time_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4 ;


-- -----------------------------------------------------
-- Table `chicagocrime`.`fact_cases`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `chicagocrime`.`fact_cases` (
  `case_number` INT NOT NULL,
  `domestic` VARCHAR(8) NULL DEFAULT NULL,
  `latitude` VARCHAR(45) NULL DEFAULT NULL,
  `longitude` VARCHAR(45) NULL DEFAULT NULL,
  `arrest` VARCHAR(8) NULL DEFAULT NULL,
  `area_id` INT NOT NULL,
  `crime_id` INT NOT NULL,
  `time_id` INT NOT NULL,
  `date_id` INT NOT NULL,
  `location_id` INT NOT NULL,
  PRIMARY KEY (`case_number`),
  CONSTRAINT `fk_fact_cases_dim_area1`
    FOREIGN KEY (`area_id`)
    REFERENCES `chicagocrime`.`dim_area` (`area_id`),
  CONSTRAINT `fk_fact_cases_dim_crime1`
    FOREIGN KEY (`crime_id`)
    REFERENCES `chicagocrime`.`dim_crime` (`crime_id`),
  CONSTRAINT `fk_fact_cases_dim_date1`
    FOREIGN KEY (`date_id`)
    REFERENCES `chicagocrime`.`dim_date` (`date_id`),
  CONSTRAINT `fk_fact_cases_dim_location1`
    FOREIGN KEY (`location_id`)
    REFERENCES `chicagocrime`.`dim_location` (`location_id`),
  CONSTRAINT `fk_fact_cases_dim_time1`
    FOREIGN KEY (`time_id`)
    REFERENCES `chicagocrime`.`dim_time` (`time_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4 ;

CREATE INDEX `fk_fact_cases_dim_area1_idx` ON `chicagocrime`.`fact_cases` (`area_id` ASC) ;

CREATE INDEX `fk_fact_cases_dim_crime1_idx` ON `chicagocrime`.`fact_cases` (`crime_id` ASC) ;

CREATE INDEX `fk_fact_cases_dim_time1_idx` ON `chicagocrime`.`fact_cases` (`time_id` ASC) ;

CREATE INDEX `fk_fact_cases_dim_date1_idx` ON `chicagocrime`.`fact_cases` (`date_id` ASC) ;

CREATE INDEX `fk_fact_cases_dim_location1_idx` ON `chicagocrime`.`fact_cases` (`location_id` ASC) ;
