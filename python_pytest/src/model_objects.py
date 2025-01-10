import math
from enum import Enum


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

    def calculate_discount_on(self, quantity, unit_price):
        discount = None
        if self.is_two_for_amount(int(quantity)):
            total = self.argument * (int(quantity) / 2) + int(quantity) % 2 * unit_price
            discount_n = unit_price * quantity - total
            discount = Discount(self.product, "2 for " + str(self.argument), -discount_n)
        if self.offer_type == SpecialOfferType.THREE_FOR_TWO and int(quantity) > 2:
            number_of_x = math.floor(int(quantity) / 3)
            discount_amount = quantity * unit_price - (
                    (number_of_x * 2 * unit_price) + int(quantity) % 3 * unit_price)
            discount = Discount(self.product, "3 for 2", -discount_amount)
        if self.offer_type == SpecialOfferType.TEN_PERCENT_DISCOUNT:
            discount = Discount(self.product, str(self.argument) + "% off",
                                -quantity * unit_price * self.argument / 100.0)
        if self.offer_type == SpecialOfferType.FIVE_FOR_AMOUNT and int(quantity) >= 5:
            number_of_x = math.floor(int(quantity) / 5)
            discount_total = unit_price * quantity - (
                    self.argument * number_of_x + int(quantity) % 5 * unit_price)
            discount = Discount(self.product, str(5) + " for " + str(self.argument), -discount_total)
        return discount

    def is_two_for_amount(self, quantity):
        return self.offer_type == SpecialOfferType.TWO_FOR_AMOUNT and quantity >= 2


class Discount:
    def __init__(self, product, description, discount_amount):
        self.product = product
        self.description = description
        self.discount_amount = discount_amount
