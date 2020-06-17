import json, datetime, time
from flask import jsonify, request, current_app, url_for
from . import api
from .. import db
from ..models import User, Order
from sqlalchemy import exc


@api.route('/orders', methods=['GET'])
def getOrders():
    orders = Order.query.filter_by(finishTime=None).order_by(Order.orderAddTime.asc())
    return jsonify([order.to_json() for order in orders])

@api.route('/orders/<int:id>', methods=['GET'])
def getOrdersById(id):
    order = Order.query.get(id)
    return jsonify(order.to_json())

@api.route('/orders/<int:id>', methods=['PUT'])
def getOrder(id):
    order = Order.query.get(id)
    order.finishTime = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    data = {}
    try:
        db.session.commit()
        data['message'] = 'Pedido finalizado com sucesso.'
    except exc.SQLAlchemyError:
        data['message'] = 'Falha no pedido.'
    return jsonify(data)    

@api.route('/orders/history', methods=['GET'])
def getHistory():
    orders = Order.query.filter(Order.finishTime.isnot(None)).filter(Order.callType == False).filter(Order.billType == False).order_by(Order.finishTime.desc())
    return jsonify([order.to_json() for order in orders])

@api.route('/orders/history/<int:id>', methods=['PUT'])
def rollBackOrder(id):
    order = Order.query.get(id)
    order.finishTime = None
    data = {}
    try:
        db.session.commit()
        data['message'] = 'Pedido revertido com sucesso.'
    except exc.SQLAlchemyError:
        data['message'] = 'Falha no pedido.'
    return jsonify(data)