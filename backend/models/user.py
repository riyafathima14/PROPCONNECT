# models/user.py
from extensions import db

class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    first_name = db.Column(db.String(50), nullable=False)
    last_name = db.Column(db.String(50), nullable=False)
    email = db.Column(db.String(100), unique=True, nullable=True)
    phone = db.Column(db.String(15), unique=True, nullable=True)
    password = db.Column(db.String(100), nullable=False)
    otp = db.Column(db.String(6), nullable=True)
    is_verified = db.Column(db.Boolean, default=False)

    def __repr__(self):
        return f'<User {self.email}>'
