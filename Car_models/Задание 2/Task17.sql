SELECT employeeNumber, SUM(cost_sales) - SUM(cost_product) as receipt  FROM employees
    JOIN customers ON employees.employeeNumber = customers.salesRepEmployeeNumber
    JOIN (SELECT customerNumber, orderDate,quantityOrdered*buyPrice as cost_product, quantityOrdered*priceEach as cost_sales FROM orderdetails
        JOIN orders USING (orderNumber)
        JOIN products USING (productCode)) as f
WHERE orderDate BETWEEN '2005-01-01' AND '2005-01-31'
GROUP BY employeeNumber;
