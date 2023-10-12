





-- group by star rating average to show highest and lowest rating trails 
SELECT AVG(r.star_rating) as avg_rating
, p.name as park_name
, t.trail_name as trail_name
FROM review r INNER JOIN trail t ON
t.trail_id = r.trail_trail_id INNER JOIN parks p ON
p.park_id = r.parks_park_id
GROUP BY t.trail_id;

-- setting auto commit to 0
SET AUTOCOMMIT= 0;

-- start transaction to insert data into tables
START TRANSACTION;

-- insert into Elevation Query
INSERT INTO elevation(elevation_feet)
VALUES 
  (1000)
, (2000);

-- insert into wildlife query
INSERT INTO wildlife (animal_name, animal_type, commonality, danger_level, trail_trail_id)
VALUES 
  ('deer', 'mammal', 'common', 0, 1)
, ('moose', 'mammal', 'less common', 4, 1)
, ('black bear', 'mammal', 'depends', 5, 1)
, ('Grizzly bear', 'mammal', 'depends', 5, 1)
, ('bald eagle', 'bird', 'fairly common', 2, 1)
, ('bison', 'mammal', 'fairly common', 4, 1)
, ('rattle snake', 'snake', 'fairly common', 5, 1);

-- insert into Map Query
INSERT INTO map(map_name, map_image)
VALUES 
  ('yellowstone', 'yellowstonemap.jpg')
, ('teton', 'teton.jpg');


-- insert into Location Query
INSERT INTO location (city, state, zip, map_map_id, trail_trail_id)
VALUES
  ('Yellowstone','Montana', 83440, 1, 1)
, ('Teton','Wyoming', 83440, 2, 2);



-- insert into Park Query
INSERT INTO parks (name, map_map_id, trail_trail_id)
VALUES
  ('Yellowstone', 1, 1)
, ('Teton', 1, 1);


-- insert into Terrain Query
INSERT INTO terrain (terrain_type)
VALUES
  ('mountainous')
, ('rocky');


-- insert into Trail query
INSERT INTO location (trail_name, distance_mile, distance_kilo, difficulty, map_map_id, terrain_terrain_id, elevation_elevation_id)
VALUES
  ('Old faithful', 1, 2, 'easy', 1, 1, 1)
, ('Jackson Pass', 3, 5, 'hard', 2, 2, 2);

COMMIT;


-- start new transaction to add indexes to tables
START TRANSACTION;

-- adding an index on the difficulty column in the trail table
ALTER TABLE trail
ADD INDEX difficulty_idx (difficulty);

-- adding a unique index to the name column in the park table so duplicates can not be added
ALTER TABLE parks
ADD UNIQUE INDEX name_idx (name);

COMMIT;

SELECT  t.trail_name AS 'Trail Name'
,		t.distance_mile AS 'Length'
,		t.difficulty AS 'Difficulty'
,		


desc trail;