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

    def calculate_discount_on(self, offer, quantity, unit_price):
        """Calculates the discount available from the offer on a qualifying product."""
        if offer.is_two_for_amount() and int(quantity) >= 2:
            total = offer.argument * (int(quantity) / 2) + int(quantity) % 2 * unit_price
            discount_amount = unit_price * quantity - total
            return Discount(offer.product, "2 for " + str(offer.argument), -discount_amount)
        if offer.is_ten_percent_discount():
            percent = offer.argument
            return self.ten_percent_off(percent, offer.product, quantity, unit_price)
        if offer.is_three_for_two() and int(quantity) > 2:
            return self.three_for_two_on(offer.product, quantity, unit_price)
        if offer.is_five_for_amount() and int(quantity) >= 5:
            number_of_x = math.floor(int(quantity) / 5)
            discount_amount = unit_price * quantity - (
                    offer.argument * number_of_x + int(quantity) % 5 * unit_price)
            return Discount(offer.product, "5 for " + str(offer.argument), -discount_amount)
        return None

    def three_for_two_on(self, p, quantity, unit_price):
        """Computes a three for two discount on product"""
        number_of_x = math.floor(int(quantity) / 3)
        discount_amount = quantity * unit_price - (
                (number_of_x * 2 * unit_price) + int(quantity) % 3 * unit_price)
        discount = Discount(p, "3 for 2", -discount_amount)
        return discount

    def ten_percent_off(self, percent, p, quantity, unit_price):
        """Computes a 10% off discount on product"""
        discount_amount = -quantity * unit_price * percent / 100.0
        return Discount(p, str(percent) + "% off", discount_amount)


    def is_three_for_two(self):
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
