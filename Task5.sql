-- dropping tables just incase already in schema
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS Performance;
DROP TABLE IF EXISTS NonMusicalEntertainment;
DROP TABLE IF EXISTS AttendeePlanner;
DROP TABLE IF EXISTS Ticket;
DROP TABLE IF EXISTS Attendee;
DROP TABLE IF EXISTS TicketOption;
DROP TABLE IF EXISTS CampingOption;
DROP TABLE IF EXISTS Artist;
DROP TABLE IF EXISTS Stage;
DROP TABLE IF EXISTS Entertainment;
SET FOREIGN_KEY_CHECKS = 1;

-- stage table
Create table Stage (
	StageID int primary key auto_increment,
    Name VarChar(100) Not Null,
    PerformanceID int
);

-- artist table
Create Table Artist (
	ArtistID int primary key auto_increment,
    Name VarChar(100) Not Null,
    Genre VarChar(100) Not Null,
    ProfileDescription LongText Not Null,
    PerformanceID int
);

-- entertainment table
Create Table Entertainment (
	EntertainmentID int primary key auto_increment,
    EntertainmentType VarChar(100) Not Null,
    Name VarChar(100) Not Null,
    Location VarChar(100) not null,
    Date Date not null,
    StartTime Time not null,
    EndTime time not null,
    PerformanceID int null,
    PlannerID int,
    NonMusicalEntertainmentID int null
);

-- performance table
Create table Performance (
	PerformanceID int primary key auto_increment,
    EntertainmentID int,
    ArtistID int,
    StageID int,
    foreign key (EntertainmentID) references Entertainment(EntertainmentID) ON UPDATE CASCADE ON DELETE CASCADE,
    foreign key (ArtistID) references Artist(ArtistID) ON UPDATE CASCADE ON DELETE CASCADE,
    foreign key (StageID) references Stage(StageID) ON UPDATE CASCADE ON DELETE CASCADE
);

-- non musical entertainment table
Create Table NonMusicalEntertainment (
	NonMusicalEntertainmentID int primary key auto_increment,
    Type VarChar(100) not null,
    EntertainmentID int null,
    foreign key (EntertainmentID) references Entertainment(EntertainmentID) ON UPDATE CASCADE ON DELETE CASCADE
);

-- attendee planner table
Create Table AttendeePlanner (
	PlannerID int primary key auto_increment,
    EntertainmentID int,
    AttendeeID int,
    foreign key (EntertainmentID) references Entertainment(EntertainmentID) ON UPDATE CASCADE ON DELETE CASCADE
);

-- attendee table
Create table Attendee (
	AttendeeID int primary key auto_increment,
    FirstName VarChar(100) not null,
    LastName VarChar(100) not null,
    Email VarChar(100) null,
    ContactNumber VarChar(15) null,
    PlannerID int,
    TicketID int,
    foreign key (PlannerID) references AttendeePlanner(PlannerID) ON UPDATE CASCADE ON DELETE SET NULL
);

-- ticket table
Create table Ticket (
	ticketID int primary key auto_increment,
    PurchaseDate datetime not null,
    AttendeeID int,
    TicketOptionID int,
    CampingOptionID int,
    foreign key (AttendeeID) references Attendee(AttendeeID) ON UPDATE CASCADE ON DELETE CASCADE
);

-- camping options table
Create table CampingOption (
	CampingOptionID int primary key auto_increment,
    OptionType VarChar(100) not null,
    Price decimal(9,2) not null,
    Amenities LongText not null,
    TicketID int,
    foreign key (TicketID) references Ticket(TicketID) ON UPDATE CASCADE ON DELETE CASCADE
);

-- ticket options table
Create table TicketOption(
	TicketOptionID int primary key auto_increment,
    TicketType VarChar(100) not null,
    DaysCovered VarChar(100) not null,
    Price decimal(9,2) not null,
    TicketID int,
    foreign key (TicketID) references Ticket(TicketID) ON UPDATE CASCADE ON DELETE CASCADE
);

-- now adding the foreign keys back to stage, artist and entertainment
-- this fixes the circular dependency issue
ALTER TABLE Stage
ADD foreign key (PerformanceID) references Performance(PerformanceID) ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE Artist
ADD foreign key (PerformanceID) references Performance(PerformanceID) ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE Entertainment
ADD foreign key (PerformanceID) references Performance(PerformanceID) ON UPDATE CASCADE ON DELETE SET NULL;


