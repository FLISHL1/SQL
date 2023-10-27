# task1
DELIMITER //

CREATE procedure GetCustomers()
BEGIN
     select * from customers;
end //;

DELIMITER ;

CALL GetCustomers();


# task2
DELIMITER $$
CREATE PROCEDURE GetTotalOrder()
BEGIN
    DECLARE totalOrder INT DEFAULT 0;
    SELECT COUNT(*)
        INTO totalOrder
        FROM orders;
    SELECT totalOrder;
END$$
DELIMITER ;

CALL GetTotalOrder();

# task3
DELIMITER //
CREATE PROCEDURE GetOfficeByCountry(IN countryName VARCHAR(255))
BEGIN
    SELECT * FROM offices
    WHERE country = countryName;
END //
DELIMITER ;

CALL GetOfficeByCountry('France');

# task4
DELIMITER $$
CREATE PROCEDURE GetOrderCountByStatus (IN orderStatus VARCHAR(25), OUT total INT)
BEGIN
SELECT COUNT(orderNumber) INTO total
FROM orders
WHERE status = orderStatus;
END$$
DELIMITER ;

CALL GetOrderCountByStatus('in process', @total);
SELECT @total;

# task5
DELIMITER $$
CREATE PROCEDURE SetCounter(INOUT counter INT, IN inc INT
)
BEGIN
SET counter = counter + inc;
END$$
DELIMITER ;

SET @counter = 1;
CALL SetCounter(@counter, 1);
CALL SetCounter(@counter, 1);
CALL SetCounter(@counter, 5);
SELECT @counter;

# task6
DELIMITER $$
CREATE PROCEDURE GetCustomerLevel(IN pCustomerNumber INT, OUT pCustomerLevel VARCHAR(20))
BEGIN
DECLARE credit DECIMAL(10,2) DEFAULT 0;
SELECT creditLimit INTO credit FROM customers
WHERE customerNumber = pCustomerNumber;
IF credit > 50000 THEN
SET pCustomerLevel = 'PLATINUM';
END IF;
END$$
DELIMITER ;

CALL GetCustomerLevel(151, @level);
SELECT @level;


# task7
DELIMITER $$
DROP PROCEDURE GetCustomerLevel$$
CREATE PROCEDURE GetCustomerLevel(
IN pCustomerNumber INT,
OUT pCustomerLevel VARCHAR(20))
BEGIN
DECLARE credit DECIMAL DEFAULT 0;
SELECT creditLimit
INTO credit
FROM customers
WHERE customerNumber = pCustomerNumber;
IF credit > 50000 THEN
SET pCustomerLevel = 'PLATINUM';
ELSE
SET pCustomerLevel = 'NOT PLATINUM';
END IF;
END$$
DELIMITER ;

CALL GetCustomerLevel(447, @level);
SELECT @level;

# task8
DELIMITER $$
CREATE PROCEDURE GetCustomerShipping(IN pCustomerNUmber INT, OUT pShipping VARCHAR(50)
)
BEGIN
DECLARE customerCountry VARCHAR(100);
SELECT
country INTO customerCountry FROM customers
WHERE customerNumber = pCustomerNUmber;
CASE customerCountry
WHEN 'USA' THEN SET pShipping = '2-day Shipping';
WHEN 'Canada' THEN SET pShipping = '3-day Shipping';
ELSE
SET pShipping = '5-day Shipping';
END CASE;
END$$
DELIMITER ;


CALL GetCustomerShipping(112, @shipping);
SELECT @shipping;

# task9
DELIMITER $$
CREATE PROCEDURE GetDeliveryStatus(IN pOrderNumber INT, OUT pDeliveryStatus VARCHAR(100)
)
BEGIN
DECLARE waitingDay INT DEFAULT 0;

SELECT DATEDIFF(requiredDate, shippedDate) INTO waitingDay
FROM orders
WHERE orderNumber = pOrderNumber;

CASE
WHEN waitingDay = 0 THEN SET pDeliveryStatus = 'On Time';
WHEN waitingDay >= 1 AND waitingDay < 5 THEN SET pDeliveryStatus = 'Late';
WHEN waitingDay >= 5 THEN SET pDeliveryStatus = 'Very Late';
ELSE
SET pDeliveryStatus = 'No Information';
END CASE;

END$$
DELIMITER ;

CALL GetDeliveryStatus(10100, @delivery);
SELECT @delivery;

# task10
# DELIMITER $$
# CREATE PROCEDURE loops(IN num int)
# begin
#
# end $$


# task13
DELIMITER $$
CREATE PROCEDURE createEmailList (INOUT emailList varchar(4000))
BEGIN
DECLARE finished INTEGER DEFAULT 0;

DECLARE emailAddress varchar(100) DEFAULT '';

DEClARE curEmail CURSOR

FOR SELECT email FROM employees;

DECLARE CONTINUE HANDLER
FOR NOT FOUND SET finished = 1;

OPEN curEmail;
getEmail: LOOP
FETCH curEmail INTO emailAddress;
IF finished = 1 THEN
LEAVE getEmail;
END IF;
SET emailList = CONCAT(emailAddress,';',emailList);
END LOOP getEmail;
CLOSE curEmail;
END$$
DELIMITER ;