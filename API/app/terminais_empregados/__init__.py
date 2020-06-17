from flask import Blueprint
terminais_empregados = Blueprint('terminais_empregados', __name__)

from . import views
