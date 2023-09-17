SELECT lastName, reportsTo FROM employees
ORDER BY IF(reportsTo is NULL, -1, reportsTo);

SELECT lastName, reportsTo FROM employees
ORDER BY IF(reportsTo is NULL, -1, reportsTo) DESC;
