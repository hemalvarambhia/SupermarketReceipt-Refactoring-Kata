import math

from model_objects import ProductQuantity, SpecialOfferType, Discount


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
        for p, quantity in self._product_quantities.items():
            if p in offers.keys():
                offer = offers[p]
                unit_price = catalog.unit_price(p)
                discount = self.__calculate_discount(offer, quantity, unit_price)

                if discount:
                    receipt.add_discount(discount)

    def __calculate_discount(self, offer, quantity, unit_price):
        discount = None
        if offer.offer_type == SpecialOfferType.TWO_FOR_AMOUNT and int(quantity) >= 2:
            discount = offer.two_for_amount_discount(quantity, unit_price)
        if offer.offer_type == SpecialOfferType.THREE_FOR_TWO and int(quantity) > 2:
            discount = offer.three_for_amount_discount(quantity, unit_price)
        if offer.offer_type == SpecialOfferType.FIVE_FOR_AMOUNT and int(quantity) >= 5:
            discount = offer.five_for_amount_discount(quantity, unit_price)
        if offer.offer_type == SpecialOfferType.TEN_PERCENT_DISCOUNT:
            discount = offer.ten_percent_discount(quantity, unit_price)
        return discount
