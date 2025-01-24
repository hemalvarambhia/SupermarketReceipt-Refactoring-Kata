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

    if qualifies_for_three_for_two?(quantity)
      return three_for_two_discount(unit_price, quantity)
    end

    if qualifies_for_ten_percent_discount?
      return ten_percent_discount(unit_price, quantity)
    end

    if qualifies_for_five_for_amount?(quantity)
      number_of_x = quantity / 5
      total = (@argument * number_of_x + quantity % 5 * unit_price)
      discount_total = unit_price * quantity - total
      Kata::Discount.new(@product, "5 for #{@argument}", discount_total)
    end
  end

  private

  def ten_percent_discount(unit_price, quantity)
    Kata::Discount.new(@product, "#{@argument}% off", quantity * unit_price * @argument / 100.0)
  end

  def three_for_two_discount(unit_price, quantity)
    number_of_x = quantity / 3
    total = ((number_of_x * 2 * unit_price) + quantity % 3 * unit_price)
    discount_amount = quantity * unit_price - total
    Kata::Discount.new(@product, '3 for 2', discount_amount)
  end

  def two_for_amount_discount(unit_price, quantity)
    total = @argument * (quantity / 2) + quantity % 2 * unit_price
    discount_amount = unit_price * quantity - total
    Kata::Discount.new(@product, "2 for #{@argument}", discount_amount)
  end

  def qualifies_for_five_for_amount?(quantity)
    @offer_type == Kata::SpecialOfferType::FIVE_FOR_AMOUNT && quantity >= 5
  end

  def qualifies_for_ten_percent_discount?
    @offer_type == Kata::SpecialOfferType::TEN_PERCENT_DISCOUNT
  end

  def qualifies_for_three_for_two?(quantity)
    @offer_type == Kata::SpecialOfferType::THREE_FOR_TWO && quantity > 2
  end

  def qualifies_for_two_for_amount?(quantity)
    @offer_type == Kata::SpecialOfferType::TWO_FOR_AMOUNT && quantity >= 2
  end
end
