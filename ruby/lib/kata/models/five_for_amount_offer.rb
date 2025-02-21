# frozen_string_literal: true

module Kata
  # Models a 5 for the price of n offer.
  class FiveForAmountOffer
    def initialize(product:, argument:)
      @product = product
      @argument = argument
    end

    def qualifies?(quantity)
      quantity >= 5
    end

    def discount(unit_price, quantity)
      number_of_x = quantity / 5
      total = (@argument * number_of_x + quantity % 5 * unit_price)
      discount_total = unit_price * quantity - total
      Kata::Discount.new(@product, "5 for #{@argument}", discount_total)
    end
  end
end
