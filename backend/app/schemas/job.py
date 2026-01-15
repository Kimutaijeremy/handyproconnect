from pydantic import BaseModel
from typing import Optional

class JobBase(BaseModel):
    title: str
    description: str
    location: str
    urgency: str = "normal"
    budget_min: Optional[float] = None
    budget_max: Optional[float] = None
    service_id: Optional[int] = None

class JobCreate(JobBase):
    pass

class JobResponse(JobBase):
    id: int
    customer_id: int
    customer_name: str
    status: str
    
    class Config:
        from_attributes = True
