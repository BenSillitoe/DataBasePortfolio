# Sunbeat Music Festival – Event Management Database

A MySQL database and query portfolio for **Sunbeat**, a fictional three-day music festival. Built for CIS2700 Database Systems (Level 5) at Edge Hill University.

## Scenario
Sunbeat runs Friday to Sunday across five stages: Main Stage, Groove Grounds, Acoustic Corner, Rock Riff Ridge and Chillout Lounge. Over 40 artists perform, some more than once. The database handles:

- **Ticketing:** day passes, multi-day passes and VIP tickets
- **Camping:** Basic and Premium camping reservations
- **Line-up:** artist profiles, performances, stages and time slots
- **Extras:** non-musical entertainment such as the Comedy Tent, Cinema Dome and Food & Brew Street

It supports attendees (booking tickets, viewing the line-up, building a personal schedule), organisers (managing schedules, tracking sales) and artists (viewing their own performance times).

## Queries
Each query is documented with comments covering its purpose, the tables involved, the logic and the expected outcome.

| File | Type | Scope |
|------|------|-------|
| `t5Aquery1.sql` | SELECT with aggregates | 1 table |
| `t5Aquery2.sql` | SELECT with aggregates | 2–3 tables |
| `t5Aquery3.sql` | SELECT with aggregates | 7+ tables |
| `t5Bquery1.sql` | Aggregates + GROUP BY | 1 table |
| `t5Bquery2.sql` | Aggregates + GROUP BY | 2–3 tables |
| `t5Bquery3.sql` | Aggregates + GROUP BY | 7+ tables |
| `t5Cquery1.sql` | Subquery | 1 table |
| `t5Cquery2.sql` | Subquery (WHERE / HAVING / FROM) | 2–3 tables |
| `t5Cquery3.sql` | Subquery | 7+ tables |

## Skills Demonstrated
- Relational database design with primary and foreign keys
- Multi-table JOINs (up to 7+ entities)
- Aggregate functions: `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`
- `GROUP BY` and `HAVING`
- Subqueries in `WHERE`, `HAVING` and `FROM` (derived tables)
- Sales and attendance reporting

## How to Run
1. Open **MySQL Workbench**.
2. Run the schema and data scripts to create and populate the database.
3. Open any query file from the table above and run it.

## Tech
MySQL 8 · MySQL Workbench

---
*All artists and the festival itself are fictional.*
