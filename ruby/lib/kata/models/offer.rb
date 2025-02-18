# frozen_string_literal: true

module Kata
  # A class that encapsulates the offers available on products and computes the discount.
  class Offer
    def initialize(offer_type, product, argument)
      available_offers = {
        Kata::SpecialOfferType::TWO_FOR_AMOUNT => Kata::TwoForAmountOffer.new(product: product, argument: argument),
        Kata::SpecialOfferType::FIVE_FOR_AMOUNT => Kata::FiveForAmountOffer.new(product: product, argument: argument),
        Kata::SpecialOfferType::THREE_FOR_TWO => Kata::ThreeForTwoOffer.new(product: product),
        Kata::SpecialOfferType::TEN_PERCENT_DISCOUNT =>
          Kata::TenPercentDiscountOffer.new(product: product, argument: argument)
      }
      @offer = available_offers[offer_type]
    end

    def calculate_discount(unit_price, quantity)
      offer_qualified_for = @offer.qualifies?(quantity) ? @offer : NoOffer.new

      offer_qualified_for.discount(unit_price, quantity)
    end
  end
end
