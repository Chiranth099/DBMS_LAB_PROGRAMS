create database bank24;
use bank24;


CREATE TABLE Branch (
    branch_name VARCHAR(30) PRIMARY KEY,
    branch_city VARCHAR(30),
    assets DECIMAL(12,2)
);

CREATE TABLE BankCustomer (
    customer_name VARCHAR(30) PRIMARY KEY,
    customer_street VARCHAR(50),
    customer_city VARCHAR(30)
);

CREATE TABLE BankAccount (
    accno INT PRIMARY KEY,
    branch_name VARCHAR(30),
    balance DECIMAL(12,2),
    FOREIGN KEY (branch_name) REFERENCES Branch(branch_name)
);

CREATE TABLE Depositer (
    customer_name VARCHAR(30),
    accno INT,
    PRIMARY KEY (customer_name, accno),
    FOREIGN KEY (customer_name) REFERENCES BankCustomer(customer_name),
    FOREIGN KEY (accno) REFERENCES BankAccount(accno)
);

-- Loan Table added for your Query #7 & #8
CREATE TABLE Loan (
    loan_no INT PRIMARY KEY,
    branch_name VARCHAR(30),
    amount DECIMAL(12,2),
    customer_name VARCHAR(30),
    FOREIGN KEY (branch_name) REFERENCES Branch(branch_name),
    FOREIGN KEY (customer_name) REFERENCES BankCustomer(customer_name)
);

INSERT INTO Branch VALUES
('Mumbai_Main', 'Mumbai', 12000000),
('Delhi_Central', 'Delhi', 9500000),
('Bangalore_Indiranagar', 'Bangalore', 8800000),
('Chennai_Town', 'Chennai', 6500000),
('Kolkata_Sector7', 'Kolkata', 7200000);

INSERT INTO BankCustomer VALUES
('Amit Sharma', 'MG Road', 'Mumbai'),
('Priya Singh', 'Connaught Place', 'Delhi'),
('Rahul Mehta', 'Anna Nagar', 'Chennai'),
('Sneha Das', 'Salt Lake', 'Kolkata'),
('John Paul', 'Bandra', 'Mumbai'),
('Ria Nair', 'Indiranagar', 'Bangalore'),
('Aditya Jain', 'Whitefield', 'Bangalore');

INSERT INTO BankAccount VALUES
(1001, 'Mumbai_Main', 50000),
(1002, 'Mumbai_Main', 125000),
(2001, 'Delhi_Central', 60000),
(3001, 'Chennai_Town', 45000),
(4001, 'Kolkata_Sector7', 30000),
(5001, 'Bangalore_Indiranagar', 200000),
(5002, 'Bangalore_Indiranagar', 95000);

INSERT INTO Depositer VALUES
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

-- list of queries
-- 1
SELECT customer_name, customer_city
FROM BankCustomer
WHERE customer_city = 'Bangalore';

-- 2
SELECT accno, balance
FROM BankAccount
WHERE balance > 100000;

-- 3
SELECT branch_city, SUM(assets) AS total_assets
FROM Branch
GROUP BY branch_city;

-- 4
SELECT B.branch_name, B.branch_city, SUM(A.balance) AS total_deposits
FROM Branch B
JOIN BankAccount A ON B.branch_name = A.branch_name
GROUP BY B.branch_name, B.branch_city;

-- 5
SELECT D.customer_name, COUNT(D.accno) AS number_of_accounts
FROM Depositer D
GROUP BY D.customer_name
HAVING COUNT(D.accno) > 1;

-- 6
SELECT C.customer_name, C.customer_city, A.accno, A.balance, A.branch_name
FROM BankCustomer C
JOIN Depositer D ON C.customer_name = D.customer_name
JOIN BankAccount A ON A.accno = D.accno;

-- 7
SELECT branch_name, AVG(amount) AS avg_loan_amount
FROM Loan
GROUP BY branch_name;

-- 8
SELECT DISTINCT C.customer_name
FROM BankCustomer C
JOIN Depositer D ON C.customer_name = D.customer_name
JOIN BankAccount A ON A.accno = D.accno
WHERE A.branch_name IN (SELECT branch_name FROM Loan);

-- 9
SELECT D.customer_name, SUM(A.balance) AS total_balance
FROM Depositer D
JOIN BankAccount A ON D.accno = A.accno
GROUP BY D.customer_name
ORDER BY total_balance DESC
LIMIT 3;

-- 10
WITH BranchDeposits AS (
    SELECT branch_name, SUM(balance) AS total_deposits
    FROM BankAccount
    GROUP BY branch_name
)
SELECT branch_name, total_deposits
FROM BranchDeposits
WHERE total_deposits = (SELECT MAX(total_deposits) FROM BranchDeposits);

USE bank24;
show tables;
SELECT 
    branch_name,
    (assets / 100000) AS "assets in lakhs"
FROM 
    Branch;

