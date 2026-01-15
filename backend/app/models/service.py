from sqlalchemy import Column, Integer, String, Text, Float
from sqlalchemy.orm import relationship
from app.db.base_class import Base

class Service(Base):
    __tablename__ = "services"
    
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False, unique=True, index=True)
    category = Column(String, nullable=False, index=True)  # electrical, plumbing, handyman
    description = Column(Text)
    average_price = Column(Float)
    estimated_duration = Column(Integer)  # in minutes
    requires_certification = Column(String, nullable=True)  # certification type if needed
    
    # Relationships
    professionals = relationship("User", secondary="user_services", back_populates="services")
    jobs = relationship("Job", back_populates="service")
    
    def __repr__(self):
        return f"<Service {self.name} ({self.category})>"