-- inserting data into tables
insert into Stage (name, PerformanceID)
Values('Main Stage', null);

insert into Stage (name, PerformanceID)
Values('Groove Grounds', null);

Insert into Artist (Name, Genre, ProfileDescription, PerformanceID)
Values ('The Rolling Scones', 'Classic Rock', 'A classic rock band known for their energetic performances', null);

insert into Entertainment (EntertainmentType, Name, Location, Date, StartTime, EndTime, PerformanceID, PlannerID, NonMusicalEntertainmentID)
Values ('Performance', 'The Rolling Scones', 'Main Stage', '1969-05-07', '12:00:00', '14:00:00', null, null, null);

insert into Entertainment (EntertainmentType, Name, Location, Date, StartTime, EndTime, PerformanceID, PlannerID, NonMusicalEntertainmentID)
Values ('Food Vender', 'The Hungry Jammer', 'Centre Park', '1969-05-07', '9:00:00', '22:00:00', null, null, null);

insert into Performance (EntertainmentID, ArtistID, StageID)
values (1,1,1);

-- updating the foreign key references
update Stage set PerformanceID = 1 where StageID = 1;
update Artist set PerformanceID = 1 where ArtistID = 1;
update Entertainment set PerformanceID = 1 where EntertainmentID = 1;

insert into NonMusicalEntertainment (Type, EntertainmentID)
values ('Food', 2);

update Entertainment set NonMusicalEntertainmentID = 1 where EntertainmentID = 2;

insert into AttendeePlanner (EntertainmentID, AttendeeID)
values (1, null);

insert into Attendee (FirstName, LastName, Email, ContactNumber, PlannerID, TicketID)
values ('Collette', 'Gava', 'Collette.Gavan@edgehill.ac.uk', '07938689364', 1, null);

update AttendeePlanner set AttendeeID = 1 where PlannerID = 1;

update Entertainment set PlannerID = 1 where EntertainmentID in (1,2);

insert into Ticket(PurchaseDate, AttendeeID, TicketOptionID, CampingOptionID)
values ('1968-12-06 14:22:56', 1, null, null);

update Attendee set TicketID = 1 where AttendeeID = 1;

insert into CampingOption(OptionType, Price, Amenities, TicketID)
Values('Premuim Camping', 150.00, 'Power and close to entrance', 1);

update Ticket set CampingOptionID = 1 where TicketID = 1;

insert into TicketOption (TicketType, DaysCovered, Price, TicketID)
Values('VIP', 'Weekend Pass', 199.99, 1);

update Ticket set TicketOptionID = 1 where TicketID = 1;

