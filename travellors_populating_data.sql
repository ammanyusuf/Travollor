# CPSC 471 Project: Travellors
# Date: 4/13/2020

# This is the file to populate data in the travelors schema

# Populate the city table

INSERT INTO travellors.city (name,country,state,province,district)
VALUES ('Calgary','Canada','N/A','Alberta','NW');

INSERT INTO travellors.city (name,country,state,province,district)
VALUES ('Miami','USA','Florida','N/A','NW');

INSERT INTO travellors.city (name,country,state,province,district)
VALUES ('Milano','Italy','Lombardy','N/A','NW');

INSERT INTO travellors.city (name,country,state,province,district)
VALUES ('Paris','France','N/A','Ile-de-France','NW');

INSERT INTO travellors.city (name,country,state,province,district)
VALUES ('Barcelona','Spain','N/A','Catalonia','NW');

INSERT INTO travellors.city (name,country,state,province,district)
VALUES ('Toronto','Canada','N/A','Ontario','NW');

INSERT INTO travellors.city (name,country,state,province,district)
VALUES ('Lima','Peru','N/A','Lima','NW');


# Add 3 admins
INSERT INTO travellors.admin (admin_id,first_name,last_name)
VALUES (1,'John','Smith');

INSERT INTO travellors.admin (admin_id,first_name,last_name)
VALUES (2,'Tom','Nook');

INSERT INTO travellors.admin (admin_id,first_name,last_name)
VALUES (3,'Issiah','Cans');

# Add 8 businesses
# The city is Miami
INSERT INTO travellors.local_business (name,address,user_personal_information,city_id)
VALUES ('Beach Fronts Inc.','3001 Ventura ST SW','',2);

INSERT INTO travellors.local_business (name,address,user_personal_information,city_id)
VALUES ('Mountaniers Organization','8001 Mountain ST SW','',2);

INSERT INTO travellors.local_business (name,address,user_personal_information,city_id)
VALUES ('Foodies Smoothies','1234 Cherry Road N','',2);

INSERT INTO travellors.local_business (name,address,user_personal_information,city_id)
VALUES ('Fashion Central','1234 Runway Ridge SE','',2);

INSERT INTO travellors.local_business (name,address,user_personal_information,city_id)
VALUES ('Museums Galore','1891 Hidden History Road NW','',2);

INSERT INTO travellors.local_business (name,address,user_personal_information,city_id)
VALUES ('10-9 Clubs','11 Party Lane NW','',2);

INSERT INTO travellors.local_business (name,address,user_personal_information,city_id)
VALUES ('Soccer Fans 4 U','90 Golden Ball Way NW','',2);

INSERT INTO travellors.local_business (name,address,user_personal_information,city_id)
VALUES ('Pio','90 Lomo Road NW','',2);


