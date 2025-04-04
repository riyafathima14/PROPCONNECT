from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_mail import Mail, Message
from twilio.rest import Client
from twilio.base.exceptions import TwilioRestException
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
import random
import os
import re
import smtplib
import logging
from dotenv import load_dotenv
from flask_cors import CORS

# Load environment variables
load_dotenv()

# Ensure required environment variables are present
required_env_vars = [
    'MAIL_SERVER', 'MAIL_PORT', 'MAIL_USERNAME', 'MAIL_PASSWORD',
    'TWILIO_ACCOUNT_SID', 'TWILIO_AUTH_TOKEN', 'TWILIO_PHONE_NUMBER', 'TWILIO_MESSAGING_SERVICE_SID'
]

missing_vars = [var for var in required_env_vars if not os.getenv(var)]

if missing_vars:
    raise EnvironmentError(f"❌ Missing required environment variables: {', '.join(missing_vars)}")

app = Flask(__name__)
CORS(app)

# Configure logging
logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s')

logging.basicConfig(level=logging.INFO, format="%(asctime)s - %(levelname)s - %(message)s")

# Flask Configuration
app.config['SECRET_KEY'] = os.getenv('SECRET_KEY', 'your_secret_key_here')

# PostgreSQL Database Configuration
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:propconnect@localhost:5432/propconnect'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)

# Flask-Mail Configuration (Email OTP)
app.config['MAIL_SERVER'] = os.getenv('MAIL_SERVER')
app.config['MAIL_PORT'] = int(os.getenv('MAIL_PORT'))
app.config['MAIL_USE_TLS'] = True
app.config['MAIL_USERNAME'] = os.getenv('MAIL_USERNAME')
app.config['MAIL_PASSWORD'] = os.getenv('MAIL_PASSWORD')

mail = Mail(app)

# Twilio Configuration (SMS OTP)
twilio_client = Client(os.getenv('TWILIO_ACCOUNT_SID'), os.getenv('TWILIO_AUTH_TOKEN'))
TWILIO_PHONE_NUMBER = os.getenv('TWILIO_PHONE_NUMBER')
TWILIO_MESSAGING_SERVICE_SID = os.getenv("TWILIO_MESSAGING_SERVICE_SID")
# Debug: Check Twilio Configuration
print("Twilio Account SID:", os.getenv('TWILIO_ACCOUNT_SID'))
print("Twilio Auth Token:", os.getenv('TWILIO_AUTH_TOKEN'))
print("Twilio Phone Number:", os.getenv('TWILIO_PHONE_NUMBER'))
print("Twilio Messaging Service SID:", os.getenv("TWILIO_MESSAGING_SERVICE_SID"))


# User Model
class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    first_name = db.Column(db.String(50), nullable=False)
    last_name = db.Column(db.String(50), nullable=False)
    email = db.Column(db.String(100), unique=True, nullable=True)
    phone = db.Column(db.String(15), unique=True, nullable=True)
    password = db.Column(db.String(100), nullable=False)
    otp = db.Column(db.String(6), nullable=True)
    is_verified = db.Column(db.Boolean, default=False)

def generate_otp(length=4):
    """generate a secure random otp of given length"""
    return  ''.join(str(random.randint(0, 9)) for _ in range(length))

def is_valid_email(email):
    email_regex = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    return re.match(email_regex, email)

def is_valid_phone(phone):
    return phone.startswith("+") and len(phone) >= 10

