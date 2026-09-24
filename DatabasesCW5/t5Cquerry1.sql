/*
Step 1 Basic (1 table)
- Retrieves entertainment events longer than average duration
- The subquery computes the average duration, main query fiters events longer than that value
referances used: https://www.youtube.com/watch?v=nJIEIzF7tDw
*/

SELECT Name, 
Location, 
Date,
TIMEDIFF(EndTime, StartTime) AS Duration
FROM Entertainment
WHERE TIMEDIFF(EndTime, StartTime) > 
(SELECT AVG(TIMEDIFF(EndTime, StartTime)) FROM Entertainment);