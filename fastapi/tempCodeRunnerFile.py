@app.get("/employees/department/{department}")
def search_employees(department:str):
    result = []
    for emp in employees:
        if emp["department"].lower() == department.lower():
            result.append(emp)
    return result
