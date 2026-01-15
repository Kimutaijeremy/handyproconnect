from fastapi import APIRouter, Depends, HTTPException
from app.api.v1.endpoints.auth import get_current_user
from app.schemas.job import JobCreate, JobResponse
import json
from datetime import datetime

router = APIRouter()

jobs_db = []

@router.get("/", response_model=list)
async def get_jobs(current_user: dict = Depends(get_current_user)):
    if current_user["role"] == "professional":
        return jobs_db
    else:
        return [job for job in jobs_db if job["customer_id"] == current_user["id"]]

@router.post("/", response_model=JobResponse)
async def create_job(job: JobCreate, current_user: dict = Depends(get_current_user)):
    new_job = {
        **job.dict(),
        "id": len(jobs_db) + 1,
        "customer_id": current_user["id"],
        "customer_name": current_user["full_name"],
        "status": "open",
        "created_at": datetime.utcnow().isoformat(),
        "updated_at": datetime.utcnow().isoformat()
    }
    jobs_db.append(new_job)
    return new_job

@router.get("/open", response_model=list)
async def get_open_jobs(current_user: dict = Depends(get_current_user)):
    if current_user["role"] != "professional":
        raise HTTPException(status_code=403, detail="Only professionals can view open jobs")
    return [job for job in jobs_db if job["status"] == "open"]

@router.get("/{job_id}")
async def get_job(job_id: int, current_user: dict = Depends(get_current_user)):
    for job in jobs_db:
        if job["id"] == job_id:
            if current_user["role"] == "professional" or job["customer_id"] == current_user["id"]:
                return job
    raise HTTPException(status_code=404, detail="Job not found")
