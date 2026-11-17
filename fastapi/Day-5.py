'''
Task 1 — Build GET and POST endpoints
'''
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

employees = []

class Employee(BaseModel):
    name : str
    salary : int
    department : str


@app.get("/employees")
def get_employees():
    return employees

@app.post("/employees")
def create_employee(employee: Employee):
    employees.append(employee.model_dump())
    return employee


'''
Task 2 — Create an employee using validation and status codes
'''
from fastapi import status
from pydantic import BaseModel, Field

class Employee(BaseModel):
    name :str = Field(min_length=2)
    salary : int = Field(gt = 0)
    department : str = Field(min_length=2)

@app.post("/employees", status_code=status.HTTP_201_CREATED)
def create_employee(employee:Employee):
    return {
        "message":"Employee created successfully",
        "employee": employee
    }


'''
Task 3 — Implement full CRUD
'''



























































