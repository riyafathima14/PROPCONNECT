from flask_sqlalchemy import SQLAlchemy
from datetime import datetime, timezone

db = SQLAlchemy()  # define db without initializing

# User Table
class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    first_name = db.Column(db.String(50), nullable=False)
    last_name = db.Column(db.String(50), nullable=False)
    email = db.Column(db.String(100), unique=True, nullable=False)
    phone = db.Column(db.String(15), unique=True, nullable=False)
    password = db.Column(db.String(100), nullable=False)
    aadhaar_number = db.Column(db.String(12), unique=True, nullable=False)
    aadhaar_verified = db.Column(db.Boolean, default=False)
    role = db.Column(db.String(10), nullable=False)  # 'user' or 'owner'
    created_at = db.Column(db.DateTime, default=lambda: datetime.now(timezone.utc))  # Use timezone-aware datetime
    otp = db.Column(db.String(6), nullable=True)  # OTP for verification
    is_verified = db.Column(db.Boolean, default=False)  # Verification status


# Property Table
class Property(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    owner_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    title = db.Column(db.String(255), nullable=False)
    property_type = db.Column(db.String(50), nullable=False)
    location = db.Column(db.String(255), nullable=False)
    latitude = db.Column(db.Float, nullable=False)
    longitude = db.Column(db.Float, nullable=False)
    price = db.Column(db.Float, nullable=False)
    size = db.Column(db.Integer, nullable=False)
    description = db.Column(db.Text, nullable=False)
    status = db.Column(db.String(20), nullable=False)  # Available, Rented, Sold
    created_at = db.Column(db.DateTime, default=lambda: datetime.now(timezone.utc))  # Fixed timezone issue
    imgURL = db.Column(db.String(255), nullable=True)

# Interest Table
class Interest(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    property_id = db.Column(db.Integer, db.ForeignKey('property.id'), nullable=False)
    interest_date = db.Column(db.DateTime, default=lambda: datetime.now(timezone.utc))  # Fixed timezone issue
    status = db.Column(db.String(20), nullable=False)  # pending, confirmed, rejected

# Search History Table
class SearchHistory(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    search_query = db.Column(db.String(255), nullable=False)
    location = db.Column(db.String(255), nullable=True)
    min_price = db.Column(db.Float, nullable=True)
    max_price = db.Column(db.Float, nullable=True)
    property_type = db.Column(db.String(50), nullable=True)
    search_date = db.Column(db.DateTime, default=lambda: datetime.now(timezone.utc))  # Fixed timezone issue

# Favorites Table
class Favorite(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    property_id = db.Column(db.Integer, db.ForeignKey('property.id'), nullable=False)
    saved_date = db.Column(db.DateTime, default=lambda: datetime.now(timezone.utc))  # Fixed timezone issue

#CORS(app)                     # allow flutter to access Flask
