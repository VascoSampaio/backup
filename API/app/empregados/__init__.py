from flask import Blueprint
empregados = Blueprint('empregados', __name__)

from . import views
