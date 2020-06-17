# -*- coding: utf-8 -*-

from . import profile
from flask import render_template, redirect, request, url_for, flash, request
from flask_login import login_user, logout_user, login_required
from flask import Markup
from .. import db
from ..models import User, Role, User, Table, Service, Terminal, TerminalType, Order, Category, Icon, Product, Attribute, Location
from .forms import AlterarUser
import flask_login



@profile.route('/')
@login_required
def index():
    
    a=User.query.get(flask_login.current_user.id)
    form = AlterarUser()

    form.username.data = a.username
    form.email.data=a.email
    
    if form.validate_on_submit():
        form = AlterarUser()
        a.username=form.username.data
        a.email=form.email.data

        db.session.commit()
        flash('Profile actualizado com sucesso.')
        return redirect(url_for('profile.index'))
        

    return render_template('criar.html', titulo="Editar Profile", form=form)    

    

    

    