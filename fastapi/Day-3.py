'''
Task 1 — Create custom exception handling in FastAPI
Requirement: If an employee does not exist, return a proper 404 error.
'''
from fastapi import FastAPI, HTTPException

app = FastAPI()

employees = {
    1: "Ali",
    2: "John",
    3: "Sara"
}

@app.get("/employees/{employee_id}")
def get_employee(employee_id : int):
    try:
        return{
            "name":employees[employee_id]
        }
    except KeyError:
        raise HTTPException(
            status_code= 404,
            detail ="Employee not found"
        )

'''
Task 2 — Upload and read a file
Requirement: Upload a log file through FastAPI and read its contents.
'''
from fastapi import FastAPI, UploadFile, File

app = FastAPI()

@app.post("/upload")
async def upload_file(file:UploadFile = File(...)):
    content = await file.read()

    return {
        "filename":file.filename,
        "size":len(content),
        "content":content.decode("utf-8")
    }


'''
Task 3 — Create a reusable employee service using OOP
Requirement: Use a class to handle employee-related business logic.
'''
from fastapi import FastAPI, HTTPException

app = FastAPI()

class EmployeeService:
    def __init__(self):

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

@app.get("/employees/{employee_id}")
def get_employee(employee_id:int):

    name = service.get_employee(employee_id)

    return {"name": name}

'''
Task 4 — Create a generator-based streaming API
Requirement: Return a large dataset gradually instead of building a complete list first.
'''































