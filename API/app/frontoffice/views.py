# -*- coding: utf-8 -*-

from . import frontoffice
from flask import render_template, redirect, request, url_for, flash, jsonify, make_response, session,escape
from ..models import Category, Product, Icon, Table, Location, Service, Order, OrderProduct, Attribute, AttributeCategory, SystemProperty
from .. import db
import json
import time


class Display(object):
    def __init__(self, id, nome, url, imagem, descricao):
        self.id = id
        self.nome = nome
        self.url = url
        self.imagem = imagem
        self.descricao = descricao

class SubDisplay(object):
    def __init__(self, id, nome, produtos):
        self.id = id
        self.nome = nome
        self.produtos = produtos

class Atributo(object):
    def __init__(self, id, nome):
        self.id = id
        self.nome = nome
        self.tipo = tipo
        self.valores = valores


@frontoffice.route('/callWaiter/', methods=["GET"])
def callWaiter():
    table = Table.query.filter_by(internalNumber=session['tableInternalId']).first()
    newOrder = Order(tableId=table.id, callType=True)
    db.session.add(newOrder)
    db.session.commit()
    return " "

@frontoffice.route('/', methods=["POST", "GET"])
def index():
    if session.get('serviceId') is None:
        showPopUp = "false"
        if request.method == 'POST':
            codigoMesa = request.form.get('codigoMesa')
            table = Table.query.filter_by(displayNumber=int(codigoMesa)).first()
            if table is not None:
                session['tableInternalId'] = table.internalNumber
               
                location = Location.query.filter_by(id=table.locationId).first()
                service = Service.query.filter_by(locationId=location.id).first()

                if location is not None and service is not None :
                    session['serviceId'] = service.id
                    return redirect(url_for('frontoffice.restaurante'))
            else:
                showPopUp = "true"
       
        return render_template('codigo.html', showPopUp=showPopUp)
    else:
        return redirect(url_for('frontoffice.menu'))

@frontoffice.route('/restaurante')
def restaurante():
    menuUrl = url_for('frontoffice.menu')
    systemProperties = SystemProperty.query.get(1)
    #fazer a query do restaurante pelo o id para ir buscar o nome e a imagem
    return render_template('restaurante.html', menuUrl=menuUrl, imageUrl=systemProperties.resIcon, name=systemProperties.resName)

@frontoffice.route('/menu', methods=["POST", "GET"])
def menu():

    if request.method == 'POST':
        obs = request.form.get('obs')
        qnt = request.form.get('qnt')
        productId = request.form.get('product-id')
        categoryLevel0 = request.form.get('product-category-level-0-id')
       

        #Vai buscar os atributos
        product = Product.query.get(productId)
        attributes = product.attributes
        attributeCategories = []

        for attribute in attributes:
            attributeCategory= AttributeCategory.query.filter_by(id=attribute.attributeCategoryId).first()
            if not attributeCategory.id in attributeCategories:
                attributeCategories.append(attributeCategory.id)
           
       
        attributesFinal = []
        #Percorrer os tipos de atributos devido ao submit do form
        for attributeCategory in attributeCategories:

            attributeCategoryObj = AttributeCategory.query.get(attributeCategory)
           
            if attributeCategoryObj.multipleChoice == True:
                attrs = request.form.getlist(str(attributeCategory))
                for attr in attrs:
                    atributeObj = Attribute.query.get(int(attr))
                    attributesFinal.append({'name': atributeObj.name, 'id': atributeObj.id})
            else:
                attr = request.form.get(str(attributeCategory))
                atributeObj = Attribute.query.get(int(attr))
                attributesFinal.append({'name': atributeObj.name, 'id': atributeObj.id})
       
        if session.get('orders') is not None:
            old = json.loads(session.get('orders'))
            orderItemId = len(old['orders'])
            old['orders'].append({'name': product.name, 'orderItemId': orderItemId, 'id': productId, 'qnt': qnt, 'obs': obs, 'categoryLevel0':categoryLevel0, 'attributes': attributesFinal})
            session['orders'] = json.dumps(old)
        else:
            session['orders'] = json.dumps({'orders': [{'name': product.name, 'orderItemId': 0, 'id': productId, 'qnt': qnt, 'obs': obs, 'categoryLevel0':categoryLevel0, 'attributes': attributesFinal}]})

        return redirect(url_for('frontoffice.categoria', id=categoryLevel0))

   
    breadCrumbs = [['menu', url_for('frontoffice.menu')]]


    cartUrl = url_for('frontoffice.carrinho')
    pagamentoUrl = url_for('frontoffice.pagamento')
   
    ordersCounter = 0
    if session.get('orders') is not None:
        orders = json.loads(session.get('orders'))
        ordersCounter = len(orders['orders'])

    displays = []
    for category in Category.query.filter_by(level=0).all():
        icons = category.icons
        for icon in icons:
            displays.append(Display(str(category.id), category.name, url_for('frontoffice.categoria', id=category.id), icon.imageLocation, category.description))

       
    return render_template('menu.html', breadCrumbs=breadCrumbs, displays=displays, ordersCounter=ordersCounter, cartUrl=cartUrl, pagamentoUrl=pagamentoUrl)