/*
---------------------
TASK 4A
---------------------


STEP 1 - Single table, single entity
- Changes the attendees contact number, say if they were to change their number to a new one
- the query updates the attendee table when ID = 1 and sets their contact number to the new one
- 1 row affected, and contact number shoud change to new number
~ I used w3schools as a reference: https://www.w3schools.com/mysql/mysql_update.asp 

Update Attendee
SET ContactNumber = '07598375026'
Where AttendeeID = 1 ;

 
STEP 2 - Multiple tables, 2-3 entites 
- Joins PerformanceID, artist name and artist genre into one table to make it more visable 
- Entities affected are only performance and artist 
- I used w3school again for this: 


SELECT Performance.PerformanceID, Artist.Name, Artist.Genre
FROM Performance
INNER JOIN Artist ON Performance.ArtistID = Artist.ArtistID;

 
STEP 3 - Multiple-table, 6 entites 
- Joins 6 entities into one visable table to make the data more visable and esier to acess
- 6 entites affected, artist, stage, entertainemnt, attendee planner, attendee and ticket, with 4 rows affected
- I used Sling Academy for this: https://www.slingacademy.com/article/mysql-8-how-to-update-multiple-tables-in-a-single-query/


SET SQL_SAFE_UPDATES = 0;
UPDATE Performance
INNER JOIN Artist ON Performance.ArtistID = Artist.ArtistID
INNER JOIN Stage ON Performance.StageID = Stage.StageID
INNER JOIN Entertainment ON Performance.EntertainmentID = Entertainment.EntertainmentID
INNER JOIN AttendeePlanner ON Entertainment.PlannerID = AttendeePlanner.PlannerID
INNER JOIN Attendee ON AttendeePlanner.AttendeeID = Attendee.AttendeeID
INNER JOIN Ticket ON Attendee.AttendeeID = Ticket.AttendeeID
SET Artist.Name = 'Gorill-az',
    Stage.Name = 'Main Stage',
    Entertainment.Location = 'West Park',
    Attendee.Email = 'BenSillitoe@gmail.com',
    Ticket.PurchaseDate = '1969-01-01 10:00:00'
WHERE Performance.PerformanceID = 1;


STEP 4 - Cascading updates
I tried to get the casscading affect on the values below, by updating the performanceID to 100 instead of 1


-- before update
select PerformanceID, Name from Stage where PerformanceID = 1;
select PerformanceID, Name from Artist where PerformanceID = 1;

-- doing the update
Update Performance 
Set PerformanceID = 100
Where performanceID = 1;

-- after update
select PerformanceID, Name from Stage where PerformanceID = 100;
select PerformanceID, Name from Artist where PerformanceID = 100;

-- changing it back
Update Performance 
Set PerformanceID = 1
Where performanceID = 100;


----------------------------
TASK 4B
----------------------------


STEP 1 - Single-table, 1 entity 
- Deletes one row of data from the performance entity where performance ID = 3


insert into Performance (EntertainmentID, ArtistID, StageID)
values (null, null, null);

DElETE FROM Performance where performanceID = 2;


Step 2 - multiple tables, 2 entities 
- Joins artist and performance, but removes test band in the process
- I used geeks for geeks: https://www.geeksforgeeks.org/sql/sql-delete-join/


insert into Artist (Name, Genre, ProfileDescription, PerformanceID)
values ('Test Band', 'Rock', 'A test band', 1);

Delete Artist
From Artist
INNER Join Performance ON Artist.PerformanceID = Performance.PerformanceID
Where Artist.name = 'Test Band';


STEP 3 - multiple tables, 6 entites 
- This query will delete all data collected in all 6 entities where PerformanceID = 1
- commented out because it deletes a lot of data


DELETE Artist, Stage, Entertainment, Attendee, Ticket
FROM Performance
INNER JOIN Artist ON Performance.ArtistID = Artist.ArtistID
INNER JOIN Stage ON Performance.StageID = Stage.StageID
INNER JOIN Entertainment ON Performance.EntertainmentID = Entertainment.EntertainmentID
INNER JOIN AttendeePlanner ON Entertainment.PlannerID = AttendeePlanner.PlannerID
INNER JOIN Attendee ON AttendeePlanner.AttendeeID = Attendee.AttendeeID
INNER JOIN Ticket ON Attendee.AttendeeID = Ticket.AttendeeID
WHERE Performance.PerformanceID = 1;


STEP 4 - cascading deletes 
I tried to get the cascading deletes here


insert into Stage (name, PerformanceID) values('Test Stage', null);
insert into Artist (Name, Genre, ProfileDescription, PerformanceID)
values ('Cascade Test Band', 'Pop', 'Testing cascades', null);
insert into Entertainment (EntertainmentType, Name, Location, Date, StartTime, EndTime, PerformanceID, PlannerID, NonMusicalEntertainmentID)
values ('Performance', 'Test Show', 'Test Location', '2025-06-01', '18:00:00', '20:00:00', null, null, null);

insert into Performance (EntertainmentID, ArtistID, StageID)
values (4, 3, 3);

update Stage set PerformanceID = 4 where StageID = 3;
update Artist set PerformanceID = 4 where ArtistID = 3;
update Entertainment set PerformanceID = 4 where EntertainmentID = 4;

-- before delete
select count(*) from Stage where PerformanceID = 4;
select count(*) from Artist where PerformanceID = 4;
select count(*) from Entertainment where PerformanceID = 4;

DELETE from Performance Where PerformanceID = 4;

-- after delete
select count(*) from Stage where PerformanceID = 4;
select count(*) from Artist where PerformanceID = 4;
select count(*) from Entertainment where PerformanceID = 4;

-- SELECT * FROM Entertainment;
*/

/* 
TASK 5 A 
*/

/*
Step 1 -Basic (1 Table) 
- This query will return the amount of attendees in the database
- Entities: Attendee 
- Logic: Count(*) counts every attendee in table 
- Outcome expected: a simple value showing how many attendees that attend the festival 
- only one entity is used so a single aggregate query is fine and now joins or subqueries are needed
Referance used: https://www.youtube.com/watch?v=jcoJuc5e3RE
*/

Select count(*) From Attendee;

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

/*
Task 5C: queries with subqueries
*/

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
);

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
