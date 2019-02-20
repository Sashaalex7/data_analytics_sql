
CREATE TABLE
unique_placeid  (
placeID INT UNIQUE NOT NULL,
PRIMARY KEY (placeID)
)
;
psql -U postgres -c"\copy unique_placeid FROM '/usr/local/share/netology/slq/unic_placeid.csv' DELIMITER ',' CSV HEADER";


CREATE TABLE
unique_userid (
userID INT UNIQUE NOT NULL,
PRIMARY KEY (userID)
)
;
psql -U postgres -c"\copy unique_userid FROM '/usr/local/share/netology/slq/unic_userid.csv' DELIMITER ',' CSV HEADER";

CREATE TABLE
Сuisine  (
placeID INT references unique_placeid (placeID),
Сuisine VARCHAR
)
;
psql -U postgres -c"\copy Сuisine FROM '/usr/local/share/netology/slq/chefmozcuisine.csv' DELIMITER ',' CSV HEADER";




CREATE TABLE
Payment  (
placeID INT references unique_placeid (placeID),
payment VARCHAR
)
;
psql -U postgres -c"\copy Payment FROM '/usr/local/share/netology/slq/chefmozaccepts.csv' DELIMITER ',' CSV HEADER";



CREATE TABLE
User_Сuisine  (
userID INT references unique_userid (userID),
cuisine VARCHAR
)
;
psql -U postgres -c"\copy User_Сuisine FROM '/usr/local/share/netology/slq/usercuisine.csv' DELIMITER ',' CSV HEADER";






CREATE TABLE
Geoplaces  (
placeID INT references unique_placeid (placeID),
name VARCHAR,
alcohol VARCHAR,
smoking_area VARCHAR,
dress_code VARCHAR,
accessibility VARCHAR,
price VARCHAR,
Rambience VARCHAR,
franchise VARCHAR
)
;


psql -U postgres -c"\copy Geoplaces FROM '/usr/local/share/netology/slq/rest2.csv' DELIMITER ',' CSV HEADER";



CREATE TABLE
User_consumer  (
userID INT references unique_userid (userID),
drink_level VARCHAR,
dress_preference VARCHAR,
ambience VARCHAR,
hijos VARCHAR,
interest VARCHAR,
personality VARCHAR,
religion VARCHAR,
activity VARCHAR,
budget VARCHAR
)
;
psql -U postgres -c"\copy User_consumer FROM '/usr/local/share/netology/slq/user2.csv' DELIMITER ',' CSV HEADER";


CREATE TABLE
Rating  (
userID INT references unique_userid (userID),
placeID INT references unique_placeid (placeID),
rating INT,
food_rating INT,
service_rating INT
)
;


psql -U postgres -c"\copy Rating FROM '/usr/local/share/netology/slq/rating_final.csv' DELIMITER ',' CSV HEADER";




