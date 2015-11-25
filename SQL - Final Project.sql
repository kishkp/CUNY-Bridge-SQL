-- 1. create a new database called BuildingEnergy. The SQL script should be self-contained, such that if it runs again it will re-create the database.

drop schema if exists BuildingEnergy;
create schema BuildingEnergy;
use BuildingEnergy;

-- 2. You should first create two tables, EnergyCategories and EnergyTypes.
-- • Populate the EnergyCategories table with rows for Fossil and Renewable.
-- • Populate the EnergyTypes table with rows for Electricity, Gas, Steam, Fuel Oil, Solar, and Wind.
-- • In the EnergyTypes table, you should indicate that Electricity, Gas, Steam, and Fuel Oil are Fossil 
-- energy sources, while Solar and Wind are renewable energy sources.
-- When inserting data into the tables, be sure to use an INSERT statement and not the table import wizard.

DROP TABLE IF EXISTS EnergyCategories;
CREATE TABLE EnergyCategories
(
  EnerCat_id int PRIMARY KEY,
  EnerCat varchar(50) NOT NULL
);

DROP TABLE IF EXISTS EnergyTypes;
CREATE TABLE EnergyTypes
(
  EnerType_id int PRIMARY KEY,
  EnerType varchar(50) NOT NULL,
  EnerCat_id int references EnergyCategories(EnerCat_id)
);

INSERT INTO EnergyCategories (EnerCat_id, EnerCat) VALUES (1, 'Fossil');
INSERT INTO EnergyCategories (EnerCat_id, EnerCat) VALUES (2, 'Renewable');

INSERT INTO EnergyTypes (EnerType_id, EnerType, EnerCat_id) VALUES (1, 'Electricity', 1);
INSERT INTO EnergyTypes (EnerType_id, EnerType, EnerCat_id) VALUES (2, 'Gas', 1);
INSERT INTO EnergyTypes (EnerType_id, EnerType, EnerCat_id) VALUES (3, 'Steam', 1);
INSERT INTO EnergyTypes (EnerType_id, EnerType, EnerCat_id) VALUES (4, 'Fuel Oil', 1);
INSERT INTO EnergyTypes (EnerType_id, EnerType, EnerCat_id) VALUES (5, 'Solar', 2);
INSERT INTO EnergyTypes (EnerType_id, EnerType, EnerCat_id) VALUES (6, 'Wind', 2);

-- 3. Write a JOIN statement that shows the energy categories and associated energy types that you entered. 

Select b.EnerCat as 'EnergyCategory', a.EnerType as 'EnergyType' 
from EnergyTypes a 
Left join EnergyCategories b on a.EnerCat_id = b.EnerCat_id
order by b.EnerCat;

-- 4. You should add a table called Buildings. There should be a many-to-many relationship between Buildings 
-- and EnergyTypes. Here is the information that should be included about buildings in the database:
-- • Empire State Building; Energy Types: Electricity, Gas, Steam
-- • Chrysler Building; Energy Types: Electricity, Steam
-- • Borough of Manhattan Community College; Energy Types: Electricity, Steam, Solar

DROP TABLE IF EXISTS Buildings;
CREATE TABLE Buildings
(
  Build_id int PRIMARY KEY,
  Build_name varchar(50) NOT NULL
);

INSERT INTO Buildings (Build_id, Build_name) VALUES (1, 'Empire State Building');
INSERT INTO Buildings (Build_id, Build_name) VALUES (2, 'Chrysler Building');
INSERT INTO Buildings (Build_id, Build_name) VALUES (3, 'Borough of Manhattan Community College');

DROP TABLE IF EXISTS Buildings_EnergyTypes;
CREATE TABLE Buildings_EnergyTypes
(
  Build_id int references Buildings(Build_id),
  EnerType_id int references EnergyTypes(EnerType_id)
);

INSERT INTO Buildings_EnergyTypes (Build_id, EnerType_id) VALUES (1, 1);
INSERT INTO Buildings_EnergyTypes (Build_id, EnerType_id) VALUES (1, 2);
INSERT INTO Buildings_EnergyTypes (Build_id, EnerType_id) VALUES (1, 3);

