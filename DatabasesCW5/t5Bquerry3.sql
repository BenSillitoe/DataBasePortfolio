/*
Step 3 Advanced (7+ tables)
- Retrieves 8 entities from the data base to give a complete picture of the festival artists all the way to the revenue
- Entities used: Artist, performance, stage, entertainment, attendeePlanner, attendee, ticket, ticketoption, camping option
- Logic: links artists to performance and stages, tracks attendee plans and ticket purchese and then finally aggregates attendacne and revenue
- Aggregates: Count(Distinct attendeeID), Count(Distinct TicketID), SUM(Prices)
Refences used: https://www.youtube.com/watch?v=jcoJuc5e3RE
*/

SELECT 
a.Name AS ArtistName,
a.Genre,
s.Name AS StageName,
e.Date AS PerformanceDate,
e.StartTime,
e.EndTime,
COUNT(DISTINCT att.AttendeeID) AS TotalAttendeesPlanning,
COUNT(DISTINCT t.TicketID) AS TicketsSold,
SUM(IFNULL(topt.Price, 0) + IFNULL(co.Price, 0)) AS TotalRevenue
FROM Artist a
JOIN Performance p ON a.ArtistID = p.ArtistID
JOIN Stage s ON p.StageID = s.StageID
JOIN Entertainment e ON p.EntertainmentID = e.EntertainmentID
LEFT JOIN AttendeePlanner ap ON e.EntertainmentID = ap.EntertainmentID
LEFT JOIN Attendee att ON ap.AttendeeID = att.AttendeeID
LEFT JOIN Ticket t ON att.AttendeeID = t.AttendeeID
LEFT JOIN TicketOption topt ON t.TicketOptionID = topt.TicketOptionID
LEFT JOIN CampingOption co ON t.CampingOptionID = co.CampingOptionID
GROUP BY a.ArtistID, a.Name, a.Genre, s.Name, e.Date, e.StartTime, e.EndTime
ORDER BY TotalRevenue DESC;