@frontoffice.route('/categoria/<int:id>')
def categoria(id):

    subDisplays = []
    for subcategory in Category.query.filter_by(level=1, categoryId=id).all():
        products = []

        for product in Product.query.filter_by(categoryId=subcategory.id).all():
            products.append({'id':product.id, 'price':product.price, 'nome':product.name, 'url': url_for('frontoffice.artigo', id=product.id)})
       
        subDisplays.append(SubDisplay(id=subcategory.id, nome=subcategory.name, produtos=products))

    display = Category.query.filter_by(id=id).first()
    infoheader = [display.name, display.description]
    breadCrumbs = [['menu', url_for('frontoffice.menu')], [display.name, url_for('frontoffice.categoria', id=id)]]
   
    cartUrl = url_for('frontoffice.carrinho')
    pagamentoUrl = url_for('frontoffice.pagamento')

    ordersCounter = 0
    if session.get('orders') is not None:
        orders = json.loads(session.get('orders'))
        ordersCounter = len(orders['orders'])

   
    productsToDisplay = []

    for categories in Category.query.filter_by(level=0, id=id).all():
        print("Category:")
        print(categories)
        for product in Product.query.filter_by(categoryId=categories.id).all():
            productsToDisplay.append({'id':product.id, 'price':product.price, 'nome':product.name, 'url': url_for('frontoffice.artigo', id=product.id)})

    print("productsToDisplay")
    print(productsToDisplay)
    return render_template('categoria.html', id=id, breadCrumbs=breadCrumbs, info=infoheader, ordersCounter=ordersCounter, subDisplays=subDisplays, cartUrl=cartUrl, pagamentoUrl=pagamentoUrl, productsToDisplay=productsToDisplay)

