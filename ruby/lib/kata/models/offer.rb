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
      Kata::Discount.new(@product, '2 for ' + @argument.to_s, discount_amount)
    end
  end
end
