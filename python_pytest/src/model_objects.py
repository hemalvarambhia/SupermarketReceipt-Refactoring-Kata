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

    def calculate_discount(self, quantity, unit_price):
        discount = None
        if TwoForAmount(self.product, self.argument).qualifies(self.offer_type, quantity):
            discount = TwoForAmount(self.product, self.argument).discount(quantity, unit_price)
        if self.__qualifies_for_three_for_two_offer(quantity):
            discount = self.__three_for_two_discount(quantity, unit_price)
        if self.__qualifies_for_five_for_amount_offer(quantity):
            discount = self.__five_for_amount_discount(quantity, unit_price)
        if self.__qualifies_for_ten_percent_offer():
            discount = self.__ten_percent_discount(quantity, unit_price)
        return discount

    def __qualifies_for_ten_percent_offer(self):
        return self.offer_type == SpecialOfferType.TEN_PERCENT_DISCOUNT

    def __qualifies_for_five_for_amount_offer(self, quantity):
        return self.offer_type == SpecialOfferType.FIVE_FOR_AMOUNT and int(quantity) >= 5

    def __qualifies_for_three_for_two_offer(self, quantity):
        return self.offer_type == SpecialOfferType.THREE_FOR_TWO and int(quantity) > 2

    def __five_for_amount_discount(self, quantity, unit_price):
        number_of_x = math.floor(int(quantity) / 5)
        discount_total = unit_price * quantity - (
                self.argument * number_of_x + int(quantity) % 5 * unit_price)
        return Discount(self.product, str(5) + " for " + str(self.argument), -discount_total)

    def __three_for_two_discount(self, quantity, unit_price):
        number_of_x = math.floor(int(quantity) / 3)
        discount_amount = quantity * unit_price - (
                (number_of_x * 2 * unit_price) + int(quantity) % 3 * unit_price)
        return Discount(self.product, "3 for 2", -discount_amount)

    def __ten_percent_discount(self, quantity, unit_price):
        return Discount(self.product, str(self.argument) + "% off",
                            -quantity * unit_price * self.argument / 100.0)

class TwoForAmount:
    def __init__(self, product, argument):
        self.offer_type = SpecialOfferType.TWO_FOR_AMOUNT
        self.product = product
        self.argument = argument

    def qualifies(self, offer_type, quantity):
        return self.offer_type == offer_type and int(quantity) >= 2

    def discount(self, quantity, unit_price):
        total = self.argument * (int(quantity) / 2) + int(quantity) % 2 * unit_price
        discount_n = unit_price * quantity - total
        return Discount(self.product, "2 for " + str(self.argument), -discount_n)


class Discount:
    def __init__(self, product, description, discount_amount):
        self.product = product
        self.description = description
        self.discount_amount = discount_amount
