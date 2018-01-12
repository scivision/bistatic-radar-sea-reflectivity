#!/usr/bin/env python
install_requires = ['numpy', 'oct2py==3.9']
tests_require = ['nose','coveralls']
# %%
from setuptools import setup, find_packages

setup(name='bistatic-sea-reflectivity',
      packages = find_packages(),
      version = '0.1.0',
      description='Bistatic Sea Reflectivity hot clutter model.',
      long_description=open('README.rst').read(),
      author=['Vilhelm Gregers-Hansen','Rashmi Mital','Michael Hirsch, Ph.D.',],
      url='https://github.com/scivision/bistatic-sea-reflectivity',
      install_requires=install_requires,
      tests_require=tests_require,
      extras_require={'tests': tests_require,
                      'plot': ['matplotlib']},
      python_requires='>=3.4')
