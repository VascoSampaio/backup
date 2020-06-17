"""empty message

Revision ID: 96261516b2ac
Revises: 456a945560f6
Create Date: 2020-06-05 21:22:54.220094

"""

# revision identifiers, used by Alembic.
revision = '96261516b2ac'
down_revision = '456a945560f6'

from alembic import op
import sqlalchemy as sa


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('languages',
    sa.Column('languageCode', sa.String(length=64), nullable=False),
    sa.Column('name', sa.String(length=64), nullable=True),
    sa.Column('nativeName', sa.String(length=64), nullable=True),
    sa.Column('iconId', sa.Integer(), nullable=True),
    sa.ForeignKeyConstraint(['iconId'], ['icons.id'], ),
    sa.PrimaryKeyConstraint('languageCode')
    )
    op.create_table('restaurants',
    sa.Column('id', sa.Integer(), nullable=False),
    sa.Column('systemPropertyId', sa.Integer(), nullable=True),
    sa.ForeignKeyConstraint(['systemPropertyId'], ['systemproperties.id'], ),
    sa.PrimaryKeyConstraint('id')
    )
    op.create_table('attributecategorytranslations',
    sa.Column('attributeCategoryId', sa.Integer(), nullable=False),
    sa.Column('languageId', sa.String(length=64), nullable=False),
    sa.Column('nameTranslation', sa.String(length=64), nullable=True),
    sa.ForeignKeyConstraint(['attributeCategoryId'], ['attributecategory.id'], ),
    sa.ForeignKeyConstraint(['languageId'], ['languages.languageCode'], ),
    sa.PrimaryKeyConstraint('attributeCategoryId', 'languageId')
    )
    op.create_table('categorytranslations',
    sa.Column('categoryId', sa.Integer(), nullable=False),
    sa.Column('languageId', sa.String(length=64), nullable=False),
    sa.Column('nameTranslation', sa.String(length=64), nullable=True),
    sa.Column('descriptionTranslation', sa.Text(), nullable=True),
    sa.ForeignKeyConstraint(['categoryId'], ['categories.id'], ),
    sa.ForeignKeyConstraint(['languageId'], ['languages.languageCode'], ),
    sa.PrimaryKeyConstraint('categoryId', 'languageId')
    )
    op.create_table('locationtranslations',
    sa.Column('locationId', sa.Integer(), nullable=False),
    sa.Column('languageId', sa.String(length=64), nullable=False),
    sa.Column('nameTranslation', sa.String(length=64), nullable=True),
    sa.ForeignKeyConstraint(['languageId'], ['languages.languageCode'], ),
    sa.ForeignKeyConstraint(['locationId'], ['locations.id'], ),
    sa.PrimaryKeyConstraint('locationId', 'languageId')
    )
    op.create_table('attributetranslations',
    sa.Column('attributeId', sa.Integer(), nullable=False),
    sa.Column('languageId', sa.String(length=64), nullable=False),
    sa.Column('nameTranslation', sa.String(length=64), nullable=True),
    sa.ForeignKeyConstraint(['attributeId'], ['attributes.id'], ),
    sa.ForeignKeyConstraint(['languageId'], ['languages.languageCode'], ),
    sa.PrimaryKeyConstraint('attributeId', 'languageId')
    )
    op.create_table('producttranslations',
    sa.Column('productId', sa.Integer(), nullable=False),
    sa.Column('languageId', sa.String(length=64), nullable=False),
    sa.Column('nameTranslation', sa.String(length=64), nullable=True),
    sa.Column('descriptionTranslation', sa.Text(), nullable=True),
    sa.ForeignKeyConstraint(['languageId'], ['languages.languageCode'], ),
    sa.ForeignKeyConstraint(['productId'], ['products.id'], ),
    sa.PrimaryKeyConstraint('productId', 'languageId')
    )
    op.add_column('attributecategory', sa.Column('restaurantId', sa.Integer(), nullable=True))
    op.create_foreign_key(None, 'attributecategory', 'restaurants', ['restaurantId'], ['id'])
    op.add_column('attributes', sa.Column('restaurantId', sa.Integer(), nullable=True))
    op.create_foreign_key(None, 'attributes', 'restaurants', ['restaurantId'], ['id'])
    op.add_column('categories', sa.Column('restaurantId', sa.Integer(), nullable=True))
    op.create_foreign_key(None, 'categories', 'restaurants', ['restaurantId'], ['id'])
    op.add_column('locations', sa.Column('restaurantId', sa.Integer(), nullable=True))
    op.create_foreign_key(None, 'locations', 'restaurants', ['restaurantId'], ['id'])
    op.drop_constraint('productattributes_ibfk_2', 'productattributes', type_='foreignkey')
    op.drop_constraint('productattributes_ibfk_1', 'productattributes', type_='foreignkey')
    op.create_foreign_key(None, 'productattributes', 'products', ['productId'], ['id'])
    op.create_foreign_key(None, 'productattributes', 'attributes', ['attributeId'], ['id'])
    op.add_column('products', sa.Column('restaurantId', sa.Integer(), nullable=True))
    op.create_foreign_key(None, 'products', 'restaurants', ['restaurantId'], ['id'])
    op.add_column('terminals', sa.Column('restaurantId', sa.Integer(), nullable=True))
    op.create_foreign_key(None, 'terminals', 'restaurants', ['restaurantId'], ['id'])
    op.add_column('users', sa.Column('restaurantId', sa.Integer(), nullable=True))
    op.create_foreign_key(None, 'users', 'restaurants', ['restaurantId'], ['id'])
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_constraint(None, 'users', type_='foreignkey')
    op.drop_column('users', 'restaurantId')
    op.drop_constraint(None, 'terminals', type_='foreignkey')
    op.drop_column('terminals', 'restaurantId')
    op.drop_constraint(None, 'products', type_='foreignkey')
    op.drop_column('products', 'restaurantId')
    op.drop_constraint(None, 'productattributes', type_='foreignkey')
    op.drop_constraint(None, 'productattributes', type_='foreignkey')
    op.create_foreign_key('productattributes_ibfk_1', 'productattributes', 'orders', ['productId'], ['id'])
    op.create_foreign_key('productattributes_ibfk_2', 'productattributes', 'products', ['attributeId'], ['id'])
    op.drop_constraint(None, 'locations', type_='foreignkey')
    op.drop_column('locations', 'restaurantId')
    op.drop_constraint(None, 'categories', type_='foreignkey')
    op.drop_column('categories', 'restaurantId')
    op.drop_constraint(None, 'attributes', type_='foreignkey')
    op.drop_column('attributes', 'restaurantId')
    op.drop_constraint(None, 'attributecategory', type_='foreignkey')
    op.drop_column('attributecategory', 'restaurantId')
    op.drop_table('producttranslations')
    op.drop_table('attributetranslations')
    op.drop_table('locationtranslations')
    op.drop_table('categorytranslations')
    op.drop_table('attributecategorytranslations')
    op.drop_table('restaurants')
    op.drop_table('languages')
    # ### end Alembic commands ###
