CREATE TABLE employees(
	id SERIAL PRIMARY KEY,
	name VARCHAR(100),
	department_id INT,
	salary NUMERIC(10,2)
);

INSERT INTO employees (name, department_id, salary)
VALUES
('Ali', 10, 50000),
('John', 20, 60000),
('Sara', 10, 70000),
('David', 30, 45000),
('Ahmed', 20, 60000),
('Zara', 10, 80000);


SELECT * FROM employees



CREATE TABLE departments(
	id INT PRIMARY KEY,
	department_name VARCHAR(100)
);

INSERT INTO departments(id,department_name)
VALUES
(10,'IT'),
(20,'HR'),
(30,'Finance');

SELECT * FROM departments


-- SQL Problem 1 — Find employees earning above average salary
SELECT *
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);


-- SQL Problem 2 — Find department-wise employee count
SELECT department_id, COUNT(*) AS employee_count
FROM employees
GROUP BY department_id;


-- SQL Problem 3 — Find departments having more than one employee
SELECT department_id, COUNT(*) AS total
FROM employees
GROUP BY department_id
HAVING COUNT(*)> 1;


--SQL Problem 4 — Display employee names with department names
SELECT
    e.name,
    d.department_name
FROM employees e
INNER JOIN departments d
ON e.department_id = d.id;


-- SQL Problem 5 — Find the second-highest distinct salary
SELECT DISTINCT salary
FROM employees
ORDER BY salary DESC 
OFFSET 1
LIMIT 1;


-- SQL Problem 6 — Find employees whose names start with A
SELECT * 
FROM employees
WHERE name LIKE 'A%';


-- SQL Problem 7 — Rank employees by salary
SELECT 
	name,
	salary,
	DENSE_RANK() OVER(
		ORDER BY salary DESC
	) AS salary_rank
FROM employees;


-- SQL Problem 8 — Find the highest-paid employee in each department
SELECT 
	department_id,
	name,
	salary
FROM (
	SELECT 
		department_id, 
		name, 
		salary,
		ROW_NUMBER() OVER(
			PARTITION BY department_id
			ORDER BY salary DESC
		) AS rn
	FROM employees
) ranked
WHERE rn = 1;




