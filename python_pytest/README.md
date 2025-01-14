# Supermarket Receipt

You are working on the software for a supermarket, in particular for the teller machine that cashiers use to calculate the price of a shopping cart full of items and give the customer a receipt. The supermarket has a catalog of products for sale at various prices. Normally the price of a shopping cart is the sum of the prices of all the items in it. However, at any given time there might be special offers and price reductions on particular products. For example:

- 10% discount
- 3 for the price of 2
- 2 items for a reduced price
- 5 items for a reduced price

The starting position for this exercise contains the code for setting up the Teller object, a catalog of products, the shopping cart, and any special offers. It can calculate the price of a shopping cart and generate a receipt, but so far there aren't many test cases.

## Setup
- make a venv
- install requirements, e.g. `python -m pip install -r requirements.txt` or `pipenv install pytest ruff pylint approvaltests pytest-approvaltests coverage virtualenv`
- use pytest to run the tests e.g. PYTHONPATH=src:tests pipenv run pytest

## Radon
More information on how to use `radon` may be found on the 
[Github repository](https://github.com/rubik/radon). To run it:
- when using `pipenv` usage for McCabe Cyclomatic Complexity Metric is as follows `pipenv run radon cc <path> -a`
- to calculate the Halstead Complexity Metric, the command is `pipenv run radon hal <path>`
- to calculate the Maintainability Index, the command is `pipenv run radon mi <path>` 
