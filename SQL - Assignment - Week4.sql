drop schema if exists Org;
create schema Org;
use Org;

-- Create EmpMaster

DROP TABLE IF EXISTS EmpMaster;

CREATE TABLE EmpMaster
(
  Emp_id int PRIMARY KEY,
  Emp_Name varchar(50) NOT NULL,
  Emp_Title varchar(50) NOT NULL,
  Emp_Supervisor int
);

-- Insert records into the EmpMaster table

INSERT INTO EmpMaster (Emp_id, Emp_Name, Emp_Title, Emp_Supervisor) VALUES (101,'Steve Jobs','CEO',Null);
INSERT INTO EmpMaster (Emp_id, Emp_Name, Emp_Title, Emp_Supervisor) VALUES (201,'Craig Federighi','VP, Mac software Engineering',101);
INSERT INTO EmpMaster (Emp_id, Emp_Name, Emp_Title, Emp_Supervisor) VALUES (202,'Eddy Cue','VP, Internet Services',101);
INSERT INTO EmpMaster (Emp_id, Emp_Name, Emp_Title, Emp_Supervisor) VALUES (301,'Bud Tribble','Manager, software Technology',201);
INSERT INTO EmpMaster (Emp_id, Emp_Name, Emp_Title, Emp_Supervisor) VALUES (302,'Simon Patience','Manager, Core OS',201);
INSERT INTO EmpMaster (Emp_id, Emp_Name, Emp_Title, Emp_Supervisor) VALUES (303,'Max Paley','Manager, Audio / Video',202);
INSERT INTO EmpMaster (Emp_id, Emp_Name, Emp_Title, Emp_Supervisor) VALUES (304,'Jeff Robbin','Manager, Consumer Apps',202);
INSERT INTO EmpMaster (Emp_id, Emp_Name, Emp_Title, Emp_Supervisor) VALUES (203,'Amy Bayes','Personal Assistant',101);
INSERT INTO EmpMaster (Emp_id, Emp_Name, Emp_Title, Emp_Supervisor) VALUES (305,'Maggie Chow','Personal Assistant',201);
INSERT INTO EmpMaster (Emp_id, Emp_Name, Emp_Title, Emp_Supervisor) VALUES (306,'Vince Arti','Personal Assistant',202);

Select a.Emp_id as "Employee ID", a.Emp_name as "Name", a.Emp_Title as "Designation", b.Emp_name as "Manager's Name" 
from EmpMaster a 
Left join EmpMaster b on a.Emp_Supervisor = b.Emp_id
order by a.Emp_Supervisor;

Select a.*, c.Group_name from Rooms a
left join Group_Rooms b on a.Room_id = b.Room_id
left join Groups c on b.group_id = c.group_id ;

-- A list of users, the groups that they belong to, and the rooms to which they are assigned. This should be sorted alphabetically by user, then by group, then by room.

Select a.User_id, a.User_name, b.Group_name, d.Room_name from Users a
left join Groups b on a.group_id = b.group_id
left join Group_Rooms c on b.group_id = c.Group_id
left join Rooms d on c.room_id = d.room_id
order by a.User_name, b.Group_name, d.Room_name;
