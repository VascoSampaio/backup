# -*- coding: utf-8 -*-

from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField, IntegerField, SelectField
from wtforms.validators import DataRequired, InputRequired
from wtforms.ext.sqlalchemy.fields import QuerySelectField


class NameForm(FlaskForm):
    name = StringField('What is your name?', validators=[DataRequired()])
    submit = SubmitField('Submit')

class CriarMesa(FlaskForm):
    internalNumber = IntegerField('Internal Number', validators=[DataRequired()])
    displayNumber = IntegerField('Display Number', validators=[DataRequired()])
    location = SelectField('Localização', coerce=int)
    submit = SubmitField('Criar')