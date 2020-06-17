# -*- coding: utf-8 -*-

from . import servicos
from flask import render_template, redirect, request, url_for, flash, request
from flask_login import login_user, logout_user, login_required
from flask import Markup
from .. import db
from ..models import User, Role, User, Table, Service, Terminal, TerminalType, Order, Category, Icon, Product, Attribute, Location
from .forms import CriarServico

@servicos.route('/')
@login_required
def index():
    a=Service.query.all()
    l = Location.query.all()
    lista=[]
    for Empregados in a:
        for loc in l:
            if loc.id == Empregados.locationId:

                lista.append([Empregados.id, Empregados.name, loc.name])
        
    return render_template('view.html', header='Serviço', columns =["Id","Serviço","Localização"],rows= lista, tabletype="striped", objecto="serviços", titulo ="Serviços")


@servicos.route('/criar', methods=['GET', 'POST'])
@login_required
def criar():

    form = CriarServico()
    locations = Location.query.all()
    form.location.choices = [(i.id, i.name) for i in locations]

    if request.method == 'POST' and form.validate():
        name = form.name.data
        locationId = form.location.data

        insertService = Service(name= name, locationId= locationId)
        db.session.add(insertService)
        db.session.commit()

        flash("Serviço criado com sucesso")
        return redirect(url_for('servicos.index'))
    return render_template('criar.html', titulo="Criar Serviço", form=form)


@servicos.route('/edit<id>', methods=['GET', 'POST'])
@login_required
def edit(id):

    locations = Location.query.all()
    data = Service.query.get(id)
    form = CriarServico()

    form.name.data = data.name
    form.location.data = data.locationId
    form.location.choices = [(i.id, i.name) for i in locations]

    if form.validate_on_submit():
        form = CriarServico()
        data.name = form.name.data
        data.locationId = form.location.data

        db.session.commit()
        flash('Serviço Atualizado com sucesso !')
        return redirect(url_for('servicos.index'))
    return render_template('criar.html', titulo="Editar Serviço", form=form)

@servicos.route('/delete<id>', methods = ['GET','POST'])
@login_required
def delete(id):

    data=Service.query.get(id)
    db.session.delete(data)
    db.session.commit()
    flash("Serviço Apagado com Sucesso")
    
    return redirect(url_for('servicos.index'))
