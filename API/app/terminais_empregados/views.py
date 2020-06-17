# -*- coding: utf-8 -*-

from . import terminais_empregados
from flask import render_template, redirect, request, url_for, flash
from flask_login import login_user, logout_user, login_required
from flask import Markup
from .. import db
from ..models import User, Role, User, Table, Service, Terminal, TerminalType, Order, Category, Icon, Product, Attribute, Location
from .forms import EditarTerminalEmpregado




@terminais_empregados.route('/')
@login_required
def index():
    terminal=Terminal.query.all()
    terminalType=TerminalType.query.all()
    users=User.query.all()
    lista=[]

    for terminal in terminal:
        for terminal_ty in terminalType:
            for user in users:
                if terminal_ty.id == terminal.terminalTypeId:
                    if user.id == terminal.userId:
                        lista.append([terminal.id, terminal.name, terminal_ty.name , user.username])
    return render_template('view.html', header="Terminals", columns=["Terminal Id", "Name", "Terminal Type", "User"], rows=lista, tabletype="striped", objecto="terminals", titulo="Terminals")


    

@terminais_empregados.route('/criar',methods=['GET','POST'])
@login_required
def criar():

    form = EditarTerminalEmpregado()
    terminalIds = TerminalType.query.all()
    userIds = User.query.all()

    form.userId.choices = [(k.id, k.username) for k in userIds]
    form.terminalTypeid.choices = [(i.id, i.name) for i in terminalIds]

    if request.method == 'POST' and form.validate():

        
        nameTerminal = form.name.data
        idType = form.terminalTypeid.data
        idUser = form.userId.data

        insertTerminal = Terminal(name=nameTerminal,terminalTypeId=idType, userId=idUser)
        db.session.add(insertTerminal)
        db.session.commit()

        flash("Terminal Criado com sucesso")
        return redirect(url_for('terminais_empregados.index'))

    return render_template('criar.html', titulo="Criar Terminal", form=form) 



@terminais_empregados.route('/edit<id>', methods=['GET', 'POST'])
@login_required
def edit(id):
   
    data = Terminal.query.get(id)
    form = EditarTerminalEmpregado()

    terminalIds = TerminalType.query.all()
    userIds = User.query.all()

    form.userId.choices = [(k.id, k.username) for k in userIds]
    form.terminalTypeid.choices = [(i.id, i.name) for i in terminalIds]
    form.name.data = data.name
    form.terminalTypeid.data = data.terminalTypeId
    form.userId.data = data.userId


    if form.validate_on_submit():
        form = EditarTerminalEmpregado()
        data.name = form.name.data
        data.terminalTypeId = form.terminalTypeid.data
        data.userId = form.userId.data

        db.session.commit()
        flash('Terminal Atualizado com sucesso')
        return redirect(url_for('terminais_empregados.index'))


    return render_template('criar.html',form=form)



@terminais_empregados.route('/delete<id>', methods = ['GET','POST'])
@login_required
def delete(id):
    terminalData = Terminal.query.get(id)

    db.session.delete(terminalData)
    db.session.commit()

    flash("Terminal Apagado com Sucesso")
    
    return redirect(url_for('terminais_empregados.index'))


