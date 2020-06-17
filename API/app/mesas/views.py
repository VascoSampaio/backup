# -*- coding: utf-8 -*-

from . import mesas
from flask import render_template, redirect, request, url_for, flash, request
from flask_login import login_user, logout_user, login_required
from flask import Markup
from .. import db
from ..models import User, Role, User, Table, Service, Terminal, TerminalType, Order, Category, Icon, Product, Attribute, Location

from .forms import CriarMesa

@mesas.route('/')
@login_required
def index():
    
    
    tables= Table.query.all()
    locations = Location.query.all()
    
    lista=[]
    for table in tables :
        for location in locations:
            if location.id == table.locationId :
                lista.append([table.internalNumber, table.displayNumber, location.name])
    
    return render_template('view.html', header="Mesas", columns =["Número de Mesa","Identificador Pleez","Localização"], rows =lista, tabletype="striped", objecto="mesas", titulo ="Mesas")

    
@mesas.route('/criar',methods=['GET','POST'])
@login_required
def criar():
    locations = Location.query.all()
    
    
    
    form= CriarMesa()
    form.location.choices = [(i.id, i.name) for i in locations]

    if request.method == 'POST' and form.validate():

        internalnumber = form.internalNumber.data
        displaynumber = form.displayNumber.data
        location = form.location.data
        insertmesa = Table(internalNumber=internalnumber, displayNumber=displaynumber, locationId=location)
        db.session.add(insertmesa)
        db.session.commit()

        flash("Mesa criada com sucesso")
        return redirect(url_for('mesas.index'))

    return render_template('criar.html', titulo="Criar Mesa", form=form)    


@mesas.route('/delete<id>', methods = ['GET','POST'])
@login_required
def delete(id):
  

    
    data=Table.query.get(id)

    
    db.session.delete(data)
    db.session.commit()

    flash("Mesa Apagada com Sucesso")
    
    return redirect(url_for('mesas.index'))



@mesas.route('/edit<id>', methods=['GET', 'POST'])
@login_required
def edit(id):

    data = Table.query.get(id)
    form= CriarMesa()
    locations = Location.query.all()

    form.location.choices = [(i.id, i.name) for i in locations]
    form.internalNumber.data = data.internalNumber
    form.displayNumber.data = data.displayNumber
    form.location.data = data.locationId
    form.submit.label.text = "Editar"

    if form.validate_on_submit():
        form = CriarMesa()
        data.internalNumber = form.internalNumber.data
        data.displayNumber = form.displayNumber.data
        data.locationId = form.location.data

        db.session.commit()
        flash('Mesa atualizada com sucesso')
        return redirect(url_for('mesas.index'))

    return render_template('criar.html', titulo="Editar Mesa", form=form)
    