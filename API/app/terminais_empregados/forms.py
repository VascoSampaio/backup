# -*- coding: utf-8 -*-

from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField, SelectField, IntegerField
from wtforms.validators import DataRequired


class NameForm(FlaskForm):
    name = StringField('What is your name?', validators=[DataRequired()])
    submit = SubmitField('Submit')

class EditarTerminalEmpregado(FlaskForm):
    name = StringField('Name', validators=[DataRequired()])
    terminalTypeid = SelectField('Terminal Type', coerce=int)
    userId = SelectField('User', coerce=int)
    submit = SubmitField('Editar')
