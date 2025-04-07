# routes/property_routes.py
from models.user import User
from flask import Blueprint, jsonify, request  
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
@property_bp.route('/top-rated', methods=['GET'])
def top_rated_properties():
    properties = Property.query.filter(Property.rating >= 4.0).all()
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
@property_bp.route('/search_properties', methods=['POST'])
def search_properties():
    try:
        data = request.get_json()

        location = data.get('location')
        is_buy = data.get('is_buy')
        min_budget = data.get('min_budget')
        max_budget = data.get('max_budget')
        property_types = data.get('property_types',[])

        # Start building query
        query = Property.query

        # Match locality inside location (partial match)
        if location:
            query = query.filter(Property.location.ilike(f"%{location}%"))

        # Match is_buy (assuming you have is_buy column)
        if is_buy is not None:
            if is_buy:
        # Search properties meant for buying
                query = query.filter(
                    Property.status.ilike('%Available for Sale%') |
                    Property.status.ilike('%Ready to Move%')
                )
        else:
        # Search properties meant for renting
            query = query.filter(
                Property.status.ilike('%For Rent%') |
                Property.status.ilike('%Available for Rent%')
             )


        # Match budget range
        if min_budget:
            query = query.filter(Property.price >= float(min_budget))
        if max_budget:
            query = query.filter(Property.price <= float(max_budget))

        # Match property_type
        if property_types:
           query = query.filter(Property.property_type.in_(property_types))

        properties = query.all()

        # Prepare response
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

        return jsonify({'properties': result})

    except Exception as e:
        return jsonify({'error': str(e)}), 500
@property_bp.route('/trending', methods=['GET'])
def trending_properties():
    try:
        # Optional city filter via query parameters, e.g., /properties/trending?city=Mumbai
        city = request.args.get('city')
        
        # Base query: properties with rating >= 4.0
        query = Property.query.filter(Property.rating >= 4.0)
        
        # If a city is provided, filter by city (partial match)
        if city:
            query = query.filter(Property.location.ilike(f"%{city}%"))
        
        properties = query.all()
        
        # Sort properties: first by price (ascending) then by rating (descending)
        properties.sort(key=lambda prop: (float(prop.price), - (float(prop.rating) if prop.rating is not None else 0)))
        
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
    
    except Exception as e:
        return jsonify({'error': str(e)}), 500
    
@property_bp.route('/<int:property_id>', methods=['GET'])
def get_property(property_id):
    prop = Property.query.get(property_id)
    if not prop:
        return jsonify({'error': 'Property not found'}), 404

    owner = User.query.get(prop.owner_id)
    owner_name = f"{owner.first_name} {owner.last_name}" if owner else None

    result = {
        'id': prop.id,
        'owner_id': prop.owner_id,
        'owner_name': owner_name,
        'owner_contact': owner.phone if owner else None,
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
    }
    return jsonify(result)
