'''
1. Create a FastAPI application
Create main.py:
'''

from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def home():
    return {
        "message": "Employee API is running"
    }



'''
2. Create a Pydantic schema
Create schemas.py:
'''
from pydantic import BaseModel, Field

class EmployeeCreate(BaseModel):
    name: str = Field(min_length=2)
    salary: int = Field(gt=0)
    department_id: int = Field(gt=0)



'''
3. Create the PostgreSQL connection
Create database.py:
'''

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, declarative_base

DATABASE_URL = (
    "postgresql+psycopg2://postgres:YOUR_PASSWORD@localhost:5432/company"
)

engine = create_engine(DATABASE_URL)

SessionLocal = sessionmaker(
    bind=engine,
    autoflush=False,
    autocommit=False
)

Base = declarative_base()


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


'''
4. Create the SQLAlchemy model
Create models.py:
'''

from sqlalchemy import Column, Integer, String
from database import Base


class Employee(Base):
    __tablename__ = "employees"
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(50), nullable=False)
    salary = Column(Integer, nullable=False)
    department_id = Column(Integer, nullable=False)




'''
5. Create all CRUD endpoints
Create main.py:
'''

from fastapi import FastAPI, Depends, HTTPException
from sqlalchemy.orm import Session

from database import engine, Base, get_db
from models import Employee
from schemas import EmployeeCreate

app = FastAPI()

# Create database tables
Base.metadata.create_all(bind=engine)


# CREATE
@app.post("/employees", status_code=201)
def create_employee(
    employee: EmployeeCreate,
    db: Session = Depends(get_db)
):

    new_employee = Employee(
        name=employee.name,
        salary=employee.salary,
        department_id=employee.department_id
    )

    db.add(new_employee)

    db.commit()

    db.refresh(new_employee)

    return new_employee


# READ ALL
@app.get("/employees")
def get_employees(db: Session = Depends(get_db)):

    return db.query(Employee).all()


# READ ONE
@app.get("/employees/{employee_id}")
def get_employee(
    employee_id: int,
    db: Session = Depends(get_db)
):

    employee = db.query(Employee).filter(
        Employee.id == employee_id
    ).first()

    if employee is None:
        raise HTTPException(
            status_code=404,
            detail="Employee not found"
        )

    return employee


# UPDATE
@app.put("/employees/{employee_id}")
def update_employee(
    employee_id: int,
    employee_data: EmployeeCreate,
    db: Session = Depends(get_db)
):

    employee = db.query(Employee).filter(
        Employee.id == employee_id
    ).first()

    if employee is None:
        raise HTTPException(
            status_code=404,
            detail="Employee not found"
        )

    employee.name = employee_data.name
    employee.salary = employee_data.salary
    employee.department_id = employee_data.department_id

    db.commit()

    db.refresh(employee)

    return employee


# DELETE
@app.delete("/employees/{employee_id}", status_code=204)
def delete_employee(
    employee_id: int,
    db: Session = Depends(get_db)
):

    employee = db.query(Employee).filter(
        Employee.id == employee_id
    ).first()

    if employee is None:
        raise HTTPException(
            status_code=404,
            detail="Employee not found"
        )

    db.delete(employee)

    db.commit()

    return None



