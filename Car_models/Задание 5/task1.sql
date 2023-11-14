# task1
DELIMITER $$
CREATE FUNCTION CustomerLevel(
credit DECIMAL(10, 2)
)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
DECLARE customerLevel VARCHAR(20);
IF credit > 50000 THEN

SET customerLevel = 'PLATINUM';

ELSEIF (credit >= 50000 AND
credit <= 10000) THEN
SET customerLevel = 'GOLD';
ELSEIF credit < 10000 THEN
SET customerLevel = 'SILVER';
END IF;
RETURN (customerLevel);
END$$
DELIMITER ;

SELECT
customerName,
CustomerLevel(creditLimit)
FROM
customers
ORDER BY
customerName;

# task2
DROP PROCEDURE GetCustomerLevel;

DELIMITER $$
CREATE PROCEDURE GetCustomerLevel(
IN customerNo INT,
OUT customerLevel VARCHAR(20)
)
BEGIN
DECLARE credit DEC(10, 2) DEFAULT 0;
SELECT
    creditLimit
INTO credit
FROM customers
WHERE

customerNumber = customerNo;

SET customerLevel = CustomerLevel(credit);
END$$
DELIMITER ;

CALL GetCustomerLevel(-131, @customerLevel);
SELECT @customerLevel;

# task3
DELIMITER //
CREATE FUNCTION getOrderDays(orderDate date, requiredDate date)
RETURNS int DETERMINISTIC
BEGIN
    DECLARE days int;
    SET days := DATEDIFF(requiredDate, orderDate);
    return days;

end //

DROP FUNCTION getOrderDays;

DELIMITER //
CREATE FUNCTION getOrderDays(id_order int)
RETURNS int DETERMINISTIC
BEGIN
    DECLARE days int;
    SELECT DATEDIFF(requiredDate, orderDate) into days FROM orders
    WHERE orderNumber = id_order;
    return days;

end //
SELECT getOrderDays(10100);

