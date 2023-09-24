SELECT orderNumber, productCode, priceEach, MSRP FROM orderdetails JOIN products USING (productCode)
WHERE productCode='S10_1678' and priceEach < MSRP;

SELECT customers.*, orderNumber FROM customers LEFT JOIN orders USING (customerNumber);

SELECT customers.*, orderNumber FROM customers LEFT JOIN orders USING (customerNumber)
WHERE orderNumber is NULL;