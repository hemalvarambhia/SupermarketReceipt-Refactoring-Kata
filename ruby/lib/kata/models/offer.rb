class Kata::Offer
  attr_reader :product, :offer_type, :argument

  def initialize(offer_type, product, argument)
    @offer_type = offer_type
    @argument = argument
    @product = product
  end

  def calculate_discount(unit_price, quantity)
    if @offer_type == Kata::SpecialOfferType::TWO_FOR_AMOUNT && quantity.to_i >= 2
      total = @argument * (quantity.to_i / 2) + quantity.to_i % 2 * unit_price
      discount_amount = unit_price * quantity - total
      return Kata::Discount.new(@product, '2 for ' + @argument.to_s, discount_amount)
    end

    if @offer_type == Kata::SpecialOfferType::THREE_FOR_TWO && quantity.to_i > 2
      number_of_x = quantity.to_i / 3
      total = ((number_of_x * 2 * unit_price) + quantity.to_i % 3 * unit_price)
      discount_amount = quantity * unit_price - total
      Kata::Discount.new(@product, '3 for 2', discount_amount)
    end
  end
end
