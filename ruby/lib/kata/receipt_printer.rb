# frozen_string_literal: true
# 
module Kata
  class ReceiptPrinter
    def initialize(columns = 40)
      @columns = columns
    end

    def print_receipt(receipt)
      result = receipt.items.map { |item| line_item_in_receipt(item) }.join('')
      receipt.discounts.inject(result) do |line_item, discount|
        line_item << "#{discount_line_in_receipt(discount)}\n"
      end
      result.concat("\n")
      result << total_line_in_receipt(receipt)
      result
    end

    private

    def total_line_in_receipt(receipt)
      TextBasedReceiptView.new(@columns).total_line_in_receipt(receipt)
    end

    def discount_line_in_receipt(discount)
      TextBasedReceiptView.new(@columns).discount_line_in_receipt(discount)
    end

    def line_item_in_receipt(item)
      TextBasedReceiptView.new(@columns).line_item_in_receipt(item)
    end
  end
end
