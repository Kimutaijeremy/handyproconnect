from fastapi import APIRouter, Depends
from app.api.v1.endpoints.auth import get_current_user

router = APIRouter()

@router.get("/profile")
async def get_profile(current_user: dict = Depends(get_current_user)):
    return current_user

@router.put("/profile")
async def update_profile(update_data: dict, current_user: dict = Depends(get_current_user)):
    # Update user in database
    return {"message": "Profile updated successfully", "user": current_user}
