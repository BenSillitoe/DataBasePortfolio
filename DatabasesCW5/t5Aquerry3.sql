/*
Step 3 - Advanced (7+ tables)
- this query will take a performance, and show its stage name, artist name, genre of the artist, location, start time and end time
  as well as showing the totle number of attendees at that performance, total number of tickets and when the first and last ticket was bought.
- Entities performace, stage, artist, entertainment, attendee and ticket are all used
- Logic: Each performace is linked to its stage, artist, and entertainment scheduale, attendeeplanner connects attendees to panned entertainment,
  tickets are joined to determine sales and purchise times
- count, total unqie attendees, count, total tickets sold, min, first ticket purchised, max, last ticket sold
*/

select 
Performance.PerformanceID,
Stage.name as StageName,
Artist.name as ArtistName,
Artist.genre,
Entertainment.date,
Entertainment.location,
Entertainment.starttime,
Entertainment.endtime,
count(distinct Attendee.attendeeID) as TotalAttendees,
count(distinct Ticket.ticketID) as TotalTickets,
min(Ticket.purchasedate) as FirstTicket,
max(Ticket.purchasedate) as LastTicket
from Performance
inner join Stage on Performance.stageID = Stage.stageID
inner join Artist on Performance.artistID = Artist.artistID
inner join Entertainment on Performance.entertainmentID = Entertainment.entertainmentID
inner join AttendeePlanner on Entertainment.plannerID = AttendeePlanner.plannerID
inner join Attendee on AttendeePlanner.attendeeID = Attendee.attendeeID
inner join Ticket on Attendee.ticketID = Ticket.ticketID
group by Performance.PerformanceID, Stage.name, Artist.name, Artist.genre, Entertainment.date, Entertainment.location, Entertainment.starttime, Entertainment.endtime;
