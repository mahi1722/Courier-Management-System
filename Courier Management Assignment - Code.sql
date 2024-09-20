-- Create the database
CREATE DATABASE CourierManagementSystem;


USE CourierManagementSystem;

-- Create tables
CREATE TABLE User (
    UserID INT PRIMARY KEY,
    Name VARCHAR(255),
    Email VARCHAR(255) UNIQUE,
    Password VARCHAR(255),
    ContactNumber VARCHAR(20),
    Address TEXT
);

CREATE TABLE Courier (
    CourierID INT PRIMARY KEY,
    SenderName VARCHAR(255),
    SenderAddress TEXT,
    ReceiverName VARCHAR(255),
    ReceiverAddress TEXT,
    Weight DECIMAL(5, 2),
    Status VARCHAR(50),
    TrackingNumber VARCHAR(20) UNIQUE,
    DeliveryDate DATE,
    UserID INT,
    FOREIGN KEY (UserID) REFERENCES User(UserID)
);

CREATE TABLE CourierServices (
    ServiceID INT PRIMARY KEY,
    ServiceName VARCHAR(100),
    Cost DECIMAL(8, 2)
);

CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(255),
    Email VARCHAR(255) UNIQUE,
    ContactNumber VARCHAR(20),
    Role VARCHAR(50),
    Salary DECIMAL(10, 2)
);

CREATE TABLE Location (
    LocationID INT PRIMARY KEY,
    LocationName VARCHAR(100),
    Address TEXT
);

CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY,
    CourierID INT,
    LocationID INT,
    Amount DECIMAL(10, 2),
    PaymentDate DATE,
    FOREIGN KEY (CourierID) REFERENCES Courier(CourierID),
    FOREIGN KEY (LocationID) REFERENCES Location(LocationID)
);

show tables;

-- Insert sample data
INSERT INTO User (UserID, Name, Email, Password, ContactNumber, Address)
VALUES 
(1, 'John Doe', 'john@work.com', 'password123', '123-456-7890', '123 Main St, City'),
(2, 'Jane Smith', 'jane@work.com', 'password456', '987-654-3210', '456 Elm St, Town');

INSERT INTO Courier (CourierID, SenderName, SenderAddress, ReceiverName, ReceiverAddress, Weight, Status, TrackingNumber, DeliveryDate, UserID)
VALUES 
(1, 'John Doe', '123 Main St, City', 'Alice Johnson', '789 Oak St, Village', 2.5, 'In Transit', 'TRK123456', '2024-09-25', 1),
(2, 'Jane Smith', '456 Elm St, Town', 'Bob Brown', '321 Pine St, Hamlet', 1.8, 'Delivered', 'TRK789012', '2024-09-20', 2);

INSERT INTO CourierServices (ServiceID, ServiceName, Cost)
VALUES 
(1, 'Standard Delivery', 10.00),
(2, 'Express Delivery', 20.00);

INSERT INTO Employee (EmployeeID, Name, Email, ContactNumber, Role, Salary)
VALUES 
(1, 'Mike Wilson', 'mike@courier.com', '555-1234', 'Driver', 35000.00),
(2, 'Sarah Lee', 'sarah@courier.com', '555-5678', 'Customer Service', 32000.00);

INSERT INTO Location (LocationID, LocationName, Address)
VALUES 
(1, 'City Center', '100 Main Plaza, City'),
(2, 'Suburb Hub', '200 Green Ave, Suburb');

INSERT INTO Payment (PaymentID, CourierID, LocationID, Amount, PaymentDate)
VALUES 
(1, 1, 1, 15.00, '2024-09-19'),
(2, 2, 2, 12.50, '2024-09-18');

-- SQL Queries

-- Task 2: Select, Where
-- 1. List all customers
SELECT * FROM User;

-- 2. List all orders for a specific customer
SELECT * FROM Courier WHERE UserID = 1;

-- 3. List all couriers
SELECT * FROM Courier;

-- 4. List all packages for a specific order (assuming order is equivalent to courier)
SELECT * FROM Courier WHERE CourierID = 1;

-- 5. List all deliveries for a specific courier
SELECT * FROM Courier WHERE CourierID = 1;

-- 6. List all undelivered packages
SELECT * FROM Courier WHERE Status != 'Delivered';

-- 7. List all packages that are scheduled for delivery today
SELECT * FROM Courier WHERE DeliveryDate = CURDATE();

-- 8. List all packages with a specific status
SELECT * FROM Courier WHERE Status = 'In Transit';

-- 9. Calculate the total number of packages for each courier
SELECT COUNT(*) as TotalPackages, UserID FROM Courier GROUP BY UserID;

-- 10. Find the average delivery time for each courier (assuming DeliveryDate is the completion date)
SELECT UserID, AVG(DATEDIFF(DeliveryDate, CURDATE())) as AvgDeliveryTime 
FROM Courier 
GROUP BY UserID;

-- 11. List all packages with a specific weight range
SELECT * FROM Courier WHERE Weight BETWEEN 1.0 AND 3.0;

-- 12. Retrieve employees whose names contain 'John'
SELECT * FROM Employee WHERE Name LIKE '%John%';

-- 13. Retrieve all courier records with payments greater than $50
SELECT c.* FROM Courier c
JOIN Payment p ON c.CourierID = p.CourierID
WHERE p.Amount > 50;
