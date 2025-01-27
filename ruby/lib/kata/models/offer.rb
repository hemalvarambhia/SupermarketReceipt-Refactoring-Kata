class Kata::Offer
  attr_reader :product, :offer_type, :argument

  def initialize(offer_type, product, argument)
    @offer_type = offer_type
    @argument = argument
    @product = product
  end

  def calculate_discount(unit_price, quantity)
    if qualifies_for_two_for_amount?(quantity)
      return two_for_amount_discount(unit_price, quantity)
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
    Kata::Discount.new(@product, "#{@argument}% off", quantity * unit_price * @argument / 100.0)
  end

  def two_for_amount_discount(unit_price, quantity)
    total = @argument * (quantity / 2) + quantity % 2 * unit_price
    discount_amount = unit_price * quantity - total
    Kata::Discount.new(@product, "2 for #{@argument}", discount_amount)
  end

  def qualifies_for_ten_percent_discount?
    @offer_type == Kata::SpecialOfferType::TEN_PERCENT_DISCOUNT
  end

  def qualifies_for_two_for_amount?(quantity)
    @offer_type == Kata::SpecialOfferType::TWO_FOR_AMOUNT && quantity >= 2
  end
end
