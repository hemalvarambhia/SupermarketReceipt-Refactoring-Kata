class Kata::ShoppingCart
  def initialize
    @items = []
    @product_quantities = {}
  end

  def items
    Array.new @items
  end

  def add_item(product)
    add_item_quantity(product, 1.0)
    nil
  end

  attr_reader :product_quantities

  def add_item_quantity(product, quantity)
    @items << Kata::ProductQuantity.new(product, quantity)
    product_quantities[product] = if @product_quantities.key?(product)
                                    product_quantities[product] + quantity
                                  else
                                    quantity
                                  end
  end

  def handle_offers(receipt, offers, catalog)
    @product_quantities.each do |product, quantity|
      next unless offers.key?(product)

      offer = offers[product]
      unit_price = catalog.unit_price(product)

      discount = offer.calculate_discount(unit_price, quantity)
      receipt.add_discount(discount) if discount
    end
  end
end
