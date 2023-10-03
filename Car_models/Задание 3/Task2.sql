# task 1
SELECT customerNumber FROM customers
WHERE  EXISTS(SELECT orderNumber FROM orders WHERE orders.customerNumber=customers.customerNumber);

# task 2
SELECT customerNumber FROM customers
WHERE NOT EXISTS(SELECT orderNumber FROM orders WHERE orders.customerNumber=customers.customerNumber);

# task 3


# task 4


# task 5
CREATE TABLE customers_archive
LIKE customers;

INSERT INTO customers_archive
SELECT  FROM customers
WHERE NOT EXISTS(SELECT orderNumber FROM orders WHERE orders.customerNumber=customers.customerNumber);
