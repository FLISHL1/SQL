# task 1
SELECT firstName, lastName FROM employees
UNION SELECT contactFirstName, contactLastName FROM customers
UNION SELECT contactFirstName, contactLastName FROM customers_archive;

# task 2
SELECT orderNumber FROM orders LEFT JOIN orderdetails USING (orderNumber)
WHERE orderdetails.orderNumber IS NULL;

SELECT customerNumber FROM customers_archive LEFT JOIN orders USING (customerNumber)
WHERE orders.customerNumber IS NULL;

# task 3
SELECT DISTINCT customerNumber FROM customers
WHERE customerNumber in (SELECT customerNumber FROM orders);

SELECT DISTINCT customerNumber FROM customers
WHERE customerNumber not in (SELECT customerNumber FROM orders)
UNION SELECT customerNumber FROM customers_archive
WHERE customerNumber not in (SELECT customerNumber FROM orders);


