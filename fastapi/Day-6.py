'''
Step 1 — Create the database connection
Create database.py:
'''
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker,declarative_base

DATABASE_URL = (
    "postgresql+psycopg2://postgres:password@localhost:5432/company"
)

engine = create_engine(DATABASE_URL)

SessionLocal = sessionmaker(
    bind= engine,
    autoflush = False,
    autocommit = False
)

Base = declarative_base()


'''
Step 2 — Create an employee model
Create models.py:
'''
from sqlalchemy import Column, Integer, String
#from database import Base


class Employee(Base):

    __tablename__ = "employees"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(100), nullable=False)
    salary = Column(Integer, nullable=False)
    department = Column(String(100), nullable=False)


'''
Step 3 — Create a Pydantic schema
Create schemas.py:
'''
from pydantic import BaseModel, Field, ConfigDict


class EmployeeCreate(BaseModel):
    name: str = Field(min_length=2)
    salary: int = Field(gt=0)
    department: str


class EmployeeResponse(BaseModel):
    id: int
    name: str
    salary: int
    department: str

    model_config = ConfigDict(from_attributes=True)



'''make it more easier to understand :    '''





