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
  
  CREATE TABLE `travellors`.`local` (
  `user_id` INT NOT NULL,
  `rating` INT NULL,
  `num_of_recommendations` INT NULL,
  `city_id` INT NULL,
  `super_local_flag` INT NULL,
  `super_local_uid` INT NULL,
  `good_recommendations` VARCHAR(255) NULL);
  
  CREATE TABLE `travellors`.`tourist` (
  `user_id` INT NOT NULL,
  `nationality` VARCHAR(45) NULL,
  `city_id` INT NULL,
  PRIMARY KEY (`user_id`));
  
CREATE TABLE `travellors`.`visit` (
  `attraction_id` INT NOT NULL,
  `tourist_uid` INT NULL,
  PRIMARY KEY (`attraction_id`, `tourist_uid`));


  
CREATE TABLE `travellors`.`rides_on` (
  `transport_uid` INT NOT NULL,
  `tourist_uid` INT NOT NULL,
  `departure_address` VARCHAR(255) NULL,
  `distance_travelled` INT NULL,
  `destination_address` VARCHAR(255) NULL,
  PRIMARY KEY (`transport_uid`, `tourist_uid`));
  
  CREATE TABLE `travellors`.`identification` (
  `local_uid` INT NOT NULL,
  `type_of_identification` VARCHAR(255) NULL,
  `identification_file` VARCHAR(255) NULL,
  PRIMARY KEY (`local_uid`));
  
  CREATE TABLE `travellors`.`places_travelled` (
  `tourist_uid` INT NOT NULL,
  `Name_of_place_travelled` VARCHAR(255) NULL,
  PRIMARY KEY (`tourist_uid`));
  
  
  
  
  
