SELECT lastName, firstName FROM employees
ORDER BY lastName;

SELECT contactFirstName, contactLastName,  COUNT(orderNumber) as count_order FROM customers JOIN orders ON customers.customerNumber=orders.customerNumber
GROUP BY contactFirstName, contactLastName
order by contactFirstName;