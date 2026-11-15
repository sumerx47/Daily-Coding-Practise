@app.get("/employees/filter")
def filter_employees(min_salary: int):
    result = []

    for employee in employees:
        if employee["salary"] >= min_salary:
            result.append(employee)

    return result

