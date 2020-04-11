# CPSC 471 Project: Travellors
# Date: 4/8/2020

# Skip this step if you have already created this table
CREATE SCHEMA `travellors` ;

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
    
# Below I'll create the sub-classes for the attraction entity. 
# There's 6 sub-classes in total

# Completed Foreign Keys
CREATE TABLE `travellors`.`entertainment` (
  `attraction_id` INT NOT NULL,
  `entertainment_type` VARCHAR(45) NOT NULL,
  UNIQUE INDEX `attraction_id_UNIQUE` (`attraction_id` ASC),
  CONSTRAINT `attraction_id`
    FOREIGN KEY (`attraction_id`)
    REFERENCES `travellors`.`attraction` (`attraction_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

# Completed Foreign Keys    
CREATE TABLE `travellors`.`parks` (
  `attraction_id` INT NOT NULL,
  `parks` VARCHAR(45) NOT NULL,
  CONSTRAINT `attraction_id_fk2`
    FOREIGN KEY (`attraction_id`)
    REFERENCES `travellors`.`attraction` (`attraction_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

# Completed Foreign Keys    
CREATE TABLE `travellors`.`cultural_site` (
  `attraction_id` INT NOT NULL,
  `admission_price` VARCHAR(45) NOT NULL,
  CONSTRAINT `attraction_id_fk3`
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
  CONSTRAINT `attraction_id_fk4`
    FOREIGN KEY (`attraction_id`)
    REFERENCES `travellors`.`attraction` (`attraction_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
 
# Completed Foreign Keys
CREATE TABLE `travellors`.`recreation` (
  `attraction_id` INT NOT NULL,
  `recreation_type` VARCHAR(75) NOT NULL,
  CONSTRAINT `attraction_id_fk5`
    FOREIGN KEY (`attraction_id`)
    REFERENCES `travellors`.`attraction` (`attraction_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

# Completed Foreign Keys
CREATE TABLE `travellors`.`other` (
  `attraction_id` INT NOT NULL,
  `type` VARCHAR(75) NOT NULL,
  CONSTRAINT `attraction_id_fk6`
    FOREIGN KEY (`attraction_id`)
    REFERENCES `travellors`.`attraction` (`attraction_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
 
# Creating 'Local Business' Entity
# Completed Foreign Keys
CREATE TABLE `travellors`.`local_business` (
  `business_license_number` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `address` VARCHAR(200) NOT NULL,
  `user_personal_information` VARCHAR(150) NOT NULL,
  `attraction_id` INT NOT NULL,
  `city_id` INT NOT NULL,
  PRIMARY KEY (`business_license_number`),
  INDEX `city_id_idx` (`city_id` ASC) VISIBLE,
  CONSTRAINT `attraction_id_fk7`
    FOREIGN KEY (`attraction_id`)
    REFERENCES `travellors`.`attraction` (`attraction_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `city_id_fk2`
    FOREIGN KEY (`city_id`)
    REFERENCES `travellors`.`city` (`city_id`)
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
  
# Creating 'Provides_deals' relationship table
# Note: total relationship for tourist so cannot be null. mmm if PK both must be not null
# Missing mapping FK (Tourist_UID) to tourist table
CREATE TABLE `travellors`.`provides_deals` (
	`business_license_number` INT NOT NULL,
	`tourist_uid` INT NOT NULL,
	PRIMARY KEY (`business_license_number`, `tourist_uid`),
    CONSTRAINT `business_license_number_fk1` 
		FOREIGN KEY (`business_license_number`)
        REFERENCES `travellors`.`local_business` (`business_license_number`)
		ON DELETE CASCADE
		ON UPDATE CASCADE
    
    #CONSTRAINT `business_license_number_fk1` 
	#	FOREIGN KEY (`tourist_uid`)
    #   REFERENCES `travellors`.`tourist` (`user_id`)
	#	ON DELETE CASCADE
	#	ON UPDATE CASCADE 
    );

# Creating 'Book' relationship table
# Note: partial relationship so attributes can be null .. mmm
# Missing FK for tourist_uid

CREATE TABLE `travellors`.`book` (
	`tour_guide_id` INT NOT NULL,
    `tourist_uid` INT NOT NULL,
    PRIMARY KEY (`tour_guide_id`, `tourist_uid`),
    CONSTRAINT `tour_guide_id_fk1` 
		FOREIGN KEY (`tour_guide_id`)
        REFERENCES `travellors`.`tour_guide` (`tour_guide_id`)
		ON DELETE CASCADE
		ON UPDATE CASCADE
    
    #CONSTRAINT `tourist_uid_fk1` 
	#	FOREIGN KEY (`tourist_uid`)
    #   REFERENCES `travellors`.`tourist` (`user_id`)
	#	ON DELETE CASCADE
	#	ON UPDATE CASCADE 
);

# Creating 'Rate' relationship table
# Local and tourist table need to be created first...
# Not implemented yet >>> ****** <<<<<<

CREATE TABLE `travellors`.`book` (
#	`local_uid` INT NOT NULL,
#    `rater_uid` INT NOT NULL,
#    PRIMARY KEY (`local_uid`, `rater_uid`),
#    CONSTRAINT `local_uid_fk1` 
#		FOREIGN KEY (`local_uid`)
#        REFERENCES `travellors`.`local` (`user_id`)
#		ON DELETE CASCADE
#		ON UPDATE CASCADE
    
    #CONSTRAINT `rater_uid_fk1` 
	#	FOREIGN KEY (`rater_uid`)
    #   REFERENCES `travellors`.`local` (`user_id`)
	#	ON DELETE CASCADE
	#	ON UPDATE CASCADE 
);
    
# Creating 'Travels_to' relationship
# Have to implement this table since transportation table doesn't exist yet

CREATE TABLE `travellors`.`travels_to` (
  `transportation_id` INT NOT NULL AUTO_INCREMENT,
  `attraction_id` INT NOT NULL,
  `start_destination` VARCHAR(150) NOT NULL,
  `end_destination` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`transportation_id`, `attraction_id`),
  CONSTRAINT `transportation_id_fk1`
    FOREIGN KEY (`transportation_id`)
    REFERENCES `travellors`.`transportation` (`transportation_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `attraction_id_fk9`
    FOREIGN KEY (`attraction_id`)
    REFERENCES `travellors`.`attraction` (`attraction_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);



