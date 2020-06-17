# -*- coding: utf-8 -*-

from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField, BooleanField, SubmitField, SelectField,SelectMultipleField
from wtforms.validators import DataRequired
from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField, IntegerField, SelectField
from wtforms.validators import DataRequired, InputRequired
from wtforms.ext.sqlalchemy.fields import QuerySelectField





class EncaminhamentoForm(FlaskForm):
    fam_encaminhamento_id = SelectField(u'Familia Encaminhamento', coerce=int)
    servico_id = SelectField(u'Serviço', coerce=int)
    terminal_empregado_id = SelectField(u'Terminal Empregado', coerce=int)
    mesas=SelectMultipleField(u'Mesas',coerce=int)
    
    
    submit = SubmitField('Criar')
    
    
class SearchEncaminhamentoForm(FlaskForm):
    fam_encaminhamento_id = SelectField(u'Familia Encaminhamento', coerce=int)
    
    
   
    submit = SubmitField('submit')
    
    
class DefaultEncaminhamentoForm(FlaskForm):
    fam_encaminhamento_id = SelectField(u'Familia Teste', coerce=int)
    
    
   
    submit1 = SubmitField('Definir')

class Search(FlaskForm):
    tableId = IntegerField('Número da Mesa', validators=[DataRequired()])
    submit = SubmitField('Search')