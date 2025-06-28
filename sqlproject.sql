DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);

DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);
DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

-- import data from books table
COPY Books(Book_ID, Title, Author, Genre, Published_Year, Price, Stock)
FROM 'D:\Project\Books.csv'
CSV HEADER;


-- Import data from customers table
COPY Customers(Customer_ID, Name, Email, Phone, City, Country)
FROM 'D:\Project\Customer sql - Customers.csv'
CSV HEADER;

-- Import data from orders table
COPY Orders(Order_ID, Customer_Id, Book_ID, Order_Date, Quantity, Total_Amount)
FROM 'D:\Project\Orders sql - Orders.csv'
CSV HEADER;


--1.Retrieve all books in the 'Fiction' genre
SELECT * FROM Books WHERE genre = 'Fiction';


--2.Find books published after year 1950
SELECT * FROM Books WHERE Published_Year > 1950;

--3.List all the customers from Canada
SELECT * FROM Customers WHERE Country ='Canada';


--4.Show orders placed in November 2023
SELECT * FROM Orders WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';

--5.Retrieve the total stock of books available
SELECT SUM(Stock) AS total_stock FROM Books;

--6.Find the detail of the most expensive book
SELECT * FROM Books ORDER BY Price DESC LIMIT 1;

--7.Show all the customers who ordered more than 1 quantity of book;
SELECT * FROM Orders WHERE Quantity > 1;

--8.Retrive all orders where total amount exceeds $20
SELECT * FROM Orders WHERE Total_amount >20;

--9.List all genres available in the Books Table
SELECT DISTINCT genre FROM Books;

--10.Find the book with lowest Stock
SELECT * FROM Books ORDER BY Stock LIMIT 1;

--11.Calculate the total revenue generated from all orders
SELECT SUM(total_amount) AS Revenue FROM Orders;


--Advance Query
--1.Retrieve the total number of books sold for each genre
SELECT b.Genre,SUM(O.quantity) AS total_book
FROM Orders O JOIN Books b on O.book_id = b.book_id 
GROUP BY b.Genre;

--2.Find the average price of books in the fantasy genre
SELECT AVG(price) AS Average_price FROM Books WHERE Genre = 'Fantasy';

--3.List customers who have placed atleast 2 Orders
SELECT  o.customer_id,c.name, COUNT(o.Order_id) AS ORDER_COUNT
FROM Orders o Join customers c ON o.customer_id = c.customer_id
GROUP BY o.customer_id, c.name
HAVING COUNT(Order_id)>=2;


--4.Find the most frequently ordered book
SELECT book_id, COUNT(Order_id) AS ORDER_COUNT
FROM Orders GROUP BY book_id ORDER BY ORDER_COUNT DESC 
LIMIT 1;

--5.Show the top 3 most expensive books of 'Fantasy' Genre
SELECT * from Books where Genre = 'Fantasy' ORDER BY Price DESC
LIMIT 3; 

--6.Retrieve the total Quantity of books sold by each author;
SELECT b.author, SUM(o.quantity) AS totalBook_sold 
FROM Orders o JOIN Books b ON o.book_id = b.book_id
GROUP BY b.author;

--7.List the cities Where Customer who spent over $30 are located
SELECT DISTINCT c.city, total_amount
FROM Orders o JOIN Customers c ON o.customer_id = c.customer_id
WHERE o.total_amount > 30;


--8.Find the Customer who spent the most on Orders
SELECT c.customer_id, c.name, SUM(o.total_amount) AS total_spent
FROM Orders o JOIN Customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_id,c.name ORDER BY total_spent DESC LIMIT 1;

--9.Calculate the stock remaining after fulfilling the order
SELECT b.book_id, b.title, b.stock,COALESCE(SUM(o.quantity), 0) AS order_quantity,
b.stock - COALESCE(SUM(o.quantity), 0) AS remaining_stock
FROM Books b
LEFT JOIN Orders o ON o.book_id = b.book_id
GROUP BY b.book_id, b.title, b.stock;
