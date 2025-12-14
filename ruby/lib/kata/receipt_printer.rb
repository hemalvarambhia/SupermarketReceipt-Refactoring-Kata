# frozen_string_literal: true

module Kata
  class ReceiptPrinter
    def initialize(columns = 40, receipt_view = TextBasedReceiptView.new(columns))
      @receipt_view = receipt_view
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
      @receipt_view.total_line_in_receipt(receipt)
    end

    def discount_line_in_receipt(discount)
      @receipt_view.discount_line_in_receipt(discount)
    end

    def line_item_in_receipt(item)
      @receipt_view.line_item_in_receipt(item)
    end
  end
end
