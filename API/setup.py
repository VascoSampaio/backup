import os
from setuptools import find_packages, setup

requires = (
		"alembic==0.9.3",
		"blinker==1.4",
		"click==6.7",
		"dominate==2.3.1",
		"Flask==0.12.2",
		"Flask-Bootstrap==3.3.7.1",
		"Flask-Login==0.4.0",
		"Flask-Mail==0.9.1",
		"Flask-Migrate==2.0.4",
		"Flask-Moment==0.5.1",
		"Flask-SQLAlchemy==2.2",
		"Flask-WTF==0.14.2",
		"itsdangerous==0.24",
		"Jinja2==2.11.3",
		"Mako==1.0.7",
		"MarkupSafe==1.0",
		"python-dateutil==2.6.1",
		"python-editor==1.0.3",
		"six==1.10.0",
		"SQLAlchemy==1.1.11",
		"visitor==0.1.3",
		"Werkzeug==0.12.2",
		"WTForms==2.1",
		"PyMySQL==0.9.3",
		"Flask-HTTPAuth==4.0.0",
		"waitress",
        )

def read(fname):
    return open(os.path.join(os.path.dirname(__file__), fname)).read()

setup(
    name = "PleezApp",
    version = "0.0.1",
    author = "PleezCompany",
    author_email = "prod@pleez.pt",
    description = ("Production pleez"),
    license = "BSD",
    keywords = "pleez production pi",
    url = "http://0.0.0.0:5000",
    packages=find_packages(),
	include_package_data=True,
    install_requires=requires,
    long_description=read('README.md'),
    classifiers=[
        "Development Status :: 3 - Alpha",
        "Topic :: Utilities",
        "License :: OSI Approved :: BSD License",
    ],
)