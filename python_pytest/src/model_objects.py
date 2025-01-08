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

    def three_for_two(self):
        return self.offer_type == SpecialOfferType.THREE_FOR_TWO

    def is_five_for_amount(self):
        return self.offer_type is SpecialOfferType.FIVE_FOR_AMOUNT

    def is_two_for_amount(self):
        return self.offer_type is SpecialOfferType.TWO_FOR_AMOUNT

    def is_ten_percent_discount(self):
        return self.offer_type is SpecialOfferType.TEN_PERCENT_DISCOUNT


class Discount:
    def __init__(self, product, description, discount_amount):
        self.product = product
        self.description = description
        self.discount_amount = discount_amount
