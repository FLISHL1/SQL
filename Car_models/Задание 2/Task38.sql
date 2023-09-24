# 2.16
SELECT orderYear, productLine, SUM(orderValue) totalOrderValue, GROUPING(orderYear), GROUPING(productLine) FROM sales
GROUP BY orderYear, productline WITH ROLLUP;

# 2.17
SELECT IF(GROUPING(orderYear), 'All Years', orderYear) as orderYear, IF(GROUPING(productLine), 'All Product Lines', productLine) as productLine,
       SUM(orderValue) totalOrderValue FROM sales
GROUP BY orderYear, productline WITH ROLLUP;
