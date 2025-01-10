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

    def is_two_for_amount(self, quantity):
        """
        Identifies whether an offer is two-for-amount e.g. two for the price of one
        :return: true | false
        """
        return self.offer_type == SpecialOfferType.TWO_FOR_AMOUNT and quantity >= 2

    def is_three_for_two(self, quantity):
        """
        Identifies whether an offer is three-for-two e.g. three for the price of two
        :return: true | false
        """
        return self.offer_type == SpecialOfferType.THREE_FOR_TWO and quantity > 2

    def is_five_for_amount(self, quantity):
        return self.offer_type == SpecialOfferType.FIVE_FOR_AMOUNT and quantity >= 5

class Discount:
    def __init__(self, product, description, discount_amount):
        self.product = product
        self.description = description
        self.discount_amount = discount_amount
