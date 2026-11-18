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
from fastapi import FastAPI, HTTPException,status
from pydantic import BaseModel, Field

app = FastAPI()

employees = []
next_id = 1

class Employee(BaseModel):
    name :str = Field(min_length=2)
    salary : int = Field(gt = 0)
    department :str = Field(min_length=2)

@app.post("/employees",status_code=201)
def create_employees(employee:Employee):
    global next_id

    new_employee = {
        "id":next_id,
        **employee.model_dump()
    }

    employees.append(new_employee)
    next_id +=1

    return new_employee

@app.get("/employees")
def get_employees():
    return employees

@app.get("/employees/{employee_id}")
def get_employee(employee_id : int):
    for emp in employees:
        if emp["id"] == employee_id
        return emp
    raise HTTPException(
        status_code = 404
        detail = "Employee not found"
    )

@app.put("/employees/{employee_id}")
def update_employees(employee_id : int , updated :Employee)
    for emp in employees:
        if emp["id"] == employee_id:
            emp.update(updated.model_dump())
            return emp
    raise HTTPException(
        status_code = 404,
        detail = "Employee not found"
    )

@app.delete("/employees/{employee_id}")
def delete_employees(employee_id :int):
    for emp in employees:
        if emp["id"] == employee_id:
            employees.remove(emp)
            return {"message":"employee deleted"}

    raise HTTPException(
        status_code = 404,
        detail = "employee not found"
    )




















































