# frozen_string_literal: true

module Kata
  # Models a three for two offer.
  class ThreeForTwoOffer
    def initialize(product:)
      @product = product
    end

    def qualifies?(type, quantity)
      type == Kata::SpecialOfferType::THREE_FOR_TWO && quantity > 2
    end

    def discount(unit_price, quantity)
      number_of_x = quantity / 3
      total = ((number_of_x * 2 * unit_price) + quantity % 3 * unit_price)
      discount_amount = quantity * unit_price - total
      Kata::Discount.new(@product, '3 for 2', discount_amount)
    end
  end
end
