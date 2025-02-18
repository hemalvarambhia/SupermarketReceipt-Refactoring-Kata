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
        offer = self.__applicable_offer(quantity)

        return offer.discount(quantity, unit_price)


    def __applicable_offer(self, quantity):
        offers = [
            TwoForAmount(self.product, self.argument),
            ThreeForTwo(self.product, self.argument),
            FiveForAmount(self.product, self.argument),
            TenPercentDiscount(self.product, self.argument)
        ]
        available_offers = {
            SpecialOfferType.TWO_FOR_AMOUNT: TwoForAmount(self.product, self.argument),
            SpecialOfferType.THREE_FOR_TWO: ThreeForTwo(self.product, self.argument),
            SpecialOfferType.FIVE_FOR_AMOUNT: FiveForAmount(self.product, self.argument),
            SpecialOfferType.TEN_PERCENT_DISCOUNT: TenPercentDiscount(self.product, self.argument)
        }
        return available_offers[self.offer_type] if available_offers[self.offer_type].qualifies(self.offer_type, quantity) else NoOffer()

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

class ThreeForTwo:
    def __init__(self, product, argument):
        self.offer_type = SpecialOfferType.THREE_FOR_TWO
        self.product = product
        self.argument = argument

    def qualifies(self, offer_type, quantity):
        return self.offer_type == offer_type and int(quantity) > 2

    def discount(self, quantity, unit_price):
        number_of_x = math.floor(int(quantity) / 3)
        discount_amount = quantity * unit_price - (
                (number_of_x * 2 * unit_price) + int(quantity) % 3 * unit_price)
        return Discount(self.product, "3 for 2", -discount_amount)

class FiveForAmount:
    def __init__(self, product, argument):
        self.offer_type = SpecialOfferType.FIVE_FOR_AMOUNT
        self.product = product
        self.argument = argument

    def qualifies(self, offer_type, quantity):
        return self.offer_type == offer_type and int(quantity) >= 5

    def discount(self, quantity, unit_price):
        number_of_x = math.floor(int(quantity) / 5)
        discount_total = unit_price * quantity - (
                self.argument * number_of_x + int(quantity) % 5 * unit_price)
        return Discount(self.product, str(5) + " for " + str(self.argument), -discount_total)

class TenPercentDiscount:
    def __init__(self, product, argument):
        self.offer_type = SpecialOfferType.TEN_PERCENT_DISCOUNT
        self.product = product
        self.argument = argument

    def qualifies(self, offer_type, quantity):
        return self.offer_type == offer_type

    def discount(self, quantity, unit_price):
        return Discount(self.product, str(self.argument) + "% off",
                            -quantity * unit_price * self.argument / 100.0)

class NoOffer:
    def discount(self, quantity, unit_price):
        return None

class Discount:
    def __init__(self, product, description, discount_amount):
        self.product = product
        self.description = description
        self.discount_amount = discount_amount
