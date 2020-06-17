# -*- coding: utf-8 -*-
import datetime
from werkzeug.security import generate_password_hash, check_password_hash
from itsdangerous import TimedJSONWebSignatureSerializer as Serializer
from flask import current_app, request, url_for
from flask_login import UserMixin, AnonymousUserMixin
from . import db, login_manager
from sqlalchemy import desc

class Language(db.Model):
    __tablename__ = 'languages'
    languageCode = db.Column(db.String(64), primary_key=True)
    name = db.Column(db.String(64))
    nativeName = db.Column(db.String(64))
    iconId = db.Column(db.Integer, db.ForeignKey('icons.id'))

class Role(db.Model):
    __tablename__ = 'roles'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(64), unique=True)

    def __repr__(self):
        return '<Role %r>' % self.name

class TerminalType(db.Model):
    __tablename__ = 'terminaltypes'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(64))

    def __repr__(self):
        return '<TerminalTypes %r>' % self.name

class User(UserMixin, db.Model):
    __tablename__ = 'users'
    id = db.Column(db.Integer, primary_key=True) 
    username = db.Column(db.String(64), unique=True, index=True)
    email = db.Column(db.String(64), unique=True, index=True)
    roleId = db.Column(db.Integer, db.ForeignKey('roles.id')) # nao esta em uso
    restaurantId = db.Column(db.Integer, db.ForeignKey('restaurants.id'))
    passwordHash = db.Column(db.String(128))
    pinHash = db.Column(db.String(128))

    @property
    def password(self):
        raise AttributeError('password is not a readable attribute')

    @property
    def pin(self):
        raise AttributeError('pin is not a readable attribute')

    @password.setter
    def password(self, password):
        self.passwordHash = generate_password_hash(password)

    @pin.setter
    def pin(self,pin):
        self.pinHash = generate_password_hash(pin)

    def verify_password(self, password):
        """esta funcao recebe o objecto user(que está na base de dados) e compara a pass"""
        return check_password_hash(self.passwordHash, password)

    def verify_pin(self, pin):
        return check_password_hash(self.pinHash, pin)

    def generate_auth_token(self, expiration):
        s = Serializer(current_app.config['SECRET_KEY'],expires_in=expiration)
        return s.dumps({'id': self.id}).decode('utf-8')

    def confirm(self, token):
        s = Serializer(current_app.config['SECRET_KEY'])
        try:
            data = s.loads(token.encode('utf-8'))
        except:
            return False
        if data.get('confirm') != self.id:
            return True
        self.confirmed = True
        db.session.add(self)
        return True
        
    @staticmethod
    def verify_auth_token(token):
        s = Serializer(current_app.config['SECRET_KEY'])
        try:
            data = s.loads(token)
            user = User.query.get(data['id'])
        except:
            return None
        
        if user :
            return True
        else :
            return False 

    def to_json(self):
        """esta funcao recebe um objecto to tipo user -> devolve em formato json o dados do utilizador """
        json_user = {
            'url': url_for('api.get_user', id=self.id),
            'username': self.username

        }
        return json_user

    def __repr__(self):
        return '<User %r>' % self.username
    
class AnonymousUser(AnonymousUserMixin):
    def can(self, permissions):
        return True

    def is_administrator(self):
        return False

login_manager.anonymous_user = AnonymousUser


@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))

orderProductAttributes = db.Table('attributesOrderProduct',
    db.Column('orderProductId', db.Integer, db.ForeignKey('orderProducts.id'), primary_key=True),
    db.Column('attributeId', db.Integer, db.ForeignKey('attributes.id'), primary_key=True))

class OrderProduct(db.Model):
    __tablename__ = 'orderProducts'
    id = db.Column(db.Integer, primary_key=True)
    orderId = db.Column(db.Integer, db.ForeignKey('orders.id'))
    productId = db.Column(db.Integer, db.ForeignKey('products.id'))
    description = db.Column(db.String(64))
    qty = db.Column(db.Integer)
    attributes = db.relationship('Attribute', secondary=orderProductAttributes, backref='orderProduct', lazy=True)

    def to_json(self):
        jsonOrderProduct = {
            'id': self.id,
            'product': Product.query.get(self.productId).to_json(),
            'attributes': [attribute.to_json() for attribute in self.attributes],
            'description': self.description,
            'qty': self.qty
        }
        return jsonOrderProduct

    def __repr__(self):
        return '<OrderProduct %r>' % self.id
    
