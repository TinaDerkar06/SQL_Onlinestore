SQL Book Store Project
Project Overview
This project implements a foundational database system for a Book Store using SQL. It demonstrates key database concepts such as schema design, data manipulation, and querying, providing a solid backend structure for managing books, customers, and their orders. The primary goal was to create a robust and scalable database that can efficiently manage book inventory, customer information, and sales transactions.

Features
Book Management: Store and retrieve detailed information about various books, including title, author, genre, publication year, price, and stock quantity.

Customer Management: Maintain customer records with essential details like name, email, phone, city, and country.

Order Processing: Handle the creation and tracking of customer orders, linking books and customers.

Basic Inventory Tracking: Reflect changes in book stock as orders are placed.

Relational Database Design: Utilizes relationships between tables to ensure data integrity and avoid redundancy.

Data Import Capabilities: Includes commands to efficiently import data from CSV files into the respective tables.

Comprehensive Queries: Provides a set of basic and advanced SQL queries for data retrieval, aggregation, and analysis.

Technologies Used
Database System: PostgreSQL

SQL Language: Used for all database schema definition (DDL) and data manipulation (DML) operations.

Database Schema
The database is designed with the following tables and relationships:

Books: Stores information about books available in the store.

Book_ID (Primary Key, SERIAL)

Title (VARCHAR(100))

Author (VARCHAR(100))

Genre (VARCHAR(50))

Published_Year (INT)

Price (NUMERIC(10, 2))

Stock (INT)

Customers: Holds details about registered customers.

Customer_ID (Primary Key, SERIAL)

Name (VARCHAR(100))

Email (VARCHAR(100))

Phone (VARCHAR(15))

City (VARCHAR(50))

Country (VARCHAR(150))

Orders: Records details of each customer order.

Order_ID (Primary Key, SERIAL)

Customer_ID (INT Foreign Key referencing Customers(Customer_ID))

Book_ID (INT Foreign Key referencing Books(Book_ID))

Order_Date (DATE)

Quantity (INT)

Total_Amount (NUMERIC(10, 2))

Getting Started
To set up and run this project locally, follow these steps:

Prerequisites
PostgreSQL: Ensure you have a PostgreSQL server installed and running.

PostgreSQL Client: A client tool like psql (command-line), pgAdmin, or DBeaver to connect to your PostgreSQL database.

Installation
Clone the repository:

Bash

git clone https://github.com/YourUsername/sql-book-store.git
cd sql-book-store
Create the database and tables:
Open your PostgreSQL client and connect to your database. Then, execute the sqlproject.sql file. This file will:

Drop existing tables if they exist.

Create the Books, Customers, and Orders tables.

Attempt to import data from specified CSV files. Note: You will need to adjust the file paths in the COPY commands within sqlproject.sql to match the location of your CSV files on your system. For COPY to work, these CSV files (Books.csv, Customer sql - Customers.csv, Orders sql - Orders.csv) must be accessible by the PostgreSQL server, or you can use \copy from the psql client, which runs on the client side.

Bash

# Example using psql from the command line
psql -U your_username -d your_database_name -f sqlproject.sql
Make sure the CSV files mentioned in sqlproject.sql are in the correct absolute path or in a path accessible by the PostgreSQL server, or update the COPY commands to use \copy if running from psql locally.

Usage Examples and Queries
The sqlproject.sql file contains a variety of queries to interact with the database. Here are some highlights:

Basic Queries
Retrieve all books in the 'Fiction' genre:

SQL

SELECT * FROM Books WHERE genre = 'Fiction';
Find books published after the year 1950:

SQL

SELECT * FROM Books WHERE Published_Year > 1950;
List all customers from Canada:

SQL

SELECT * FROM Customers WHERE Country ='Canada';
Show orders placed in November 2023:

SQL

SELECT * FROM Orders WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';
Retrieve the total stock of books available:

SQL

SELECT SUM(Stock) AS total_stock FROM Books;
Find the detail of the most expensive book:

SQL

SELECT * FROM Books ORDER BY Price DESC LIMIT 1;
Show all customers who ordered more than 1 quantity of a book:

SQL

SELECT * FROM Orders WHERE Quantity > 1;
Retrieve all orders where the total amount exceeds $20:

SQL

SELECT * FROM Orders WHERE Total_amount >20;
List all genres available in the Books Table:

SQL

SELECT DISTINCT genre FROM Books;
Find the book with the lowest Stock:

SQL

SELECT * FROM Books ORDER BY Stock LIMIT 1;
Calculate the total revenue generated from all orders:

SQL

SELECT SUM(total_amount) AS Revenue FROM Orders;
Advanced Queries
Retrieve the total number of books sold for each genre:

SQL

SELECT b.Genre, SUM(O.quantity) AS total_book
FROM Orders O JOIN Books b ON O.book_id = b.book_id
GROUP BY b.Genre;
Find the average price of books in the 'Fantasy' genre:

SQL

SELECT AVG(price) AS Average_price FROM Books WHERE Genre = 'Fantasy';
List customers who have placed at least 2 Orders:

SQL

SELECT o.customer_id, c.name, COUNT(o.Order_id) AS ORDER_COUNT
FROM Orders o JOIN Customers c ON o.customer_id = c.customer_id
GROUP BY o.customer_id, c.name
HAVING COUNT(Order_id) >= 2;
Find the most frequently ordered book:

SQL

SELECT book_id, COUNT(Order_id) AS ORDER_COUNT
FROM Orders GROUP BY book_id ORDER BY ORDER_COUNT DESC
LIMIT 1;
Show the top 3 most expensive books of the 'Fantasy' Genre:

SQL

SELECT * from Books where Genre = 'Fantasy' ORDER BY Price DESC
LIMIT 3;
Retrieve the total Quantity of books sold by each author:

SQL

SELECT b.author, SUM(o.quantity) AS totalBook_sold
FROM Orders o JOIN Books b ON o.book_id = b.book_id
GROUP BY b.author;
List the cities where customers who spent over $30 are located:

SQL

SELECT DISTINCT c.city, total_amount
FROM Orders o JOIN Customers c ON o.customer_id = c.customer_id
WHERE o.total_amount > 30;
Find the Customer who spent the most on Orders:

SQL

SELECT c.customer_id, c.name, SUM(o.total_amount) AS total_spent
FROM Orders o JOIN Customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_id,c.name ORDER BY total_spent DESC LIMIT 1;
Calculate the stock remaining after fulfilling the order:

SQL

SELECT b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity), 0) AS order_quantity,
b.stock - COALESCE(SUM(o.quantity), 0) AS remaining_stock
FROM Books b
LEFT JOIN Orders o ON o.book_id = b.book_id
GROUP BY b.book_id, b.title, b.stock;
Project Structure
sqlproject.sql: Contains the SQL DDL statements for creating all tables, defining primary and foreign keys, and setting up constraints, along with COPY commands for data import and a comprehensive set of SQL queries for various operations.

README.md: This file, .

Contributing
Contributions are welcome! If you have suggestions for improvements or new features, please feel free to:

Fork the repository.

Create a new branch (git checkout -b feature/your-feature-name).

Make your changes.

Commit your changes (git commit -m 'Add new feature').

Push to the branch (git push origin feature/your-feature-name).

Open a Pull Request.
