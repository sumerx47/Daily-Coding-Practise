-- Create tables
CREATE TABLE departments(
	id 	INT PRIMARY KEY,
	department_name VARCHAR(50)
)

CREATE TABLE employees(
	id SERIAL PRIMARY KEY,
	name VARCHAR(100),
	department_id INT REFERENCES departments(id),
	salary NUMERIC(10,2)
)

-- Insert Values
INSERT INTO departments
VALUES
(10, 'IT'),
(20, 'HR'),
(30, 'Finance');


INSERT INTO employees(name, department_id, salary)
VALUES
('Ali',10, 50000),
('John', 20, 60000),
('Sara', 10, 70000),
('David', 30, 45000),
('Ahmed', 20, 60000),
('Zara', 10, 80000),
('Ravi', 30, 45000);

--Show Tables
SELECT * FROM employees
SELECT * FROM departments

-- Query 1 — Find the third-highest distinct salary
SELECT DISTINCT salary 
FROM employees
ORDER BY salary DESC
OFFSET 2
LIMIT 1;

-- Query 2 — Find duplicate salaries
SELECT salary, COUNT(*) AS total
FROM employees
GROUP BY salary
HAVING COUNT(*) > 1;

-- Query 3 — Find the highest-paid employee in each department
SELECT * 
FROM (
	SELECT 
			e.name,
			d.department_name,
			e.salary,
			DENSE_RANK() OVER(
				PARTITION BY e.department_id
				ORDER BY e.salary DESC
			) AS ranking
			FROM employees e
			INNER JOIN departments d
			ON e.department_id = d.id
) ranked
WHERE ranking = 1;

-- Query 4 — Find employees earning more than their department average
SELECT 
	name,
	department_id,
	salary
FROM employees e
WHERE salary > (
	SELECT AVG(salary)
	FROM employees
	WHERE department_id = e.department_id
);

-- Query 5 — Use a CTE to calculate average salary
WITH  salary_data AS (
		SELECT AVG(salary) AS average_salary
		FROM employees
)

SELECT *
FROM employees
WHERE salary > (
	SELECT average_salary 
	FROM salary_data
)

-- Query 6 — Find departments with no employees
SELECT d.department_name
FROM departments d
LEFT JOIN employees e
ON d.id = e.department_id
WHERE e.id IS NULL;

-- Query 7 — Calculate department-wise total and average salary
SELECT 
	d.department_name,
	COUNT(e.id) AS total_employees,
	SUM(e.salary) AS total_salary,
	AVG(e.salary) AS average_salary
FROM departments d
LEFT JOIN employees e
On d.id = e.department_id
GROUP  BY d.id, d.department_name;

-- Query 8 — Find the top two highest-paid employees in each department
SELECT *
FROM (
	SELECT 
		name,
		department_id,
		salary,
		ROW_NUMBER() OVER(
			PARTITION BY department_id
			ORDER BY salary DESC
		) AS rn
	FROM employees
) ranked 
WHERE rn <= 2;


















