from fastapi import APIRouter, Depends, HTTPException
from app.api.v1.endpoints.auth import get_current_user
import json
from datetime import datetime

router = APIRouter()
quotes_db = []

@router.get("/")
async def get_quotes(current_user: dict = Depends(get_current_user)):
    if current_user["role"] == "professional":
        return [q for q in quotes_db if q["professional_id"] == current_user["id"]]
    else:
        return [q for q in quotes_db if q["customer_id"] == current_user["id"]]

@router.post("/{job_id}")
async def create_quote(job_id: int, amount: float, notes: str = "", 
                      current_user: dict = Depends(get_current_user)):
    if current_user["role"] != "professional":
        raise HTTPException(status_code=403, detail="Only professionals can submit quotes")
    
    new_quote = {
        "id": len(quotes_db) + 1,
        "job_id": job_id,
        "professional_id": current_user["id"],
        "professional_name": current_user["full_name"],
        "customer_id": None,  # Will be filled from job
        "amount": amount,
        "notes": notes,
        "status": "pending",
        "created_at": datetime.utcnow().isoformat()
    }
    quotes_db.append(new_quote)
    return new_quote