#@app.route('/send-email', methods=['GET'])
def send_email_otp(email, otp):
    try:
        #otp =  generate_otp()
        smtp_server = "smtp.gmail.com"
        smtp_port = 587
        sender_email = os.getenv("MAIL_USERNAME")
        sender_password = os.getenv("MAIL_PASSWORD")

        #create the email content
        message = MIMEMultipart()
        message["From"] = sender_email
        message["To"] = email
        message["Subject"] = "Action Required: Verify Your PropConnect Account"
        message["Reply-To"] = sender_email
        message["MIME-Version"] = "1.0"

        email_body = f"""
        <html>
        <body style="font-family: Arial, sans-serif; color: #333;">
            <div style="max-width: 600px; margin: auto; padding: 20px; border: 1px solid #ddd; border-radius: 8px;">
                <h2 style="color: #007bff; text-align: center;">Welcome to PropConnect!</h2>
                <p>Hi there,</p>
                <p>We received a request to verify your email for PropConnect. Use the One-Time Password (OTP) below to proceed:</p>
                <h3 style="text-align: center; font-size: 24px; color: #28a745;">{otp}</h3>
                <p style="color: #888; font-size: 12px;">This OTP is valid for the next 10 minutes. Please do not share it with anyone.</p>
                <hr>
                <p style="text-align: center; font-size: 14px;">If you did not request this, please ignore this email.</p>
                <p style="text-align: center; font-size: 12px; color: #888;">PropConnect Team | <a href="mailto:support@propconnect.com">Contact Support</a></p>
            </div>
        </body>
        </html>
        """ 
        message.attach(MIMEText(email_body, "html"))

        #send the email
        with smtplib.SMTP(smtp_server, smtp_port) as server:
            server.set_debuglevel(1)
            server.starttls()  # Secure the connection
            server.login(sender_email, sender_password)
            server.sendmail(sender_email, email, message.as_string())
           # server.quit()


        logging.info(f"✅ OTP sent to {email}")
        return otp
    except Exception as e:
        logging.error(f"❌ Error sending OTP to {email}: {e}")
        return None

#TEST_EMAIL        

"""@app.route('/test-email', methods=['GET'])
def test_email():
    try:
        email = request.args.get('email')
        otp = "123456"  # In production, use a randomly generated OTP

        send_email_otp(email, otp)
        return jsonify({"message": f"Test OTP sent to {email}"}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500       """ 

#@app.route('/send-sms', methods=['GET'])
def send_sms_otp(phone, otp):
    try:
        #otp = generate_otp()
        message=twilio_client.messages.create(
            body=f'Your OTP for PropConnect is: {otp}',
            messaging_service_sid=TWILIO_MESSAGING_SERVICE_SID,
            to=phone
        )
        logging.info(f"✅ OTP sent to {phone}, Message SID: {message.sid}")
        return otp
    except Exception as e:
        logging.error(f"❌ Error sending OTP to {phone}: {e}")
        return None

#TEST_SMS

"""@app.route('/test-sms', methods=['GET'])
def test_sms():
    try:
        phone_number = request.args.get('phone')

        if not phone_number:
            return jsonify({"error": "Phone number is required!"}), 400
        
        #send sms using twilio
        message = twilio_client.messages.create(
            body="Test message from PropConnect!",
            messaging_service_sid=TWILIO_MESSAGING_SERVICE_SID,
            to=phone_number  # Replace with your phone number
        )
        return jsonify({"message": "Test SMS sent!", "sid": message.sid}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500"""


@app.route('/send-otp', methods=['POST'])
def send_otp():
    data = request.json
    first_name = data.get('first_name')
    last_name = data.get('last_name')
    email = data.get('email')
    phone = data.get('phone')
    password = data.get('password')

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
                return jsonify({"message": "OTP resent to email"}), 200

            elif phone:
                send_sms_otp(phone, otp)
                return jsonify({"message": "OTP resent to phone"}), 200

        return jsonify({"error": "User already exists and verified"}), 400

    new_user = User(first_name=first_name, last_name=last_name, email=email, phone=phone, password=password, otp=otp)
    db.session.add(new_user)
    db.session.commit()

    if email:
        send_email_otp(email, otp)
        return jsonify({"message": "OTP sent to email"}), 200

    elif phone:
        send_sms_otp(phone, otp)
        return jsonify({"message": "OTP sent to phone"}), 200

@app.route('/verify-otp', methods=['POST'])
def verify_otp():
    data = request.json
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

@app.route('/')
def home():
    return jsonify({"message":"Flask OTP backend is running"})

if __name__ == '__main__':
    with app.app_context():
        db.create_all()
    app.run(debug=True)
