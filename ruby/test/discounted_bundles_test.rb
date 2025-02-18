# frozen_string_literal: true
require_relative './test_helper'
# Tests that document how a discounted bundle works.
class DiscountedBundlesTest < Minitest::Test
  def test_qualifies_for_discount_when_complete_bundle_purchased
    bundle_of_products = [
      Kata::Product.new(name: 'banana', unit: Kata::ProductUnit::KILO)
    ]
    products_purchased = [
      Kata::Product.new(name: 'banana', unit: Kata::ProductUnit::KILO)
    ]
    qualifies_for_discount = DiscountedBundleOffer.new(bundle: bundle_of_products).qualifies?(products_purchased)

    assert_equal(true, qualifies_for_discount)
  end

  def test_does_not_qualify_for_discounted_bundle_when_incomplete_bundle_purchased
    skip 'TODO'
  end

  def test_does_not_qualify_for_discounted_bundle_when_bundle_not_purchased
    skip 'TODO'
  end

  def test_qualifies_for_discounted_bundle_when_complete_bundle_purchased_plus_incomplete_bundle
    skip 'TODO'
  end
end
