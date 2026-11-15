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

-- Query 1 — Find all employees earning more than 50000.
SELECT *
FROM employees
WHERE salary > 50000;

-- Query 2 — Find employees working in the IT department.
SELECT e.name, e.salary, d.department_name
FROM employees e
JOIN departments d
ON e.department_id = d.id
WHERE d.department_name = 'IT';

-- Query 3 — Find the total number of employees in each department.
SELECT d.department_name, COUNT(e.id) AS total_employees
FROM departments d
LEFT JOIN employees e
ON d.id = e.department_id
GROUP BY d.id, department_name;

-- Query 4 — Find departments having more than one employee.
SELECT department_id, COUNT(*) AS total_employees
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 1;

-- Query 5 — Find employees earning more than the company average salary.
SELECT name, salary
FROM employees
WHERE salary > (
		SELECT AVG(salary)
		FROM employees
);

-- Query 6 — Find the highest-paid employee in each department.
SELECT name,department_id.salary
FROM(
	SELECT name,department_id,salary,
	DENSE_RANK() OVER(
		PARTITION BY department_id 
		ORDER BY salary DESC		
	) AS ranking
   FROM employees
) ranked
WHERE ranking = 1;


-- Query 7 — Use a CTE to calculate department average salary.
WITH departmnet_salary AS(
	SELECT 
		department_id,
		AVG(salary) AS average_salary
	FROM employees
	GROUP BY department_id
)
SELECT 
	d.department_name,
	ds.average_salary
FROM departmnet_salary ds
JOIN departments d
ON ds.department_id = d.id;

-- Query 8 — Find employees who earn the highest salary in the company.
SELECT name,salary
FROM employees
WHERE salary = (
	SELECT MAX(salary)
	FROM employees
);


























