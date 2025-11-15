# frozen_string_literal: true
require_relative './test_helper'
# Tests that document how a discounted bundle works.
class DiscountedBundlesTest < Minitest::Test
  def test_qualifies_for_discount_when_complete_bundle_purchased
    bundle_of_products = [ Kata::Product.kilo_of(name: 'banana') ]
    discounted_bundle_offer = DiscountedBundle.new(bundle: bundle_of_products)

    products_purchased = [ Kata::Product.kilo_of(name: 'banana') ]
    qualifies_for_discount = discounted_bundle_offer.complete_bundle?(products_purchased)

    assert_equal(true, qualifies_for_discount)
  end

  def test_qualifies_for_discount_when_any_complete_bundle_purchased
    bundle_of_products = [ Kata::Product.kilo_of(name: 'blueberries') ]
    discounted_bundle_offer = DiscountedBundle.new(bundle: bundle_of_products)

    products_purchased = [ Kata::Product.kilo_of(name: 'blueberries') ]
    qualifies_for_discount = discounted_bundle_offer.complete_bundle?(products_purchased)

    assert_equal(true, qualifies_for_discount)
  end

  def test_does_not_qualify_for_discounted_bundle_when_incomplete_bundle_purchased
    bundle_of_products = [ Kata::Product.kilo_of(name: 'banana') ]
    discounted_bundle_offer = DiscountedBundle.new(bundle: bundle_of_products)

    products_purchased = [ Kata::Product.kilo_of(name: 'blueberries') ]
    qualifies_for_discount = discounted_bundle_offer.complete_bundle?(products_purchased)

    assert_equal(false, qualifies_for_discount)
  end

  def test_does_not_qualify_for_discounted_bundle_when_any_incomplete_bundle_purchased
    bundle_of_products = [
      Kata::Product.kilo_of(name: 'blueberries'),
      Kata::Product.kilo_of(name: 'raspberries'),
    ]
    discounted_bundle_offer = DiscountedBundle.new(bundle: bundle_of_products)

    products_purchased = [
      Kata::Product.kilo_of(name: 'blueberries'), # part of bundle
      Kata::Product.each(name: 'yoghurt'),
      Kata::Product.kilo_of(name: 'banana'),
    ]
    qualifies_for_discount = discounted_bundle_offer.complete_bundle?(products_purchased)

    assert_equal(false, qualifies_for_discount)
  end

  def test_qualifies_for_discounted_bundle_when_complete_bundle_purchased_plus_incomplete_bundle
    bundle_of_products = [
      Kata::Product.each(name: 'orange juice'),
      Kata::Product.kilo_of(name: 'orange')
    ]
    discounted_bundle_offer = DiscountedBundle.new(bundle: bundle_of_products)

    products_purchased = [
      Kata::Product.each(name: 'orange juice'),
      Kata::Product.kilo_of(name: 'orange'),
      Kata::Product.kilo_of(name: 'orange'),
      Kata::Product.each(name: 'milk'),
      Kata::Product.kilo_of(name: 'blueberries')
    ]
    qualifies_for_discount = discounted_bundle_offer.complete_bundle?(products_purchased)

    assert_equal(true, qualifies_for_discount)
  end

  def test_qualifies_for_discounted_bundle_when_complete_bundle_purchased_more_than_once
    bundle_of_products = [
      Kata::Product.each(name: 'orange juice'),
      Kata::Product.kilo_of(name: 'orange')
    ]
    discounted_bundle_offer = DiscountedBundle.new(bundle: bundle_of_products)

    products_purchased = [
      Kata::Product.each(name: 'orange juice'),
      Kata::Product.kilo_of(name: 'orange'),
      Kata::Product.new(name: 'orange juice', unit: Kata::ProductUnit::EACH),
      Kata::Product.new(name: 'orange', unit: Kata::ProductUnit::KILO),
      Kata::Product.new(name: 'blueberries', unit: Kata::ProductUnit::KILO)
    ]
    qualifies_for_discount = discounted_bundle_offer.qualifies?(products_purchased)

    assert_equal(true, qualifies_for_discount)
  end

  def test_distills_bundle_from_products_purchased
    bundle_of_products = [
      Kata::Product.new(name: 'orange juice', unit: Kata::ProductUnit::EACH),
      Kata::Product.new(name: 'blueberries', unit: Kata::ProductUnit::KILO)
    ]
    discounted_bundle_offer = DiscountedBundle.new(bundle: bundle_of_products)

    products_purchased = [
      Kata::Product.new(name: 'orange juice', unit: Kata::ProductUnit::EACH),
      Kata::Product.new(name: 'carrot', unit: Kata::ProductUnit::KILO),
      Kata::Product.new(name: 'milk', unit: Kata::ProductUnit::EACH),
      Kata::Product.new(name: 'blueberries', unit: Kata::ProductUnit::KILO)
    ]
    qualifies_for_discount = discounted_bundle_offer.qualifies?(products_purchased)
    assert(true, qualifies_for_discount)
  end
end
