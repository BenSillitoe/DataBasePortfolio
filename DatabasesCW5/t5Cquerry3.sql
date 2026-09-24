/*
Step 3 Advanced (7+ tables)
- Retieves all attendees with VIP tickets whose camping opetions price are above average, 
  while also showing what peroframance, artist, stage and entertainment they plan to attend
- the subquery computes average camping prices, main query filters attendees whose camping cost exceeds it
- Aggregates: AVG
Referances used: https://www.youtube.com/watch?v=nJIEIzF7tDw
https://www.youtube.com/watch?v=0OQJDd3QqQM
*/

SELECT 
a.AttendeeID,
a.FirstName,
a.LastName,
a.Email,
t.TicketID,
topt.TicketType,
topt.Price AS TicketPrice,
copt.OptionType AS CampingOption,
copt.Price AS CampingPrice,
e.Name AS EntertainmentName,
e.Location,
e.Date,
s.Name AS StageName,
art.Name AS ArtistName
FROM Attendee a
JOIN Ticket t ON a.TicketID = t.TicketID
JOIN TicketOption topt ON t.TicketOptionID = topt.TicketOptionID
JOIN CampingOption copt ON t.CampingOptionID = copt.CampingOptionID
JOIN AttendeePlanner ap ON a.PlannerID = ap.PlannerID
JOIN Entertainment e ON ap.EntertainmentID = e.EntertainmentID
JOIN Performance p ON e.PerformanceID = p.PerformanceID
JOIN Stage s ON p.StageID = s.StageID
JOIN Artist art ON p.ArtistID = art.ArtistID
WHERE topt.TicketType = 'VIP'
  AND copt.Price > (
        SELECT AVG(Price)
        FROM CampingOption
    );