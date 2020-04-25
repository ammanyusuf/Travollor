# Use Case 1:
# As a tourist, I want to be able to get a list of all cities that have beaches so that I can enjoy sun
# GET: Endpoint for retrieving information and facts from a city. 
# Parameters: Int: city_ID 
# Description: 
# This endpoint will take the city_ID and retrieve information such as where it’s located and interesting facts. 
# The interesting facts will be the attractions in this city which will be retrieved using the foreign key of city_ID 
# in the attractions relation
# Expected Output: 
# The expected output for this endpoint will be a message including information about the city such as the location and attractions

DELIMITER //

CREATE PROCEDURE `infoAndFactsFromCity` (
	# Parameters
    IN cityNumber INT
)
BEGIN
	SELECT c.name as city_name, c.country, a.interesting_fact, 
        group_concat(DISTINCT a.name ORDER BY a.name ASC SEPARATOR ', ') as attraction_names,
		group_concat(DISTINCT r.type ORDER BY r.type ASC SEPARATOR ', ') as restaurant_types, 
		group_concat(DISTINCT re.recreation_type ORDER BY re.recreation_type ASC SEPARATOR ', ') as recreation_types,
		group_concat(DISTINCT cs.admission_price ORDER BY cs.admission_price ASC SEPARATOR ', ') as cultural_site_price,
		group_concat(DISTINCT p.parks ORDER BY p.parks ASC SEPARATOR ', ') as parks_name,
		group_concat(DISTINCT en.entertainment_type ORDER BY en.entertainment_type ASC SEPARATOR ', ') as entertainment_type
	FROM city as c, attraction as a, restaurant as r, recreation as re, cultural_site as cs, parks as p, entertainment as en
	WHERE c.city_id = cityNumber AND c.city_id = a.city_id and (a.attraction_id = r.attraction_id or a.attraction_id = re.attraction_id or
	a.attraction_id = cs.attraction_id or a.attraction_id = p.attraction_id or a.attraction_id = en.attraction_id);
END //

DELIMITER ;

# Use case 2) GET: Endpoint for retrieving the attraction that has the most recommendations. 
# Setting post_rating >= 8 to be a good rating for a post

DELIMITER //

CREATE PROCEDURE `attractionMostRecommendationsByCityID` (
	# Parameters
    IN cityNumber INT 
)
BEGIN
	SELECT a.attraction_id, a.name as attraction_name, COUNT(title) as num_recommendations, a.interesting_fact, a.attraction_description
    FROM city as c, recommendation as rem, attraction as a
	WHERE c.city_id = cityNumber and c.city_id = rem.city_id and a.attraction_id = rem.attraction_id and post_rating >= 8
    GROUP BY rem.attraction_id
    ORDER BY num_recommendations DESC LIMIT 1;
END //

DELIMITER ;

# Use case 3) GET: Endpoint for retrieving locations where tour guides live based on the location tourists will visit. 

DELIMITER //

CREATE PROCEDURE `tourGuidesByTouristCityID` (
	# Parameters
    IN touristCityID INT 
)
BEGIN
	SELECT tour.*
	FROM tourist as t, tour_guide as tour
	WHERE t.city_id = touristCityID and t.city_id = tour.city_id;
END //

DELIMITER ;

# GET Method: get tourist's nationality

DELIMITER //
CREATE PROCEDURE `touristNationality` ()
BEGIN
	SELECT DISTINCT nationality
    FROM tourist;
END //
DELIMITER ;

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


#POST locals recommendations
USE `travellors`;
DROP procedure IF EXISTS `add_recommendation`;