@frontoffice.route('/artigo/<int:id>', methods=['GET'])
def artigo(id):

    product = Product.query.filter_by(id=id).first()
    subDisplay = Category.query.filter_by(id=product.categoryId, level=1).first()
    if subDisplay is not None:
        display = Category.query.filter_by(id=subDisplay.categoryId).first()
        breadCrumbs = [['menu', url_for('frontoffice.menu')],
        [display.name, url_for('frontoffice.categoria', id=display.id)],
        [subDisplay.name, url_for('frontoffice.categoria', id=display.id) + "#subDisplay" + str(subDisplay.id)],
        [product.name]]

    else:
        display = Category.query.filter_by(id=product.categoryId).first()
        breadCrumbs = [['menu', url_for('frontoffice.menu')],
        [display.name, url_for('frontoffice.categoria', id=display.id)], [product.name]]

   
    redirect = url_for('frontoffice.menu')
    infoheader = [product.name, product.description]
   
    allowObs = product.allowDescription

    """
    Atributos
    """
    attributes = product.attributes

    attributesArray = []
    for attribute in attributes:
       
        name = attribute.name
        idAttr = attribute.id
       
        price = attribute.price

        attributeCategoryId = attribute.attributeCategoryId
        attributeCategory= AttributeCategory.query.filter_by(id=attributeCategoryId).first()
        attributeCategoryName = attributeCategory.name
        multipleChoice = attributeCategory.multipleChoice

        #TODO: ir buscar o nome da categoria do atributo
       
        if len(attributesArray) > 0:
            found = False
            i = 0
            while found == False and i < len(attributesArray):
                if attributesArray[i]['attributeCategoryId'] == attributeCategoryId :
                    attributesArray[i]['attributes'].append({'name': name, 'id': idAttr, 'price': price})
                    found = True
 
                i = i + 1
           
            if found == False:
                attributesArray.append({'attributeCategoryName': attributeCategoryName, 'attributeCategoryId': attributeCategoryId, 'multipleChoice': multipleChoice, 'attributes': [{'name': name, 'id': idAttr, 'price': price}]})

        else:
            attributesArray.append({'attributeCategoryName': attributeCategoryName, 'attributeCategoryId': attributeCategoryId, 'multipleChoice': multipleChoice, 'attributes': [{'name': name, 'id': idAttr, 'price': price}]})
   
    cartUrl = url_for('frontoffice.carrinho')
    pagamentoUrl = url_for('frontoffice.pagamento')
   
    ordersCounter = 0
    if session.get('orders') is not None:
        orders = json.loads(session.get('orders'))
        ordersCounter = len(orders['orders'])
   

    return render_template('artigo.html', id=id, product=product, allowObs=allowObs, atributos=attributesArray, categoryLevel0= display.id, breadCrumbs=breadCrumbs, info=infoheader, redirect = redirect, ordersCounter=ordersCounter, cartUrl=cartUrl, pagamentoUrl=pagamentoUrl)

@frontoffice.route('/carrinho', methods=["POST", "GET"])
def carrinho():
    #redirect = url_for('frontoffice.pagamento')
    breadCrumbs = [['menu', url_for('frontoffice.menu')], ['carrinho', url_for('frontoffice.carrinho')]]
   
    cartUrl = "#"
    pagamentoUrl = url_for('frontoffice.pagamento')

    headerImageContent = ['o seu pedido', url_for('static', filename='images/Pleez_IconesMenu_carrinho.png')]
   
    orders = []

    categoriesOrdered = []

    #TODO OPTIMIZAR  
    ordersCounter = 0

    if session.get('orders') is not None:

        pedidos = json.loads(session.get('orders'))
        orders = pedidos['orders']
        ordersCounter = len(pedidos['orders'])

        if request.args.get('order') == "pedir":
            #{'name': product.name, 'orderItemId': orderItemId, 'id': productId, 'qnt': qnt, 'obs': obs, 'categoryLevel0':categoryLevel0}
            #'attributes': [{'name': Verder, 'id': 12}]


            table = Table.query.filter_by(internalNumber=session['tableInternalId']).first()
            newOrder = Order(tableId=table.id)
            db.session.add(newOrder)
            #added = False
           
            for produto in orders:

                prd = Product.query.get(produto['id'])
                newOrderProduct = OrderProduct(orderId=newOrder.id, productId=prd.id, description=produto['obs'], qty=produto['qnt'])

                for attribute in produto['attributes']:
                    attribute = Attribute.query.get(attribute['id'])
                    newOrderProduct.attributes.append(attribute)

               
                db.session.add(newOrderProduct)
               
            db.session.commit()

            session['orders'] = None
            return redirect(url_for('frontoffice.menu'))

        if request.method == 'POST':
            changeQnt = request.form.get('changeQnt')
            orderItemId = request.form.get('orderItemId')


            if changeQnt == "icrement" :

                i = 0
                changed = False

                while i < len(orders) and changed == False:
                    #Quando encontra o orderItemId incrementa
                    if str(orders[i]['orderItemId']) == str(orderItemId):
                        orders[i]['qnt'] = int(orders[i]['qnt']) + 1
                        changed = True
                    i = i + 1

            else:
                i = 0
                changed = False

                while i < len(orders) and changed == False:
                    if str(orders[i]['orderItemId']) == str(orderItemId):
                        #Remove quanto encontra
                        if int(orders[i]['qnt']) <= 1 :
                            orders.remove(orders[i])
                            changed = True
                        #Decrementa quando encontra
                        else:
                            orders[i]['qnt'] = int(orders[i]['qnt']) - 1
                            changed = True
                    i = i + 1

            #Actualiza a Session
            session['orders'] = json.dumps({'orders': orders})

        #Prepara a separação dos items por categoria de lvl 0
        for order in orders:
            display = Category.query.filter_by(id=order['categoryLevel0']).first()
            """ TODO FALTA CARREGAR O URL DA IMAGEM """
            icons = display.icons
            displayImage = ""
            for icon in icons:
                displayImage = icon.imageLocation


            if len(categoriesOrdered) == 0:
                products = []
                products.append(order)
               
               
                categoriesOrdered.append({'name': display.name, 'image': displayImage, 'categoryLevel0': order['categoryLevel0'], 'products': products})
            else:
                found = False
                i = 0
                while i < len(categoriesOrdered) and found == False:
                    if categoriesOrdered[i]['categoryLevel0'] == order['categoryLevel0']:
                        categoriesOrdered[i]['products'].append(order)
                        found = True

                    i = i + 1

                if found == False:
                    products = []
                    products.append(order)
                    categoriesOrdered.append({'name': display.name, 'image': displayImage, 'categoryLevel0': order['categoryLevel0'], 'products': products})

        return render_template('carrinho.html', breadCrumbs=breadCrumbs, ordersCounter=ordersCounter, cartUrl=cartUrl, headerImageContent=headerImageContent, orders=categoriesOrdered, pagamentoUrl=pagamentoUrl)
    else:
        return render_template('carrinhoVazio.html', breadCrumbs=breadCrumbs, ordersCounter=ordersCounter, cartUrl=cartUrl, headerImageContent=headerImageContent, orders=categoriesOrdered, pagamentoUrl=pagamentoUrl, menuUrl=url_for('frontoffice.menu'))
   


   

    """ TODO FAZER O ELSE QUANDO NÃO EXISTEM PRODUTOS NO CARRINHO """
       
