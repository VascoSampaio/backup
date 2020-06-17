# -*- coding: utf-8 -*-

from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, BooleanField, SubmitField,IntegerField, SelectField,SelectMultipleField
from wtforms.validators import DataRequired, Length, Email, EqualTo

class EmpregadoForm(FlaskForm):
    username = StringField('Nome', validators=[DataRequired()])
    email = StringField('Email', validators=[DataRequired(), Length(1, 64),Email()])
    pin = StringField('Pin', validators=[DataRequired()])
    password = PasswordField('Password',validators =[DataRequired(), EqualTo('confirm', message='Passwords não são iguais')])
    confirm = PasswordField ('Confirmar Password')
    submit = SubmitField('Criar')
