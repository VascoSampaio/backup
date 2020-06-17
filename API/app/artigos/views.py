# -*- coding: utf-8 -*-

from . import artigos
from flask import render_template, redirect, request, url_for, flash
from flask_login import login_user, logout_user, login_required
from flask import Markup
from ..models import User, Role, User, Table, Service, Terminal, TerminalType, Order, Category, Icon, Product, Attribute, Location

from .forms import  FormArtigo, FormProcurarArtigo
from .. import db

@artigos.route('/')
@login_required
def index():
    form=FormProcurarArtigo()
    produtos = Product.query.all()
    cat = Category.query.all()
    
    lista=[]
    for Empregados in produtos:
        lista.append([Empregados.id, Empregados.name, str(str(Empregados.price) +"€"), Empregados.description])
    return render_template('view.html', header='Artigos', columns =["Id","Producto","Preço","Descrição"],rows= lista, tabletype="striped", objecto="Artigos", titulo ="Artigos", form=form)
    
    
@artigos.route('/edit<id>', methods=['GET','POST'])
@login_required
def edit(id):
    form=FormArtigo()
    produtos = Product.query.get(id)

    form.name.data = produtos.name
    form.description.data = produtos.description
    form.price.data = produtos.price
    form.submit.label.text="Editar"
    
    if form.validate_on_submit():
       form=FormArtigo()
       produtos.name = form.name.data
       produtos.description = form.description.data
       produtos.price = form.price.data

       db.session.commit()
       flash('Artigo Atualizado com sucesso')
       return redirect(url_for('artigos.index'))

    return render_template('criar.html', titulo="Editar Artigo", form=form) 
    
    
    
@artigos.route('/criar', methods=['GET', 'POST'])
@login_required
def criar():
    
    form=FormArtigo()
    produtos = Product.query.all()
    
    if form.validate_on_submit():
        name = form.name.data
        description = form.description.data
        price = form.price.data

        produtoName = Product.query.filter_by(name=name).first()
        if produtoName:
            flash("Este produto já existe")
        else:
            artigo = Product(name=name, price=price, description=description)
            db.session.add(artigo)
            db.session.commit()
            flash("Artigo criado com sucesso")
            return redirect(url_for('artigos.index'))

    return render_template('criar.html', titulo="Criar Artigo", form=form) 
   
@artigos.route('/delete<id>')
@login_required
def delete(id):
    produto = Product.query.get(id)
    db.session.delete(produto)
    db.session.commit()
    flash('Artigo Eleminado com Sucesso')
    return redirect(url_for('artigos.index'))
    