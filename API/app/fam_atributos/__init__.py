from flask import Blueprint
fam_atributos = Blueprint('fam_atributos', __name__)

from . import views
