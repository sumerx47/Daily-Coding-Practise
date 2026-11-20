'''
Task 1 — Create a database dependency
Your task: Create a function that opens a PostgreSQL session, provides it to the API endpoint and closes it afterward.
'''
def get_db():
    db = SessionLocal()

    try:
        yield db

    finally:
        db.close()


@app.get("/employees")
def get_employees(db: Session = Depends(get_db)):
    return db.query(Employee).all()


















