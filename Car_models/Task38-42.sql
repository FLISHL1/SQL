SELECT * FROM customers
ORDER BY creditLimit DESC
LIMIT 5;

SELECT contactFirstName FROM customers
ORDER BY contactFirstName
LIMIT 10;

SELECT contactFirstName FROM customers
ORDER BY contactFirstName
LIMIT 11, 20;

SELECT contactFirstName FROM customers
ORDER BY creditLimit desc
LIMIT 1 OFFSET 1;

SELECT DISTINCT customerName FROM customers
LIMIT 5;
