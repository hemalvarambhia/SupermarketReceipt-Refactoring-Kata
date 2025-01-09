from model_objects import ProductQuantity


class ShoppingCart:
    """
    A shopping cart whose responsibility are:
    - to store products put in them,
    - knows how to calculate the discounts on the offers on products.
    """
    def __init__(self):
        self._items = []
        self._product_quantities = {}

    @property
    def items(self):
        """Returns the items in the shopping cart."""
        return self._items

    def add_item(self, product):
        """Add one item to the shopping cart."""
        self.add_item_quantity(product, 1.0)

    @property
    def product_quantities(self):
        """Returns the products in the shopping cart and the quantity purchased."""
        return self._product_quantities

    def add_item_quantity(self, product, quantity):
        """Add specified number of item to the shopping cart."""
        self._items.append(ProductQuantity(product, quantity))
        if product in self._product_quantities:
            self._product_quantities[product] = self._product_quantities[product] + quantity
        else:
            self._product_quantities[product] = quantity

    def handle_offers(self, receipt, offers, catalog):
        """
        Using the offers available on products, the shopping cart looks at how many qualifying
        products were purchased and uses the unit price to calculate the discount on them.
        """
        for p, quantity in self._product_quantities.items():
            if p in offers.keys():
                offer = offers[p]
                unit_price = catalog.unit_price(p)
                discount = offer.calculate_discount_on(offer, quantity, unit_price)
                if discount:
                    receipt.add_discount(discount)
