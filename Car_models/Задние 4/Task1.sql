# task1
UPDATE employees
SET email='mary.patterso@classicmodelcars.com'
WHERE firstName='Mary' and lastName='Patterson';
SELECT email FROM employees
WHERE firstName='Mary' and lastName='Patterson';

# task2
UPDATE employees
SET lastName='Hill', email='mary.hill@classicmodelcars.com'
WHERE employeeNumber=1056;
SELECT lastName, email FROM employees
WHERE employeeNumber=1056;

# task3
UPdATE employees
SET email=REPLACE(email, '@classicmodelcars.com', '@mysqltutorial.org')
WHERE jobTitle='Sales Rep' and officeCode=6;
SELECT email FROM employees
WHERE jobTitle='Sales Rep' and officeCode=6;

# task4
UPDATE customers
SET salesRepEmployeeNumber = (
    SELECT employeeNumber FROM employees
    WHERE jobTitle='Sales Rep'
    ORDER BY RAND()
    )
WHERE salesRepEmployeeNumber is NULL;
SELECT customerNumber, salesRepEmployeeNumber FROM customers;

# task5
DELETE FROM customers
WHERE country='France'
ORDER BY RAND()
LIMIT 5;

# task6
DELETE  FROM customers_archive
WHERE customerNumber not in (SELECT customerNumber FROM orders)

# task7
DELETE FROM offices
WHERE officeCode=4;

# task8
START TRANSACTION;
SELECT
@orderNumber := MAX(orderNUmber) + 1
FROM
orders;

INSERT INTO orders(
orderNumber,
orderDate,
requiredDate,
shippedDate,
status,
customerNumber)
VALUES(
@orderNumber,
'2005-05-31',
'2005-06-10',
'2005-06-11',
'In Process',
145);
INSERT INTO orderdetails(
orderNumber,
productCode,
quantityOrdered,
priceEach,
orderLineNumber)
VALUES(
@orderNumber,'S18_1749', 30, '136', 1),
(@orderNumber,'S18_2248', 50, '55.09', 2);
COMMIT;

