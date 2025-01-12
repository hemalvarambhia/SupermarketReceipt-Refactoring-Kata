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
        if self.__qualifies_for_two_for_amount(int(quantity)):
            return TwoForAmount(self.product, self.argument).discount(quantity, unit_price)
        if self.__qualifies_for_three_for_two(int(quantity)):
            return ThreeForTwo(self.product).discount(quantity, unit_price)
        if self.__qualifies_for_ten_percent_discount():
            return TenPercentOff(self.product, self.argument).discount(quantity, unit_price)
        if self.__qualifies_for_five_for_amount(int(quantity)):
            return FiveForAmount(self.product, self.argument).discount(quantity, unit_price)
        return None

    def offer_of_type(self, offer_type):
        return {
            SpecialOfferType.THREE_FOR_TWO: ThreeForTwo(self.product),
            SpecialOfferType.TEN_PERCENT_DISCOUNT: TenPercentOff(self.product, self.argument),
            SpecialOfferType.FIVE_FOR_AMOUNT: FiveForAmount(self.product, self.argument),
            SpecialOfferType.TWO_FOR_AMOUNT: TwoForAmount(self.product, self.argument)
        }[offer_type]

    def __qualifies_for_ten_percent_discount(self):
        return self.offer_type == SpecialOfferType.TEN_PERCENT_DISCOUNT

    def __qualifies_for_three_for_two(self, quantity):
        return self.offer_type == SpecialOfferType.THREE_FOR_TWO and quantity > 2

    def __qualifies_for_five_for_amount(self, quantity):
        return self.offer_type == SpecialOfferType.FIVE_FOR_AMOUNT and quantity >= 5

    def __qualifies_for_two_for_amount(self, quantity):
        return self.offer_type == SpecialOfferType.TWO_FOR_AMOUNT and quantity >= 2


class ThreeForTwo:

    def __init__(self, product):
        self.product = product

    def discount(self, quantity, unit_price):
        number_of_x = math.floor(int(quantity) / 3)
        discount_amount = quantity * unit_price - (
                (number_of_x * 2 * unit_price) + int(quantity) % 3 * unit_price)
        return Discount(self.product, "3 for 2", -discount_amount)


class TwoForAmount:
    def __init__(self, product, argument):
        self.product = product
        self.argument = argument

    def discount(self, quantity, unit_price):
        total = self.argument * (int(quantity) / 2) + int(quantity) % 2 * unit_price
        discount_n = unit_price * quantity - total
        return Discount(self.product, "2 for " + str(self.argument), -discount_n)

class FiveForAmount:
    def __init__(self, product, argument):
        self.product = product
        self.argument = argument

    def discount(self, quantity, unit_price):
        number_of_x = math.floor(int(quantity) / 5)
        discount_total = unit_price * quantity - (
                self.argument * number_of_x + int(quantity) % 5 * unit_price)
        return Discount(self.product, str(5) + " for " + str(self.argument), -discount_total)


class TenPercentOff:

    def __init__(self, product, percent):
        self.product = product
        self.argument = percent

    def discount(self, quantity, unit_price):
        return Discount(self.product, str(self.argument) + "% off",
                        -quantity * unit_price * self.argument / 100.0)


class Discount:
    def __init__(self, product, description, discount_amount):
        self.product = product
        self.description = description
        self.discount_amount = discount_amount
