class Kata::Offer
  attr_reader :product, :offer_type, :argument

  def initialize(offer_type, product, argument)
    @offer_type = offer_type
    @argument = argument
    @product = product
  end

  def calculate_discount(unit_price, quantity)
    available_offers = {
      Kata::SpecialOfferType::TWO_FOR_AMOUNT => Kata::TwoForAmountOffer.new(product: @product, argument: @argument),
      Kata::SpecialOfferType::FIVE_FOR_AMOUNT => Kata::FiveForAmountOffer.new(product: @product, argument: @argument),
      Kata::SpecialOfferType::THREE_FOR_TWO => Kata::ThreeForTwoOffer.new(product: @product),
      Kata::SpecialOfferType::TEN_PERCENT_DISCOUNT => Kata::TenPercentDiscountOffer.new(product: @product, argument: @argument)
    }
    two_for_amount = available_offers[@offer_type]
    if two_for_amount.qualifies?(@offer_type, quantity)
      return two_for_amount.discount(unit_price, quantity)
    end

    three_for_two_offer = available_offers[@offer_type]
    if three_for_two_offer.qualifies?(@offer_type, quantity)
      return three_for_two_offer.discount(unit_price, quantity)
    end

    ten_percent_discount_offer = available_offers[@offer_type]
    if ten_percent_discount_offer.qualifies?(@offer_type, nil)
      return ten_percent_discount_offer.discount(unit_price, quantity)
    end

    five_for_amount = available_offers[@offer_type]
    if five_for_amount.qualifies?(@offer_type, quantity)
      five_for_amount.discount(unit_price, quantity)
    end
  end
end
