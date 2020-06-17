# -*- coding: utf-8 -*-

from . import empregados
from flask import render_template, redirect, request, url_for, flash
from flask_login import login_user, logout_user, login_required
from flask import Markup
from ..models import User, Role, User, Table, Service, Terminal, TerminalType, Order, Category, Icon, Product, Attribute, Location
from .. import db
from .forms import EmpregadoForm
from werkzeug.security import generate_password_hash, check_password_hash


@empregados.route('/')
@login_required
def index():
        
    a=User.query.all()
    lista=[]
    for Empregados in a:
        lista.append([Empregados.id, Empregados.username, Empregados.email, Empregados.roleId])
        
    return render_template('view.html', header='Empregado', columns =["id","Nome","Email","RoleID"],rows= lista, tabletype="striped", objecto="empregados", titulo ="Empregados")


@empregados.route('/edit<id>', methods=['GET', 'POST'])
@login_required
def edit(id):

    a=User.query.get(id)
    form = EmpregadoForm()

    form.username.data = a.username
    form.email.data=a.email
    
    if form.validate_on_submit():
        form = EmpregadoForm()
        a.username=form.username.data
        a.email=form.email.data

        db.session.commit()
        flash('Empregado actualizado com sucesso.')
        return redirect(url_for('empregados.index'))
        
    return render_template('criar.html', titulo="Editar Empregado", form=form)




@empregados.route('/criar', methods=['GET', 'POST'])
@login_required
def criar():
    form = EmpregadoForm()
    
    if form.validate_on_submit():

        u = User.query.all()

        for i in u:
            v = i.verify_pin(form.pin.data)
            if v == True:
                flash('ERRO. Pin tem que ser diferente')
                return redirect(url_for('empregados.criar'))
            
        

        user = User(username=form.username.data, email=form.email.data,roleId=1, password=form.password.data , pin=form.pin.data)
        db.session.add(user)
        db.session.commit()
        flash('Empregado criado com sucesso.')
        return redirect(url_for('empregados.index'))
       
            
       
        
        
     
        
    return render_template('criar.html', titulo="Criar Empregado", form=form)



@empregados.route('/delete<id>', methods = ['GET','POST'])
@login_required
def delete(id):
   
    
    data=User.query.get(id)

    
    db.session.delete(data)
    db.session.commit()

    flash("Empregado Eleminado com Sucesso")
    
    return redirect(url_for('empregados.index'))
