# task 1
SELECT employees.* FROM employees
JOIN offices USING (officeCode)
WHERE country='USA';

# task 2
SELECT customerNumber FROM payments
WHERE amount = (SELECT MAX(f.amount) FROM payments as f);

# task 3
SELECT customerNumber FROM payments
WHERE amount >= (SELECT AVG(amount) FROM payments);

# task 4
SELECT contactFirstName FROM customers
WHERE (SELECT COUNT(orderNumber) FROM orders WHERE orders.customerNumber=customers.customerNumber) = 0;

# task 5
SELECT max, ROUND(avg), min FROM (
SELECT MAX(quantityOrdered) as max, AVG(quantityOrdered) as avg, MIN(quantityOrdered) as min FROM orderdetails) as f;

# task 6
SELECT productCode FROM products
WHERE MSRP > (SELECT AVG(f.MSRP) FROM products as f
                               WHERE f.productLine=products.productLine);

# task 7
SELECT orderNumber FROM orders
WHERE (SELECT SUM(quantityOrdered*priceEach) FROM orderdetails
                                             WHERE orderdetails.orderNumber=orders.orderNumber) > 60000;

# task 8
SELECT DISTINCT customerNumber FROM customers
WHERE EXISTS (SELECT orderNumber FROM orders
    WHERE (SELECT SUM(quantityOrdered*priceEach) FROM orderdetails
                                             WHERE orderdetails.orderNumber=orders.orderNumber) > 60000 AND orders.customerNumber=customers.customerNumber);

# task 9
SELECT productCode FROM orderdetails
WHERE orderNumber in (SELECT orderNumber FROM orders WHERE YEAR(orderDate) = '2003')
GROUP BY productCode
ORDER BY SUM(quantityOrdered*priceEach) DESC
LIMIT 5;

# task 10
SELECT productName FROM orderdetails
JOIN products USING (productCode)
WHERE orderNumber in (SELECT orderNumber FROM orders WHERE YEAR(orderDate) = '2003')
GROUP BY productCode
ORDER BY SUM(quantityOrdered*priceEach) DESC
LIMIT 5;

# task 11
SELECT customerNumber, ROUND(SUM(quantityOrdered*priceEach)) sales,
(CASE
WHEN SUM(quantityOrdered*priceEach) < 10000 THEN 'Silver'
WHEN SUM(quantityOrdered*priceEach) BETWEEN 10000 AND 100000 THEN 'Gold'
WHEN SUM(quantityOrdered*priceEach) > 100000 THEN 'Platinum'
END) customerGroup
FROM orderdetails
INNER JOIN orders USING (orderNumber)
WHERE YEAR(shippedDate) = 2003
GROUP BY customerNumber;

# task 12
SELECT customerGroup, COUNT(cg.customerGroup) AS groupCount
FROM (SELECT customerNumber, ROUND(SUM(quantityOrdered*priceEach)) sales,
(CASE
WHEN SUM(quantityOrdered*priceEach) < 10000 THEN 'Silver'
WHEN SUM(quantityOrdered*priceEach) BETWEEN 10000 AND 100000 THEN 'Gold'
WHEN SUM(quantityOrdered*priceEach) > 100000 THEN 'Platinum'
END) customerGroup FROM
orderdetails
INNER JOIN orders USING (orderNumber)
WHERE YEAR(shippedDate) = 2003
GROUP BY customerNumber) cg
GROUP BY cg.customerGroup;

