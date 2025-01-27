module Kata
  # A class that models someone who scans products from the shopping cart and notifies
  # the customer how much they bought.
  class Teller
    def initialize(catalog)
      @catalog = catalog
      @offers = {}
    end

    def add_special_offer(offer_type, product, argument)
      @offers[product] = Kata::Offer.new(offer_type, product, argument)
    end

    def checks_out_articles_from(the_cart)
      receipt = Kata::Receipt.new
      the_cart.each_item { |product_quantity| add(product_quantity, receipt) }
      the_cart.handle_offers(receipt, @offers, @catalog)

      receipt
    end

    private

    def add(product_quantity, receipt)
      product = product_quantity.product
      quantity = product_quantity.quantity
      unit_price = @catalog.unit_price(product)
      price = quantity * unit_price
      receipt.add_product(product, quantity, unit_price, price)
    end
  end
end