# Add 10 Attractions
INSERT INTO travellors.attraction (name,interesting_fact,attraction_description,city_id,business_license_number)
VALUES ('Miami Beach','Home to 1000 real life dolphins!','This is the most famous beach in the state of Florida.  
		The sunny weather and warm sand welcomes you to try out the Florida waters!',2,1);

INSERT INTO travellors.attraction (name,interesting_fact,attraction_description,city_id,business_license_number)
VALUES ('Palm Bay','Has so many palms it rivals the Palm Tree Parl!  It also doubles as a cool beach','This is a beach with a view!
			A view fo 999 Palm Trees',2,1);

INSERT INTO travellors.attraction (name,interesting_fact,attraction_description,city_id,business_license_number)
VALUES ('Soccer Stadium Barcellona','Messi played here once!','One of the most famouse statiums in the world.  Housed greatest
		that has ever played.',2,5);
        
INSERT INTO travellors.attraction (name,interesting_fact,attraction_description,city_id,business_license_number)
VALUES ('Seafood and More!','The best seafood and more to come!  Including but not limited to food from the sea','Fresh sea food out of the sea yes!',2,8);

INSERT INTO travellors.attraction (name,interesting_fact,attraction_description,city_id,business_license_number)
VALUES ('Seafood and And Litte Bit More!','Seafood straight from the sea!  As fresh as it can get','Fresh sea food out of the sea yes!',2,8);
        
INSERT INTO travellors.attraction (name,interesting_fact,attraction_description,city_id,business_license_number)
VALUES ('The Miami Louvre','Forged 10 paintings straight out of the actual Louvre','This is Miamis attempt to emulate the Louvre from Paris',2,5);

INSERT INTO travellors.attraction (name,interesting_fact,attraction_description,city_id,business_license_number)
VALUES ('Palm Tree Park','Imported 100 species of palm trees from Madagascar','Take a walk through the palm tree park and endulge in the views',2,2);
        
INSERT INTO travellors.attraction (name,interesting_fact,attraction_description,city_id,business_license_number)
VALUES ('Club Groovay','A time travel back to the 80s','The hotest club in Miami is straight out of the 80s',2,6);
        
INSERT INTO travellors.attraction (name,interesting_fact,attraction_description,city_id,business_license_number)
VALUES ('Drive In Movie Inn','Houses space for 100 cars per viewing!','Old school drive in movies for the family',2,8);
        
INSERT INTO travellors.attraction (name,interesting_fact,attraction_description,city_id,business_license_number)
VALUES ('Ice Cold Smoothies','Smoothies are slightly below ice cold','Refresh yourself from the hot Miami weather with some cool smoothies',2,3);


# Add Values into the cubclasses of the Attraction class
# Add values into Recreation
INSERT INTO travellors.recreation (attraction_id,recreation_type)
VALUES (3,'Sport');

INSERT INTO travellors.recreation (attraction_id,recreation_type)
VALUES (1,'Beach');

INSERT INTO travellors.recreation (attraction_id,recreation_type)
VALUES (2,'Beach');

# Add values into Restaurant
INSERT INTO travellors.restaurant (attraction_id,type,menu,food_quality)
VALUES (4,'Seafood','Appetizers: Calmari and Spritz.  Seafood: Swordfish, Squid.  Desserts: Chocolate cake','8');

INSERT INTO travellors.restaurant (attraction_id,type,menu,food_quality)
VALUES (5,'Seafood','Appetizers: Shrimp.  Seafood: Salmon, Sushi.  Desserts: Cookies','7');

INSERT INTO travellors.restaurant (attraction_id,type,menu,food_quality)
VALUES (10,'Smoothies','Mango Raspberry, Banana Blast, Five-O','10');

# Add values into Cultural Site
INSERT INTO travellors.cultural_site (attraction_id,admission_price)
VALUES (6, '20');

# Add values into Parks
INSERT INTO travellors.parks (attraction_id, parks)
VALUES (7, 'Palm Tree Park');

# Add values into entertainment
INSERT INTO travellors.entertainment (attraction_id,entertainment_type)
VALUES (8,"Club");

INSERT INTO travellors.entertainment (attraction_id,entertainment_type)
VALUES (9,"Movies");

# Adding 5 tour guides
INSERT INTO travellors.tour_guide (certification,first_name,last_name,years_of_experience,attraction_id,city_id)
VALUES ("743-VXT-345","Ryan","Reynolds",20,1,2);

INSERT INTO travellors.tour_guide (certification,first_name,last_name,years_of_experience,attraction_id,city_id)
VALUES ("817-ASK-809","Tessa","Thompson",5,2,2);

INSERT INTO travellors.tour_guide (certification,first_name,last_name,years_of_experience,attraction_id,city_id)
VALUES ("132-DWD-352","Luigi","Waluigi",12,3,2);

INSERT INTO travellors.tour_guide (certification,first_name,last_name,years_of_experience,attraction_id,city_id)
VALUES ("192-HGB-190","French","Frenchwoman",12,6,2);

INSERT INTO travellors.tour_guide (certification,first_name,last_name,years_of_experience,attraction_id,city_id)
VALUES ("283-BNM-782","Palmlad","Trees",19,7,2);

# Add 10 users (5 locals and 5 tourists)
# 5 Users
INSERT INTO travellors.user (email_id,first_name,last_name,admin_id)
VALUES ("someemail@gmail.com","Johny","Appleseed","1");

INSERT INTO travellors.user (email_id,first_name,last_name,admin_id)
VALUES ("coolCoolio@gmail.com","Sweet","Coolio","2");

INSERT INTO travellors.user (email_id,first_name,last_name,admin_id)
VALUES ("sammu@gmail.com","Samuel","Sammu","3");

INSERT INTO travellors.user (email_id,first_name,last_name,admin_id)
VALUES ("Lue@gmail.com","Lue","Baloo","1");

INSERT INTO travellors.user (email_id,first_name,last_name,admin_id)
VALUES ("gibbon@gmail.com","Gibbon","Troglodyte","2");

# 6 Tourists
INSERT INTO travellors.user (email_id,first_name,last_name,admin_id)
VALUES ("lione@gmail.com","Lione","Messi","1");

INSERT INTO travellors.user (email_id,first_name,last_name,admin_id)
VALUES ("visiting@gmail.com","Visiting","Person","2");

INSERT INTO travellors.user (email_id,first_name,last_name,admin_id)
VALUES ("baboon@gmail.com","Bee","Fast","3");

INSERT INTO travellors.user (email_id,first_name,last_name,admin_id)
VALUES ("lone@gmail.com","Lone","Ranger","1");

INSERT INTO travellors.user (email_id,first_name,last_name,admin_id)
VALUES ("egg@gmail.com","Egg","AndCheese","2");

# Added 6th tourist
INSERT INTO travellors.user (email_id,first_name,last_name,admin_id)
VALUES ("gastby@gmail.com","Gastby","Pooly","3");

# Add 5 Locals
INSERT INTO travellors.local (user_id,rating,num_of_recommendations,city_id,super_local_flag,super_local_uid,good_recommendations)
VALUES (1,7,10,2,1,null,15);

INSERT INTO travellors.local (user_id,rating,num_of_recommendations,city_id,super_local_flag,super_local_uid,good_recommendations)
VALUES (2,9,1,2,0,null,0);

INSERT INTO travellors.local (user_id,rating,num_of_recommendations,city_id,super_local_flag,super_local_uid,good_recommendations)
VALUES (3,10,112,2,1,1,10);

INSERT INTO travellors.local (user_id,rating,num_of_recommendations,city_id,super_local_flag,super_local_uid,good_recommendations)
VALUES (4,2,15,2,0,null,1);

INSERT INTO travellors.local (user_id,rating,num_of_recommendations,city_id,super_local_flag,super_local_uid,good_recommendations)
VALUES (5,6,20,2,0,null,20);

# Add 5 tourists
INSERT INTO travellors.tourist (user_id,nationality,city_id)
VALUES (6,"French","4");

INSERT INTO travellors.tourist (user_id,nationality,city_id)
VALUES (7,"Italian","3");

INSERT INTO travellors.tourist (user_id,nationality,city_id)
VALUES (8,"Peruvian","7");

INSERT INTO travellors.tourist (user_id,nationality,city_id)
VALUES (9,"Canadian","1");

INSERT INTO travellors.tourist (user_id,nationality,city_id)
VALUES (10,"Canadian","6");

# Why can't this be done??
INSERT INTO travellors.tourist (user_id,nationality,city_id)
VALUES ('11', 'Italian', '2');

# Add values for transportation
INSERT INTO travellors.transportation(transport_type,fare)
VALUES ('Subway',2);

INSERT INTO travellors.transportation(transport_type,fare)
VALUES ('Bus',3);

INSERT INTO travellors.transportation(transport_type,fare)
VALUES ('Taxi',13);

# Add some Recommendations
INSERT INTO travellors.recommendation(title,creation_date,posting_time,post_rating,tips,description,personal_information,attraction_id,city_id,local_uid,tour_guide_uid,tourist_id)
VALUES ("The Day At The Beach",
		"2020-01-01",
        "19:30:10",
        8,
        "Avoid the snapping seaguls, they are very mean :(",
        "It was a wonderful day at the Miami Beach today.  Sunny sunshine
        and wet water! Got to play beach volleyball, had a hot dog
        at the nearby stand beach stand 10/10 by itself.
        There is one spot at the beach that no one goes to
        and is super peaceful.  We call it the 'seaguls pirate island'
        rummored to be haunted by seaguls.  Most of this is a local myth, but
        there are stories of seaguls following the beach goer back to their
        house.  Quite a scary folk-tale.
        Update: Seagul ate my hot dog :(",
        "",
        1,2,1,1,6);

INSERT INTO travellors.recommendation(title,creation_date,posting_time,post_rating,tips,description,personal_information,attraction_id,city_id,local_uid,tour_guide_uid,tourist_id)
VALUES ("Movie Night",
		"2020-01-01",
        "20:30:10",
        10,
        "The back left row has the best view! Plus direct access to the popcorn.",
        "Whats better than a movie? A drive in movie! This gem has the best of both world;
        the comfortableness and convenience of your own car plus all you can eat popcorn.  This
        is a true gem!",
        "",
        9,2,2,1,7);
        
INSERT INTO travellors.recommendation(title,creation_date,posting_time,post_rating,tips,description,personal_information,attraction_id,city_id,local_uid,tour_guide_uid,tourist_id)
VALUES ("Night at the Museum",
		"2020-02-01",
        "22:30:10",
        10,
        "Watch out for the one of a kind T-rex exhibit straight from Drumheller Canada!",
        "Have you watched night at the museum 2?? We'll if you have, you know that the museum really comes
        to life at night!  So does our speical Miami Louvre!  One of a kind merging of classical counterfeit
        art with ancient pre-historical exhibits!  Fun for the whole family.",
        "",
        6,3,2,4,8);
        
INSERT INTO `travellors`.`recommendation` (`title`, `creation_date`, `posting_time`, `post_rating`, `tips`, `description`, `attraction_id`, `city_id`, `local_uid`, `tour_guide_uid`, `tourist_id`) 
VALUES ('Refreshing Smoothies', 
		'2020-02-01', 
        '18:30:45', 
        '9', 
        'Super refreshing and lots of flavour! The strawberry with milk was the best!', 
        'After a long day at the beach, what\'s better than taking in a cool yummy smoothie?! What are you waiting for? Go get your smoothie!',
        '9', '2', '2', '3', '9');
        
INSERT INTO `travellors`.`recommendation` (`title`, `creation_date`, `posting_time`, `post_rating`, `tips`, `description`, `attraction_id`, `city_id`, `local_uid`, `tour_guide_uid`, `tourist_id`) 
VALUES ('Beach day', '2020-01-01', '22:30:10', '8', 'Lie along the front side to get the most comfty place', 'Beautiful beach and warm water w/ dolphins', '1', '2', '1', '1', '7');

# Add to visit table
INSERT INTO travellors.visit(attraction_id,tourist_uid)
VALUES (1,6);
INSERT INTO travellors.visit(attraction_id,tourist_uid)
VALUES (1,7);
INSERT INTO travellors.visit(attraction_id,tourist_uid)
VALUES (1,8);
INSERT INTO travellors.visit(attraction_id,tourist_uid)
VALUES (1,9);
INSERT INTO travellors.visit(attraction_id,tourist_uid)
VALUES (1,10);
INSERT INTO travellors.visit(attraction_id,tourist_uid)
VALUES (2,7);
INSERT INTO travellors.visit(attraction_id,tourist_uid)
VALUES (3,6);
INSERT INTO travellors.visit(attraction_id,tourist_uid)
VALUES (3,10);
INSERT INTO travellors.visit(attraction_id,tourist_uid)
VALUES (4,9);
INSERT INTO travellors.visit(attraction_id,tourist_uid)
VALUES (5,8);
INSERT INTO travellors.visit(attraction_id,tourist_uid)
VALUES (6,6);
INSERT INTO travellors.visit(attraction_id,tourist_uid)
VALUES (7,7);
INSERT INTO travellors.visit(attraction_id,tourist_uid)
VALUES (7,8);
INSERT INTO travellors.visit(attraction_id,tourist_uid)
VALUES (8,10);
INSERT INTO travellors.visit(attraction_id,tourist_uid)
VALUES (9,6);
INSERT INTO travellors.visit(attraction_id,tourist_uid)
VALUES (9,7);
INSERT INTO travellors.visit(attraction_id,tourist_uid)
VALUES (9,8);
INSERT INTO travellors.visit(attraction_id,tourist_uid)
VALUES (10,10);

# Add values to the rides on table
INSERT INTO travellors.rides_on (transport_uid,tourist_uid,departure_address,distance_travelled,destination_address)
VALUE (1,6,"162 Miami Road SW",30,"9000 Sunset Beach Road");
INSERT INTO travellors.rides_on (transport_uid,tourist_uid,departure_address,distance_travelled,destination_address)
VALUE (1,9,"162 Miami Road SW",30,"9000 Sunset Beach Road");
INSERT INTO travellors.rides_on (transport_uid,tourist_uid,departure_address,distance_travelled,destination_address)
VALUE (1,10,"162 Miami Road SW",30,"9000 Sunset Beach Road");
INSERT INTO travellors.rides_on (transport_uid,tourist_uid,departure_address,distance_travelled,destination_address)
VALUE (2,6,"85 Miami Louvre",30,"80 Palm Parks");
INSERT INTO travellors.rides_on (transport_uid,tourist_uid,departure_address,distance_travelled,destination_address)
VALUE (2,7,"85 Miami Louvre",30,"80 Palm Parks");

# Add values to the identifiaction table
INSERT INTO travellors.identification (local_uid,type_of_identification,identification_file)
VALUES (1,'Drivers License','driverslicense.png');
INSERT INTO travellors.identification (local_uid,type_of_identification,identification_file)
VALUES (2,'Passport','passport.png');
INSERT INTO travellors.identification (local_uid,type_of_identification,identification_file)
VALUES (3,'Birth Ceritficate','birthcertificate.png');
INSERT INTO travellors.identification (local_uid,type_of_identification,identification_file)
VALUES (4,'Proof of Residence','proofOfResidence.png');

# Adding values to places traved table
INSERT INTO travellors.places_travelled (tourist_uid,Name_of_place_travelled)
VALUES (6,'Spain');
INSERT INTO travellors.places_travelled (tourist_uid,Name_of_place_travelled)
VALUES (6,'Peru');
INSERT INTO travellors.places_travelled (tourist_uid,Name_of_place_travelled)
VALUES (6,'Italy');
INSERT INTO travellors.places_travelled (tourist_uid,Name_of_place_travelled)
VALUES (7,'South Africa');
INSERT INTO travellors.places_travelled (tourist_uid,Name_of_place_travelled)
VALUES (8,'Russia');
INSERT INTO travellors.places_travelled (tourist_uid,Name_of_place_travelled)
VALUES (8,'Italy');
INSERT INTO travellors.places_travelled (tourist_uid,Name_of_place_travelled)
VALUES (9,'Peru');

# Adding values to provides deals
INSERT INTO travellors.provides_deals(business_license_number,tourist_uid)
VALUES (1,6);
INSERT INTO travellors.provides_deals(business_license_number,tourist_uid)
VALUES (2,7);
INSERT INTO travellors.provides_deals(business_license_number,tourist_uid)
VALUES (8,9);
INSERT INTO travellors.provides_deals(business_license_number,tourist_uid,deals)
VALUES (5,6, 'BOGO:Buy One Get One');
INSERT INTO travellors.provides_deals(business_license_number,tourist_uid,deals)
VALUES (3,9, 'Buy One Get One 50% off');


# Adding values to book
INSERT INTO travellors.book(tour_guide_id,tourist_uid)
VALUES (1,6);
INSERT INTO travellors.book(tour_guide_id,tourist_uid)
VALUES (2,6);
INSERT INTO travellors.book(tour_guide_id,tourist_uid)
VALUES (3,10);

# RATE TABLE IS EMPTY
#########################
###########################
###########################

# TRAVELS TO TABLE IS ALSO EMPTY
#################################
#################################
################################
