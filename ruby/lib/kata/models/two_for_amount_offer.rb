# frozen_string_literal: true

module Kata
  # Represents 2 for the price of n offer
  class TwoForAmountOffer
    def initialize(product:, argument:)
      @product = product
      @argument = argument
    end

    def qualifies?(quantity)
      quantity >= 2
    end

    def discount(unit_price, quantity)
      total = @argument * (quantity / 2) + quantity % 2 * unit_price
      discount_amount = unit_price * quantity - total
      Kata::Discount.new(@product, "2 for #{@argument}", discount_amount)
    end
  end
end
