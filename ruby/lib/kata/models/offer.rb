class Kata::Offer
  attr_reader :product, :offer_type, :argument

  def initialize(offer_type, product, argument)
    @offer_type = offer_type
    @argument = argument
    @product = product
  end

  def calculate_discount(unit_price, quantity)
    two_for_amount = Kata::TwoForAmountOffer.new(product: @product, argument: @argument)
    if two_for_amount.qualifies?(@offer_type, quantity)
      return two_for_amount.discount(unit_price, quantity)
    end

    three_for_two_offer = Kata::ThreeForTwoOffer.new(product: @product)
    if three_for_two_offer.qualifies?(@offer_type, quantity)
      return three_for_two_offer.discount(unit_price, quantity)
    end

    if qualifies_for_ten_percent_discount?
      return ten_percent_discount(unit_price, quantity)
    end

    five_for_amount = Kata::FiveForAmountOffer.new(product: @product, argument: @argument)
    if five_for_amount.qualifies?(@offer_type, quantity)
      five_for_amount.discount(unit_price, quantity)
    end
  end

  private

  def ten_percent_discount(unit_price, quantity)
    Kata::TenPercentDiscountOffer.new(product: @product, argument: @argument).discount(unit_price, quantity)
  end

  def qualifies_for_ten_percent_discount?(quantity = nil)
    Kata::TenPercentDiscountOffer.new(product: @product, argument: @argument).qualifies?(@offer_type, quantity)
  end

end
