# frozen_string_literal: true
require_relative './test_helper'
# Tests that document how a discounted bundle works.
class DiscountedBundlesTest < Minitest::Test
  def test_qualifies_for_discount_when_complete_bundle_purchased
    bundle_of_products = [ Kata::Product.new(name: 'banana', unit: Kata::ProductUnit::KILO) ]
    discounted_bundle_offer = DiscountedBundleOffer.new(bundle: bundle_of_products)

    products_purchased = [ Kata::Product.new(name: 'banana', unit: Kata::ProductUnit::KILO) ]
    qualifies_for_discount = discounted_bundle_offer.qualifies?(products_purchased)

    assert_equal(true, qualifies_for_discount)
  end

  def test_qualifies_for_discount_when_any_complete_bundle_purchased
    bundle_of_products = [ Kata::Product.new(name: 'blueberries', unit: Kata::ProductUnit::KILO) ]
    discounted_bundle_offer = DiscountedBundleOffer.new(bundle: bundle_of_products)

    products_purchased = [ Kata::Product.new(name: 'blueberries', unit: Kata::ProductUnit::KILO) ]
    qualifies_for_discount = discounted_bundle_offer.qualifies?(products_purchased)

    assert_equal(true, qualifies_for_discount)
  end

  def test_does_not_qualify_for_discounted_bundle_when_incomplete_bundle_purchased
    bundle_of_products = [ Kata::Product.new(name: 'banana', unit: Kata::ProductUnit::KILO) ]
    discounted_bundle_offer = DiscountedBundleOffer.new(bundle: bundle_of_products)

    products_purchased = [ Kata::Product.new(name: 'blueberries', unit: Kata::ProductUnit::KILO) ]
    qualifies_for_discount = discounted_bundle_offer.qualifies?(products_purchased)

    assert_equal(false, qualifies_for_discount)
  end

  def test_does_not_qualify_for_discounted_bundle_when_bundle_not_purchased
    bundle_of_products = [
      Kata::Product.new(name: 'blueberries', unit: Kata::ProductUnit::KILO),
      Kata::Product.new(name: 'raspberries', unit: Kata::ProductUnit::KILO),
    ]
    discounted_bundle_offer = DiscountedBundleOffer.new(bundle: bundle_of_products)

    products_purchased = [
      Kata::Product.new(name: 'blueberries', unit: Kata::ProductUnit::KILO), # part of bundle
      Kata::Product.new(name: 'yoghurt', unit: Kata::ProductUnit::EACH),
      Kata::Product.new(name: 'banana', unit: Kata::ProductUnit::KILO),
    ]
    qualifies_for_discount = discounted_bundle_offer.qualifies?(products_purchased)

    assert_equal(false, qualifies_for_discount)
  end

  def test_qualifies_for_discounted_bundle_when_complete_bundle_purchased_plus_incomplete_bundle
    bundle_of_products = [
      Kata::Product.new(name: 'orange juice', unit: Kata::ProductUnit::EACH),
      Kata::Product.new(name: 'orange', unit: Kata::ProductUnit::KILO)
    ]
    discounted_bundle_offer = DiscountedBundleOffer.new(bundle: bundle_of_products)

    products_purchased = [
      Kata::Product.new(name: 'orange juice', unit: Kata::ProductUnit::EACH),
      Kata::Product.new(name: 'orange', unit: Kata::ProductUnit::KILO),
      Kata::Product.new(name: 'orange', unit: Kata::ProductUnit::KILO),
      Kata::Product.new(name: 'milk', unit: Kata::ProductUnit::EACH),
      Kata::Product.new(name: 'blueberries', unit: Kata::ProductUnit::KILO)
    ]
    qualifies_for_discount = discounted_bundle_offer.qualifies?(products_purchased)

    assert_equal(true, qualifies_for_discount)
  end
end
