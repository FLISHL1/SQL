SELECT orderNumber, SUM(cost) as costs FROM (SELECT orderNumber, quantityOrdered*priceEach as cost FROM orderdetails) as f
GROUP BY orderNumber
HAVING costs >=60000;