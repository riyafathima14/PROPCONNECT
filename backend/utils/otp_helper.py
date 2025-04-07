# utils/otp_helper.py
import random
import re
from flask import current_app
from extensions import twilio_client

def generate_otp(length=4):
    return ''.join(str(random.randint(0, 9)) for _ in range(length))

def is_valid_email(email):
    email_regex = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    return re.match(email_regex, email)

def is_valid_phone(phone):
    phone = phone.strip()
    return bool(re.match(r'^(\+91)?[6-9]\d{9}$',phone))

def send_sms_otp(phone, otp):
    try:
        message = twilio_client.messages.create(
            body=f'Your OTP for PropConnect is: {otp}',
            messaging_service_sid=current_app.config.get('TWILIO_MESSAGING_SERVICE_SID'),
            to=phone
        )
        current_app.logger.info(f"✅ OTP sent to {phone}, Message SID: {message.sid}")
        return otp
    except Exception as e:
        current_app.logger.error(f"❌ Error sending OTP to {phone}: {e}")
        return None
