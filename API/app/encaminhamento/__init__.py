from flask import Blueprint
encaminhamento = Blueprint('encaminhamento', __name__)

from . import views
