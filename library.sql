-- Create the library database
CREATE DATABASE library;


-- Use the library database
USE library;

-- Create the Branch table
CREATE TABLE Branch (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(255),
    Contact_no VARCHAR(15)
);

-- Create the Employee table
CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(100),
    Position VARCHAR(50),
    Salary DECIMAL(10, 2),
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);

-- Create the Books table
CREATE TABLE Books (
    ISBN VARCHAR(20) PRIMARY KEY,
    Book_title VARCHAR(255),
    Category VARCHAR(100),
    Rental_Price DECIMAL(10, 2),
    Status VARCHAR(3),
    Author VARCHAR(100),
    Publisher VARCHAR(100)
);

-- Create the Customer table
CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(100),
    Customer_address VARCHAR(255),
    Reg_date DATE
);

-- Create the IssueStatus table
CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(255),
    Issue_date DATE,
    Isbn_book VARCHAR(20),
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);

-- Create the ReturnStatus table
CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(255),
    Return_date DATE,
    Isbn_book2 VARCHAR(20),
    FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);
SHOW TABLES;


INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no) VALUES
(1, 101, '123 Library St, Cityville', '123-456-7890'),
(2, 102, '456 Book Ln, Townsville', '234-567-8901'),
(3, 103, '789 Novel Rd, Villagetown', '345-678-9012'),
(4, 104, '321 Reading Blvd, Hamletcity', '456-789-0123'),
(5, 105, '654 Literature Ave, Metropolis', '567-890-1234'),
(6, 106, '987 Fiction Dr, Boroughplace', '678-901-2345'),
(7, 107, '159 Story St, Hamletcity', '789-012-3456'),
(8, 108, '753 Page Pl, Metropolis', '890-123-4567');


INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no) VALUES
(201, 'Alice Johnson', 'Librarian', 55000.00, 1),
(202, 'Bob Smith', 'Assistant Librarian', 45000.00, 2),
(203, 'Carol White', 'Librarian', 60000.00, 3),
(204, 'David Brown', 'Assistant Librarian', 48000.00, 4),
(205, 'Eve Davis', 'Librarian', 62000.00, 5),
(206, 'Frank Miller', 'Assistant Librarian', 43000.00, 6),
(207, 'Grace Lee', 'Librarian', 57000.00, 7),
(208, 'Hank Wilson', 'Assistant Librarian', 46000.00, 8);


INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher) VALUES
('978-3-16-148410-0', 'History of Time', 'Science', 30.00, 'yes', 'Stephen Hawking', 'Bantam Books'),
('978-1-86197-876-9', 'Sapiens', 'History', 35.00, 'yes', 'Yuval Noah Harari', 'Harper'),
('978-0-7432-7356-5', '1984', 'Fiction', 25.00, 'no', 'George Orwell', 'Secker & Warburg'),
('978-0-140-17772-3', 'To Kill a Mockingbird', 'Fiction', 28.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.'),
('978-0-670-81302-4', 'The Catcher in the Rye', 'Fiction', 24.00, 'no', 'J.D. Salinger', 'Little, Brown and Company'),
('978-0-452-28423-4', 'The Great Gatsby', 'Fiction', 22.00, 'yes', 'F. Scott Fitzgerald', 'Charles Scribner\'s Sons'),
('978-0-7432-7357-2', 'Moby-Dick', 'Adventure', 32.00, 'yes', 'Herman Melville', 'Harper & Brothers'),
('978-0-141-03435-2', 'War and Peace', 'Historical Fiction', 40.00, 'yes', 'Leo Tolstoy', 'The Russian Messenger');


INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date) VALUES
(301, 'John Doe', '123 Maple St, Cityville', '2021-12-15'),
(302, 'Jane Smith', '456 Oak Ln, Townsville', '2022-01-10'),
(303, 'Jim Brown', '789 Pine Rd, Villagetown', '2022-03-05'),
(304, 'Jill White', '321 Cedar Blvd, Hamletcity', '2021-11-20'),
(305, 'Jack Davis', '654 Birch Ave, Metropolis', '2022-02-28'),
(306, 'Jenny Miller', '987 Elm Dr, Boroughplace', '2022-06-15'),
(307, 'Jake Lee', '159 Ash St, Hamletcity', '2021-10-22'),
(308, 'Julie Wilson', '753 Poplar Pl, Metropolis', '2022-07-01');

INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book) VALUES
(401, 301, 'History of Time', '2023-05-01', '978-3-16-148410-0'),
(402, 302, 'Sapiens', '2023-05-15', '978-1-86197-876-9'),
(403, 303, '1984', '2023-06-01', '978-0-7432-7356-5'),
(404, 304, 'To Kill a Mockingbird', '2023-06-10', '978-0-140-17772-3'),
(405, 305, 'The Catcher in the Rye', '2023-06-20', '978-0-670-81302-4'),
(406, 306, 'The Great Gatsby', '2023-07-01', '978-0-452-28423-4'),
(407, 307, 'Moby-Dick', '2023-07-15', '978-0-7432-7357-2'),
(408, 308, 'War and Peace', '2023-07-25', '978-0-141-03435-2');


SELECT Book_title, Category, Rental_Price
FROM Books
WHERE Status = 'yes';

SELECT Emp_name, Salary
FROM Employee
ORDER BY Salary DESC;


SELECT Books.Book_title, Customer.Customer_name
FROM IssueStatus
JOIN Books ON IssueStatus.Isbn_book = Books.ISBN
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id;

SELECT Category, COUNT(*) AS Total_Books
FROM Books
GROUP BY Category;


SELECT Emp_name, Position
FROM Employee
WHERE Salary > 50000;


SELECT Customer.Customer_name
FROM Customer
LEFT JOIN IssueStatus ON Customer.Customer_Id = IssueStatus.Issued_cust
WHERE Customer.Reg_date < '2022-01-01' AND IssueStatus.Issued_cust IS NULL;


SELECT Branch_no, COUNT(*) AS Total_Employees
FROM Employee
GROUP BY Branch_no;


SELECT Customer.Customer_name
FROM IssueStatus
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id
WHERE IssueStatus.Issue_date BETWEEN '2023-06-01' AND '2023-06-30';


SELECT Book_title
FROM Books
WHERE Book_title LIKE '%history%';


SELECT Branch_no, COUNT(*) AS Total_Employees
FROM Employee
GROUP BY Branch_no
HAVING COUNT(*) > 4;
select * from Employee;


SELECT Employee.Emp_name, Branch.Branch_address
FROM Employee
JOIN Branch ON Employee.Emp_Id = Branch.Manager_Id;


SELECT DISTINCT Customer.Customer_name
FROM IssueStatus
JOIN Books ON IssueStatus.Isbn_book = Books.ISBN
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id
WHERE Books.Rental_Price > 25;


