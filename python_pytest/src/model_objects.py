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

    def calculate_discount_on(self, p, offer, quantity, unit_price):
        """
        Calculates the discount on the product if there is an offer available.
        :param p:
        :param offer:
        :param quantity:
        :param unit_price:
        :return: Discount
        """
        discount = None
        if self.is_two_for_amount(int(quantity)):
            total = self.argument * (int(quantity) / 2) + int(quantity) % 2 * unit_price
            discount_n = unit_price * quantity - total
            discount = Discount(offer.product, "2 for " + str(self.argument), -discount_n)
        if self.is_three_for_two(int(quantity)):
            number_of_x = math.floor(int(quantity) / 3)
            discount_amount = quantity * unit_price - (
                    (number_of_x * 2 * unit_price) + int(quantity) % 3 * unit_price)
            discount = Discount(self.product, "3 for 2", -discount_amount)
        if self.is_five_for_amount(int(quantity)):
            number_of_x = math.floor(int(quantity) / 5)
            discount_total = unit_price * quantity - (
                    self.argument * number_of_x + int(quantity) % 5 * unit_price)
            discount = Discount(self.product, str(5) + " for " + str(self.argument), -discount_total)
        if self.is_ten_percent_discount():
            discount = Discount(self.product, str(self.argument) + "% off",
                                -quantity * unit_price * self.argument / 100.0)
        return discount

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
        """
        Identifies whether an offer is five for amount e.g. five for the price of two, or three.
        :return: true | false
        """
        return self.offer_type == SpecialOfferType.FIVE_FOR_AMOUNT and quantity >= 5

    def is_ten_percent_discount(self):
        """
        Identifies whether an offer is ten percent off e.g. 10% percent off.
        :return: true | false
                """
        return self.offer_type == SpecialOfferType.TEN_PERCENT_DISCOUNT
class Discount:
    def __init__(self, product, description, discount_amount):
        self.product = product
        self.description = description
        self.discount_amount = discount_amount
