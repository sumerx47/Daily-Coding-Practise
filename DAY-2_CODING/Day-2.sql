-- CREATE TABLE EMPLOYEES
CREATE TABLE employees (
    id INTEGER PRIMARY KEY,
    name VARCHAR(100),
    department_id INTEGER,
    salary INTEGER
);

-- CREATE TABLE DEPARTMENTS
CREATE TABLE departments (
    id INTEGER PRIMARY KEY,
    department_name VARCHAR(100)
);

--INSERT VALUES INTO EMPLOYEES TABLE
INSERT INTO employees (id, name, department_id, salary)
VALUES
(1, 'Ali', 10, 50000),
(2, 'John', 20, 60000),
(3, 'Sara', 10, 70000),
(4, 'David', 30, 45000),
(5, 'Ahmed', 20, 60000);

--INSERT VALUES INTO DEPARTMENTS TABLE
INSERT INTO departments (id, department_name)
VALUES
(10, 'IT'),
(20, 'HR'),
(30, 'Finance');


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

-- Q4. Find departments having average salary above 50,000.
SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id
HAVING AVG(salary) > 50000;

-- Q5. Find employees earning more than the average salary.
SELECT * FROM employees
WHERE salary > (
	SELECT AVG(salary) FROM employees
);

-- Q6. Display employee names with department names.
SELECT e.name, d.department_name
FROM employees e
INNER JOIN departments d
ON e.department_id = d.id

-- Q7. Find duplicate salaries.
SELECT salary, COUNT(*)
FROM employees
GROUP BY salary
HAVING COUNT(*) > 1;

-- Q8. Rank employees based on salary.
SELECT name, salary, DENSE_RANK() OVER(
ORDER BY salary DESC) AS salary_rank
FROM employees;


/*
      SQL operators you must understand

| Operator     | Purpose                          |
| ------------ | -------------------------------- |
| `WHERE` →    | Filters rows before grouping     |
| `ORDER BY` → | Sorts results                    |
| `GROUP BY` → | Groups rows                      |
| `HAVING` →   | Filters groups                   |
| `DISTINCT` → | Removes duplicate results        |
| `LIMIT` →    | Restricts returned rows          |
| `OFFSET` →   | Skips rows                       |
| `BETWEEN` →  | Checks a range                   |
| `IN` →       | Matches multiple possible values |
| `LIKE` →     | Pattern matching                 |
| `JOIN` →     | Combines tables                  |
| `COUNT` →    | Counts rows or values            |
| `COALESCE` → | Replaces NULL with a fallback    |
| `CASE` →     | Conditional SQL expression       |

*/



