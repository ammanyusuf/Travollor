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

#call updateLocalRatings (1,9,@new_rating);
#select @new_rating;


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

#INSERT INTO travellors.user (user_id,email_id,first_name,last_name,admin_id)
#VALUES (111,"someemail@gmail.com","Fabby","Lappy","1");

#INSERT INTO travellors.user (user_id,email_id,first_name,last_name,admin_id)
#VALUES (112,"someemail@gmail.com","Fabby","Lappy","1");

#INSERT INTO travellors.user (user_id,email_id,first_name,last_name,admin_id)
#VALUES (113,"someemail@gmail.com","Fabby","Lappy","1");

INSERT INTO travellors.user (user_id,email_id,first_name,last_name,admin_id)
VALUES (114,"someemail@gmail.com","Fabby","Lappy","1");

#call addLocal (1,113,2,false,@inserted_user_id);
#select @inserted_user_id;

#select last_insert_id();


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

call verifyLocalBusiness (1,112,"cool cats and kittens","Bigt Cat Rescue 200 St",2,@out_bln);
select @out_bln;
