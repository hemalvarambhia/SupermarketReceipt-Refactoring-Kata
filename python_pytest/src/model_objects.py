from enum import Enum
import math


class Product:
    def __init__(self, name, unit):
        self.name = name
        self.unit = unit


class ProductQuantity:
    def __init__(self, product, quantity):
        self.product = product
        self.quantity = quantity


class ProductUnit(Enum):
    EACH = 1
    KILO = 2


class SpecialOfferType(Enum):
    THREE_FOR_TWO = 1
    TEN_PERCENT_DISCOUNT = 2
    TWO_FOR_AMOUNT = 3
    FIVE_FOR_AMOUNT = 4

class Offer:
    def __init__(self, offer_type, product, argument):
        self.offer_type = offer_type
        self.product = product
        self.argument = argument

    def two_for_amount_discount(self, quantity, unit_price):
        total = self.argument * (int(quantity) / 2) + int(quantity) % 2 * unit_price
        discount_n = unit_price * quantity - total
        return Discount(self.product, "2 for " + str(self.argument), -discount_n)

    def five_for_amount_discount(self, quantity, unit_price):
        number_of_x = math.floor(int(quantity) / 5)
        discount_total = unit_price * quantity - (
                self.argument * number_of_x + int(quantity) % 5 * unit_price)
        return Discount(self.product, str(5) + " for " + str(self.argument), -discount_total)

    def three_for_amount_discount(self, quantity, unit_price):
        number_of_x = math.floor(int(quantity) / 3)
        discount_amount = quantity * unit_price - (
                (number_of_x * 2 * unit_price) + int(quantity) % 3 * unit_price)
        return Discount(self.product, "3 for 2", -discount_amount)

    def ten_percent_discount(self, quantity, unit_price):
        return Discount(self.product, str(self.argument) + "% off",
                            -quantity * unit_price * self.argument / 100.0)


class Discount:
    def __init__(self, product, description, discount_amount):
        self.product = product
        self.description = description
        self.discount_amount = discount_amount
