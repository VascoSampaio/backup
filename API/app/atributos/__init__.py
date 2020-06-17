from flask import Blueprint

atributos = Blueprint('atributos', __name__)

from . import views
