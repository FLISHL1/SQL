SELECT customerName FROM customers
WHERE salesRepEmployeeNumber is NULL;

SELECT customerName FROM customers
WHERE salesRepEmployeeNumber is not NULL
ORDER BY customerName;