DELIMITER $$
USE `travellors`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_recommendation`(IN rtitle varchar(255), IN rcreation_date DATE, 
IN rposting_time TIME, IN rtips VARCHAR(255), IN rdescription VARCHAR(1000), IN rattraction_id INT, 
IN rcity_id INT,IN rlocal_uid INT, OUT title_name varchar(255))
BEGIN
INSERT INTO travellors.recommendation(title,creation_date,posting_time,tips,description
,attraction_id,city_id,local_uid) values (rtitle, rcreation_date,rposting_time
,rtips,rdescription,rattraction_id,rcity_id,rlocal_uid);

 SELECT title
    INTO title_name
    FROM recommendation 
    WHERE title = (SELECT title FROM recommendation as r  WHERE r.local_uid = rlocal_uid and title = rtitle );

END$$

DELIMITER ;


# Use case 7: as a local i should be able to rate other locals so that other users
#			  can decide if a particular local could be trusted or not.
# PUT: enpoint for updating local ratings 
# Parameters: int user_id, int rating
# Output: the new rating of local 

DELIMITER //
DROP PROCEDURE IF EXISTS updateLocalRatings;
CREATE PROCEDURE updateLocalRatings (
	# Parameters
    IN uid INT,
    IN updated_rating INT,
    OUT new_rating INT
)
BEGIN
	
    UPDATE local
    SET rating = (updated_rating + rating)
    WHERE user_id = uid;
    
    SELECT rating
    INTO new_rating
    FROM local
    WHERE local.user_id = uid;
    
END //

DELIMITER ;

# Use case 8: as a super local, i should be able to recruit/add other locals 
#			  so that the website can continue to have trustworthy locals
# POST: endpoint for adding a local, based on super local input.
# Parameters: int super_local_user_id, int local_user_id, int city_id, boolean super_local_flag
# Output: the user id of the newly inserted local

DELIMITER //
DROP PROCEDURE IF EXISTS addLocal;
CREATE PROCEDURE addLocal (
	# Parameters
    IN super_local_user_id INT,
    IN local_user_id INT,
    IN city_id INT,
    IN super_local_flag_input BOOLEAN,
    OUT inserted_user_id INT
)
BEGIN
	
    INSERT INTO local (user_id, rating, num_of_recommendations, city_id, super_local_flag, super_local_uid, good_recommendations)
    VALUES (local_user_id, 0, 0, city_id, super_local_flag_input, super_local_user_id, 0);
    
	SELECT local.user_id INTO inserted_user_id
    FROM local 
    WHERE local.user_id = local_user_id;
    
END //

DELIMITER ;

# Use case 9: as a super local, I should be able to verify local businesses in my city so that
#			  users know about the deals provided by local businesses
# POST: endpoint for adding a local business, based on super local input
# Parameters: int super_local_UID, int business_liscence_number, string name, string address, int city_id
# Output: the business_liscence_number of the newly inserted local
DELIMITER //
DROP PROCEDURE IF EXISTS verifyLocalBusiness;
CREATE PROCEDURE verifyLocalBusiness (
	# Parameters
    IN super_local_UID_1 INT,
    IN business_license_number1 INT,
    IN name1 varchar(100),
    IN address1 varchar(200),
    IN city_id1 INT,
    OUT out_bln INT
)
BEGIN
	
    INSERT INTO local_business (business_license_number,name,address,user_personal_information,city_id,super_local_uid)
    VALUES (business_license_number1,name1,address1,"",city_id1,super_local_UID_1);
    
    SELECT business_license_number INTO out_bln
    FROM local_business
    WHERE local_business.business_license_number = business_license_number1;
    
END //

DELIMITER ;

# POST: Endpoint for storing user (tourist and local) personal information which includes name and email address.  
# As an admin I should be able to add users (tourists and loocals) so that only registered people can access the system.

DELIMITER //
CREATE PROCEDURE `addUser` (
	IN email_id varchar(255),
    IN first_name varchar(255),
    IN last_name varchar(255),
    IN admin_id INT,
    OUT userID int
)

BEGIN 
	INSERT INTO user (email_id, first_name, last_name, admin_id) values (email_id, first_name, last_name, admin_id);
    
    SELECT user_id 
    INTO userID
    FROM user
    WHERE user_id = (SELECT last_insert_id());
END //
DELIMITER ;
