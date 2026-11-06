-- CREATE TABLE
CREATE TABLE employees (
    id INTEGER PRIMARY KEY,
    name VARCHAR(100),
    department_id INTEGER,
    salary INTEGER
);

--INSERT VALUES INTO TABLE
INSERT INTO employees (id, name, department_id, salary)
VALUES
(1, 'Ali', 10, 50000),
(2, 'John', 20, 60000),
(3, 'Sara', 10, 70000),
(4, 'David', 30, 45000),
(5, 'Ahmed', 20, 60000);

-- SHOW TABLE
SELECT * FROM employees;

SELECT * FROM departments;



/* Q1. Find the highest salary. */
SELECT MAX(salary) AS Highest_salary
FROM employees;


-- Q2. Find the second-highest distinct salary.
SELECT DISTINCT salary 
FROM employees
ORDER BY salary DESC
OFFSET 1
LIMIT 1;

-- Q3. Find average salary department-wise.
SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id




