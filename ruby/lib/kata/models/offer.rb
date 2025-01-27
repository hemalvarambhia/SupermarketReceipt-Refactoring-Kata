class Kata::Offer
  attr_reader :product, :offer_type, :argument

  def initialize(offer_type, product, argument)
    @offer_type = offer_type
    @argument = argument
    @product = product
    @available_offers = {
      Kata::SpecialOfferType::TWO_FOR_AMOUNT => Kata::TwoForAmountOffer.new(product: @product, argument: @argument),
      Kata::SpecialOfferType::FIVE_FOR_AMOUNT => Kata::FiveForAmountOffer.new(product: @product, argument: @argument),
      Kata::SpecialOfferType::THREE_FOR_TWO => Kata::ThreeForTwoOffer.new(product: @product),
      Kata::SpecialOfferType::TEN_PERCENT_DISCOUNT => Kata::TenPercentDiscountOffer.new(product: @product, argument: @argument)
    }
  end

  def calculate_discount(unit_price, quantity)
    offer = @available_offers[@offer_type]
    if offer.qualifies?(@offer_type, quantity)
      offer.discount(unit_price, quantity)
    else
      nil
    end
  end
end
