# frozen_string_literal: true

module Kata
  # Responsible for rendering a text based form of the receipt content.
  class TextBasedReceiptView

    def initialize(columns = 40)
      @columns = columns
    end

    def total_line_in_receipt(receipt)
      price_presentation = format('%.2f', receipt.total_price.to_f)
      number_of_spaces = @columns - 'Total: '.size - price_presentation.size
      whitespace = ' ' * number_of_spaces
      "Total: #{whitespace}#{price_presentation}"
    end

    def discount_line_in_receipt(discount)
      product_name = discount.product.name
      price_presentation = format('%.2f', discount.discount_amount)
      description = discount.description
      number_of_spaces = @columns - 3 - product_name.size - description.size - price_presentation.size
      whitespace = ' ' * number_of_spaces
      description + "(#{product_name})" + whitespace + "-#{price_presentation}"
    end

    def line_item_in_receipt(item)
      total_price = format('%.2f', item.total_price)
      unit_price_text = format('%.2f', item.price)
      number_of_spaces = @columns - item.product.name.size - total_price.size
      whitespace = ' ' * number_of_spaces
      quantity = present_quantity(item)
      line = "#{item.product.name}#{whitespace}#{total_price}\n"
      line += "  #{unit_price_text} * #{quantity}\n" unless item.quantity == 1
      line
    end

    private

    def present_quantity(item)
      item.each? ? format('%x', item.quantity.to_i) : format('%.3f', item.quantity)
    end
  end
end
