# config.py
import os
from dotenv import load_dotenv

load_dotenv()

# Ensure required environment variables are present
required_env_vars = [
    'MAIL_SERVER', 'MAIL_PORT', 'MAIL_USERNAME', 'MAIL_PASSWORD',
    'TWILIO_ACCOUNT_SID', 'TWILIO_AUTH_TOKEN', 'TWILIO_PHONE_NUMBER', 'TWILIO_MESSAGING_SERVICE_SID'
]
missing_vars = [var for var in required_env_vars if not os.getenv(var)]
if missing_vars:
    raise EnvironmentError(f"❌ Missing required environment variables: {', '.join(missing_vars)}")

class Config:
    SECRET_KEY = os.getenv('SECRET_KEY', 'your_secret_key_here')
    
    # Database Configuration
    SQLALCHEMY_DATABASE_URI = 'postgresql://postgres:propconnect@localhost:5432/propconnect'
    SQLALCHEMY_TRACK_MODIFICATIONS = False

    # Flask-Mail Configuration
    MAIL_SERVER = os.getenv('MAIL_SERVER')
    MAIL_PORT = int(os.getenv('MAIL_PORT'))
    MAIL_USE_TLS = True
    MAIL_USERNAME = os.getenv('MAIL_USERNAME')
    MAIL_PASSWORD = os.getenv('MAIL_PASSWORD')

    # Twilio Configuration
    TWILIO_ACCOUNT_SID = os.getenv('TWILIO_ACCOUNT_SID')
    TWILIO_AUTH_TOKEN = os.getenv('TWILIO_AUTH_TOKEN')
    TWILIO_PHONE_NUMBER = os.getenv('TWILIO_PHONE_NUMBER')
    TWILIO_MESSAGING_SERVICE_SID = os.getenv('TWILIO_MESSAGING_SERVICE_SID')
