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

      if offer.offer_type == Kata::SpecialOfferType::FIVE_FOR_AMOUNT && quantity.to_i >= 5
        number_of_x = quantity.to_i / 5
        total = (offer.argument * number_of_x + quantity.to_i % 5 * unit_price)
        discount_total = unit_price * quantity - total
        discount = Kata::Discount.new(product, 5.to_s + ' for ' + offer.argument.to_s, discount_total)
      end

      receipt.add_discount(discount) if discount
    end
  end
end
