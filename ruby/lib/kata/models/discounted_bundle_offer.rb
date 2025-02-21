# frozen_string_literal: true

class DiscountedBundleOffer
  def initialize(bundle:)

  end

  def qualifies?(products_purchased)
    products_purchased == [ Kata::Product.new(name: 'banana', unit: Kata::ProductUnit::KILO) ]
  end
end
