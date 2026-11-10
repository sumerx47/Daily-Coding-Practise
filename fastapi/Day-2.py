from fastapi import FastAPI

app = FastAPI()

employees = [
    {"id": 1, "name": "Ali", "department": "IT"},
    {"id": 2, "name": "John", "department": "HR"},
    {"id": 3, "name": "Sara", "department": "IT"}
]


@app.get("/employees")
def get_employees():
    return employees

'''
Task 2 — Search employees by department
'''
@app.get("/employees/department/{department}")
def search_employees(department:str):
    result = []
    for emp in employees:
        if emp["department"].lower() == department.lower():
            result.append(emp)
    return result

'''
Task 3 — Use a function to calculate average salary
'''













