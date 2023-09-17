SELECT * FROM employees
WHERE firstName LIKE 'a%';

SELECT * FROM employees
WHERE lastName LIKE '%on';

SELECT * FROM employees
WHERE lastName LIKE '%on%';

SELECT * FROM employees
WHERE firstName LIKE 'T_m';

SELECT * FROM employees
WHERE lastName LIKE 'B%';

SELECT * FROM products
WHERE productCode LIKE '%_20%'
