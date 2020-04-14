# CPSC 471 Project: Travellors
# Date: 4/8/2020

# Skip this step if you have already created this table
CREATE SCHEMA `travellors` ;

# Enter these commands at the MYSQL Command Line Client

# if you already created a user for any of your databases, skip this command
create user 'admin1'@'localhost' identified by 'password';

# If you have dropped this schema (travellors), execute this command again
grant all on travellors.* to 'admin1'@'localhost';

# Creating city table
CREATE TABLE `travellors`.`city` (
  `city_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `country` VARCHAR(50) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `province` VARCHAR(45) NOT NULL,
  `district` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`city_id`));
  
# Creating attraction table
# added constraints for ATTRACTION table at the bottom
CREATE TABLE `travellors`.`attraction` (
  `attraction_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `interesting_fact` VARCHAR(250) NOT NULL,
  `attraction_description` VARCHAR(300) NOT NULL,
  `city_id` INT NOT NULL,
  `business_license_number` INT NOT NULL,
  PRIMARY KEY (`attraction_id`)
);
 
# Creating 'Local Business' Entity
# Completed Foreign Keys
CREATE TABLE `travellors`.`local_business` (
  `business_license_number` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `address` VARCHAR(200) NOT NULL,
  `user_personal_information` VARCHAR(150) NOT NULL,
  #`attraction_id` INT NOT NULL,
  `city_id` INT NOT NULL,
  PRIMARY KEY (`business_license_number`),
  INDEX `city_id_idx` (`city_id` ASC) VISIBLE,
 # CONSTRAINT `attraction_id_fk7`
  #  FOREIGN KEY (`attraction_id`)
 #   REFERENCES `travellors`.`attraction` (`attraction_id`)
   # ON DELETE CASCADE
  #  ON UPDATE CASCADE,
  CONSTRAINT `city_id_local_business`
    FOREIGN KEY (`city_id`)
    REFERENCES `travellors`.`city` (`city_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
    
# Below I'll create the sub-classes for the attraction entity. 
# There's 6 sub-classes in total

# Completed Foreign Keys
CREATE TABLE `travellors`.`entertainment` (
  `attraction_id` INT NOT NULL,
  `entertainment_type` VARCHAR(45) NOT NULL,
  UNIQUE INDEX `attraction_id_UNIQUE` (`attraction_id` ASC),
  CONSTRAINT `attraction_id_entertainment`
    FOREIGN KEY (`attraction_id`)
    REFERENCES `travellors`.`attraction` (`attraction_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

# Completed Foreign Keys    
CREATE TABLE `travellors`.`parks` (
  `attraction_id` INT NOT NULL,
  `parks` VARCHAR(45) NOT NULL,
  CONSTRAINT `attraction_id_parks`
    FOREIGN KEY (`attraction_id`)
    REFERENCES `travellors`.`attraction` (`attraction_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

# Completed Foreign Keys    
CREATE TABLE `travellors`.`cultural_site` (
  `attraction_id` INT NOT NULL,
  `admission_price` VARCHAR(45) NOT NULL,
  CONSTRAINT `attraction_id_cultural_site`
    FOREIGN KEY (`attraction_id`)
    REFERENCES `travellors`.`attraction` (`attraction_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

# Completed Foreign Keys    
CREATE TABLE `travellors`.`restaurant` (
  `attraction_id` INT NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  `menu` VARCHAR(1000) NOT NULL,
  `food_quality` VARCHAR(50) NOT NULL,
  CONSTRAINT `attraction_id_restaurant`
    FOREIGN KEY (`attraction_id`)
    REFERENCES `travellors`.`attraction` (`attraction_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
 
# Completed Foreign Keys
CREATE TABLE `travellors`.`recreation` (
  `attraction_id` INT NOT NULL,
  `recreation_type` VARCHAR(75) NOT NULL,
  CONSTRAINT `attraction_id_recreation`
    FOREIGN KEY (`attraction_id`)
    REFERENCES `travellors`.`attraction` (`attraction_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

# Completed Foreign Keys
CREATE TABLE `travellors`.`other` (
  `attraction_id` INT NOT NULL,
  `type` VARCHAR(75) NOT NULL,
  CONSTRAINT `attraction_id_other`
    FOREIGN KEY (`attraction_id`)
    REFERENCES `travellors`.`attraction` (`attraction_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

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
  CONSTRAINT `attraction_id_tour_guide`
    FOREIGN KEY (`attraction_id`)
    REFERENCES `travellors`.`attraction` (`attraction_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `city_id_tour_guide`
    FOREIGN KEY (`city_id`)
    REFERENCES `travellors`.`city` (`city_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
    
# New tables
CREATE TABLE `travellors`.`admin` (
  `admin_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(255) NULL,
  `last_name` VARCHAR(255) NULL,
  PRIMARY KEY (`admin_id`));
  
  CREATE TABLE `travellors`.`user` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `email_id` VARCHAR(255) NULL,
  `first_name` VARCHAR(255) NULL,
  `last_name` VARCHAR(255) NULL,
  `admin_id` INT NULL,
PRIMARY KEY (`user_id`));
#changes
ALTER TABLE `travellors`.`user` 
ADD CONSTRAINT `admi_id_user`
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
  `good_recommendations` INT NULL);
  #changes
ALTER TABLE `travellors`.`local` 
ADD CONSTRAINT `user_id_local`
  FOREIGN KEY (`user_id`)
  REFERENCES `travellors`.`user` (`user_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
ALTER TABLE `travellors`.`local` 
ADD CONSTRAINT `city_id_local`
  FOREIGN KEY (`city_id`)
  REFERENCES `travellors`.`city` (`city_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
ALTER TABLE `travellors`.`local` 
ADD CONSTRAINT `super_local_uid_local`
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
 # ALTER TABLE `travellors`.`tourist` 
#CHANGE COLUMN `user_id` `user_id` INT NOT NULL AUTO_INCREMENT ;
ALTER TABLE `travellors`.`tourist` 
ADD CONSTRAINT `user_id_tourist`
  FOREIGN KEY (`user_id`)
  REFERENCES `travellors`.`user` (`user_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
ALTER TABLE `travellors`.`tourist` 
ADD CONSTRAINT `city_id_tourist`
  FOREIGN KEY (`city_id`)
  REFERENCES `travellors`.`city` (`city_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
CREATE TABLE `travellors`.`transportation` (
  `transportation_id` INT NOT NULL AUTO_INCREMENT,
  `transport_type` VARCHAR(255) NULL,
  `fare` INT NULL,
  PRIMARY KEY (`transportation_id`)
  );

CREATE TABLE `travellors`.`recommendation` (
  `title` VARCHAR(255) NOT NULL,
  `creation_date` DATE NULL,
  `posting_time` TIME NULL,
  `post_rating` INT NULL,
  `tips` VARCHAR(255) NULL,
  `description` VARCHAR(10000) NULL,
  `personal_information` VARCHAR(255) NULL,
  `attraction_id` INT NULL,
  `city_id` INT NULL,
  `local_uid` INT NULL,
  `tour_guide_uid` INT NULL,
  `tourist_id` INT NULL,
  PRIMARY KEY (`title`));
#changes
ALTER TABLE `travellors`.`recommendation` 
ADD CONSTRAINT `attraction_id_recommendation`
  FOREIGN KEY (`attraction_id`)
  REFERENCES `travellors`.`attraction` (`attraction_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `city_id_recommendation`
  FOREIGN KEY (`city_id`)
  REFERENCES `travellors`.`city` (`city_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `tourist_id_recommendation`
  FOREIGN KEY (`tourist_id`)
  REFERENCES `travellors`.`tourist` (`user_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `tour_guide_recommendation`
  FOREIGN KEY (`tour_guide_uid`)
  REFERENCES `travellors`.`tour_guide` (`tour_guide_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `local_uid_recommendation`
  FOREIGN KEY (`local_uid`)
  REFERENCES `travellors`.`local` (`user_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
CREATE TABLE `travellors`.`visit` (
  `attraction_id` INT NOT NULL,
  `tourist_uid` INT NOT NULL, # changed to NOT NULL
  PRIMARY KEY (`attraction_id`, `tourist_uid`));

# Add FK Constraints to visit
ALTER TABLE `travellors`.`visit` 
;
ALTER TABLE `travellors`.`visit` 
ADD CONSTRAINT `attraction_id_visit`
  FOREIGN KEY (`attraction_id`)
  REFERENCES `travellors`.`attraction` (`attraction_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `tourist_uid_visit`
  FOREIGN KEY (`tourist_uid`)
  REFERENCES `travellors`.`tourist` (`user_id`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

CREATE TABLE `travellors`.`rides_on` (
  `transport_uid` INT NOT NULL,
  `tourist_uid` INT NOT NULL,
  `departure_address` VARCHAR(255) NULL,
  `distance_travelled` INT NULL,
  `destination_address` VARCHAR(255) NULL,
  PRIMARY KEY (`transport_uid`, `tourist_uid`),
  CONSTRAINT `tourist_uid_rides_on`
	  FOREIGN KEY (`tourist_uid`)
	  REFERENCES `travellors`.`tourist` (`user_id`)
	  ON DELETE CASCADE
	  ON UPDATE CASCADE,
  CONSTRAINT `transport_uid_rides_on`
	  FOREIGN KEY (`transport_uid`)
	  REFERENCES `travellors`.`transportation` (`transportation_id`)
	  ON DELETE CASCADE
	  ON UPDATE CASCADE
  );
  
  CREATE TABLE `travellors`.`identification` (
  `local_uid` INT NOT NULL,
  `type_of_identification` VARCHAR(255) NULL,
  `identification_file` VARCHAR(255) NULL,
  PRIMARY KEY (`local_uid`),
  CONSTRAINT `local_uid_identification`
	  FOREIGN KEY (`local_uid`)
	  REFERENCES `travellors`.`local` (`user_id`)
	  ON DELETE CASCADE
	  ON UPDATE CASCADE
  );
  
  CREATE TABLE `travellors`.`places_travelled` (
  `tourist_uid` INT NOT NULL,
  `Name_of_place_travelled` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`tourist_uid`,`Name_of_place_travelled`),
  CONSTRAINT `tourist_uid_places_travelled`
	  FOREIGN KEY (`tourist_uid`)
	  REFERENCES `travellors`.`tourist` (`user_id`)
	  ON DELETE CASCADE
	  ON UPDATE CASCADE
  );
  
# Creating 'Provides_deals' relationship table
# Note: total relationship for tourist so cannot be null. mmm if PK both must be not null
# Missing mapping FK (Tourist_UID) to tourist table
CREATE TABLE `travellors`.`provides_deals` (
	`business_license_number` INT NOT NULL,
	`tourist_uid` INT NOT NULL,
	PRIMARY KEY (`business_license_number`, `tourist_uid`),
    CONSTRAINT `business_license_number_provides_deals` 
		FOREIGN KEY (`business_license_number`)
        REFERENCES `travellors`.`local_business` (`business_license_number`)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
    CONSTRAINT `tourist_uid_provides_deals` #Changed this from business license number fk10
		FOREIGN KEY (`tourist_uid`)
        REFERENCES `travellors`.`tourist` (`user_id`)
		ON DELETE CASCADE
		ON UPDATE CASCADE 
    );

# Creating 'Book' relationship table
# Note: partial relationship so attributes can be null .. mmm
# Missing FK for tourist_uid

CREATE TABLE `travellors`.`book` (
	`tour_guide_id` INT NOT NULL,
    `tourist_uid` INT NOT NULL,
    PRIMARY KEY (`tour_guide_id`, `tourist_uid`),
    CONSTRAINT `tour_guide_id_book` 
		FOREIGN KEY (`tour_guide_id`)
        REFERENCES `travellors`.`tour_guide` (`tour_guide_id`)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
    CONSTRAINT `tourist_uid_book` 
		FOREIGN KEY (`tourist_uid`)
       REFERENCES `travellors`.`tourist` (`user_id`)
		ON DELETE CASCADE
		ON UPDATE CASCADE 
);

# Creating 'Rate' relationship table

CREATE TABLE `travellors`.`rate` (
	`local_uid` INT NOT NULL,
    `rater_uid` INT NOT NULL,
    PRIMARY KEY (`local_uid`, `rater_uid`),
    CONSTRAINT `local_uid_rate` 
		FOREIGN KEY (`local_uid`)
        REFERENCES `travellors`.`local` (`user_id`)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
    CONSTRAINT `rater_uid_rate` 
		FOREIGN KEY (`rater_uid`)
       REFERENCES `travellors`.`local` (`user_id`)
		ON DELETE CASCADE
		ON UPDATE CASCADE 
);
    
# Creating 'Travels_to' relationship
# Have to implement this table since transportation table doesn't exist yet

CREATE TABLE `travellors`.`travels_to` (
  `transportation_id` INT NOT NULL,
  `attraction_id` INT NOT NULL,
  `start_destination` VARCHAR(150) NOT NULL,
  `end_destination` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`transportation_id`, `attraction_id`),
  CONSTRAINT `transportation_id_travels_to`
    FOREIGN KEY (`transportation_id`)
    REFERENCES `travellors`.`transportation` (`transportation_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `attraction_id_travels_to`
    FOREIGN KEY (`attraction_id`)
    REFERENCES `travellors`.`attraction` (`attraction_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
    
#  ------  Adding constraints to tables -----------

# Adding constraints for ATTRACTION TABLE
ALTER TABLE `travellors`.`attraction` 
ADD INDEX `city_id_idx` (`city_id` ASC) VISIBLE;
;
ALTER TABLE `travellors`.`attraction` 
ADD CONSTRAINT `city_id_attraction`
  FOREIGN KEY (`city_id`)
  REFERENCES `travellors`.`city` (`city_id`)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
ADD CONSTRAINT `business_license_number_attraction`
    FOREIGN KEY (`business_license_number`)
    REFERENCES `travellors`.`local_business` (`business_license_number`)
    ON DELETE CASCADE
    ON UPDATE CASCADE;


