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
