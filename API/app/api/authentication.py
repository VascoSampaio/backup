from flask import g, jsonify
from flask_httpauth import HTTPBasicAuth, HTTPTokenAuth, MultiAuth
from ..models import User
from . import api
from .errors import unauthorized, forbidden

basicAuth = HTTPBasicAuth()
tokenAuth = HTTPTokenAuth(scheme='Bearer')
multiAuth = MultiAuth(basicAuth, tokenAuth)

@basicAuth.verify_password
def verify_password(email, pin):
    if email != '':
        user = User.query.filter_by(email=email.lower()).first()
        if not user:
            return False
        g.current_user = user
        g.token_used = False 
        return user.verify_password(pin)
    if pin == '':
        return False
    for user in User.query.all():
        if user.verify_pin(pin):
            temp = user
            g.current_user = temp
            g.token_used = False
            return True
    return False

@tokenAuth.verify_token
def verify_token(token):
    if User.verify_auth_token(token):
        return unauthorized('Invalid token')

@basicAuth.error_handler
def auth_error():
    return unauthorized('Invalid credentials')


@api.before_request
@multiAuth.login_required
def before_request():
    multiAuth.current_user()

@api.route('/loginManager/', methods=['POST'])
def get_token():
    if g.current_user.is_anonymous or g.token_used:
        return unauthorized('Invalid credentials')
    return jsonify({'token': g.current_user.generate_auth_token(
        expiration=3600), 'user': g.current_user.username})
