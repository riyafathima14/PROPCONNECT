# routes/root.py
from flask import Blueprint, jsonify

root_bp = Blueprint('root', __name__)  # create a blueprint

@root_bp.route('/', methods=['GET'])   # define the '/' route
def root():
    return {"message": "✅ Flask Backend Connected Successfully!"}
