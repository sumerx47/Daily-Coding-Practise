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
def calculate_average(salaries):
    if not salaries:
        return 0
    return sum(salaries)/len(salaries)

@app.get("/employees/average-salary")
def average_salary():
    salaries = [50000,60000,70000,45000]
    average = calculate_average(salaries)
    return {"average_salary":average}

'''
Task 4 — Sort employees by salary using lambda
'''
employees = [
    {"name": "Ali", "salary": 50000},
    {"name": "John", "salary": 60000},
    {"name": "Sara", "salary": 70000}
]

@app.get("/employees/sort")
def sort_employees():
    result = sorted(employees, key = lambda x:x["salary"] ,reverse = True)
    return result


'''
Task 5 — Filter employees using list comprehension
'''
@app.get("/employees/high-salary")
def high_salary():
    salaries = [
        {"name": "Ali", "salary": 50000},
        {"name": "John", "salary": 60000},
        {"name": "Sara", "salary": 70000}
    ]
    result = [emp for emp in salaries if emp["salary"] > 50000 ]
    return result




