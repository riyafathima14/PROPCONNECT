# app.py
from flask import Flask
import logging
from config import Config
from flask_cors import CORS
from extensions import db, mail, cors, twilio_client
from twilio.rest import Client
from dotenv import load_dotenv
load_dotenv()

from routes import register_routes  # We'll create register_routes in routes/__init__.py
from routes import root

 # Setup Twilio Client
#global twilio_client
#twilio_client = Client(app.config['TWILIO_ACCOUNT_SID'], app.config['TWILIO_AUTH_TOKEN'])
twilio_client = Client(Config.TWILIO_ACCOUNT_SID, Config.TWILIO_AUTH_TOKEN)

def create_app():
    # load_dotenv()
    app = Flask(__name__)
    CORS(app, resources={r"/*": {"origins": "*"}})
    app.config.from_object(Config)

    # Initialize extensions
    db.init_app(app)
    mail.init_app(app)
    #cors.init_app(app)

   

    # Configure logging
    logging.basicConfig(level=logging.INFO, format="%(asctime)s - %(levelname)s - %(message)s")

    # Register blueprints from the routes package
    register_routes(app)

    return app



if __name__ == '__main__':
    app = create_app()
    with app.app_context():
        db.create_all()
    app.run(host="0.0.0.0", port=5000, debug=True)
