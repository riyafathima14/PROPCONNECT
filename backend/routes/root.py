# routes/root.py
from flask import Blueprint

root_bp = Blueprint('root', __name__)  # create a blueprint

@root_bp.route('/', methods=['GET'])   # define the '/' route
def home():
    return {"message": "✅ Flask Backend Connected Successfully!"}
