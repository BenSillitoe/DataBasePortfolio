/* 
Step 2 Intermediate (2-3 tables)
- Retrieves all stages taht host performances longer than average performance duration
- Subquery calculates the benchmark duration, and HAVING compares grouped resluts against it
Referance used: https://www.youtube.com/watch?v=rn6AHdrfg0M
*/

SELECT s.StageID,
s.Name AS StageName,
TIMESTAMPDIFF(MINUTE, e.StartTime, e.EndTime) AS DurationMinutes
FROM Stage s
JOIN Performance p ON s.StageID = p.StageID
JOIN Entertainment e ON p.EntertainmentID = e.EntertainmentID
GROUP BY s.StageID, s.Name, e.StartTime, e.EndTime
HAVING DurationMinutes > (
    SELECT AVG(TIMESTAMPDIFF(MINUTE, StartTime, EndTime))
    FROM Entertainment
    WHERE EntertainmentType = 'Performance'