# Hotel Management Database System

## Overview
This repository contains a complete relational database schema and sample data for a Hotel Management System implemented in MySQL. The system is designed to manage hotel branches, rooms, guests, reservations, payments, staff, services, and reviews. It demonstrates key database concepts such as normalized tables, primary and foreign keys, constraints (e.g., CHECK for validation), and relationships (one-to-many and many-to-many).

This project is submitted as part of the Power Learn Project (PLP) Database Design & Programming with SQL module Week 8 Assignment (Final Project).

The use case focuses on a multi-branch hotel chain in Ethiopia, handling operations like booking rooms, tracking availability, processing payments, and collecting guest reviews.

## Features
- **Entities and Relationships**:
  - Hotels with branches and locations (one-to-many with rooms and staff).
  - Rooms with types, prices, and features (many-to-many with features via junction table).
  - Guests with unique contact details.
  - Reservations linking guests, rooms, hotels, and payments (with date validations).
  - Payments with methods and status.
  - Staff with roles and multiple contacts (normalized via junction table).
  - Services that can be added to reservations (many-to-many).
  - Reviews for guest feedback.
  - Room service availability tracking.
  - Staff contacts are normalized in a separate Staff_Contact junction table to allow multiple phone numbers per staff member.

- **Constraints**: Includes PRIMARY KEY, FOREIGN KEY (with references), UNIQUE (for emails/phones), and CHECK (e.g., ratings 0-5, positive values).
- **Sample Data**: Includes inserts for hotels, rooms, guests, etc., to populate the database for testing.

## Requirements
- MySQL server (version 5.7 or later recommended).
- A MySQL client like MySQL Workbench, phpMyAdmin, or the command-line tool.

## How to Run
1. **Clone the Repository**:
   ```
   git clone https://github.com/Yoni-Berihun/YO-Hotel-Database-Management-System.git
   cd YO-Hotel-Database-Management-System
   ```

2. **Execute the SQL Script**:
   - Open your MySQL client.
   - Run the provided `hotel_management.sql` file:
     ```
     mysql -u yourusername -p < Hotel_Management.sql
     ```
   - This will create the `Hotel_Management` database, all tables, and insert sample data.

3. **Verify**:
   - Connect to the database: `USE Hotel_Management;`
   - Run queries like `SHOW TABLES;` to see the structure.
   - Test with sample queries, e.g.:
     ```
     SELECT * FROM Reservation JOIN Guest ON Reservation.Guest_ID = Guest.Guest_ID;
     ```

## Database Schema
### Key Tables
- **Hotel**: Stores branch details (ID, name, location, phone).
- **Room**: Room info with type, price, availability (linked to Hotel).
- **Guest**: Guest profiles with unique phone/email.
- **Reservation**: Core table for bookings (links to Guest, Hotel, Room, Payment).
- **Payment**: Payment details with method and status.
- **Staff**: Staff members (linked to Hotel).
- **Services**: Additional services like spa or shuttle.
- **Review**: Guest reviews with ratings.
- Junction tables: `Room_Room_Feature`, `Reservation_Service`, `Staff_Contact`, `Room_Service_Availability` for many-to-many relationships.



## Sample Queries
- **Available Rooms**: `SELECT * FROM Room WHERE Availability = TRUE;`
- **Guest Reservations**: `SELECT Guest_name, Check_in_date, Room_type FROM Reservation JOIN Guest ON Reservation.Guest_ID = Guest.Guest_ID JOIN Room ON Reservation.Room_ID = Room.Room_ID;`
- **Hotel Reviews**: `SELECT AVG(Rating) FROM Review WHERE Hotel_ID = 'h.01';`

## What I Learned from This Project
Through this assignment, I gained hands-on experience in designing a relational database from scratch, including:
- **Schema Design**: Creating normalized tables (up to 3NF) to reduce redundancy and ensure data integrity.
- **Constraints and Relationships**: Implementing PRIMARY/FOREIGN keys, UNIQUE constraints, and CHECK clauses to enforce rules, as well as handling one-to-many and many-to-many relationships with junction tables.
- **SQL Best Practices**: Writing clean, commented SQL code with proper data types, and inserting sample data to test functionality.
- **Real-World Application**: Applying concepts to a hotel management system, which helped me understand how databases support business operations like bookings and reviews.
- **Debugging and Iteration**: Fixing issues like duplicate keys, syntax errors, and inconsistencies during development, improving my problem-solving skills.

This project solidified my understanding of SQL and database principles, preparing me for more complex systems.

## Acknowledgments
Thank you to Power Learn Project (PLP) for this precious chance to apply what I've learned in the Database Design & Programming with SQL module. The guidance and resources provided were invaluable in completing this final project.

## Notes
- This schema is normalized to 3NF to minimize redundancy.
- Dates use ISO format (YYYY-MM-DD).
- For production, add indexes (e.g., on frequently queried fields like dates) and triggers (e.g., to update totals).
- No views or procedures are included, but they can be added for advanced reporting.

## License
This project is for educational purposes. Feel free to use and modify it under the MIT License.

If you encounter issues or have suggestions, open an issue in this repository!