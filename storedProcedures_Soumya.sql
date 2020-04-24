#GET local business info

USE `travellors`;
DROP procedure IF EXISTS `local_business_info`;

DELIMITER $$
USE `travellors`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `local_business_info`(IN city_id INT)
BEGIN
SELECT l.name, l.address, p.deals
FROM local_business as l, provides_deals as p
WHERE l.city_id = city_id and l.business_license_number = p.business_license_number;
END$$

DELIMITER ;
# GET recommendations written for a particular attraction
USE `travellors`;
DROP procedure IF EXISTS `recommendations_retrieve`;

DELIMITER $$
USE `travellors`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `recommendations_retrieve`(IN attraction_name varchar(255))
BEGIN
	SELECT DISTINCT r.title, r.description, r.city_id, r.local_uid, r.post_rating,r.attraction_id
    FROM recommendation as r, attraction as a, city as c
    WHERE r.attraction_id = a.attraction_id and a.city_id = r.city_id and a.name = attraction_name;
END$$

DELIMITER ;
CALL recommendations_retrieve('Miami Beach');


#POST locals recommendations
USE `travellors`;
DROP procedure IF EXISTS `add_recommendation`;

DELIMITER $$
USE `travellors`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_recommendation`(IN rtitle varchar(255), IN rcreation_date DATE, IN rposting_time TIME, 
IN rpost_rating INT, IN rtips VARCHAR(255), IN rdescription VARCHAR(1000), IN rpersonal_info VARCHAR(255),
IN rattraction_id INT, IN rcity_id INT,IN rlocal_uid INT, IN rtour_guide_id INT, IN rtourist_id INT, OUT title_name varchar(255))
BEGIN
INSERT INTO travellors.recommendation(title,creation_date,posting_time,post_rating,tips,description,
personal_information,attraction_id,city_id,local_uid,tour_guide_uid,tourist_id) values (rtitle, rcreation_date,rposting_time,
rpost_rating,rtips,rdescription,rpersonal_info,rattraction_id,rcity_id,rlocal_uid,rtour_guide_id, rtourist_id);

 SELECT title
    INTO title_name
    FROM recommendation 
    WHERE title = (SELECT title FROM recommendation as r  WHERE r.local_uid = rlocal_uid and title = rtitle );

END$$

DELIMITER ;

