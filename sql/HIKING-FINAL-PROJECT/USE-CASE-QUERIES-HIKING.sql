-- this script contains queries that read data from the database

-- set the correct schema
USE hiking;

-- shows general information about the trail based on what state it is in
SELECT  t.trail_name AS 'Trail Name'
,		t.distance_mile AS 'Length'
,		t.difficulty AS 'Difficulty'
,		p.name AS 'Park name'

FROM	trail t INNER JOIN parks p 
ON		t.parks_park_id = p.park_id INNER JOIN location l
ON		t.location_location_id = l.location_id 
WHERE 	l.state = '<state placeholder>';


-- shows trails in a certain park and returns the easiest trails
/* possible use case: filtering out trails you would like to go to but filter out the difficulty
		based on your skill level. Can be used to plan trips by showing all or some states.
*/
SELECT  t.trail_name AS 'Trail Name'
,		t.distance_mile AS 'Length'
,		t.difficulty AS 'Difficulty'
,		l.state AS 'State'
,		p.name AS 'Park'
FROM	trail t INNER JOIN location l 
ON		t.location_location_id = l.location_id INNER JOIN parks p
ON		t.parks_park_id = p.park_id 
WHERE 	t.difficulty = '<difficulty placeholder>' AND l.state = '<state placeholder>';

-- shows the sum of easy and hard trails grouped by each park.
/* possible use case: be able to show users the balance of the difficulty of hikes in different parks. 
		This would be useful if a family were to go on a trip, easier trails would be better for them,
        helping them avoid parks with more difficult trails
*/
SELECT  p.name AS Park_name
,		SUM(CASE WHEN difficulty = 'easy' THEN 1 ELSE 0 END) Easy_trails
,		SUM(CASE WHEN difficulty = 'hard' THEN 1 ELSE 0 END) Hard_trails
FROM    parks p INNER JOIN trail t
ON		t.parks_park_id = p.park_id
GROUP BY p.name;
		

