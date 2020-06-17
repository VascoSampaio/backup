from flask import Blueprint
frontoffice = Blueprint('frontoffice', __name__)

from . import views
