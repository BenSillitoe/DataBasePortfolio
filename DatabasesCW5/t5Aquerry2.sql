/*
Step 2 - Intermediate (2-3 tables)
- this counts performacnes by stage
- Entites used: stage, performace, artist
- Each stage is joined to perforamance, but sorted onto what performance is hosted by waht stage
- aggregates: count, to count performances per stage, and Group_Concat, aggregates multiple names into a single list
- Outcome expected: One row per stage showing; name, num of perforamances, and arts performing on that stage
Referance used: https://www.w3schools.com/sql/sql_groupby.asp?utm_source=chatgpt.com
*/

SELECT 
	Stage.Name AS StageName,
    COUNT(Performance.PerformanceID) AS TotalPerformances,
    GROUP_CONCAT(Artist.Name) AS Artists
FROM Stage
INNER JOIN Performance ON Stage.StageID = Performance.StageID
INNER JOIN Artist ON Performance.ArtistID = Artist.ArtistID
GROUP BY Stage.Name;