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