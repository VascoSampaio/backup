from flask import Blueprint
servicos = Blueprint('servicos', __name__)

from . import views
