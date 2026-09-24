/*
Step 2 Intermediate (2-3 tables)
- Retrieves the total ticket revenue per customer (attendee)
- Entites used: Attendee, Ticket, Ticket Option, Camping Option
- Attendees are joined to tickets, ticket options and camping options contribute to total price, Left join ensures attendees without extras are still included.
- Aggregates: Count - tickets booked, SUM - total spent 
referance used: https://www.w3schools.com/sql/sql_join.asp?utm_source=chatgpt.com
*/

SELECT a.FirstName,
a.LastName,
COUNT(t.TicketID) AS TicketsBooked,
SUM(topt.Price + IFNULL(co.Price, 0)) AS TotalSpent
FROM Attendee a
JOIN Ticket t ON a.AttendeeID = t.AttendeeID
LEFT JOIN TicketOption topt ON t.TicketOptionID = topt.TicketOptionID
LEFT JOIN CampingOption co ON t.CampingOptionID = co.CampingOptionID
GROUP BY a.AttendeeID, a.FirstName, a.LastName;
