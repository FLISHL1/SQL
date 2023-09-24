# 2.6
SELECT YEAR(orderDate) as year, SUM(cost) as sum_sales FROM (SELECT orderNumber, quantityOrdered*priceEach as cost, status, orderDate FROM orders JOIN orderdetails USING (orderNumber)) as f
WHERE status='Shipped'
GROUP BY YEAR(orderDate);

# 2.7
SELECT YEAR(orderDate) as year, SUM(cost) as sum_sales FROM (SELECT orderNumber, quantityOrdered*priceEach as cost, status, orderDate FROM orders JOIN orderdetails USING (orderNumber)) as f
WHERE status='Shipped'
GROUP BY 1
HAVING year!=2003;
