# 2.5
SELECT f1.costs, COUNT(orderNumber) FROM (SELECT orderNumber, SUM(cost) as costs FROM
    (SELECT orderNumber, quantityOrdered*priceEach as cost FROM orderdetails) as f
    GROUP BY orderNumber) as f1
GROUP BY f1.costs;
