from fastapi import APIRouter

router = APIRouter()

@router.get("/")
async def get_services():
    return [
        {"id": 1, "name": "Electrical", "category": "electrical", "requires_certification": "Electrician License"},
        {"id": 2, "name": "Plumbing", "category": "plumbing", "requires_certification": "Plumber License"},
        {"id": 3, "name": "Handyman", "category": "general", "requires_certification": "Trade Certification"},
        {"id": 4, "name": "Green Solutions", "category": "green", "requires_certification": "Green Certification"},
    ]
