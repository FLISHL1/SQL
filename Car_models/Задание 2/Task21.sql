SELECT DISTINCT LEAST(c1.customerName, c2.customerName) as customer1, GREATEST(c1.customerName, c2.customerName) as customer2, c1.city FROM customers as c1
    JOIN customers as c2 ON c1.city=c2.city and c1.customerNumber!=c2.customerNumber
ORDER BY c1.city;

