# frozen_string_literal: true

class DiscountedBundleOffer
  def initialize(bundle:)
    @bundle = bundle
  end

  def qualifies?(products_purchased)
    products_purchased == @bundle
  end
end
