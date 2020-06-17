# -*- coding: utf-8 -*-

from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField, IntegerField, SelectField
from wtforms.validators import DataRequired, InputRequired
from wtforms.ext.sqlalchemy.fields import QuerySelectField


class NameForm(FlaskForm):
    name = StringField('What is your name?', validators=[DataRequired()])
    submit = SubmitField('Submit')

class CriarLocalizacao(FlaskForm):
    nomeLoc = StringField('Nome', validators=[DataRequired()])
    submit = SubmitField('Criar')