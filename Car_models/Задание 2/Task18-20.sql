SELECT CONCAT(emp.lastName, ' ', emp.firstName) as employ, CONCAT(rep.lastName, ' ', rep.firstName) as reportTo FROM employees as emp JOIN employees as rep ON emp.reportsTo=rep.employeeNumber
WHERE emp.reportsTo is not NULL;


SELECT CONCAT(emp.lastName, ' ', emp.firstName) as employ, CONCAT(rep.lastName, ' ', rep.firstName) as reportTo FROM employees as emp
    LEFT JOIN employees as rep ON emp.reportsTo=rep.employeeNumber;


SELECT firstName FROM employees
WHERE jobTitle='President';
