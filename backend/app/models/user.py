from sqlalchemy import Column, Integer, String, Boolean, Enum, Float, DateTime
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
import enum
from app.db.base_class import Base

class UserRole(str, enum.Enum):
    CUSTOMER = "customer"
    PROFESSIONAL = "professional"
    ADMIN = "admin"

class User(Base):
    __tablename__ = "users"
    
    id = Column(Integer, primary_key=True, index=True)
    email = Column(String, unique=True, index=True, nullable=False)
    hashed_password = Column(String, nullable=False)
    full_name = Column(String, nullable=False)
    phone = Column(String, nullable=True)
    role = Column(Enum(UserRole), default=UserRole.CUSTOMER)
    rating = Column(Float, default=0.0)
    is_active = Column(Boolean, default=True)
    created_at = Column(DateTime(timezone=True), server_default=func.now())
    updated_at = Column(DateTime(timezone=True), onupdate=func.now())
    
    # Relationships
    jobs_posted = relationship("Job", back_populates="customer", foreign_keys="Job.customer_id")
    quotes = relationship("Quote", back_populates="professional")
    services = relationship("Service", secondary="user_services", back_populates="professionals")
    certifications = relationship("Certification", back_populates="user")
    
    def __repr__(self):
        return f"<User {self.email} ({self.role})>"