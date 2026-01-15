from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from app.core.config import settings
import logging

logger = logging.getLogger(__name__)

try:
    # Use string directly, not PostgresDsn
    database_url = settings.DATABASE_URL
    logger.info(f"Connecting to database: {database_url.split('@')[-1] if '@' in database_url else 'local'}")
    
    engine = create_engine(database_url, pool_pre_ping=True)
    SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
    
    logger.info("Database engine created successfully")
    
except Exception as e:
    logger.error(f"Failed to create database engine: {e}")
    # Create a dummy engine for testing
    engine = None
    SessionLocal = None
    print(f"⚠️  Database connection failed: {e}")
    print("⚠️  Running in test mode without database")

def get_db():
    """Get database session"""
    if SessionLocal is None:
        raise Exception("Database not configured")
    
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
