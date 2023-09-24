SELECT * FROM orders
JOIN orderdetails USING (orderNumber)
JOIN products USING (productCode)
ORDER BY orderNumber, productCode;

SELECT * FROM orders
JOIN orderdetails USING (orderNumber)
JOIN products USING (productCode)
JOIN customers USING (customerNumber)
ORDER BY orderNumber, productCode;