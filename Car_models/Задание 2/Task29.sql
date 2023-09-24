# 2.8
SELECT status, SUM(quantityOrdered) as count FROM orders JOIN orderdetails USING (orderNumber)
GROUP BY status
ORDER BY 2 DESC;

