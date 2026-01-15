class UserService:
    def __init__(self, db):
        self.db = db
    
    def get_user_by_email(self, email: str):
        return None
    
    def create_user(self, user_data):
        # For testing
        return user_data
    
    def authenticate_user(self, email: str, password: str):
        # For testing
        return {"email": email, "role": "customer"}