INSERT INTO Buildings_EnergyTypes (Build_id, EnerType_id) VALUES (2, 1);
INSERT INTO Buildings_EnergyTypes (Build_id, EnerType_id) VALUES (2, 3);

INSERT INTO Buildings_EnergyTypes (Build_id, EnerType_id) VALUES (3, 1);
INSERT INTO Buildings_EnergyTypes (Build_id, EnerType_id) VALUES (3, 3);
INSERT INTO Buildings_EnergyTypes (Build_id, EnerType_id) VALUES (3, 5);

-- 5. Write a JOIN statement that shows the buildings and associated energy types for each building.

Select a.Build_name as 'Building', c.EnerType as 'EnergyType' 
from Buildings a 
Left join Buildings_EnergyTypes b on a.Build_id = b.Build_id
Left join EnergyTypes c on b.EnerType_id = c.EnerType_id;

-- 6. Please add this information to the BuildingEnergy database, inserting rows as needed in various tables.
-- Building: Bronx Lion House; Energy Types: Geothermal
-- Brooklyn Childrens Museum: Energy Types: Electricity, Geothermal

INSERT INTO Buildings (Build_id, Build_name) VALUES (4, 'Bronx Lion House');
INSERT INTO Buildings (Build_id, Build_name) VALUES (5, 'Brooklyn Childrens Museum');

INSERT INTO EnergyTypes (EnerType_id, EnerType, EnerCat_id) VALUES (7, 'Geothermal', 2);

INSERT INTO Buildings_EnergyTypes (Build_id, EnerType_id) VALUES (4, 7);
INSERT INTO Buildings_EnergyTypes (Build_id, EnerType_id) VALUES (5, 1);
INSERT INTO Buildings_EnergyTypes (Build_id, EnerType_id) VALUES (5, 7);

-- 7. Write a SQL query that displays all of the buildings that use Renewable Energies.

Select d.Build_name as 'Building', b.EnerType as 'Energy Type', a.EnerCat as 'Energy Category' from EnergyCategories as a 
Left join EnergyTypes as b on a.EnerCat_id = b.EnerCat_id
Right Join Buildings_EnergyTypes as c on b.EnerType_id = c.EnerType_id 
Left Join Buildings as d on c.Build_id = d.Build_id
where a.EnerCat = 'Renewable';

-- 8. Write a SQL query that shows the frequency with which energy types are used in various buildings.

Select c.EnerType as 'EnergyType', count(*) as 'Frequency' 
from Buildings a 
Left join Buildings_EnergyTypes b on a.Build_id = b.Build_id
Left join EnergyTypes c on b.EnerType_id = c.EnerType_id
Group By c.EnerType
Order By count(*) Desc;

-- 9. Do one (or more if you want!) of the following. 9(c) and 9(d) are both challenging
-- you are especially encouraged to work on in a group if you tackle one or both of these exercises!
-- a. Create the appropriate foreign key constraints.
-- Ans: DONE in the respective Create statements !!!

-- b. Create an entity relationship (ER) diagram for the tables in the database. 
-- You can sketch this by hand and include a photo or scan if you wish.
-- Ans: Included in Word attachment

-- c. Suppose you wanted to design a set of HTML pages to manage (add, edit, and delete) the information 
-- in the various database tables; create a mockup of the user interface (on paper or using a package like Balsamiq Mockups).
-- Ans: Included in Word attachment

-- d. Suppose you want to track changes over time in energy type preferences in New York City buildings. 
-- What information should you add to each table? What might a report that shows the trends over time look like?

-- Ans: There are multiple ways of doing this. It depends on whether we need to store detailed information. 

-- One option is to store the preferences of the building every year. So in this table we will have Year, Build_id 
-- and EnerType_id. We can then use this table to generate summary statistics for the Year and EnerType. We can then use
-- the Year and EnerType frequency to generate a trend line for the various years. 

-- The other option is to store the year and summary statistic as a table by itself. So in this table, we will have 
-- Year, EnergyType, Frequency as columns. Again as in the above option, we can use this table to generate a trend.
