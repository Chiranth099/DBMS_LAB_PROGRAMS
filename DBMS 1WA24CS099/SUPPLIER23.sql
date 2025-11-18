create database supplier23;
use supplier23;

CREATE TABLE supplier23 (
	sid int PRIMARY KEY,
    sname varchar(10),
    city varchar(20)
    );
    
CREATE TABLE parts (
    pid int PRIMARY KEY,
    pname varchar(20),
    color varchar(10)
    );
    
CREATE TABLE catalog1 (
    sid int,
    pid int,
    cost decimal(10,2),
    PRIMARY KEY(sid,pid),
    FOREIGN KEY (sid) REFERENCES supplier23(sid),
    FOREIGN KEY (pid) REFERENCES parts(pid)
    );
    
    INSERT INTO supplier23 VALUES
(1, 'Rama', 'Bengaluru'),
(2, 'Suresh', 'Mysuru'),
(3, 'Kiran', 'Chennai'),
(4, 'Megha', 'Hyderabad'),
(5, 'Asha', 'Pune');

INSERT INTO parts VALUES
(101, 'Bolt', 'Red'),
(102, 'Nut', 'Blue'),
(103, 'Screw', 'Black'),
(104, 'Washer', 'Red'),
(105, 'Gear', 'Silver');

INSERT INTO catalog1 VALUES
(1, 101, 25.50),
(1, 102, 15.75),
(2, 103, 10.00),
(2, 104, 12.50),
(3, 101, 24.00),
(3, 105, 55.00),
(4, 102, 14.50),
(4, 105, 52.00),
(5, 104, 13.00);

SELECT DISTINCT p.pname
FROM parts p
JOIN catalog1 c ON p.pid = c.pid;

SELECT s.sname
FROM supplier23 s
JOIN catalog1 c ON s.sid = c.sid
GROUP BY s.sid, s.sname
HAVING COUNT(c.pid) = (SELECT COUNT(*) FROM parts);

SELECT s.sname
FROM supplier23 s
JOIN catalog1 c ON s.sid = c.sid
JOIN parts p ON c.pid = p.pid
WHERE p.color = 'Red'
GROUP BY s.sid, s.sname
HAVING COUNT(p.pid) = (
    SELECT COUNT(*) FROM parts WHERE color = 'Red'
);

SELECT p.pname
FROM parts p
JOIN catalog1 c ON p.pid = c.pid
JOIN supplier23 s ON s.sid = c.sid
WHERE s.sname = 'Acme Widget Suppliers'
AND p.pid NOT IN (
    SELECT c2.pid
    FROM catalog1 c2
    JOIN supplier23 s2 ON s2.sid = c2.sid
    WHERE s2.sname <> 'Acme Widget Suppliers'
);

SELECT DISTINCT c.sid
FROM catalog1 c
JOIN (
    SELECT pid, AVG(cost) AS avg_cost
    FROM catalog1
    GROUP BY pid
) A ON c.pid = A.pid
WHERE c.cost > A.avg_cost;

SELECT p.pname, s.sname
FROM parts p
JOIN catalog1 c ON p.pid = c.pid
JOIN supplier23 s ON c.sid = s.sid
WHERE (p.pid, c.cost) IN (
    SELECT pid, MAX(cost)
    FROM catalog1
    GROUP BY pid
);

