from flask import jsonify, request, g, url_for, current_app
from .. import db
from ..models import Table
from . import api
from .decorators import permission_required
from .errors import forbidden


@api.route('/tables/', methods=['GET'])
def getMesas():
    tables = Table.query.order_by(Table.id.asc()).all()
    return jsonify([table.to_json() for table in tables])