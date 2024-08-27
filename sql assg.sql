-- Create the database
CREATE DATABASE library;

-- Connect to the database
USE library;

-- Create tables
CREATE TABLE Branch (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(255),
    Contact_no VARCHAR(20)
);

CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(100),
    Position VARCHAR(100),
    Salary DECIMAL(10,2),
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);

CREATE TABLE Books (
    ISBN VARCHAR(20) PRIMARY KEY,
    Book_title VARCHAR(255),
    Category VARCHAR(100),
    Rental_Price DECIMAL(10,2),
    Status CHAR(3),
    Author VARCHAR(100),
    Publisher VARCHAR(100)
);

CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(100),
    Customer_address VARCHAR(255),
    Reg_date DATE
);

CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(255),
    Issue_date DATE,
    Isbn_book VARCHAR(20),
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);

CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(255),
    Return_date DATE,
    Isbn_book2 VARCHAR(20),
    FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);

INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no)
VALUES (1, 101, '123 Main St', '555-1234');


INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no)
VALUES 
(101, 'John Smith', 'Manager', 50000.00, 1),
(098, 'Charlie Brown', 'Shelf keeper', 12000, 1),
(006, 'Hannah Moore', 'Book Assistance', 13000, 1);
      
INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher)
VALUES 
('978-1-234-56789-0', '1984', 'Science Fiction', 10.99, 'yes', 'George Orwell', 'Penguin'),
('007-2-768-56092-9', '1996', 'Drama', 13.0, 'yes', 'F. Scott Fitzgerald', 'Peacock'),
('857-8-390-43210-8', 1890, 'Drama', 13.0, 'yes', 'William Shakespear', 'Black Swan');

INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date)
VALUES (1, 'Jane Doe', '456 Elm St', '2023-01-01');

INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book)
VALUES 
(2,1, '1984', '2023-06-01', '978-1-234-56789-0');

INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2)
VALUES (1, 1, '1984', '2023-06-15', '978-1-234-56789-0');

SELECT Book_title, Category, Rental_Price
FROM Books
WHERE Status = 'yes';

SELECT Emp_name, Salary
FROM Employee
ORDER BY Salary DESC;

SELECT DISTINCT b.Book_title, c.Customer_name
FROM IssueStatus iss
JOIN Books b ON iss.Isbn_book = b.ISBN
JOIN Customer c ON iss.Issued_cust = c.Customer_Id;

SELECT Category, COUNT(*) as Total_Count
FROM Books
GROUP BY Category;

SELECT Emp_name, Position
FROM Employee
WHERE Salary > 50000;

SELECT Customer_name
FROM Customer
WHERE Reg_date < '2022-01-01'
AND Customer_id NOT IN (SELECT Issued_cust FROM IssueStatus);

SELECT Branch_no, COUNT(*) as Total_Employees
FROM Employee
GROUP BY Branch_no;

SELECT DISTINCT c.Customer_name
FROM IssueStatus iss
JOIN Customer c ON iss.Issued_cust = c.Customer_Id
WHERE MONTH(iss.Issue_date) = 6 AND YEAR(iss.Issue_date) = 2023;

SELECT DISTINCT b.Book_title
FROM IssueStatus iss
JOIN Books b ON iss.Isbn_book = b.ISBN;

SELECT Branch_no, COUNT(*) as Employee_count
FROM Employee
GROUP BY Branch_no
HAVING COUNT(*) > 5;

SELECT E.Emp_name, B.Branch_address
FROM Employee E
JOIN Branch B ON E.Branch_no = B.Branch_no
WHERE E.Position = 'Manager';

SELECT DISTINCT c.Customer_name
FROM IssueStatus iss
JOIN Books b ON iss.Isbn_book = b.ISBN
JOIN Customer c ON iss.Issued_cust = c.Customer_Id
WHERE b.Rental_Price > 25;


