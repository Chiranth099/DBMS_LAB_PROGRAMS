create database bank31;
use bank31;


CREATE TABLE Branch1(
    branch_name VARCHAR(30) PRIMARY KEY,
    branch_city VARCHAR(30),
    assets DECIMAL(12,2)
);

CREATE TABLE BankCustomer1 (
    customer_name VARCHAR(30) PRIMARY KEY,
    customer_street VARCHAR(50),
    customer_city VARCHAR(30)
);

CREATE TABLE BankAccount1 (
    accno INT PRIMARY KEY,
    branch_name VARCHAR(30),
    balance DECIMAL(12,2),
    FOREIGN KEY (branch_name) REFERENCES Branch1(branch_name)
);

CREATE TABLE Depositer1 (
    customer_name VARCHAR(30),
    accno INT,
    PRIMARY KEY (customer_name),
    FOREIGN KEY (customer_name) REFERENCES BankCustomer1(customer_name),
    FOREIGN KEY (accno) REFERENCES BankAccount1(accno)
);

CREATE TABLE Loan (
    loan_no INT PRIMARY KEY,
    branch_name VARCHAR(30),
    amount DECIMAL(12,2),
    customer_name VARCHAR(30),
    FOREIGN KEY (branch_name) REFERENCES Branch1(branch_name),
    FOREIGN KEY (customer_name) REFERENCES BankCustomer1(customer_name)
);

INSERT INTO Branch1 VALUES
('Mumbai_Main', 'Mumbai', 12000000),
('Delhi_Central', 'Delhi', 9500000),
('Bangalore_Indiranagar', 'Bangalore', 8800000),
('Chennai_Town', 'Chennai', 6500000),
('Kolkata_Sector7', 'Kolkata', 7200000);

INSERT INTO BankCustomer1 VALUES
('Amit Sharma', 'MG Road', 'Mumbai'),
('Priya Singh', 'Connaught Place', 'Delhi'),
('Rahul Mehta', 'Anna Nagar', 'Chennai'),
('Sneha Das', 'Salt Lake', 'Kolkata'),
('John Paul', 'Bandra', 'Mumbai'),
('Ria Nair', 'Indiranagar', 'Bangalore'),
('Aditya Jain', 'Whitefield', 'Bangalore');

INSERT INTO BankAccount1 VALUES
(1001, 'Mumbai_Main', 50000),
(1002, 'Mumbai_Main', 125000),
(2001, 'Delhi_Central', 60000),
(3001, 'Chennai_Town', 45000),
(4001, 'Kolkata_Sector7', 30000),
(5001, 'Bangalore_Indiranagar', 200000),
(5002, 'Bangalore_Indiranagar', 95000);

INSERT INTO Depositer1 VALUES
('Amit Sharma', 1001),
('John Paul', 1002),
('Priya Singh', 2001),
('Rahul Mehta', 3001),
('Sneha Das', 4001),
('Ria Nair', 5001),
('Aditya Jain', 5001),
('Aditya Jain', 5002);   -- Aditya has 2 accounts

INSERT INTO Loan VALUES
(9001, 'Mumbai_Main', 500000, 'Amit Sharma'),
(9002, 'Delhi_Central', 300000, 'Priya Singh'),
(9003, 'Bangalore_Indiranagar', 750000, 'Ria Nair'),
(9004, 'Chennai_Town', 200000, 'Rahul Mehta');


SELECT D.customer_name
FROM Depositer1 D
JOIN BankAccount1 A ON D.accno = A.accno
JOIN Branch1 B ON A.branch_name = B.branch_name
WHERE B.branch_city = 'Delhi'
GROUP BY D.customer_name
HAVING COUNT(DISTINCT A.branch_name) = (
    SELECT COUNT(*) 
    FROM Branch1 
    WHERE branch_city = 'Delhi'
);

SELECT L.customer_name
FROM Loan L
WHERE L.customer_name NOT IN (
    SELECT D.customer_name FROM Depositer1 D
);

SELECT DISTINCT D.customer_name
FROM Depositer1 D
JOIN BankAccount1 A ON D.accno = A.accno
JOIN Branch1 B ON A.branch_name = B.branch_name
JOIN Loan L ON D.customer_name = L.customer_name
WHERE B.branch_city = 'Bangalore' 
  AND L.branch_name IN (
      SELECT branch_name FROM Branch1 WHERE branch_city = 'Bangalore'
  );
  
  SELECT branch_name
FROM Branch1
WHERE assets > ALL (
    SELECT assets 
    FROM Branch1 
    WHERE branch_city = 'Bangalore'
);

DELETE FROM BankAccount1
WHERE branch_name IN (
    SELECT branch_name 
    FROM Branch1 
    WHERE branch_city = 'Mumbai'
);

UPDATE BankAccount1
SET balance = balance * 1.05
WHERE accno > 0;
SELECT * FROM BankAccount1;


