-- ==========================================
-- Assignment 5: Transactions, Logic & Analysis
-- Database: company_db
-- ==========================================

USE company_db;

-- ==========================================
-- Task 1: Transaction to Transfer Salary
-- Transfer 1000 salary from employee_id 4 to employee_id 10
-- ==========================================

START TRANSACTION;

UPDATE employees
SET salary = salary - 1000
WHERE employee_id = 4;

UPDATE employees
SET salary = salary + 1000
WHERE employee_id = 10;

COMMIT;


-- ==========================================
-- Task 2: Departments with Employees
-- Using EXISTS
-- ==========================================

SELECT
    department_id,
    department_name
FROM departments d
WHERE EXISTS (
    SELECT *
    FROM employees e
    WHERE e.department_id = d.department_id
);


-- ==========================================
-- Task 3: Recursive CTE for Employee Hierarchy
-- ==========================================

WITH RECURSIVE employee_hierarchy AS (

    SELECT
        employee_id,
        first_name,
        manager_id,
        1 AS level
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    SELECT
        e.employee_id,
        e.first_name,
        e.manager_id,
        eh.level + 1
    FROM employees e
    JOIN employee_hierarchy eh
    ON e.manager_id = eh.employee_id
)

SELECT *
FROM employee_hierarchy;


-- ==========================================
-- Task 4: LEAD and LAG for Salaries
-- ==========================================

SELECT
    employee_id,
    first_name,
    salary,

    LAG(salary) OVER (
        ORDER BY salary
    ) AS previous_salary,

    LEAD(salary) OVER (
        ORDER BY salary
    ) AS next_salary

FROM employees;


-- ==========================================
-- Task 5: Salary Totals with ROLLUP
-- ==========================================

SELECT
    department_id,
    SUM(salary) AS total_salary
FROM employees
GROUP BY department_id WITH ROLLUP;


-- ==========================================
-- Task 6: Export Database Structure and Data
-- Run this command in CMD (not MySQL)
-- ==========================================

-- mysqldump -u root -p company_db > company_db_backup.sql