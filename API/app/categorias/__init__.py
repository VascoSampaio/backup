from flask import Blueprint
categorias = Blueprint('categorias', __name__)

from . import views
