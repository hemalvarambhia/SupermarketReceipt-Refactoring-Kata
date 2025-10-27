# frozen_string_literal: true
require 'pry'
class DiscountedBundle
  def initialize(bundle:)
    @product_bundle = bundle
  end

  def qualifies?(products_purchased)
    products_in_bundle = products_purchased.find_all { |item| @product_bundle.include?(item) }

    products_in_bundle.uniq == @product_bundle
  end
  alias_method :complete_bundle?, :qualifies?
end
