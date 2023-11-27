#task1
CREATE TABLE employees_audit
(
    id             INT AUTO_INCREMENT PRIMARY KEY,
    employeeNumber INT         NOT NULL,
    lastname       VARCHAR(50) NOT NULL,
    changedat      DATETIME    DEFAULT NULL,
    action         VARCHAR(50) DEFAULT NULL
);
CREATE TRIGGER before_employee_update
    BEFORE UPDATE
    ON employees
    FOR EACH ROW
    INSERT INTO employees_audit
    SET action         = 'update',
        employeeNumber = OLD.employeeNumber,
        lastname       = OLD.lastname,
        changedat      = NOW();
UPDATE employees
SET lastName = 'Phan'
WHERE employeeNumber = 1056;

# task2
CREATE TABLE price_logs
(
    id          INT AUTO_INCREMENT,
    productCode VARCHAR(15)    NOT NULL,
    price       DECIMAL(10, 2) NOT NULL,
    updated_at  TIMESTAMP      NOT NULL
        DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    FOREIGN KEY (productCode)
        REFERENCES products (productCode)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
DELIMITER $$
CREATE TRIGGER before_products_update
    BEFORE UPDATE
    ON products
    FOR EACH ROW
BEGIN
    IF OLD.msrp <> NEW.msrp THEN
        INSERT INTO price_logs(productCode, price)
        VALUES (OLD.productCode, OLD.msrp);
    END IF;
END$$
DELIMITER ;

UPDATE products
SET msrp = 200
WHERE productCode = 'S12_1099';

# task3
CREATE TABLE billings
(
    billingNo   INT AUTO_INCREMENT,
    customerNo  INT,
    billingDate DATE,
    amount      DEC(10, 2),
    PRIMARY KEY (billingNo)
);

DELIMITER $$
CREATE TRIGGER before_billing_update
    BEFORE UPDATE
    ON billings
    FOR EACH ROW
BEGIN
    IF NEW.amount > OLD.amount * 10 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'New amount cannot be 10 times
greater than the current amount.';
    END IF;
END$$
DELIMITER ;

UPDATE billings
SET amount = 100000
WHERE billingNo = 1;

# task4
CREATE TABLE work_centers
(
    id       INT AUTO_INCREMENT PRIMARY KEY,
    name     VARCHAR(100) NOT NULL,
    capacity INT          NOT NULL
);
CREATE TABLE work_center_stats
(
    totalCapacity INT NOT NULL
);

DELIMITER $$
CREATE TRIGGER before_workcenters_insert
    BEFORE INSERT
    ON work_centers
    FOR EACH ROW
BEGIN
    DECLARE rowcount INT;
    SELECT COUNT(*)
    INTO rowcount
    FROM work_center_stats;
    IF rowcount > 0 THEN
        UPDATE work_center_stats
        SET totalCapacity = totalCapacity + NEW.capacity;
    ELSE
        INSERT INTO work_center_stats(totalCapacity)
        VALUES (NEW.capacity);
    END IF;
END $$
DELIMITER ;

INSERT INTO work_centers
    (name, capacity)
VALUES ('test', 10);

# task5
CREATE TABLE members
(
    id        INT AUTO_INCREMENT,
    name      VARCHAR(100) NOT NULL,
    email     VARCHAR(255),
    birthDate DATE,
    PRIMARY KEY (id)
);
CREATE TABLE reminders
(
    id       INT AUTO_INCREMENT,
    memberId INT,
    message  VARCHAR(255) NOT NULL,
    PRIMARY KEY (id, memberId)
);

DELIMITER $$
CREATE TRIGGER after_members_insert
    AFTER INSERT
    ON members
    FOR EACH ROW
BEGIN
    IF NEW.birthDate IS NULL THEN
        INSERT INTO reminders(memberId, message)
        VALUES (NEW.id, CONCAT('Hi ', NEW.name, ', please
update your date of birth.'));
    END IF;
END$$
DELIMITER ;

INSERT INTO members
    (name, email, birthDate)
VALUES ('Kirill', 'test@email.ru', null);

# Мой триггер
CREATE TRIGGER inserts
    AFTER INSERT
    ON customers
    FOR EACH ROW
BEGIN
    IF NEW.country is NUll THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Country dont is null.';
    END IF;
end;

# task6
CREATE TABLE sales
(
    id          INT AUTO_INCREMENT,
    product     VARCHAR(100) NOT NULL,
    quantity    INT          NOT NULL DEFAULT 0,
    fiscalYear  SMALLINT     NOT NULL,
    fiscalMonth TINYINT      NOT NULL,
    CHECK (fiscalMonth >= 1 AND fiscalMonth <= 12),
    CHECK (fiscalYear BETWEEN 2000 and 2050),
    CHECK (quantity >= 0),
    UNIQUE (product, fiscalYear, fiscalMonth),
    PRIMARY KEY (id)
);

INSERT INTO sales(product, quantity, fiscalYear, fiscalMonth)
VALUES ('2003 Harley-Davidson Eagle Drag Bike', 120, 2020, 1),
       ('1969 Corvair Monza', 150, 2020, 1),
       ('1970 Plymouth Hemi Cuda', 200, 2020, 1);

DELIMITER $$
CREATE TRIGGER before_sales_update
    BEFORE UPDATE
    ON sales
    FOR EACH ROW
BEGIN
    DECLARE errorMessage VARCHAR(255);
    SET errorMessage = CONCAT('The new quantity ',
                              NEW.quantity, ' cannot be 3 times greater than the current
quantity ', OLD.quantity);
    IF new.quantity > OLD.quantity * 3 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = errorMessage;
    END IF;
END $$
DELIMITER ;

UPDATE sales
SET quantity = quantity * 4
WHERE id = 1;

# task7
DROP TABLE IF EXISTS sales;
CREATE TABLE sales
(
    id          INT AUTO_INCREMENT,
    product     VARCHAR(100) NOT NULL,
    quantity    INT          NOT NULL DEFAULT 0,
    fiscalYear  SMALLINT     NOT NULL,
    fiscalMonth TINYINT      NOT NULL,
    CHECK (fiscalMonth >= 1 AND fiscalMonth <= 12),
    CHECK (fiscalYear BETWEEN 2000 and 2050),
    CHECK (quantity >= 0),
    UNIQUE (product, fiscalYear, fiscalMonth),
    PRIMARY KEY (id)
);
CREATE TABLE sales_changes
(
    id             INT AUTO_INCREMENT PRIMARY KEY,
    salesId        INT,
    beforeQuantity INT,
    afterQuantity  INT,
    changedAt      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


INSERT INTO sales(product, quantity, fiscalYear, fiscalMonth)
VALUES ('2001 Ferrari Enzo', 140, 2021, 1),
       ('1998 Chrysler Plymouth Prowler', 110, 2021, 1),
       ('1913 Ford Model T Speedster', 120, 2021, 1);

DELIMITER $$
CREATE TRIGGER after_sales_update
    AFTER UPDATE
    ON sales
    FOR EACH ROW
BEGIN
    IF OLD.quantity <> NEW.quantity THEN
        INSERT INTO sales_changes(salesId, beforeQuantity,
                                  afterQuantity)
        VALUES (OLD.id, OLD.quantity, NEW.quantity);
    END IF;
END$$
DELIMITER ;

