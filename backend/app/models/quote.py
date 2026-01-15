from sqlalchemy import Column, Integer, Float, Text, Enum, DateTime, ForeignKey, Boolean
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
import enum
from app.db.base_class import Base

class QuoteStatus(str, enum.Enum):
    PENDING = "pending"
    ACCEPTED = "accepted"
    REJECTED = "rejected"
    EXPIRED = "expired"

class Quote(Base):
    __tablename__ = "quotes"
    
    id = Column(Integer, primary_key=True, index=True)
    job_id = Column(Integer, ForeignKey("jobs.id"), nullable=False)
    professional_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    amount = Column(Float, nullable=False)
    materials_cost = Column(Float, default=0.0)
    estimated_hours = Column(Integer)
    notes = Column(Text)
    status = Column(Enum(QuoteStatus), default=QuoteStatus.PENDING)
    is_green_certified = Column(Boolean, default=False)
    created_at = Column(DateTime(timezone=True), server_default=func.now())
    expires_at = Column(DateTime(timezone=True))
    
    # Relationships
    job = relationship("Job", back_populates="quotes")
    professional = relationship("User", back_populates="quotes")
    
    def __repr__(self):
        return f"<Quote ${self.amount} for Job {self.job_id}>"