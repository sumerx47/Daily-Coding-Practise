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

----------------------------------------------------------------

-- Query 1 — Create a table with constraints
CREATE TABLE users(
	id SERIAL PRIMARY KEY,
	username VARCHAR(100) UNIQUE NOT NULL,
	email VARCHAR(150) UNIQUE NOT NULL,
	password_hash TEXT NOT NULL,
	is_active BOOLEAN DEFAULT TRUE
);


-- Query 2 — Insert a user
INSERT INTO users(username, email, password_hash)
VALUES
('ali','ali@example.com','hashed_password_here');

-- Query 3 — Find a user by email
SELECT * 
FROM users
WHERE email = 'ali@example.com';

-- Query 4 — Update a user's active status
UPDATE users
SET is_active = FALSE
WHERE id = 1;

-- Query 5 — Find employees earning more than their department average
SELECT e.name,e.salary
FROM employees e
WHERE e.salary > (
	SELECT AVG(e2.salary)
	FROM employees e2
	WHERE e2.department_id = e.department_id
);

-- Query 6 — Use a CTE to calculate department salaries
WITH department_report AS(
	SELECT 
		department_id,
		COUNT(*) AS total_employees,
		AVG(salary) AS average_salary
	FROM employees
	GROUP BY department_id
)
SELECT *
FROM department_report;


-- Query 7 — Create an index
CREATE INDEX idx_users_email
ON users(email);


-- Query 8 — Use a transaction
BEGIN;

UPDATE employees
SET salary = salary + 5000
WHERE id = 1;

UPDATE employees
SET salary = salary + 5000
WHERE id = 2;

COMMIT;


ROLLBACK;





