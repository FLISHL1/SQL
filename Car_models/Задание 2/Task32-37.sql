# 2.10
SELECT productLine, SUM(orderValue) as sum_sales FROM sales
GROUP BY productLine;

# 2.11
SELECT SUM(orderValue) as sum_sales FROM sales;

# 2.12
SELECT productLine, SUM(orderValue) as sum_sales FROM sales
GROUP BY productLine
UNION SELECT 'All_Sum', SUM(orderValue) as sum_sales FROM sales;

# 2.13
SELECT productLine, SUM(orderValue) as sum_sales FROM sales
GROUP BY productLine WITH ROLLUP;

# 2.14
SELECT productLine, orderYear, SUM(orderValue) as totalOrderValue FROM sales
GROUP BY orderYear, productLine WITH ROLLUP;

# 2.15
SELECT productLine, orderYear, SUM(orderValue) as totalOrderValue FROM sales
GROUP BY  productLine, orderYear WITH ROLLUP;