class Order(db.Model):
    __tablename__ = 'orders'
    id = db.Column(db.Integer, primary_key=True)
    tableId = db.Column(db.Integer, db.ForeignKey('tables.id'))
    orderAddTime = db.Column(db.DateTime, default=datetime.datetime.now)
    finishTime = db.Column(db.DateTime)
    callType = db.Column(db.Boolean, default=False)
    billType = db.Column(db.Boolean, default=False)
    nif = db.Column(db.Integer)
    name = db.Column(db.String(100))
    terminalId = db.Column(db.Integer, db.ForeignKey('terminals.id'))
    products = db.relationship('OrderProduct', backref='order', lazy=True)
    
    def to_json(self):
        jsonOrder = {
            'id': self.id,
            'tableId': Table.query.get(self.tableId).internalNumber,
            'orderAddTime': self.orderAddTime,
            'finishTime': self.finishTime,
            'callType': self.callType,
            'billType': self.billType,
            'terminalId': self.terminalId,
            'nif': self.nif,
            'name': self.name,
            'products': [product.to_json() for product in self.products]
        }
        return jsonOrder

    def __repr__(self):
        return '<Order %r>' % self.id 

class Terminal(db.Model):
    __tablename__ = 'terminals'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(64))
    terminalTypeId = db.Column(db.Integer, db.ForeignKey('terminaltypes.id'))
    userId = db.Column(db.Integer, db.ForeignKey('users.id'))
    restaurantId = db.Column(db.Integer, db.ForeignKey('restaurants.id'))
    restaurant = db.relationship('Restaurant')

    def __repr__(self):
        return '<Terminal %r>' % self.name

productattributes = db.Table('productattributes', 
                db.Column('productId', db.Integer, db.ForeignKey('products.id'), primary_key=True),
                db.Column('attributeId', db.Integer, db.ForeignKey('attributes.id'), primary_key=True))

categoriesicons = db.Table('categoriesicons',
                db.Column('categoryId', db.Integer, db.ForeignKey('categories.id'), primary_key=True),
                db.Column('iconId', db.Integer, db.ForeignKey('icons.id'), primary_key=True))

class Icon(db.Model):
    __tablename__ = 'icons'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(64))
    imageLocation = db.Column(db.String(100))
    iconType = db.Column(db.Integer)

    def __repr__(self):
        return '<Icon %r>' % self.name

categoryservices = db.Table('categoryservices',
    db.Column('categoryId', db.Integer, db.ForeignKey('categories.id'), primary_key=True),
    db.Column('serviceId', db.Integer, db.ForeignKey('services.id'), primary_key=True))

class Table(db.Model):
    __tablename__ = 'tables'
    id = db.Column(db.Integer, primary_key=True)
    internalNumber = db.Column(db.Integer, unique=True)
    displayNumber = db.Column(db.Integer, unique=True)
    locationId = db.Column(db.Integer, db.ForeignKey('locations.id'))

    def to_json(self):
        return 

    def __repr__(self): 
        return '<Table %r>' % self.internalNumber

serviceusers = db.Table('serviceusers', 
                db.Column('userId', db.Integer, db.ForeignKey('users.id'), primary_key=True),
                db.Column('serviceId', db.Integer, db.ForeignKey('services.id'), primary_key=True))

class Service(db.Model):
    __tablename__ = 'services'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(64))
    locationId = db.Column(db.Integer, db.ForeignKey('locations.id'))

    def __repr__(self):
        return '<Service %r>' % self.name

class PaymentMethod(db.Model):
    __tablename__ = 'paymentmethods'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(64))

class Payment(db.Model):
    __tablename__ = 'payments'
    id = db.Column(db.Integer, primary_key=True)
    tableId = db.Column(db.Integer, db.ForeignKey('tables.id'))
    paymentTime = db.Column(db.DateTime)
    value = db.Column(db.Float)
    paymentMethodId = db.Column(db.Integer, db.ForeignKey('paymentmethods.id'))

    def __repr__(self):
        return '<Payment %r>' % self.name

class SystemProperty(db.Model):
    __tablename__ = 'systemproperties'
    id = db.Column(db.Integer, primary_key=True)
    resName = db.Column(db.String(64))
    resIcon = db.Column(db.String(100))
    nif = db.Column(db.Integer)
    location = db.Column(db.String(200))
    postalCode = db.Column(db.String(8))
    contact = db.Column(db.String(20))

    def __repr__(self):
        return '<Payment %r>' % self.name

class Restaurant(db.Model):
    __tablename__ = 'restaurants'
    id = db.Column(db.Integer, primary_key=True)
    systemPropertyId = db.Column(db.Integer, db.ForeignKey('systemproperties.id'))
    users = db.relationship('User', backref='restaurant')
    products = db.relationship('Product', backref='restaurant')
    categories = db.relationship('Category', backref='restaurant')
    attributeCategories = db.relationship('AttributeCategory', backref='restaurant')
    attributes = db.relationship('Attribute', backref='restaurant')


