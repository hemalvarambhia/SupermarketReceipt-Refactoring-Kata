# frozen_string_literal: true

class DiscountedBundleOffer
  def initialize(bundle:)
    @bundle = bundle
  end

  def qualifies?(products_purchased)
    @bundle.all? { |item| products_purchased.include?(item) }
  end
end
