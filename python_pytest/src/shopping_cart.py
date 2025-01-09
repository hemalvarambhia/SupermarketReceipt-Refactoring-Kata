import math

from model_objects import ProductQuantity, Discount


class ShoppingCart:

    def __init__(self):
        self._items = []
        self._product_quantities = {}

    @property
    def items(self):
        return self._items

    def add_item(self, product):
        self.add_item_quantity(product, 1.0)

    @property
    def product_quantities(self):
        return self._product_quantities

    def add_item_quantity(self, product, quantity):
        self._items.append(ProductQuantity(product, quantity))
        if product in self._product_quantities:
            self._product_quantities[product] = self._product_quantities[product] + quantity
        else:
            self._product_quantities[product] = quantity

    def handle_offers(self, receipt, offers, catalog):
        for p, quantity in self._product_quantities.items():
            if p in offers.keys():
                offer = offers[p]
                unit_price = catalog.unit_price(p)
                discount = self.calculate_discount_on(p, offer, quantity, unit_price)
                if discount:
                    receipt.add_discount(discount)

    def calculate_discount_on(self, p, offer, quantity, unit_price):
        """
        Calculates the discount available from the offer on a qualifying product.
        """
        if offer.is_two_for_amount() and int(quantity) >= 2:
            total = offer.argument * (int(quantity) / 2) + int(quantity) % 2 * unit_price
            discount_amount = unit_price * quantity - total
            return Discount(p, "2 for " + str(offer.argument), -discount_amount)
        if offer.is_ten_percent_discount():
            percent = offer.argument
            return self.ten_percent_off(percent, p, quantity, unit_price)
        if offer.is_three_for_two() and int(quantity) > 2:
            return self.three_for_two_on(p, quantity, unit_price)
        if offer.is_five_for_amount() and int(quantity) >= 5:
            number_of_x = math.floor(int(quantity) / 5)
            discount_amount = unit_price * quantity - (
                    offer.argument * number_of_x + int(quantity) % 5 * unit_price)
            return Discount(p, str(5) + " for " + str(offer.argument), -discount_amount)
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
