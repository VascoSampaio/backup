# -*- coding: utf-8 -*-

from . import localizacao
from flask import render_template, redirect, request, url_for, flash, request
from flask_login import login_user, logout_user, login_required
from flask import Markup
from .. import db
from ..models import User, Role, User, Table, Service, Terminal, TerminalType, Order, Category, Icon, Product, Attribute, Location
from .forms import CriarLocalizacao


@localizacao.route('/')
@login_required
def index():

    locs= Location.query.all()  
    lista=[]

    for i in locs :
            lista.append([i.id, i.name])
    return render_template('view.html', header="Location", columns =["IdLocation","Nome"], rows =lista, tabletype="striped", objecto="localizacao", titulo ="Localização")


@localizacao.route('/criar',methods=['GET','POST'])
@login_required
def criar():
    locs = Location.query.all()
    
    form = CriarLocalizacao()
   

    if request.method == 'POST' and form.validate():

        locData = form.nomeLoc.data
        insertlocation = Location(name=locData)
        db.session.add(insertlocation)
        db.session.commit()

        flash("Localização criada com sucesso")
        return redirect(url_for('localizacao.index'))

    return render_template('criar.html', titulo="Criar Localização", form=form)    
    

@localizacao.route('/edit<id>', methods=['GET'])
@login_required
def edit(id):

    data = Location.query.get(id)
    form= CriarLocalizacao()
    form.nomeLoc.data = data.name
    form.submit.label.text = "Editar"

    if form.validate_on_submit():

        form = CriarLocalizacao()
        data.name = form.nomeLoc.data
        db.session.commit()
        flash('Localização atualizada com sucesso')
        return redirect(url_for('localizacao.index'))

    return render_template('criar.html', titulo="Editar Localização", form=form)


@localizacao.route('/delete<id>', methods=['GET'])
@login_required

def delete(id):

    data = Location.query.get(id)
    db.session.delete(data)
    db.session.commit()
    flash('Localização eliminada com sucesso')

    return redirect(url_for('localizacao.index'))