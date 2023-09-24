SELECT lastName, firstName FROM employees
WHERE jobTitle='Sales Rep';

SELECT lastName, firstName, officeCode, jobTitle FROM employees
WHERE jobTitle='Sales Rep' and officeCode='1';

SELECT lastName, firstName, officeCode, jobTitle FROM employees
WHERE jobTitle='Sales Rep' or officeCode='1'
ORDER BY officeCode, jobTitle;

SELECT lastName, firstName, officeCode FROM employees
WHERE officeCode BETWEEN '1' AND  '3'
ORDER BY officeCode;

SELECT lastName, firstName, officeCode FROM employees
WHERE lastName LIKE '%son'
ORDER BY lastName;

SELECT lastName, firstName, officeCode FROM employees
WHERE officeCode in ('1', '2', '3')
ORDER BY officeCode;

SELECT lastName, firstName FROM employees
WHERE reportsTo is NULL;

SELECT lastName, firstName, jobTitle FROM employees
WHERE jobTitle != 'Sales Rep';

SELECT lastName, firstName, officeCode FROM employees
WHERE officeCode > '5';

SELECT lastName, firstName, officeCode FROM employees
WHERE officeCode < '4';

SELECT DISTINCT lastName FROM employees