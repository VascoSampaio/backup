# -*- coding: utf-8 -*-

from sqlalchemy import func
from sqlalchemy import text
from flask import Markup
from sqlalchemy import and_
from . import categorias
from ..models import User, Role, User, Table, Service, Terminal, TerminalType, Order, Category, Icon, Product, Attribute, Location
from flask_login import login_user, logout_user, login_required
from .. import db
from flask import render_template, redirect, request, url_for, flash
import datetime
from sqlalchemy import extract 
from collections import Counter
from .forms import CriarCategoria, SubCriarCategoria


#CATEGORIAS
@categorias.route('/')
@login_required
def index():
    cat = Category.query.all()
    lista=[]
    lista2=[]
    for i in cat:
        if i.level == 0:
            lista.append([i.id, i.name, i.description,"Principal"])
             
    return render_template('categorias.html', header="Categorias Principais", columns =["Id","Nome","Descrição","Categoria"], rows =lista, tabletype="striped", objecto="categorias", titulo ="Categorias")


@categorias.route('/view<id>')
@login_required
def cat(id):
    cat = Category.query.all()
    catName = Category.query.get(id)
    lista = []
    
    for i in cat:
        if i.categoryId == int(id):
            lista.append([i.id, i.name, "Secundária"])

    return render_template('subCategories.html', header="Categorias Secundárias", columns =["Id","Nome", "Categoria"], rows =lista, tabletype="striped", objecto="Sub Categoria",objecto2=catName.name, titulo =catName.name)


@categorias.route('/criar', methods=['GET', 'POST'])
@login_required
def criar():
    
    cat = Category.query.all()
    icons = Icon.query.all()
    form = CriarCategoria()
  
    if request.method == 'POST':
        data = request.form
        name = data.get("nome")
        description = data.get("descricao")
        iconId = data.get('icon')
        nameEng = data.get('name')
        descriptionEng = data.get('description')
        icons2 = Icon.query.filter_by(id=iconId).first()

        insertCategory = Category(name=name, description = description, level = 0, icons=[icons2])

        db.session.add(insertCategory)
        db.session.commit()
        flash('Categoria Criada com sucesso !')
        return redirect(url_for('categorias.index'))

    return render_template('criar_categorias.html', titulo="Criar Categoria",  iconsList=icons, form=form)


@categorias.route('/edit<id>', methods=['POST', 'GET'])
@login_required
def edit(id):
    
    form = CriarCategoria()
    icons = Icon.query.all()
    cat = Category.query.get(id)
    lol = cat.icons
    imageLoc = ""
    for i in lol:
        imageLoc = i.imageLocation

    if request.method == 'POST':
        cat = Category.query.get(id)
        data = request.form
        name = data.get("nome")
        description = data.get("descricao")
        iconId = data.get('icon')
        nameEng = data.get('name')
        descriptionEng = data.get('description')
        icons2 = Icon.query.filter_by(id=iconId).first()
        
        
        cat.name = name
        cat.description = description
        cat.icons = [icons2]
        
        db.session.commit()
        
        flash('Categoria Atualizada com sucesso ! ')
        return redirect(url_for('categorias.index'))
    
    return render_template('editar_categoria.html', titulo="Editar Categoria",iconsList=icons,name=cat.name,description=cat.description,iconS=imageLoc,idIn=id,form = form)

@categorias.route('/delete<id>', methods = ['GET','POST'])
@login_required
def delete(id):
 
    data=Category.query.get(id)
    db.session.delete(data)
    db.session.commit()

    flash("Categoria Apagada com Sucesso")
    
    return redirect(url_for('categorias.index'))



#SUB CATEGORIAS
@categorias.route('/editsub<id>', methods=['POST', 'GET'])
@login_required
def editSub(id):

   
    form = SubCriarCategoria()
    cat = Category.query.all()
    cat2 = Category.query.get(id)
    cat3 = Category.query.filter_by(id = cat2.categoryId).first()
    lista = []

    for i in cat:
        if i.level == 0:
            lista.append([i.id, i.name])


    form.categoryId.choices = lista
    form.categoryId.default = cat3.id
    form.process()
    
    form.name.data = cat2.name
    form.description.data = cat2.description
    
    

    if form.validate_on_submit():
        form = SubCriarCategoria()
        cat2.name = form.name.data
        cat2.description = form.description.data
        cat2.categoryId = form.categoryId.data

        db.session.commit()
        flash('Sub Categoria Atualizada com sucesso ! ')
        return redirect(url_for('categorias.index'))

    return render_template('criar.html', titulo="Editar Sub Categoria", form = form)



@categorias.route('/criarsub', methods=['POST', 'GET'])
@login_required
def criarSub():

    form = SubCriarCategoria()
    cat =   Category.query.all()
    lista = []
    for i in cat:
        if i.level == 0:
            lista.append([i.id, i.name])
    
    form.categoryId.choices = lista

    if request.method == 'POST' and form.validate():
        name = form.name.data
        description = form.description.data
        category = form.categoryId.data

        insertCategory = Category(name=name, description = description, level = 1, categoryId=category)
        db.session.add(insertCategory)
        db.session.commit()
        flash('Sub Categoria Criada com sucesso !')
        return redirect(url_for('categorias.index'))
   

    return render_template('criar.html', titulo="Criar Sub Categoria", form = form)


@categorias.route('/criarsubThis<nome>', methods=['POST', 'GET'])
@login_required
def criarsubThis(nome):
    
    form = SubCriarCategoria()
    cat2 = Category.query.all()
    lista = []

    for i in cat2:
        if i.name == nome:
            lista.append([i.id, i.name])

    form.categoryId.choices = lista

    if request.method == 'POST' and form.validate():
        name = form.name.data
        description = form.description.data
        category = form.categoryId.data

        insertCategory = Category(name=name, description = description, level = 1, categoryId=category)
        db.session.add(insertCategory)
        db.session.commit()
        flash('Sub Categoria Criada com sucesso !')
        return redirect(url_for('categorias.index'))
   

    return render_template('criar.html', titulo="Criar Sub Categoria", form = form)

