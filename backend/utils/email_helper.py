# utils/email_helper.py
import os
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from flask import current_app

def send_email_otp(email, otp):
    try:
        smtp_server = "smtp.gmail.com"
        smtp_port = 587
        sender_email = os.getenv("MAIL_USERNAME")
        sender_password = os.getenv("MAIL_PASSWORD")

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

        with smtplib.SMTP(smtp_server, smtp_port) as server:
            server.set_debuglevel(1)
            server.starttls()
            server.login(sender_email, sender_password)
            server.sendmail(sender_email, email, message.as_string())
        current_app.logger.debug(f"MAIL_USERNAME: {sender_email}")
        current_app.logger.debug(f"MAIL_PASSWORD: {'set' if sender_password else 'missing'}")

        current_app.logger.info(f"✅ OTP sent to {email}")
        return otp
    except Exception as e:
        current_app.logger.error(f"❌ Error sending OTP to {email}: {e}")
        print("Error in send_email_otp:", e)
        return None
