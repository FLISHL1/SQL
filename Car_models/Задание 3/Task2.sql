# task 1
SELECT customerNumber FROM customers
WHERE  EXISTS(SELECT orderNumber FROM orders WHERE orders.customerNumber=customers.customerNumber);

# task 2
SELECT customerNumber FROM customers
WHERE NOT EXISTS(SELECT orderNumber FROM orders WHERE orders.customerNumber=customers.customerNumber);

# task 3
# я не могу понять условие

# task 4
# я не могу понять условие

# task 5
# CREATE TABLE customers_archive
# LIKE customers;
#
# INSERT INTO customers_archive
# SELECT * FROM customers
# WHERE NOT EXISTS(SELECT orderNumber FROM orders WHERE orders.customerNumber=customers.customerNumber);

# task 6
DELETE customers FROM customers join customers_archive ca on customers.customerNumber = ca.customerNumber;

# task 7
EXPLAIN SELECT customerNumber FROM customers
WHERE EXISTS(SELECT orderNumber FROM orders WHERE orders.customerNumber=customers.customerNumber);

EXPLAIN SELECT customerNumber FROM customers
WHERE customerNumber in (SELECT orders.customerNumber FROM orders);

# task 8
SELECT employeeNumber FROM employees
WHERE officeCode in (SELECT officeCode FROM offices WHERE city='San Francisco')
