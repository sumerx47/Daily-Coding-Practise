
# Q1. Create a basic FastAPI application.
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def home():
    return {"message": "Welcome to FastAPI"}


# Q2. Create an API using a path parameter.
@app.get("/users/{user_id}")
def get_user(user_id:int):
    return {"user_id":user_id}


# Q3. Create an API using query parameters.
@app.get("/products")
def get_products(category:str, limit:int = 10):
    return {
        "category":category,
        "limit":limit
    }


# Q4. Create a POST endpoint using Pydantic.
from pydantic import BaseModel, Field

class User(BaseModel):
    name: str
    age: int = Field(gt=0)
    email: str

@app.post("/users")
def create_user(user: User):
    return {
        "message": "User created",
        "data": user
    }

# Q5. Create an API with error handling.
from fastapi import HTTPException

users = {
    1: "Ali",
    2: "John"
}

@app.get("/users/{user_id}")
def get_user(user_id: int):

    if user_id not in users:
        raise HTTPException(
            status_code=404,
            detail="User not found"
        )

    return {"name": users[user_id]}






