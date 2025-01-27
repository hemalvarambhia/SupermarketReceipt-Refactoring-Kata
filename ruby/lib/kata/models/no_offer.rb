# frozen_string_literal: true

module Kata
  class NoOffer
    def qualifies?(type, quantity)
      true
    end

    def discount(unit_price, quality)
      nil
    end
  end
end
