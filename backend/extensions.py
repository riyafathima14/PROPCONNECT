# extensions.py
from flask_sqlalchemy import SQLAlchemy
from flask_mail import Mail
from flask_cors import CORS
from twilio.rest import Client

db = SQLAlchemy()
mail = Mail()
cors = CORS()
twilio_client = None  # Will be initialized in app.py
