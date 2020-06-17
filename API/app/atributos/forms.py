# -*- coding: utf-8 -*-

from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, BooleanField, SubmitField, SelectField,SelectMultipleField, IntegerField, widgets, FloatField
from wtforms.validators import DataRequired, Length, Email


class Fam_atributos(FlaskForm):
    name = StringField('Nome', validators=[DataRequired()])
    tipo= SelectField(u'Tipo', coerce=int)
    submit = SubmitField('Criar')

    
class FormAtributo(FlaskForm):
    name = StringField('Nome', validators=[DataRequired()])
    multipleChoice = SelectField(u'Tem escolha multípla?', coerce=int)    
    submit = SubmitField('Criar')

class FormAttr(FlaskForm):
    name = StringField('Nome', validators=[DataRequired()])
    price = FloatField('Preço')
    categoriaId= SelectField(u'Categoria', coerce=int)

    submit = SubmitField('Criar')
    
    
