# frozen_string_literal: true

module Kata
  class NoOffer
    def qualifies?(_quantity)
      true
    end

    def discount(_unit_price, _quantity)
      nil
    end
  end
end
