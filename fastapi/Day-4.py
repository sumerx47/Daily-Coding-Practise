'''
Task 1 — Create an employee listing endpoint
'''
from fastapi import FastAPI

app = FastAPI()

employees = [
    {"id": 1, "name": "Ali", "salary": 50000},
    {"id": 2, "name": "John", "salary": 60000}
]

@app.get("/employees")
def get_employees():
    return employees

'''
Task 2 — Filter employees by minimum salary
Create /employees?min_salary=55000.
'''
@app.get("/employees/filter")
def filter_employees(min_salary: int):
    result = []

    for employee in employees:
        if employee["salary"] >= min_salary:
            result.append(employee)

    return result

'''
Task 3 — Find an employee by ID
'''
from fastapi import HTTPException

@app.get("/employees/{employee_id}")
def get_employee(employee_id : int):
    for emp in employees:
        if emp["id"] == employee_id:
            return emp

    raise HTTPException(
        status = 404,
        details = "Employee not found"
    )

'''
Task 4 — Connect FastAPI to PostgreSQL
'''
from sqlalchemy import create_engine

DATABASE_URL = ("postgresql+psycopg2://postgres:password@localhost:5432/company")

engine = create_engine(DATABASE_URL)

'''
Task 5 — Create an endpoint using a SQL JOIN
Assume engine is configured and the tables already exist.
'''
from sqlalchemy import text

@app.get("/employees/departments")
def employee_departments():
    query = text("""
        SELECT e.name, e.salary, d.department_name
        FROM employees e
        JOIN departments d
        ON e.department_id = d.id
    """)

    with engine.connect() as connection:
        result = connection.execute(query)

        return [
            dict(row._mapping)
            for row in result
        ]