# This classes require translation    
class Product(db.Model):
    __tablename__ = 'products'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(64))
    categoryId = db.Column(db.Integer, db.ForeignKey('categories.id'))
    restaurantId = db.Column(db.Integer, db.ForeignKey('restaurants.id'))
    allowDescription = db.Column(db.Boolean)
    price = db.Column(db.Float)
    description = db.Column(db.Text)
    attributes = db.relationship('Attribute', secondary=productattributes, backref='product', lazy=True)

    def to_json(self):
        jsonProduct = {
            'id': self.id,
            'name': self.name,
            'categoryId': self.categoryId,
            'allowDescription': self.allowDescription,
            'price': self.price,
            'description': self.description
        }
        return jsonProduct
    
    def __repr__(self):
        return '<Product %r>' % self.name

class ProductTranslation(db.Model):
    __tablename__ = 'producttranslations'
    productId = db.Column(db.Integer, db.ForeignKey('products.id'), primary_key=True)
    languageId = db.Column(db.String(64), db.ForeignKey('languages.languageCode'), primary_key=True)
    nameTranslation = db.Column(db.String(64))
    descriptionTranslation = db.Column(db.Text)

class Category(db.Model):
    __tablename__ = 'categories'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(64), unique=True)
    description = db.Column(db.Text)
    level = db.Column(db.Integer)
    categoryId = db.Column(db.Integer, db.ForeignKey('categories.id'))
    restaurantId = db.Column(db.Integer, db.ForeignKey('restaurants.id'))
    services = db.relationship('Service', secondary=categoryservices)
    icons = db.relationship('Icon', secondary=categoriesicons)

    def __repr__(self):
        return '<Category %r>' % self.name

class CategoryTranslation(db.Model):
    __tablename__ = 'categorytranslations'
    categoryId = db.Column(db.Integer, db.ForeignKey('categories.id'), primary_key=True)
    languageId = db.Column(db.String(64), db.ForeignKey('languages.languageCode'), primary_key=True)
    nameTranslation = db.Column(db.String(64))
    descriptionTranslation = db.Column(db.Text)

class AttributeCategory(db.Model):
    __tablename__ = 'attributecategory'
    id = db.Column(db.Integer, primary_key=True)
    restaurantId = db.Column(db.Integer, db.ForeignKey('restaurants.id'))
    name = db.Column(db.String(64), unique=True)
    multipleChoice = db.Column(db.Boolean)

class AttributeCategoryTranslation(db.Model):
    __tablename__ = 'attributecategorytranslations'
    attributeCategoryId = db.Column(db.Integer, db.ForeignKey('attributecategory.id'), primary_key=True)
    languageId = db.Column(db.String(64), db.ForeignKey('languages.languageCode'), primary_key=True)
    nameTranslation = db.Column(db.String(64))

class Attribute(db.Model):
    __tablename__ = 'attributes'
    id = db.Column(db.Integer, primary_key=True)
    restaurantId = db.Column(db.Integer, db.ForeignKey('restaurants.id'))
    name = db.Column(db.String(64))
    price = db.Column(db.Float)
    attributeCategoryId = db.Column(db.Integer, db.ForeignKey('attributecategory.id'))
    
    def to_json(self):
        jsonAttribute = {
            'id': self.id,
            'name': self.name,
            'price': self.price       
        }
        return jsonAttribute

    def __repr__(self):
        return '<Attribute %r>' % self.name

class AttributeTranslation(db.Model):
    __tablename__ = 'attributetranslations'
    attributeId = db.Column(db.Integer, db.ForeignKey('attributes.id'), primary_key=True)
    languageId = db.Column(db.String(64), db.ForeignKey('languages.languageCode'), primary_key=True)
    nameTranslation = db.Column(db.String(64))


class Location(db.Model):
    __tablename__ = 'locations'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(64), unique=True)
    restaurantId = db.Column(db.Integer, db.ForeignKey('restaurants.id'))
    restaurant = db.relationship('Restaurant')

    def __repr__(self):
        return '<Location %r>' % self.name

class LocationTranslation(db.Model):
    __tablename__ = 'locationtranslations'
    locationId = db.Column(db.Integer, db.ForeignKey('locations.id'), primary_key=True)
    languageId = db.Column(db.String(64), db.ForeignKey('languages.languageCode'), primary_key=True)
    nameTranslation = db.Column(db.String(64))
