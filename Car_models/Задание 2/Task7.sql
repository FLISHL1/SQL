SELECT orders.orderNumber, status, SUM(quantityOrdered*priceEach) as costs FROM orderdetails as sum_price
JOIN orders USING(orderNumber)
GROUP BY 1;