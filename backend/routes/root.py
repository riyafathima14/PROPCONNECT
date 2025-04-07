# routes/root.py
<<<<<<< HEAD
from flask import Blueprint
=======
from flask import Blueprint, jsonify
>>>>>>> 21cfef73cc1af80d997592547894e284519365f5

root_bp = Blueprint('root', __name__)  # create a blueprint

@root_bp.route('/', methods=['GET'])   # define the '/' route
<<<<<<< HEAD
def home():
=======
def root():
>>>>>>> 21cfef73cc1af80d997592547894e284519365f5
    return {"message": "✅ Flask Backend Connected Successfully!"}
