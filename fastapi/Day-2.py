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
















