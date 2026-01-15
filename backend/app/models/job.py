from sqlalchemy import Column, Integer, String, Text, Float, Enum, DateTime, ForeignKey
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
import enum
from app.db.base_class import Base

class JobStatus(str, enum.Enum):
    OPEN = "open"
    QUOTED = "quoted"
    IN_PROGRESS = "in_progress"
    COMPLETED = "completed"
    CANCELLED = "cancelled"

class Job(Base):
    __tablename__ = "jobs"
    
    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, nullable=False, index=True)
    description = Column(Text, nullable=False)
    location = Column(String, nullable=False, index=True)
    urgency = Column(String, default="normal")  # urgent, normal, flexible
    budget_min = Column(Float)
    budget_max = Column(Float)
    status = Column(Enum(JobStatus), default=JobStatus.OPEN)
    customer_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    service_id = Column(Integer, ForeignKey("services.id"), nullable=True)
    created_at = Column(DateTime(timezone=True), server_default=func.now())
    updated_at = Column(DateTime(timezone=True), onupdate=func.now())
    
    # Relationships
    customer = relationship("User", back_populates="jobs_posted", foreign_keys=[customer_id])
    quotes = relationship("Quote", back_populates="job", cascade="all, delete-orphan")
    service = relationship("Service", back_populates="jobs")
    
    def __repr__(self):
        return f"<Job {self.title} ({self.status})>"