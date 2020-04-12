CREATE SCHEMA `travellors` ;
CREATE TABLE `travellors`.`recommendation` (
  `title` VARCHAR(255) NOT NULL,
  `creation_date` DATE NULL,
  `posting_time` TIME NULL,
  `post_rating` INT NULL,
  `tips` VARCHAR(255) NULL,
  `description` VARCHAR(255) NULL,
  `personal_information` VARCHAR(255) NULL,
  `attraction_id` INT NULL,
  `city_id` INT NULL,
  `local_uid` INT NULL,
  `tour_guide_uid` INT NULL,
  `tourist_id` INT NULL,
  PRIMARY KEY (`title`));

ALTER TABLE `travellors`.`recommendation` 
ADD CONSTRAINT `attraction_id_fk9`
  FOREIGN KEY (`attraction_id`)
  REFERENCES `travellors`.`attraction` (`attraction_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `city_id_fk10`
  FOREIGN KEY (`city_id`)
  REFERENCES `travellors`.`city` (`city_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `tourist_id_fk8`
  FOREIGN KEY (`tourist_id`)
  REFERENCES `travellors`.`tourist` (`user_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `tour_guide_fk16`
  FOREIGN KEY (`tour_guide_uid`)
  REFERENCES `travellors`.`tour_guide` (`tour_guide_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `local_uid_fk20`
  FOREIGN KEY (`local_uid`)
  REFERENCES `travellors`.`local` (`user_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

  
  CREATE TABLE `travellors`.`transportation` (
  `transportation_id` INT NOT NULL,
  `transport_type` VARCHAR(255) NULL,
  `fare` INT NULL);
  
  CREATE TABLE `travellors`.`admin` (
  `admin_id` INT NOT NULL,
  `first_name` VARCHAR(255) NULL,
  `last_name` VARCHAR(255) NULL,
  PRIMARY KEY (`admin_id`));
 
  
  
  CREATE TABLE `travellors`.`user` (
  `user_id` INT NOT NULL,
  `email_id` VARCHAR(255) NULL,
  `first_name` VARCHAR(255) NULL,
  `last_name` VARCHAR(255) NULL,
  `admin_id` INT NULL,
PRIMARY KEY (`user_id`));
#changes
ALTER TABLE `travellors`.`user` 
ADD CONSTRAINT `admi_id`
  FOREIGN KEY (`admin_id`)
  REFERENCES `travellors`.`admin` (`admin_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

  
  
  
  
  CREATE TABLE `travellors`.`local` (
  `user_id` INT NOT NULL,
  `rating` INT NULL,
  `num_of_recommendations` INT NULL,
  `city_id` INT NULL,
  `super_local_flag` INT NULL,
  `super_local_uid` INT NULL,
  `good_recommendations` VARCHAR(255) NULL);
  #changes
ALTER TABLE `travellors`.`local` 
ADD CONSTRAINT `user_id`
  FOREIGN KEY (`user_id`)
  REFERENCES `travellors`.`user` (`user_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  CREATE TABLE `travellors`.`tourist` (
  `user_id` INT NOT NULL,
  `nationality` VARCHAR(45) NULL,
  `city_id` INT NULL,
  PRIMARY KEY (`user_id`));
  #changes
  ALTER TABLE `travellors`.`tourist` 
CHANGE COLUMN `user_id` `user_id` INT NOT NULL AUTO_INCREMENT ;
ALTER TABLE `travellors`.`tourist` 
ADD CONSTRAINT `user_id_fk1`
  FOREIGN KEY (`user_id`)
  REFERENCES `travellors`.`user` (`user_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  
CREATE TABLE `travellors`.`visit` (
  `attraction_id` INT NOT NULL,
  `tourist_uid` INT NOT NULL,
  PRIMARY KEY (`attraction_id`, `tourist_uid`));
  
  


  
CREATE TABLE `travellors`.`rides_on` (
  `transportation_id` INT NOT NULL,
  `tourist_uid` INT NOT NULL,
  `departure_address` VARCHAR(255) NULL,
  `distance_travelled` INT NULL,
  `destination_address` VARCHAR(255) NULL,
  PRIMARY KEY (`transportation_id`, `tourist_uid`));
  

  
  
  
  CREATE TABLE `travellors`.`identification` (
  `local_uid` INT NOT NULL,
  `type_of_identification` VARCHAR(255) NULL,
  `identification_file` VARCHAR(255) NULL,
  PRIMARY KEY (`local_uid`));
  
  CREATE TABLE `travellors`.`places_travelled` (
  `tourist_uid` INT NOT NULL,
  `Name_of_place_travelled` VARCHAR(255) NULL,
  PRIMARY KEY (`tourist_uid`));
  #changes
  ALTER TABLE `travellors`.`places_travelled` 
ADD CONSTRAINT `tourist_id_fk20`
  FOREIGN KEY (`tourist_uid`)
  REFERENCES `travellors`.`tourist` (`user_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  


# Creating attraction table
# --- Note: have to add fk to business_license_number
CREATE TABLE `travellors`.`attraction` (
  `attraction_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `interesting_fact` VARCHAR(250) NOT NULL,
  `attraction_description` VARCHAR(300) NOT NULL,
  `city_id` INT NOT NULL,
  `business_license_number` INT NOT NULL,
  PRIMARY KEY (`attraction_id`),
  INDEX `city_id_idx` (`city_id` ASC) INVISIBLE,
  CONSTRAINT `city_id`
    FOREIGN KEY (`city_id`)
    REFERENCES `travellors`.`city` (`city_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
    
    # Creating city table
CREATE TABLE `travellors`.`city` (
  `city_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `country` VARCHAR(50) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `province` VARCHAR(45) NOT NULL,
  `district` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`city_id`));
  
  # Creating 'Tour Guide' Entity
# Certification example: 743-VXT-345
CREATE TABLE `travellors`.`tour_guide` (
  `tour_guide_id` INT NOT NULL AUTO_INCREMENT,
  `certification` VARCHAR(100) NOT NULL,
  `first_name` VARCHAR(100) NOT NULL,
  `last_name` VARCHAR(100) NOT NULL,
  `years_of_experience` INT NOT NULL,
  `attraction_id` INT NOT NULL,
  `city_id` INT NOT NULL,
  PRIMARY KEY (`tour_guide_id`),
  CONSTRAINT `attraction_id_fk8`
    FOREIGN KEY (`attraction_id`)
    REFERENCES `travellors`.`attraction` (`attraction_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `city_id_fk3`
    FOREIGN KEY (`city_id`)
    REFERENCES `travellors`.`city` (`city_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
  
  
  
  
  
