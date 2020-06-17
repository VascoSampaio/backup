# -*- coding: utf-8 -*-

from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, BooleanField, SubmitField, SelectField,SelectMultipleField
from wtforms.validators import DataRequired, Length, Email

class EmpregadoForm(FlaskForm):
    name = StringField('Nome', validators=[DataRequired()])
    email = StringField('Email', validators=[DataRequired(), Length(1, 64),Email()])
    phone = StringField('Telefone', validators=[DataRequired(), Length(9)])
    submit = SubmitField('Criar')
