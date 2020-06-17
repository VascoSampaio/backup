# -*- coding: utf-8 -*-

from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, BooleanField, SubmitField, SelectField,SelectMultipleField, IntegerField, widgets, FloatField
from wtforms.validators import DataRequired, Length, Email


class Fam_atributos(FlaskForm):
    name = StringField('Nome', validators=[DataRequired()])
    tipo= SelectField(u'Tipo', coerce=int)
    submit = SubmitField('Criar')

class Atributos(FlaskForm):
    name = StringField('Nome', validators=[DataRequired()])
    submit = SubmitField('Criar')
    
class FormArtigo(FlaskForm):
    name = StringField('Nome', validators=[DataRequired()])
    description = StringField('Descrição')
    price = FloatField('Preço', validators=[DataRequired()])
    submit = SubmitField('Criar')
    
class FormProcurarArtigo(FlaskForm):
    name = StringField('Nome', validators=[DataRequired()])
    submit = SubmitField('Procurar')