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
        if product in self._product_quantities.keys():
            self._product_quantities[product] = self._product_quantities[product] + quantity
        else:
            self._product_quantities[product] = quantity

    def handle_offers(self, receipt, offers, catalog):
        for p in self._product_quantities.keys():
            quantity = self._product_quantities[p]
            if p in offers.keys():
                offer = offers[p]
                unit_price = catalog.unit_price(p)
                quantity_as_int = int(quantity)
                discount = None
                x = 1
                if offer.is_three_for_two():
                    x = 3

                elif offer.is_two_for_amount():
                    x = 2
                    if int(quantity) >= 2:
                        total = offer.argument * (int(quantity) / x) + int(quantity) % 2 * unit_price
                        discount_n = unit_price * quantity - total
                        discount = Discount(p, "2 for " + str(offer.argument), -discount_n)

                if offer.is_five_for_amount():
                    x = 5

                number_of_x = math.floor(int(quantity) / x)
                if offer.is_three_for_two() and int(quantity) > 2:
                    discount_amount = quantity * unit_price - (
                                (number_of_x * 2 * unit_price) + int(quantity) % 3 * unit_price)
                    discount = Discount(p, "3 for 2", -discount_amount)

                if offer.is_ten_percent_discount():
                    discount = Discount(p, str(offer.argument) + "% off",
                                        -quantity * unit_price * offer.argument / 100.0)

                if offer.is_five_for_amount() and int(quantity) >= 5:
                    discount_total = unit_price * quantity - (
                                offer.argument * number_of_x + int(quantity) % 5 * unit_price)
                    discount = Discount(p, str(x) + " for " + str(offer.argument), -discount_total)

                if discount:
                    receipt.add_discount(discount)
