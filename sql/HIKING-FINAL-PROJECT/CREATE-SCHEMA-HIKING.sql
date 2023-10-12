-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema hiking
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema hiking
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hiking` DEFAULT CHARACTER SET utf8 ;
USE `hiking` ;

-- -----------------------------------------------------
-- Table `hiking`.`elevation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hiking`.`elevation` (
  `elevation_id` INT NOT NULL AUTO_INCREMENT,
  `elevation_feet` INT NOT NULL,
  PRIMARY KEY (`elevation_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `hiking`.`map`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hiking`.`map` (
  `map_id` INT NOT NULL AUTO_INCREMENT,
  `map_name` VARCHAR(45) NOT NULL,
  `map_image` BLOB NOT NULL,
  PRIMARY KEY (`map_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `hiking`.`location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hiking`.`location` (
  `location_id` INT NOT NULL AUTO_INCREMENT,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `zip` VARCHAR(45) NULL DEFAULT NULL,
  `map_map_id` INT NOT NULL,
  PRIMARY KEY (`location_id`),
  INDEX `fk_location_map1_idx` (`map_map_id` ASC) VISIBLE,
  CONSTRAINT `fk_location_map1`
    FOREIGN KEY (`map_map_id`)
    REFERENCES `hiking`.`map` (`map_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `hiking`.`parks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hiking`.`parks` (
  `park_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `map_map_id` INT NOT NULL,
  `location_location_id` INT NOT NULL,
  PRIMARY KEY (`park_id`),
  INDEX `fk_parks_map1_idx` (`map_map_id` ASC) VISIBLE,
  INDEX `fk_parks_location1_idx` (`location_location_id` ASC) VISIBLE,
  CONSTRAINT `fk_parks_map1`
    FOREIGN KEY (`map_map_id`)
    REFERENCES `hiking`.`map` (`map_id`),
  CONSTRAINT `fk_parks_location1`
    FOREIGN KEY (`location_location_id`)
    REFERENCES `hiking`.`location` (`location_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `hiking`.`terrain`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hiking`.`terrain` (
  `terrain_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `terrain_type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`terrain_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `hiking`.`trail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hiking`.`trail` (
  `trail_id` INT NOT NULL AUTO_INCREMENT,
  `trail_name` VARCHAR(45) NOT NULL,
  `distance_mile` DECIMAL(2,0) NOT NULL,
  `distance_kilo` DECIMAL(2,0) NOT NULL,
  `difficulty` VARCHAR(45) NOT NULL,
  `map_map_id` INT NOT NULL,
  `terrain_terrain_id` INT UNSIGNED NOT NULL,
  `elevation_elevation_id` INT NOT NULL,
  `parks_park_id` INT NOT NULL,
  `location_location_id` INT NOT NULL,
  PRIMARY KEY (`trail_id`),
  INDEX `fk_trail_map1_idx` (`map_map_id` ASC) VISIBLE,
  INDEX `fk_trail_terrain1_idx` (`terrain_terrain_id` ASC) VISIBLE,
  INDEX `fk_trail_elevation1_idx` (`elevation_elevation_id` ASC) VISIBLE,
  INDEX `fk_trail_parks1_idx` (`parks_park_id` ASC) VISIBLE,
  INDEX `fk_trail_location1_idx` (`location_location_id` ASC) VISIBLE,
  CONSTRAINT `fk_trail_elevation1`
    FOREIGN KEY (`elevation_elevation_id`)
    REFERENCES `hiking`.`elevation` (`elevation_id`),
  CONSTRAINT `fk_trail_map1`
    FOREIGN KEY (`map_map_id`)
    REFERENCES `hiking`.`map` (`map_id`),
  CONSTRAINT `fk_trail_terrain1`
    FOREIGN KEY (`terrain_terrain_id`)
    REFERENCES `hiking`.`terrain` (`terrain_id`),
  CONSTRAINT `fk_trail_parks1`
    FOREIGN KEY (`parks_park_id`)
    REFERENCES `hiking`.`parks` (`park_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_trail_location1`
    FOREIGN KEY (`location_location_id`)
    REFERENCES `hiking`.`location` (`location_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `hiking`.`review`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hiking`.`review` (
  `review_id` INT NOT NULL AUTO_INCREMENT,
  `star_rating` INT NOT NULL,
  `review_writing` TEXT NOT NULL,
  `parks_park_id` INT NULL DEFAULT NULL,
  `trail_trail_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`review_id`),
  INDEX `fk_review_parks1_idx` (`parks_park_id` ASC) VISIBLE,
  INDEX `fk_review_trail1_idx` (`trail_trail_id` ASC) VISIBLE,
  CONSTRAINT `fk_review_parks1`
    FOREIGN KEY (`parks_park_id`)
    REFERENCES `hiking`.`parks` (`park_id`),
  CONSTRAINT `fk_review_trail1`
    FOREIGN KEY (`trail_trail_id`)
    REFERENCES `hiking`.`trail` (`trail_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `hiking`.`wildlife`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hiking`.`wildlife` (
  `animal_id` INT NOT NULL AUTO_INCREMENT,
  `animal_name` VARCHAR(45) NOT NULL,
  `animal_type` VARCHAR(45) NOT NULL,
  `commonality` VARCHAR(45) NOT NULL,
  `danger_level` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`animal_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `hiking`.`trail_has_wildlife`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hiking`.`trail_has_wildlife` (
  `trail_trail_id` INT NOT NULL,
  `wildlife_animal_id` INT NOT NULL,
  PRIMARY KEY (`trail_trail_id`, `wildlife_animal_id`),
  INDEX `fk_trail_has_wildlife_wildlife1_idx` (`wildlife_animal_id` ASC) VISIBLE,
  INDEX `fk_trail_has_wildlife_trail1_idx` (`trail_trail_id` ASC) VISIBLE,
  CONSTRAINT `fk_trail_has_wildlife_trail1`
    FOREIGN KEY (`trail_trail_id`)
    REFERENCES `hiking`.`trail` (`trail_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_trail_has_wildlife_wildlife1`
    FOREIGN KEY (`wildlife_animal_id`)
    REFERENCES `hiking`.`wildlife` (`animal_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;