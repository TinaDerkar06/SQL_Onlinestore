SQL Book Store Project
Project Overview
This project sets up a foundational PostgreSQL database for a book store. It demonstrates core database concepts by managing books, customers, and their orders, providing a backend structure for sales transactions and inventory.

Key Features
Book Management: Stores details like title, author, genre, price, and stock.

Customer Management: Manages customer information including name, email, and location.

Order Processing: Handles customer orders, linking books to purchases.

Basic Inventory & Sales Tracking: Tracks book stock and calculates total order amounts.

Technologies Used
Database System: PostgreSQL

Language: SQL

Database Schema Highlights
The database is built with three main tables:

Books: Contains all book details.

Customers: Stores customer profiles.

Orders: Records individual purchase transactions, linking customers to books.

These tables are designed with appropriate primary and foreign keys to ensure data integrity.

Getting Started
To get this project running on your local machine:

Prerequisites: Ensure you have PostgreSQL installed and a client (like psql or pgAdmin).

Clone the repository:

Bash

git clone https://github.com/YourUsername/sql-book-store.git
cd sql-book-store
Set up the database:

Open your PostgreSQL client and connect to your database.

Execute the sqlproject.sql file. This script will create the tables and attempt to import sample data using COPY commands.

Important: The COPY commands in sqlproject.sql use specific local file paths (e.g., 'D:\Project\Books.csv'). You will need to adjust these paths to where your CSV data files are located on your system, or manually import your data.

Bash

# Example using psql to run the script:
psql -U your_username -d your_database_name -f sqlproject.sql
Example Queries
The sqlproject.sql file includes many examples, but here are a few to get you started:

Find books in the 'Fiction' genre:

SQL

SELECT * FROM Books WHERE genre = 'Fiction';
Calculate total revenue from all orders:

SQL

SELECT SUM(total_amount) AS Revenue FROM Orders;
List customers who have placed at least 2 orders:

SQL

SELECT c.name, COUNT(o.Order_id) AS ORDER_COUNT
FROM Orders o JOIN Customers c ON o.customer_id = c.customer_id
GROUP BY o.customer_id, c.name
HAVING COUNT(Order_id) >= 2;
(See sqlproject.sql for a full list of basic and advanced queries.)

Project Structure
sqlproject.sql: Database schema (table creation, primary/foreign keys), data import commands, and all SQL queries.

README.md: This overview file.
