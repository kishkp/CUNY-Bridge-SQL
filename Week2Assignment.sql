drop schema if exists Video_Reviews;
create schema Video_Reviews;
use Video_Reviews;

DROP TABLE IF EXISTS Videos;
DROP TABLE IF EXISTS Reviews;

-- Create the Videos table

CREATE TABLE Videos
(
  Video_id int PRIMARY KEY,
  Title varchar(50) NOT NULL,
  ViewLength numeric(5,2) ,
  URL varchar(200) NOT NULL
);

-- Insert records into the Videos table

INSERT INTO Videos (Video_id, Title, ViewLength, URL) VALUES (1, '10 Future Technologies That Will Change The World', 10.42, 'https://www.youtube.com/watch?v=lMymFYJWW5M');
INSERT INTO Videos (Video_id, Title, ViewLength, URL) VALUES (2, '10 Extinct Animals That May Still Be Alive', 10.39, 'https://www.youtube.com/watch?v=J0SJorLJSh8');
INSERT INTO Videos (Video_id, Title, ViewLength, URL) VALUES (3, '10 Lost Cities That Have Been Found', 9.20, 'https://www.youtube.com/watch?v=YjEQLm87kBo');

select * from Videos;

-- Create the Reviews table

CREATE TABLE Reviews
(
  Review_id int PRIMARY KEY,
  Reviewer varchar(50),
  Rating int,
  Review varchar(100),
  Video_id int references Videos(Video_id)
);

-- Insert records into the Reviews table

INSERT INTO Reviews (Review_id, Reviewer, Rating, Review, Video_id) VALUES ( 1, 'Anne', 1, 'Not worth watching', 1);
INSERT INTO Reviews (Review_id, Reviewer, Rating, Review, Video_id) VALUES ( 2, 'Bob', 5, 'Interesting concepts!!', 1);
INSERT INTO Reviews (Review_id, Reviewer, Rating, Review, Video_id) VALUES ( 3, 'Ravi', 3, 'Not too bad', 1);

INSERT INTO Reviews (Review_id, Reviewer, Rating, Review, Video_id) VALUES ( 4, 'Martha',4, 'This was good', 2);
INSERT INTO Reviews (Review_id, Reviewer, Rating, Review, Video_id) VALUES ( 5, 'Bob', NULL, 'Not even worth rating this', 2);
INSERT INTO Reviews (Review_id, Reviewer, Rating, Review, Video_id) VALUES ( 6, 'Matt', 4, 'Good video', 2);

INSERT INTO Reviews (Review_id, Reviewer, Rating, Review, Video_id) VALUES ( 7, 'Ravi', 2, 'I liked the first couple of minutes', 3);
INSERT INTO Reviews (Review_id, Reviewer, Rating, Review, Video_id) VALUES ( 8, 'Bob', 4, 'This is awesome!!!', 3);
INSERT INTO Reviews (Review_id, Reviewer, Rating, Review, Video_id) VALUES ( 9, 'Ravi', NULL, 'Amazing video!!', 3);


-- Select all videos along with their ratings

SELECT v.*, r.Review_id, r.Reviewer, r.Rating, r.Review
  FROM Videos v INNER JOIN Reviews r ON v.video_id = r.video_id;

-- Generate a cross product of both tables

SELECT v.*, r.Review_id, r.Reviewer, r.Rating, r.Review
  FROM Videos v CROSS JOIN Reviews r ;

  
  
  

