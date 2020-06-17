# -*- coding: utf-8 -*-

import datetime
from . import encaminhamento
from flask import render_template, redirect, request, url_for, flash
from flask_login import login_user, logout_user, login_required
from flask import Markup
from ..models import User, Role, User, Table, Service, Terminal, TerminalType, Order, Category, Icon, Product, Attribute, Location
from .. import db

from .forms import EncaminhamentoForm, SearchEncaminhamentoForm, DefaultEncaminhamentoForm



@encaminhamento.route('/', methods=['GET', 'POST'])
@login_required
def index():
    form=SearchEncaminhamentoForm()
    form_set = DefaultEncaminhamentoForm()
    fam_encaminhamento =FamEncaminhamento.query.all()
    servicos = Servico.query.all()
    terminal_empregado = Terminal_empregado.query.all()
    
     
    form.fam_encaminhamento_id.choices =[(d.id, d.name) for d in  fam_encaminhamento]
    form_set.fam_encaminhamento_id.choices  = [(d.id, d.name) for d in  fam_encaminhamento]
   
    Dict = dict() 
    if (form.validate_on_submit() and form.submit.data ) or (form_set.validate_on_submit() and  form_set.submit1.data ):
        for servico in servicos:
            Dict[servico.id] ={}
            for terminal in terminal_empregado:
                a=Encaminhamento.query.filter_by(id_fam_encaminhamento=form.fam_encaminhamento_id.data, id_terminal_empregado =terminal.id,  id_servico =servico.id)
                Dict[servico.id][terminal.id] ={(d.id_mesa) for d in a}
              
        fam=FamEncaminhamento.query.filter_by(id=form.fam_encaminhamento_id.data).first() 
        
        if form_set.validate_on_submit() and  form_set.submit1.data:
            db.session.close()
            famm=FamEncaminhamento.query.filter_by(id=form_set.fam_encaminhamento_id.data).first() 
            print(datetime.datetime.utcnow)
            
            famm.default = datetime.datetime.utcnow()
            db.session.commit()
            flash('Empregado criado com sucesso.')
            return render_template('encaminhamento.html',items=servicos,terminais=terminal_empregado, form=form ,ola=Dict, pressed= True, familia=fam.name, form_set=form_set)
    
        
            
            
        
        

        
        return render_template('encaminhamento.html',items=servicos,terminais=terminal_empregado, form=form ,ola=Dict, pressed= True, familia=fam.name, form_set=form_set)
    else:
    
    
           
        return render_template('encaminhamento.html',items=servicos,terminais=terminal_empregado, form=form ,ola=Dict, pressed= False,  form_set=form_set)
    
@encaminhamento.route('/criar', methods=['GET', 'POST'])
@login_required
def criar():
    fam_encaminhamento =FamEncaminhamento.query.all()
    servico =Servico.query.all()
    terminal_empregado = Terminal_empregado.query.all()
    mesa= Mesa.query.all()
    
    form=EncaminhamentoForm()
    form.servico_id.choices = [(g.id, g.name) for g in servico]
    form.terminal_empregado_id.choices = [(g.id, g.name) for g in terminal_empregado]
    form.mesas.choices = [(g.id, g.numero) for g in mesa]
    form.fam_encaminhamento_id.choices = [(d.id, d.name) for d in  fam_encaminhamento]
    if form.validate_on_submit():
        for m in form.mesas.data:
            encaminhamento = Encaminhamento(id_mesa=m, id_servico=form.servico_id.data,id_terminal_empregado= form.terminal_empregado_id.data, id_fam_encaminhamento=form.fam_encaminhamento_id.data)
            db.session.add(encaminhamento)
        db.session.commit()
        return redirect(url_for('encaminhamento.index'))
    
    
    return render_template('criar_encaminhamento.html', form=form)

