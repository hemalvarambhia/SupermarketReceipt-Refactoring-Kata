# frozen_string_literal: true

module Kata
  # Models a product with 10% off
  class TenPercentDiscountOffer
    def initialize(product:, argument:)
      @product = product
      @argument = argument
    end

    def qualifies?(type, _quantity)
      type == Kata::SpecialOfferType::TEN_PERCENT_DISCOUNT
    end

    def discount(unit_price, quantity)
      Kata::Discount.new(@product, "#{@argument}% off", quantity * unit_price * @argument / 100.0)
    end
  end
end
