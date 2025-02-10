# frozen_string_literal: true
# 
module Kata
  class ReceiptPrinter
    def initialize(columns = 40)
      @columns = columns
      @receipt_view = TextBasedReceiptView.new(@columns)
    end

    def print_receipt(receipt)
      result = receipt.items.map { |item| @receipt_view.line_item_in_receipt(item) }.join('')
      receipt.discounts.inject(result) do |line_item, discount|
        line_item << "#{@receipt_view.discount_line_in_receipt(discount)}\n"
      end
      result.concat("\n")
      result << @receipt_view.total_line_in_receipt(receipt)
      result
    end
  end
end
