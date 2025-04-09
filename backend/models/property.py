# models/property.py
from extensions import db

class Property(db.Model):
    __tablename__ = 'property'

    id = db.Column(db.Integer, primary_key=True)
    owner_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    title = db.Column(db.String(255), nullable=False)
    property_type = db.Column(db.String(100), nullable=False)
    location = db.Column(db.String(255), nullable=False)
    latitude = db.Column(db.Numeric(10, 6), nullable=True)
    longitude = db.Column(db.Numeric(10, 6), nullable=True)
    price = db.Column(db.Numeric, nullable=False)
    size = db.Column(db.Integer, nullable=False)
    description = db.Column(db.Text, nullable=True)
    status = db.Column(db.String(100), nullable=False)
    created_at = db.Column(db.String(50), nullable=True)
    imgURL = db.Column(db.Text, nullable=True)  # Comma-separated URLs
    rating = db.Column(db.Numeric(2, 1), nullable=True)

    # New columns
    bedrooms = db.Column(db.Integer, nullable=True)
    bathrooms = db.Column(db.Integer, nullable=True)
    balconies = db.Column(db.Integer, nullable=True)
    floor_no = db.Column(db.Integer, nullable=True)
    total_floor = db.Column(db.Integer, nullable=True)
    furnishing = db.Column(db.String(100), nullable=True)
    ownership = db.Column(db.String(100), nullable=True)
    proof_doc = db.Column(db.LargeBinary, nullable=True)  # BYTEA -> LargeBinary
    adhaar_proof = db.Column(db.Text, nullable=True)      # XML -> Store as Text

    # Relationship to User model
    owner = db.relationship('User', backref=db.backref('properties', lazy=True))

    def __repr__(self):
        return f'<Property {self.title}>'
