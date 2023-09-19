SELECT orderNumber, productCode, priceEach*quantityOrdered as subtotal FROM orderdetails
ORDER BY subtotal DESC;

SELECT orderNumber, status FROM orders
ORDER BY FIELD(status, 'In Process', 'On Hold', 'Cancelled', 'Resolved', 'Disputed', 'Shipped');

