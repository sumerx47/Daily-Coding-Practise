   self.employees = {
            1: "Ali",
            2: "John"
        }  
    def get_employee(self, employee_id):
        if employee_id not in self.employees:
            raise HTTPException(
                status_code = 404,
                detail = "Employee not found"
            )
        return self.employees[employee_id]
service = EmployeeService()

@app.get("employees/{employee_id}")
def get_employee(employee_id:int):

    name = service.get_employee(employee_id)

    return {"name": name}