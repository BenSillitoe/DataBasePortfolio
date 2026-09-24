/*
Task 5B - Queries with multi-row functions and grouping 
*/

/* 
Step 1 Basic (1 table)
- Retrieves the number of artists and presents those artists by genre and the number of artists per genre
- Entities used: Artist
- Artists are grouped by genre and count is applied per group
- Aggregates: count(*)
*/

SELECT Genre, COUNT(*) AS NumberOfArtists
FROM Artist
GROUP BY Genre;