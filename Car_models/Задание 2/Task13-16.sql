SELECT employeeNumber, customers.customerNumber, payments.checkNumber FROM employees
    LEFT JOIN customers ON salesRepEmployeeNumber=employees.employeeNumber
    JOIN payments ON payments.customerNumber=customers.customerNumber
WHERE  jobTitle='Sales Rep'
ORDER BY employeeNumber;


SELECT * FROM orders
    JOIN orderdetails ON orders.orderNumber = orderdetails.orderNumber and orders.orderNumber=10123;


SELECT employeeNumber, customers.customerNumber FROM employees
    RIGHT JOIN customers ON salesRepEmployeeNumber=employees.employeeNumber
WHERE employeeNumber is not NULL
ORDER BY employeeNumber;


SELECT employeeNumber, customers.customerNumber FROM employees
    LEFT JOIN customers ON salesRepEmployeeNumber=employees.employeeNumber
WHERE customers.customerNumber is NULL and jobTitle='Sales Rep'
ORDER BY employeeNumber;