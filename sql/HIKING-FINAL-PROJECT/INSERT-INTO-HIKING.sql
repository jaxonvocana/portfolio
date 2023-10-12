-- this script will insert data into the hike schema

-- set the database to the correct schema
USE hiking;

-- setting auto commit to 0
SET AUTOCOMMIT= 0;

-- start transaction to insert data into tables
START TRANSACTION;

-- insert into Elevation Query
INSERT INTO elevation(elevation_feet)
VALUES 
  (1000)
, (2000);


-- insert into Map Query
INSERT INTO map(map_name, map_image)
VALUES 
  ('yellowstone', 'yellowstonemap.jpg')
, ('teton', 'teton.jpg');


-- insert into Location Query
INSERT INTO location (city, state, zip, map_map_id)
VALUES
  ('Yellowstone','Montana', 83440, 1)
, ('Teton','Wyoming', 83440, 2);



-- insert into Park Query
INSERT INTO parks (name, map_map_id, location_location_id)
VALUES
  ('Yellowstone', 1, 1)
, ('Teton', 1, 1);


-- insert into Terrain Query
INSERT INTO terrain (terrain_type)
VALUES
  ('mountainous')
, ('rocky');


-- insert into Trail query
INSERT INTO trail (trail_name, distance_mile, distance_kilo, difficulty, map_map_id, terrain_terrain_id, elevation_elevation_id, parks_park_id, location_location_id)
VALUES
  ('Old faithful', 1, 2, 'easy', 1, 1, 1, 1, 1)
, ('Jackson Pass', 3, 5, 'hard', 2, 2, 2, 2, 2);

COMMIT;

