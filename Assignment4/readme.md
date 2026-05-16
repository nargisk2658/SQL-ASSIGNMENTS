-- Assignment 4: Data Modification & Integrity

USE company_db;

-- 1. Update salary of employees in Sales department by 10%

UPDATE employees
SET salary = salary * 1.10
WHERE department = 'Sales';

SELECT * 
FROM employees
WHERE department = 'Sales';


-- 2. Delete employees working in department named 'Obsolete'

DELETE FROM employees
WHERE department = 'Obsolete';

SELECT * 
FROM employees;


-- 3. Create a view showing high-earning employees (salary > 80000)

CREATE VIEW high_earning_employees AS
SELECT employee_id, employee_name, salary
FROM employees
WHERE salary > 80000;

SELECT * 
FROM high_earning_employees;


-- 4. Add CHECK constraint to ensure salary > 0

ALTER TABLE employees
ADD CONSTRAINT chk_salary
CHECK (salary > 0);

DESCRIBE employees;


-- 5. Create an index on employee last names for faster searching

CREATE INDEX idx_last_name
ON employees(last_name);

SHOW INDEX
FROM employees;


-- 6. Create a stored procedure to retrieve employees of a given department

DELIMITER //

CREATE PROCEDURE GetEmployeesByDepartment(IN dept_name VARCHAR(50))
BEGIN
    SELECT *
    FROM employees
    WHERE department = dept_name;
END //

DELIMITER ;

CALL GetEmployeesByDepartment('Sales');
