# -*- coding: utf-8 -*-

from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField, SelectField
from wtforms.validators import DataRequired


class NameForm(FlaskForm):
    name = StringField('What is your name?', validators=[DataRequired()])
    submit = SubmitField('Submit')

class CriarServico(FlaskForm):
    name = StringField('Nome do serviço', validators=[DataRequired()])
    location = SelectField('Localização', coerce=int)
    submit = SubmitField('Criar')
