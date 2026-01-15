from fastapi import APIRouter
from app.api.v1.endpoints import auth, jobs, quotes, services, users

api_router = APIRouter()

api_router.include_router(auth.router, prefix="/auth", tags=["authentication"])
api_router.include_router(users.router, prefix="/users", tags=["users"])
api_router.include_router(jobs.router, prefix="/jobs", tags=["jobs"])
api_router.include_router(quotes.router, prefix="/quotes", tags=["quotes"])
api_router.include_router(services.router, prefix="/services", tags=["services"])
