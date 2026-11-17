
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


-- Query 1 — Get all employees.
SELECT * FROM employees

-- Query 2 — Get employees earning more than 50000.
SELECT *
FROM employees
WHERE salary > 50000;

-- Query 3 — Get employees from the IT department.
SELECT e.name, e.salary
FROM employees e
JOIN departments d
ON e.department_id = d.id
WHERE d.department_name = 'IT';

-- Query 4 — Find the total employees in each department.
SELECT department_id, COUNT(*) AS total_employees
FROM employees
GROUP BY department_id;

-- Query 5 — Find departments with average salary above 50000.
SELECT department_id, AVG(salary) AS average_salary
FROM employees
GROUP BY department_id
HAVING AVG(salary) > 50000;

-- Query 6 — Insert a new employee.
INSERT INTO employees(id,name,department_id,salary)
VALUES
(8,'zack',10,65000);

-- Query 7 — Update an employee's salary.
UPDATE employees
SET salary = 75000
WHERE id = 2;

-- Query 8 — Delete an employee.
DELETE FROM employees
WHERE id = 8;




