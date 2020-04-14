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

