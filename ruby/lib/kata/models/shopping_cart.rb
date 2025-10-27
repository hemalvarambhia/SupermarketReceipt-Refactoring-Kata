# frozen_string_literal: true

module Kata
  # Models a supermarket shopping cart that shoppers can add or remove things from.
  class ShoppingCart
    def initialize
      @items = []
      @product_quantities = {}
    end

    def each_item(&block)
      Array.new(@items).each(&block)
    end

    def add_item(product)
      add_item_quantity(product, 1.0)
      nil
    end

    def add_item_quantity(product, quantity)
      @items << Kata::ProductQuantity.new(product, quantity)
      @product_quantities[product] = if @product_quantities.key?(product)
                                       @product_quantities[product] + quantity
                                    else
                                      quantity
                                    end
    end

    def handle_offers(receipt, offers, catalog)
      products_with_offers = @product_quantities.select { |product, _| offers.key?(product) }
      products_with_offers.each do |product, quantity|
        offer = offers[product]
        unit_price = catalog.unit_price(product)

        discount = offer.calculate_discount(unit_price, quantity.to_i)
        receipt.add_discount(discount) if discount
      end
    end
  end
end
