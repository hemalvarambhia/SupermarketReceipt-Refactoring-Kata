import math

from model_objects import ProductQuantity, SpecialOfferType, Discount


class ShoppingCart:
    """
    Represents a shopping cart containing the products the shopper purchased. Initially empty,
    items can be added to the cart (a single unit or multiple) and it adds discounts to a receipt
    when the items in it have special offers on them.
    Attributes:
        _items - the items in the shopping cart;
        _product_quantities - the product and their quantities in the shopping cart;
    Methods:
        add_item - adds a single item to the cart (where single unit);
        add_item_quantity - adds a quantity of items to the cart (kilos or packages);
        handle_offers - given a receipt, calculates the discount on an item if there is an offer
        on it and adds it to the receipt;
    """

    def __init__(self):
        self._items = []
        self._product_quantities = {}

    @property
    def items(self):
        """
        Returns clients the contents of the shopping cart.
        :returns: the contents of the shopping cart
        """
        return self._items

    def add_item(self, product):
        """
        Adds a product to the shopping cart.
        :param product:
        Side effect: a single unit of Product added to items,
        quantity of product purchased incremented by 1.

        :example:
        shopping_cart = ShoppingCart()
        product = Product(name='cheese', unit=ProductUnit.EACH)
        shopping_cart.add_item(product)
        """
        self.add_item_quantity(product, 1.0)

    @property
    def product_quantities(self):
        """
        Returns clients the products in the shopping cart and the quantity purchased.
        :return: ProductQuantities
        :example:
        shopping_cart = ShoppingCart()
        product = Product(name='cheese', unit=ProductUnit.EACH)
        shopping_cart.add_item(product)
        shopping_cart.product_quantities
        """
        return self._product_quantities

    def add_item_quantity(self, product, quantity):
        """
        Adds a specified quantity of product to the shopping cart.
        :param product: Product
        :param quantity: int, float
        Side effect: a specified quantity of Product added to items, and ProductQuantities
        for product updated
        """
        self._items.append(ProductQuantity(product, quantity))
        if product in self._product_quantities:
            self._product_quantities[product] = self._product_quantities[product] + quantity
        else:
            self._product_quantities[product] = quantity

    def handle_offers(self, receipt, offers, catalog):
        """
        Given a receipt, the offers available on products and catalog of product prices
        the method looks at each product in the shopping card, the offer available on it
        and calculates the discount on the product if there is an offer available.
        :param receipt: Receipt
        :param offers: Dictionary of offers
        :param catalog: Catalog
        :Side effect: adds the discount on the product if there is to the receipt.
        """
        for p, quantity in self._product_quantities.items():
            if p in offers.keys():
                offer = offers[p]
                unit_price = catalog.unit_price(p)
                discount = None
                x = 1
                if offer.offer_type == SpecialOfferType.THREE_FOR_TWO:
                    x = 3

                elif offer.is_two_for_amount(int(quantity)):
                    total = offer.argument * (int(quantity) / 2) + int(quantity) % 2 * unit_price
                    discount_n = unit_price * quantity - total
                    discount = Discount(p, "2 for " + str(offer.argument), -discount_n)

                if offer.offer_type == SpecialOfferType.FIVE_FOR_AMOUNT:
                    x = 5

                number_of_x = math.floor(int(quantity) / x)
                if offer.offer_type == SpecialOfferType.THREE_FOR_TWO and int(quantity) > 2:
                    discount_amount = quantity * unit_price - (
                            (number_of_x * 2 * unit_price) + int(quantity) % 3 * unit_price)
                    discount = Discount(p, "3 for 2", -discount_amount)

                if offer.offer_type == SpecialOfferType.TEN_PERCENT_DISCOUNT:
                    discount = Discount(p, str(offer.argument) + "% off",
                                        -quantity * unit_price * offer.argument / 100.0)

                if offer.offer_type == SpecialOfferType.FIVE_FOR_AMOUNT and int(quantity) >= 5:
                    discount_total = unit_price * quantity - (
                            offer.argument * number_of_x + int(quantity) % 5 * unit_price)
                    discount = Discount(p, str(x) + " for " + str(offer.argument), -discount_total)

                if discount:
                    receipt.add_discount(discount)