@frontoffice.route('/pagamento', methods=["POST", "GET"])
def pagamento():
   
    breadCrumbs = [['menu', url_for('frontoffice.menu')], ['pagamento', url_for('frontoffice.pagamento')]]
   
    cartUrl = url_for('frontoffice.carrinho')

    pagamentoUrl = "#"
    #headerImageContent = ['dados de faturação', url_for('static', filename='images/Pleez_IconesMenu_carrinho.png')]
    headerImageContent = ['dados fiscais', url_for('static', filename='images/Pleez_IconesMenu_carrinho.png')]
    ordersCounter = 0

    if request.method == 'POST' and session['tableInternalId'] is not None:
           
            nif = request.form.get('nif')
            if nif == "":
             nif = 0

            nome = request.form.get('nome')
            if nome == "":
                nome = " "

            table = Table.query.filter_by(internalNumber=session['tableInternalId']).first()
            newOrder = Order(tableId=table.id, billType=True, nif=nif, name=nome)
            db.session.add(newOrder)
            db.session.commit()
            session['orders'] = None
            session['tableInternalId'] = None
            session['serviceId'] = None
            return redirect(url_for('frontoffice.index'))

    if session.get('orders') is not None:
        pedidos = json.loads(session.get('orders'))
        orders = pedidos['orders']

       
           
        ordersCounter = len(orders)
       
    return render_template('pagamento.html', breadCrumbs=breadCrumbs, ordersCounter=ordersCounter, cartUrl=cartUrl, headerImageContent=headerImageContent, pagamentoUrl=pagamentoUrl)

@frontoffice.route('/avaliacao')
def avaliacao():
    breadCrumbs = [['voltar ao menu', url_for('frontoffice.menu')]]
    return render_template('avaliacao.html', breadCrumbs=breadCrumbs)






