# Hotel Management Database

A beginner-friendly MySQL project that models core hotel operations, including hotels, rooms, guests, reservations, and payments.

## Features

- Relational schema with primary keys and foreign key relationships
- Constraints for room prices, reservation dates, and booking/payment statuses
- Sample data for testing
- SQL JOINs for reservation reports
- Aggregate queries for paid revenue and room counts
- Queries to identify pending payments and validate reservation dates
- Room-charge calculations based on length of stay

## Database Tables

- `hotels` — hotel names and locations
- `rooms` — room details, rates, and status
- `guests` — guest contact details
- `reservations` — booking dates and status
- `payments` — payment amounts, dates, and status

## Technology

MySQL 8.0

## How to Run

1. Install MySQL 8.0 or a compatible version.
2. Create the database and tables using `sql/hotel_management.sql`.
3. Execute the sample data inserts.
4. Run the reporting queries to explore reservations, room counts, and payments.

## Purpose

Built to practise relational database design, SQL querying, data validation, and hotel-operation reporting.

_Note: Uses fictional sample data for learning and demonstration._
