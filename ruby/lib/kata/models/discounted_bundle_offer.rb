# frozen_string_literal: true

class DiscountedBundleOffer
  def initialize(bundle:)
    @product_bundle = bundle
  end

  def qualifies?(products_purchased)
    @product_bundle.all? { |item| products_purchased.include?(item) }
  end
end
