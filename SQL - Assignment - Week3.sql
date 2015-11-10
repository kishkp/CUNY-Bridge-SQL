drop schema if exists Room_Access;
create schema Room_Access;
use Room_Access;

DROP TABLE IF EXISTS Groups;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Rooms;
DROP TABLE IF EXISTS Group_Rooms;

-- Create Groups

CREATE TABLE Groups
(
  Group_id int PRIMARY KEY,
  Group_name varchar(50) NOT NULL
);

-- Insert records into the Groups table
INSERT INTO Groups (Group_id, Group_Name) VALUES (1, 'I.T.');
INSERT INTO Groups (Group_id, Group_Name) VALUES (2, 'Sales');
INSERT INTO Groups (Group_id, Group_Name) VALUES (3, 'Administration');
INSERT INTO Groups (Group_id, Group_Name) VALUES (4, 'Operations');

-- Create the Users table

CREATE TABLE Users
(
  User_id int PRIMARY KEY,
  User_name varchar(50) NOT NULL,
  Group_id int references Groups(Group_id)
);

-- Insert records into the Users table

INSERT INTO Users (User_id, User_Name, Group_id) VALUES (1, 'Modesto', 1);
INSERT INTO Users (User_id, User_Name, Group_id) VALUES (2, 'Ayine', 1);

INSERT INTO Users (User_id, User_Name, Group_id) VALUES (3, 'Christopher', 2);
INSERT INTO Users (User_id, User_Name, Group_id) VALUES (4, 'Cheong woo', 2);

INSERT INTO Users (User_id, User_Name, Group_id) VALUES (5, 'Saulat', 3);
INSERT INTO Users (User_id, User_Name, Group_id) VALUES (6, 'Heidy', null);

-- Create Rooms

CREATE TABLE Rooms
(
  Room_id int PRIMARY KEY,
  Room_name varchar(50) NOT NULL
);

-- Insert records into the Rooms table

INSERT INTO Rooms (Room_id, Room_Name) VALUES (1, '101');
INSERT INTO Rooms (Room_id, Room_Name) VALUES (2, '102');
INSERT INTO Rooms (Room_id, Room_Name) VALUES (3, 'Auditorium A');
INSERT INTO Rooms (Room_id, Room_Name) VALUES (4, 'Auditorium B');


-- Create the Group Rooms

CREATE TABLE Group_Rooms
(
  Group_id int references Groups(Group_id),
  Room_id int references Rooms(Room_id)
);

-- Insert records into the Group Rooms table

INSERT INTO Group_Rooms (Group_id, Room_id) VALUES (1, 1);
INSERT INTO Group_Rooms (Group_id, Room_id) VALUES (1, 2);

INSERT INTO Group_Rooms (Group_id, Room_id) VALUES (2, 2);
INSERT INTO Group_Rooms (Group_id, Room_id) VALUES (2, 3);


-- All groups, and the users in each group. A group should appear even if there are no users assigned to the group.

Select a.*, b.User_name from Groups a
left join users b on a.group_id = b.group_id;


-- All rooms, and the groups assigned to each room. The rooms should appear even if no groups have been assigned to them.

Select a.*, c.Group_name from Rooms a
left join Group_Rooms b on a.Room_id = b.Room_id
left join Groups c on b.group_id = c.group_id ;

-- A list of users, the groups that they belong to, and the rooms to which they are assigned. This should be sorted alphabetically by user, then by group, then by room.

Select a.User_id, a.User_name, b.Group_name, d.Room_name from Users a
left join Groups b on a.group_id = b.group_id
left join Group_Rooms c on b.group_id = c.Group_id
left join Rooms d on c.room_id = d.room_id
order by a.User_name, b.Group_name, d.Room_name;
