-- 1. Which destination in the flights database is the furthest distance away, based on information in the flights table. Show the SQL query(s) that support your conclusion.

select distinct flight, origin, dest, distance from flights.flights where distance in (select max(distance) from flights.flights) ;

-- 2. What are the different numbers of engines in the planes table? For each number of engines, which aircraft have the most number of seats? Show the SQL statement(s) that support your result.

select engines, max(seats) from flights.planes group by engines;


-- 3. Show the total number of flights.

select count(*) from flights;

-- 4. Show the total number of flights by airline (carrier).

select carrier, count(*) from flights group by carrier;

-- 5. Show all of the airlines, ordered by number of flights in descending order.

select carrier, count(*) as FlightCount from flights group by carrier order by FlightCount desc;

-- 6. Show only the top 5 airlines, by number of flights, ordered by number of flights in descending order.

select carrier, count(*) as FlightCount from flights group by carrier order by FlightCount desc limit 5;

-- 7. Show only the top 5 airlines, by number of flights of distance 1,000 miles or greater, ordered by number of flights in descending order.

select carrier, count(*) as FlightCount from flights where distance	>=1000 group by carrier order by FlightCount desc limit 5 ;

-- 8. Create a question that (a) uses data from the flights database, and (b) requires aggregation to answer it, and write down both the question, and the query that answers the question.

-- Question : Show only the top 5 airlines, by number of flights in the month of november, ordered by number of flights in descending order.

select carrier, count(*) as FlightCount from flights where month=11 group by carrier order by FlightCount desc limit 5 ;
-- 