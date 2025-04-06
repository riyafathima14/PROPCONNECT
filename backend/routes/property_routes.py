# routes/property_routes.py
from flask import Blueprint, jsonify
from models.property import Property

property_bp = Blueprint('property', __name__, url_prefix='/properties')

@property_bp.route('/', methods=['GET'])
def list_properties():
    properties = Property.query.all()
    result = []
    for prop in properties:
        result.append({
            'id': prop.id,
            'owner_id': prop.owner_id,
            'title': prop.title,
            'property_type': prop.property_type,
            'location': prop.location,
            'latitude': float(prop.latitude) if prop.latitude else None,
            'longitude': float(prop.longitude) if prop.longitude else None,
            'price': float(prop.price),
            'size': prop.size,
            'description': prop.description,
            'status': prop.status,
            'created_at': prop.created_at,
            'imgURL': prop.imgURL.split(",") if prop.imgURL else [],
            'rating': float(prop.rating) if prop.rating is not None else None
        })
    return jsonify(result)
