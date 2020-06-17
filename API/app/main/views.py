# -*- coding: utf-8 -*-

from sqlalchemy import func
from sqlalchemy import text
from flask import Markup
from sqlalchemy import and_
from . import main
from . import auth
from ..models import User, Role, User, Table, Service, Terminal, TerminalType, Order, Category, Icon, Product, Attribute, Location
from flask_login import login_user, logout_user, login_required
from .forms import EmpregadoForm,  EncaminhamentoForm, SearchEncaminhamentoForm, DefaultEncaminhamentoForm, Fam_atributos, Atributos
from .. import db
from flask import render_template, redirect, request, url_for, flash
import datetime
from sqlalchemy import extract 
from collections import Counter



@main.route('/index')
@login_required
def index():

    

    #DATA SETUP
    labels = []
    values = []

    result = db.session.execute('SELECT * FROM orders')
    lista = []
    for o in result:
        lista.append(o.orderAddTime.day)

    counter = Counter(lista)
    
    for i in counter:
        print(i, counter[i])
        labels.append(i)
        values.append(counter[i])

    colors = [
    "#F7464A", "#46BFBD", "#FDB45C", "#FEDCBA",
    "#ABCDEF", "#DDDDDD", "#ABCABC", "#4169E1",
    "#C71585", "#FF4500", "#FEDCBA", "#46BFBD"
    ]
    
    bar_labels=labels
    bar_values=values
    return render_template('dashboard.html', title='Pedidos por dia', max=len(lista), labels=bar_labels, values=bar_values)

    

@main.route('/')
@login_required
def indexx():
    #DATA SETUP
    #labels = ["Estrelas", "Estrelas", "Estrelas", "Estrelas"]
    #values = ["5","5","2","2","1","5","2" ]

    labels = []
    values = []

    result = db.session.execute('SELECT * FROM orders')
    lista = []
    for o in result:
        lista.append(o.orderAddTime.day)

    counter = Counter(lista)
    
    for i in counter:
        print(i, counter[i])
        labels.append(i)
        values.append(counter[i])

    colors = [
    "#fd7e14", "#fd7e14", "#fd7e14", "#fd7e14",
    "#fd7e14", "#fd7e14", "#fd7e14", "#fd7e14",
    "#fd7e14", "#fd7e14", "#fd7e14", "#fd7e14"
    ]
    
    bar_labels=labels
    bar_values=values
    return render_template('dashboard.html', title='Pedidos por dia', max=len(lista), labels=bar_labels, values=bar_values)



@main.route('/familia_artigos')
@login_required
def familia_artigos():
    tipo_artigos= Category.query.all()
    lista=[]
    for Empregados in tipo_artigos:


        lista.append([Empregados.id, Empregados.name])

    return render_template('fam_artigos.html', header='Categorias', columns =["Id","Categoria"],rows= lista, tabletype="striped", objecto="categoria", objectos="/familia_artigos/sub_familia_artigos/")





@main.route('/familia_artigos_edit/<id>')
@login_required
def artigos_edit(id):
    return render_template('index.html')




@main.route('/familia_artigos/sub_familia_artigos/<id>')
@login_required
def sub_familia_artigos(id):
    sub_tipo_artigos = Sub_Tipo_Artigo.query.filter_by(id_tipo_artigo=id)

    lista=[]
    for Empregados in sub_tipo_artigos:


        lista.append([Empregados.id, Empregados.name])

    return render_template('sub_fam_artigos.html', header='', columns =["Id","Serviço"],rows= lista, tabletype="striped", objecto="familia_artigos")
