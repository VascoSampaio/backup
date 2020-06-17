from flask import Flask
from flask_bootstrap import Bootstrap
from flask_mail import Mail
from flask_moment import Moment
from flask_sqlalchemy import SQLAlchemy
from flask_login import LoginManager
from config import config, DevelopmentConfig, TestingConfig, ProductionConfig

from flask_wtf.csrf import CSRFProtect



bootstrap = Bootstrap()
mail = Mail()
moment = Moment()
db = SQLAlchemy()

login_manager = LoginManager()
login_manager.login_view = 'auth.login'


def create_app(config_name):
    app = Flask(__name__)
    app.config.from_object(DevelopmentConfig)    # Loads configuration succesfully.
    #csrf = CSRFProtect(app)
    #csrf.init_app(app)

    bootstrap.init_app(app)
    mail.init_app(app)
    moment.init_app(app)
    db.init_app(app)
    login_manager.init_app(app)
    


    from .main import main as main_blueprint
    app.register_blueprint(main_blueprint)

    from .auth import auth as auth_blueprint
    app.register_blueprint(auth_blueprint, url_prefix='/auth')
    
    from .mesas import mesas as mesas_blueprint
    app.register_blueprint(mesas_blueprint, url_prefix='/mesas')
    
    from .empregados import empregados as empregados_blueprint
    app.register_blueprint(empregados_blueprint, url_prefix='/empregados')
    
    from .fam_atributos import fam_atributos as fam_atributos_blueprint
    app.register_blueprint(fam_atributos_blueprint, url_prefix='/fam_atributos')
    
    from .artigos import artigos as artigos_blueprint
    app.register_blueprint(artigos_blueprint, url_prefix='/artigos')
    
    from .servicos import servicos as servicos_blueprint
    app.register_blueprint(servicos_blueprint, url_prefix='/servicos')
     
    from .terminais_empregados import terminais_empregados as terminais_empregados_blueprint
    app.register_blueprint(terminais_empregados_blueprint, url_prefix='/terminais_empregados')
    
    from .encaminhamento import encaminhamento as encaminhamento_blueprint
    app.register_blueprint(encaminhamento_blueprint, url_prefix='/encaminhamento')
    
    from .pedidos import pedidos as pedidos_blueprint
    app.register_blueprint(pedidos_blueprint, url_prefix='/pedidos')
    

    from .api import api as api_blueprint
    app.register_blueprint(api_blueprint, url_prefix='/api/v1')

    from .frontoffice import frontoffice as frontoffice_blueprint
    app.register_blueprint(frontoffice_blueprint, url_prefix='/frontoffice')

    from .localizacao import localizacao as localizacao_blueprint
    app.register_blueprint(localizacao_blueprint, url_prefix='/localizacao')

    from .categorias import categorias as categorias_blueprint
    app.register_blueprint(categorias_blueprint, url_prefix='/categorias')

    from .profile import profile as profile_blueprint
    app.register_blueprint(profile_blueprint, url_prefix='/profile')

    from .atributos import atributos as atributos_blueprint
    app.register_blueprint(atributos_blueprint, url_prefix='/atributos')
    
    
    return app