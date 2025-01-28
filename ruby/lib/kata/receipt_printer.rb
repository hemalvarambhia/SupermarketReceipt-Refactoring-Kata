class Kata::ReceiptPrinter
  def initialize(columns = 40)
    @columns = columns
  end

  def print_receipt(receipt)
    result = receipt.items.inject('') do |line_item, item|
      line_item << line_item_in_receipt(item)
    end
    receipt.discounts.inject(result) do |line_item, discount|
      line_item << "#{discount_line_in_receipt(discount)}\n"
    end
    result.concat("\n")
    price_presentation = format('%.2f', receipt.total_price.to_f)
    total = 'Total: '
    whitespace = ' ' * (@columns - total.size - price_presentation.size)
    result.concat(total, whitespace, price_presentation)
    result.to_s
  end

  private

  def discount_line_in_receipt(discount)
    product_presentation = discount.product.name
    price_presentation = '%.2f' % discount.discount_amount
    description = discount.description
    whitespace_size = @columns - 3 - product_presentation.size - description.size - price_presentation.size
    description + "(#{product_presentation})" + whitespace(whitespace_size) + "-#{price_presentation}"
  end

  def line_item_in_receipt(item)
    total_price = '%.2f' % item.total_price
    unit_price_text = '%.2f' % item.price
    whitespace_size = @columns - item.product.name.size - total_price.size
    whitespace = ' ' * whitespace_size
    quantity = present_quantity(item)
    line = "#{item.product.name}#{whitespace}#{total_price}\n"
    line += "  #{unit_price_text} * #{quantity}\n" if item.quantity != 1
    line
  end

  def present_quantity(item)
    item.each? ? format('%x', item.quantity.to_i) : '%.3f' % item.quantity
  end

  def whitespace(whitespace_size)
    ' ' * whitespace_size
  end
end
