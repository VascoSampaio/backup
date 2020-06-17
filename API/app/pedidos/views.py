# -*- coding: utf-8 -*-

import datetime
from . import pedidos
from flask import render_template, redirect, request, url_for, flash
from flask_login import login_user, logout_user, login_required
from flask import Markup
from ..models import User, Role, User, Table, Service, Terminal, TerminalType, Order, Category, Icon, Product, Attribute, Location,OrderProduct
from .. import db

from .forms import EncaminhamentoForm, SearchEncaminhamentoForm, DefaultEncaminhamentoForm
from .forms import Search


@pedidos.route('/',methods = ['GET','POST'])
@login_required

def index():
    orderProducts = OrderProduct.query.all()
    products = Product.query.all()
    tables = Table.query.all()
    orders = Order.query.all()
    lista=[]

    form= Search()
    
    if request.method == 'POST' and form.validate():
        tableId = form.tableId.data;
        for produc in tables:
         for empregados in orderProducts:
            for artigos in products:
                 for order in orders:
                    if artigos.id == empregados.productId :
                        if order.id == empregados.orderId :
                            if produc.id == order.tableId == tableId:
                           
                                lista.append([empregados.id, empregados.orderId, artigos.name ,order.tableId, empregados.description ,empregados.qty, order.orderAddTime, order.finishTime])
    
        return render_template('pedidos.html', header='Pedidos', columns =["Id","OrderId",'Produto','Número da Mesa','Descrição','Quantidade', "Início do pedido", "Fim do Pedido"],rows= lista, tabletype="striped", form=form)

    else:
        for empregados in orderProducts:
            for artigos in products:
                 for order in orders:
                    if artigos.id == empregados.productId :
                        if order.id == empregados.orderId:
                           
                            lista.append([empregados.id, empregados.orderId, artigos.name ,order.tableId,empregados.description ,empregados.qty, order.orderAddTime, order.finishTime])
    
        return render_template('pedidos.html', header='Pedidos', columns =["Id","OrderId",'Produto','Número da Mesa','Descrição','Quantidade', "Início do pedido", "Fim do Pedido"],rows= lista, tabletype="striped", form=form)
   


    







@pedidos.route('/order<id>')
@login_required
def order(id):
    header="Pedido"

    a=Order.query.filter_by(orderId=id).first
    lista=[(i.id, i.Name) for i in a.products]
   

    return render_template('pedidos.html', header=header, columns =["Id","Mesa",'Hora Pedido','Qtd.'], rows= lista, tabletype="striped")




