from flask import jsonify, request, current_app, url_for
from . import api
from ..models import User



@api.route('/order/<int:id>')
def new_order(id):
    
    


