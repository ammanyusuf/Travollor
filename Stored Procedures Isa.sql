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

call infoAndFactsFromCity(2);

SELECT DISTINCT c.name as city_name, a.name as attraction_name, a.interesting_fact, a.attraction_description, r.type as restaurant_type,
	 re.recreation_type as recreation_type, cs.admission_price as cultural_site_price,  en.entertainment_type as entertainment_type
FROM  city as c, attraction as a, restaurant as r, recreation as re, cultural_site as cs, entertainment as en
WHERE c.city_id = 2 and c.city_id = a.city_id and a.attraction_id IN (
	SELECT DISTINCT r.attraction_id
    FROM restaurant as r
    UNION
    SELECT DISTINCT re.attraction_id
    FROM recreation as re
    UNION 
    SELECT DISTINCT cs.attraction_id
    FROM cultural_site as cs
    UNION 
    SELECT DISTINCT en.attraction_id
    FROM entertainment as en
);

# Good too
SELECT DISTINCT c.name as city_name, a.interesting_fact, a.attraction_description, 
group_concat(DISTINCT a.name ORDER BY a.name ASC SEPARATOR ', ') as attraction_names,
group_concat(DISTINCT r.type ORDER BY r.type ASC SEPARATOR ', ') as restaurant_types, 
group_concat(DISTINCT re.recreation_type ORDER BY re.recreation_type ASC SEPARATOR ', ') as recreation_types,
group_concat(DISTINCT cs.admission_price ORDER BY cs.admission_price ASC SEPARATOR ', ') as cultural_site_price,
group_concat(DISTINCT p.parks ORDER BY p.parks ASC SEPARATOR ', ') as parks_name,
group_concat(DISTINCT en.entertainment_type ORDER BY en.entertainment_type ASC SEPARATOR ', ') as entertainment_type
FROM city as c, attraction as a, restaurant as r, recreation as re, cultural_site as cs, parks as p, entertainment as en
WHERE c.city_id = 2 and c.city_id = a.city_id and a.attraction_id IN (
	SELECT DISTINCT r.attraction_id
    FROM restaurant as r
    UNION
    SELECT DISTINCT re.attraction_id
    FROM recreation as re
    UNION 
    SELECT DISTINCT cs.attraction_id
    FROM cultural_site as cs
    UNION 
    SELECT DISTINCT p.attraction_id
    FROM parks as p
    UNION
    SELECT DISTINCT en.attraction_id
    FROM entertainment as en
);

# Use case 2) GET: Endpoint for retrieving the attraction that has the most recommendations. 

DELIMITER //

CREATE PROCEDURE `attractionMostRecommendationsByCityID` (
	# Parameters
    IN cityNumber INT 
)
BEGIN
	SELECT *
	FROM city as c, attraction as a, recommendation as rem
	WHERE c.city_id = 2 and c.city_id = rem.city_id;
END //

DELIMITER ;

call attractionMostRecommendationsByCityID(2);

SELECT *
FROM recommendation as m, attraction as a, city as c
WHERE c.city_id = 2 and c.city_id = m.city_id and m.attraction_id = a.attraction_id

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

call tourGuidesByTouristCityID(2);

# GET Method: get tourist's nationality

DELIMITER //
CREATE PROCEDURE `touristNationality` ()
BEGIN
	SELECT DISTINCT *
    FROM tourist;
END //
DELIMITER ;

call touristNationality();
