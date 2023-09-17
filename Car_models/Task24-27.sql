SELECT * FROM customers
WHERE country='USA' and  state='CA';

SELECT * FROM customers
WHERE country='USA' and  state='CA' and creditLimit>=100000;

SELECT * FROM customers
WHERE country in ('USA', 'France');


