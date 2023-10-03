SELECT orderNumber, SUM(quantityOrdered*priceEach) as costs FROM orderdetails
GROUP BY orderNumber
HAVING costs >=60000;