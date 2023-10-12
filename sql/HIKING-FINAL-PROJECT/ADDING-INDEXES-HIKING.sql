-- this script adds indexes to tables 

-- set the correct schema
USE hiking;

-- set autocommit to 0
SET AUTOCOMMIT= 0;

-- start new transaction to add indexes to tables
START TRANSACTION;

-- adding an index on the difficulty column in the trail table
ALTER TABLE trail
ADD INDEX difficulty_idx (difficulty);

-- adding a unique index to the name column in the park table so duplicates can not be added
ALTER TABLE parks
ADD UNIQUE INDEX name_idx (name);

-- adding an index to state for queries sorting by state data in the location table
ALTER TABLE location
ADD INDEX state_idx (state);

COMMIT;

	


