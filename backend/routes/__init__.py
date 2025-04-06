# routes/__init__.py
def register_routes(app):
    from .auth_routes import auth_bp
    from .property_routes import property_bp
    from .root import root_bp   # <-- ADD this line

    app.register_blueprint(auth_bp)
    app.register_blueprint(property_bp)
    app.register_blueprint(root_bp)   # <-- ADD this line
