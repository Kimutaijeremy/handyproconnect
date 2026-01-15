from sqlalchemy import Column, Integer, ForeignKey, Table
from app.db.base_class import Base

# Many-to-many relationship table
user_services = Table(
    "user_services",
    Base.metadata,
    Column("user_id", Integer, ForeignKey("users.id"), primary_key=True),
    Column("service_id", Integer, ForeignKey("services.id"), primary_key=True)
)