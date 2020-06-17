from flask import Blueprint
mesas = Blueprint('mesas', __name__)

from . import views
