# -*- coding: utf-8 -*-

from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField, IntegerField, SelectField, PasswordField
from wtforms.validators import DataRequired, Length, Email, EqualTo
from wtforms.ext.sqlalchemy.fields import QuerySelectField


class NameForm(FlaskForm):
    name = StringField('What is your name?', validators=[DataRequired()])
    submit = SubmitField('Submit')

class AlterarUser(FlaskForm):
    username = StringField('Nome', validators=[DataRequired()])
    email = StringField('Email', validators=[DataRequired(), Length(1, 64),Email()])
    password = PasswordField('Password',validators =[DataRequired(), EqualTo('confirm', message='Passwords não são iguais')])
    confirm = PasswordField ('Confirmar Password')
    submit = SubmitField('Gravar')