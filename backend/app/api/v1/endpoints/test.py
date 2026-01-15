from fastapi import APIRouter

router = APIRouter()

@router.get("/")
def test_all():
    return {"message": "Test endpoint is working!"}

@router.get("/db")
def test_db():
    return {"database": "Connection test endpoint"}
