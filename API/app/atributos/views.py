#!/usr/bin/python
# -*- coding: utf-8 -*-
from flask import render_template, redirect, request, url_for, flash
from flask_login import login_user, logout_user, login_required
from . import atributos
from ..models import User, Role, User,AttributeCategory, Table, Service, Terminal, TerminalType, Order, Category, Icon, Product, Attribute, Location
from .forms import FormAtributo, FormAttr
from ..models import User
from .. import db

@atributos.route('/', methods=['GET', 'POST'])
def index():

    a=AttributeCategory.query.all()
    lista=[]
    for Empregados in a:
        if Empregados.multipleChoice == 0:
            lista.append([Empregados.id, Empregados.name, "Nao tem"])
        else:
            lista.append([Empregados.id, Empregados.name, "Tem"])
        
    return render_template('atributoss.html', header='Empregado', columns =["id","Nome","Escolha Multípla"],rows= lista, tabletype="striped", objecto="Categoria de Atributos", titulo ="Categoria de Atributos")

@atributos.route('/view<id>')
@login_required
def cat(id):
    cat = Attribute.query.all()
    catName = AttributeCategory.query.get(id)
    lista = []
    
    for i in cat:
        if i.attributeCategoryId == int(id):
            lista.append([i.id, i.name, str(str(i.price)+"€")])
    

    return render_template('subAtributes.html', header="Atributos", columns =["Id","Nome","Preço"], rows =lista, tabletype="striped", objecto="Atributo",objecto2=catName.id,objecto3=catName.name, titulo =catName.name, objecto4=catName.multipleChoice, objecto5=len(lista))



@atributos.route('/criarsubThis<id>', methods=['POST', 'GET'])
@login_required
def criarsubThis(id):
    
    form = FormAttr()
    lista = []
    AttrCatAll = AttributeCategory.query.all()
    AttrCat = AttributeCategory.query.get(id)
    for k in AttrCatAll:
        lista.append([k.id, k.name])
    form.categoriaId.choices =lista
    form.categoriaId.default = AttrCat.id
    
    if form.validate_on_submit():
        nome = form.name.data
        price = form.price.data
        print("AQUI")
        categoria = form.categoriaId.data
        insertAtr = Attribute(name=nome, price=price, attributeCategoryId=categoria)
    
        db.session.add(insertAtr)
        db.session.commit()
        flash('Atributo  criada com sucesso.')
        return redirect(url_for('atributos.index'))
    form.process()
    return render_template('criar.html', titulo="Criar Atributo", form=form)




@atributos.route('/criar', methods=['GET', 'POST'])
def criar():
    form = FormAtributo()
    form.multipleChoice.choices =([0,"Não"], [1, "Sim"])
    if form.validate_on_submit():
        nome = form.name.data
        multipleChoice = form.multipleChoice.data
        insertCategoryAtr = AttributeCategory(name=nome, multipleChoice=multipleChoice)
    
        db.session.add(insertCategoryAtr)
        db.session.commit()
        flash('Categoria criada com sucesso.')
        return redirect(url_for('atributos.index'))
    return render_template('criar.html', titulo="Criar Categoria Atributo", form=form)


@atributos.route('/edit<id>', methods=['GET','POST'])
@login_required
def edit(id):
    form=FormAtributo()
    produtosAtr = AttributeCategory.query.get(id)
    
    form.multipleChoice.choices =([0,"Não"], [1, "Sim"])
    form.multipleChoice.default = produtosAtr.multipleChoice
    form.process()
    form.name.data = produtosAtr.name
    form.submit.label.text="Editar"
    

    if form.validate_on_submit():
       form=FormAtributo()
       produtosAtr.name = form.name.data
       produtosAtr.multipleChoice = form.multipleChoice.data


       db.session.commit()
       flash('Categoria de atributos Atualizado com sucesso')
       return redirect(url_for('atributos.index'))

    return render_template('criar.html', titulo="Editar Categorias Atributos", form=form)


@atributos.route('/delete<id>')
@login_required
def delete(id):
    atributo = AttributeCategory.query.get(id)

    allAtributos = Attribute.query.filter_by(attributeCategoryId = id).all()
    
    for i in allAtributos:
        db.session.delete(i)
        db.session.commit()
        
    db.session.delete(atributo)
    db.session.commit()
    flash('Atributo Categoria Eleminado com Sucesso')
    return redirect(url_for('atributos.index'))


@atributos.route('/editsub<id>', methods=['POST', 'GET'])
@login_required
def editsub(id):
    form=FormAttr()
    Atr = Attribute.query.get(id)
    lista = []
    AttrCat = AttributeCategory.query.all()
    for k in AttrCat:
        lista.append([k.id, k.name])
    
    
    form.categoriaId.choices =lista
    form.categoriaId.default = Atr.attributeCategoryId
    form.process()

    form.name.data = Atr.name
    form.price.data = Atr.price

    form.submit.label.text="Editar"
    

    if form.validate_on_submit():
       form=FormAttr()
       Atr.name = form.name.data
       Atr.price = form.price.data
       Atr.attributeCategoryId = form.categoriaId.data

       db.session.commit()
       flash('Atributos Atualizado com sucesso')
       return redirect(url_for('atributos.index'))

    return render_template('criar.html', titulo="Editar Atributos", form=form)


@atributos.route('/deletesub<id>')
@login_required
def deletesub(id):
    atributo = Attribute.query.get(id)
    db.session.delete(atributo)
    db.session.commit()
    flash('Atributo  Eleminado com Sucesso')
    return redirect(url_for('atributos.index'))
