from flask import Blueprint
localizacao = Blueprint('localizacao', __name__)

from . import views
