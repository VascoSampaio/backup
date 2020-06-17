# -*- coding: utf-8 -*-

from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField, IntegerField, SelectField
from wtforms.validators import DataRequired, InputRequired
from wtforms.ext.sqlalchemy.fields import QuerySelectField


class NameForm(FlaskForm):
    name = StringField('What is your name?', validators=[DataRequired()])
    submit = SubmitField('Submit')


class CriarCategoria(FlaskForm):
    name = StringField('Nome: ', validators=[DataRequired()])
    description = StringField('Descricao', validators=[DataRequired()])
    submit = SubmitField('Criar')

class SubCriarCategoria(FlaskForm):
    name = StringField('Nome: ', validators=[DataRequired()])
    description = StringField('Descricao', validators=[DataRequired()])
    categoryId = SelectField('Categoria Principal', coerce=int)
    submit = SubmitField('Criar')
    