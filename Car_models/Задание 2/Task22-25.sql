# 2.1
SELECT DISTINCT status FROM orders;

# 2.2
SELECT status FROM orders
group by status;

# 2.3
SELECT status, COUNT(*) FROM orders
group by status;

# 2.4
SELECT status, SUM(cost) as costs FROM orders
              JOIN (SELECT orderNumber, quantityOrdered*priceEach as cost FROM orderdetails) as f USING(orderNumber)
group by status;

