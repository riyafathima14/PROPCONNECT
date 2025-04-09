# routes/auth_routes.py
from flask import Blueprint, request, jsonify
from models.user import User
from extensions import db
from utils.otp_helper import generate_otp, is_valid_email, is_valid_phone, send_sms_otp
from utils.email_helper import send_email_otp
from werkzeug.security import generate_password_hash, check_password_hash

auth_bp = Blueprint('auth', __name__, url_prefix='/auth')


@auth_bp.route('/send-otp', methods=['POST'])
def send_otp():
    data = request.get_json()
    print("Recieved data:",data)
    first_name = data.get('first_name')
    last_name = data.get('last_name')
    email = data.get('email')
    phone = data.get('phone').strip()
    password = data.get('password')
    user_name=data.get('user_name')

    if not (first_name and last_name and password):
        return jsonify({"error": "First name, last name, and password are required"}), 400

    if not (email or phone):
        return jsonify({"error": "Either email or phone number is required"}), 400

    if email and not is_valid_email(email):
        return jsonify({"error": "Invalid email format"}), 400

    if phone and not is_valid_phone(phone):
        return jsonify({"error": "Invalid phone number format"}), 400

    otp = generate_otp(4)

    user = None
    if email:
        user = User.query.filter_by(email=email).first()
    if phone and not user:
        user = User.query.filter_by(phone=phone).first()

    if user:
        if not user.is_verified:  # Resend OTP if user is not verified
            user.otp = otp
            db.session.commit()
            if email:
                send_email_otp(email, otp)
                return jsonify({"message": "OTP sent to email"}), 200
            elif phone:
                send_sms_otp(phone, otp)
                return jsonify({"message": "OTP sent to phone"}), 200
        return jsonify({"error": "User already exists and verified"}), 400

    new_user = User(first_name=first_name, last_name=last_name, email=email, phone=phone, password=password, otp=otp,user_name=user_name)

   
    db.session.add(new_user)
    db.session.commit()

    if email:
        if send_email_otp(email, otp):
            return jsonify({"message": "OTP sent to email"}), 200
        else:
            return jsonify({"error": "Failed to resend OTP to email"}), 500
    elif phone:
        if send_sms_otp(phone, otp):
            return jsonify({"message": "OTP sent to phone"}), 200
        else:
            return jsonify({"error": "Failed to resend OTP to phone"}), 500

@auth_bp.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    print("Received data in /login:", data)
    
    # Trim whitespace for both values
    user_name = data.get('user_name', '').strip()
    password = data.get('password', '').strip()

    if not user_name or not password:
        return jsonify({"success": False, "message": "missing username or password"}), 400

    user = User.query.filter_by(user_name=user_name).first()
    if not user:
        return jsonify({"success": False, "message": "User not found"}), 404

    # For plaintext testing, compare directly with stripped versions.
    print("Stored password:", repr(user.password))
    print("Provided password:", repr(password))
    if user.password.strip() != password:
        return jsonify({"success": False, "message": "Incorrect password"}), 401

    return jsonify({
        "success": True,
        "message": "Login successful",
        "user_id": user.id,
        "user_name": user.user_name,
        "user_name": user.user_name,
        "email": user.email,
        "phone": user.phone,
        "first_name": user.first_name,
        "last_name": user.last_name,
    }), 200

@auth_bp.route('/verify-otp', methods=['POST'])
def verify_otp():
    data = request.get_json()
    email = data.get('email')
    phone = data.get('phone')
    otp = data.get('otp')

    if not otp:
        return jsonify({"error": "OTP is required"}), 400

    user = None
    if email:
        user = User.query.filter_by(email=email, otp=otp).first()
    elif phone:
        user = User.query.filter_by(phone=phone, otp=otp).first()

    if user:
        user.is_verified = True
        user.otp = None
        db.session.commit()
        return jsonify({"message": "OTP verified, user registered successfully!"}), 200

    return jsonify({"error": "Invalid OTP"}), 400

@auth_bp.route('/', methods=['GET'])
def auth_home():
    return jsonify({"message": "Flask OTP backend (Auth) is running"})
