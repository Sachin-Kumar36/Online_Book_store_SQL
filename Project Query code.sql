CREATE DATABASE OnlineBookstore;

CREATE TABLE Books(
	Book_ID SERIAL PRIMARY KEY,
	Title VARCHAR(100),
	Author VARCHAR(100),
	Genre VARCHAR(50),
	Published_Year INT,
	Price NUMERIC(10,2),
	Stock INT
);

CREATE TABLE Customers(
	Customer_ID SERIAL PRIMARY KEY,
	Name VARCHAR(100),
	Email VARCHAR(100),
	Phone VARCHAR(15),
	City VARCHAR(50),
	Country VARCHAR(150)
);

CREATE TABLE Orders(
	Order_ID SERIAL PRIMARY KEY,
	Customer_ID INT REFERENCES Customers(Customer_ID),
	Book_ID INT REFERENCES Books(Book_ID),
	Order_Date DATE,
	Quantity INT,
	Total_Amount NUMERIC(10,2)
);

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;



-- (1). Retrive  all books in the "Fiction" genre:
SELECT *
FROM Books
WHERE genre = 'Fiction';

-- (2). Find books published after the year 1950;
SELECT * 
FROM Books
WHERE published_year > 1950;

-- (3). List all customers from the China:
SELECT *
FROM Customers
WHERE country = 'China';

-- (4). Show orders placed in November 2023:
SELECT *
FROM Orders
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';

-- (5). Retrieve the total stock of books available:
SELECT sum(stock) as Total_Stock
FROM Books;

-- (6). Find the details of the most expencive book:
SELECT *
FROM Books
ORDER BY price DESC
LIMIT 1;

-- (7). Show all customers who ordered more than 1 quanity of a book:
SELECT *
FROM Orders
WHERE quantity > 1;

-- (8). Retrieve the all orders where the total amount exceeds $20:
SELECT *
FROM Orders
WHERE total_amount > 20;

-- (9). List all genres available in the Book table:
SELECT genre
FROM Books
GROUP BY genre;

-- (10). Find the book with the lowest stock:
SELECT *
FROM Books
ORDER BY stock
LIMIT 1;

-- (11). Calculate the total revenue generated for all orders:
SELECT sum(total_amount) as total_revenue
FROM Orders;

-- Advance Questions :

--(1). Retrieve the total number of books sold for each genre:
SELECT Books.genre, SUM(Orders.quantity) AS total_sold_books
FROM Orders
JOIN Books
ON Books.book_id = Orders.book_id
GROUP BY Books.genre;

-- (2). Find the average price of books in the "Fantasy" genre:
SELECT AVG(price) AS Avg_price
FROM Books
WHERE genre = 'Fantasy';

-- (3). List customers who have placed aT least 2 orders:
SELECT o.customer_id, c.name, count(o.order_id)
FROM orders o
JOIN customers c
ON c.customer_id = o.customer_id
GROUP BY o.customer_id, c.name
HAVING count(o.order_id) >= 2;

-- (4). Find the most frequently ordered book:
SELECT O.Book_id, b.title, count(O.order_id)
FROM ORDERS O
JOIN Books b
ON b.book_id = o.book_id
GROUP BY O.Book_id, b.title
ORDER BY count(order_id) DESC
LIMIT 1;

-- (5). Show the top 3 most expensive books of 'Fantasy' genre:
SELECT *
FROM Books
WHERE genre = 'Fantasy'
ORDER BY price DESC
LIMIT 3;

-- (6). Retrieve the total quantity of books sold by each auther:
SELECT b.author, sum(o.quantity)
FROM Orders o
JOIN Books b
ON b.book_id = o.book_id
GROUP BY b.author;

-- (7). List the cities where customers who spent over $30 are located:
SELECT DISTINCT c.city, total_amount
FROM orders o
JOIN customers c
ON c.customer_id = o.customer_id
WHERE o.total_amount >= 30;

-- (8). Find the customer who spent the most on orders:
SELECT c.customer_id, c.name, sum(o.total_amount) AS total_spent
FROM orders o
JOIN customers c
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_spent DESC
LIMIT 1;

-- (9). Calculate the stock remaining after fulfilling all orders:
SELECT b.book_id, b.title, b.stock, COALESCE(SUM(quantity),0) AS order_quantity,
	b.stock - COALESCE(SUM(quantity),0) AS remaining_quantity
FROM books b
LEFT JOIN Orders o
ON b.book_id = o.book_id
GROUP BY b.book_id
ORDER BY b.book_id;













