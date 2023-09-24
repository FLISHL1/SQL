SELECT orders.orderNumber, status, SUM(cost) as costs FROM
                                (SELECT orderNumber, quantityOrdered*priceEach as cost FROM orderdetails) as sum_price
                                JOIN orders ON sum_price.orderNumber=orders.orderNumber
GROUP BY 1;