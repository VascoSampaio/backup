
from . import fam_atributos
from flask import render_template, redirect, request, url_for, flash
from flask_login import login_user, logout_user, login_required
from flask import Markup
from ..models import User, Role, User, Table, Service, Terminal, TerminalType, Order, Category, Icon, Product, Attribute, Location

from .forms import  Fam_atributos, Atributos
from .. import db

@fam_atributos.route('/')
@login_required
def index():
    fams_atributos=Fam_Caracterisitica.query.all()
    lista=[]
    for Empregados in fams_atributos:
        
        
        lista.append([Empregados.id, Empregados.name, Empregados.tipo.name])
    
    return render_template('fam_atributos.html', header='Atributos', columns =["Id","Atributo", "Tipo"],rows= lista, tabletype="striped", objecto="fam_atributos", objectos="/fam_atributos/")

@fam_atributos.route('/<id>')
@login_required
def atributos(id):
    #atributos=Caracterisitica.query.filter_by(id_fam_caracteristica=id)
    
    atributos=Fam_Caracterisitica.query.options(db.joinedload('caracteristicas')).filter_by(id=id).first()
    lista=[]
    for Empregados in atributos.caracteristicas: 
        
        
        lista.append([Empregados.id, Empregados.name])
    
    return render_template('atributos.html', header='Atributos - '+str(atributos.name), columns =["Id","Atributo",""],rows= lista, tabletype="striped", objecto="fam_atributos", objectos="/fam_atributos/", id=id)    


@fam_atributos.route('/criar', methods=['GET', 'POST'])
@login_required
def criar_fam_atributos():
    form=Fam_atributos()
    tipo_atributos=Tipo_Caracterisitica.query.all()
    form.tipo.choices = [(g.id, g.name) for g in tipo_atributos]
    if form.validate_on_submit():
        tipo = form.tipo.data
        print(form.tipo.choices)
        fam= Fam_Caracterisitica(name=form.name.data, id_tipo_caracteristica=tipo)
        db.session.add(fam)
        db.session.commit()
        return redirect(url_for('fam_atributos.index'))
        
        
    return render_template('fam_atributos_criar.html', form=form)


@fam_atributos.route('/criar<id>',methods=['GET', 'POST'])
@login_required
def criar_atributos(id):
    form=Atributos()
    if form.validate_on_submit():
        atributo = Caracterisitica(id_fam_caracteristica= id, name =form.name.data)
        db.session.add(atributo)
        db.session.commit()
        return redirect(url_for('fam_atributos.atributos', id=id))
    return render_template('atributos_criar.html', form=form, id =id)
  