class Kata::ReceiptPrinter
  def initialize(columns = 40)
    @columns = columns
  end

  def print_receipt(receipt)
    result = ''
    receipt.items.each do |item|
      quantity = self.class.present_quantity(item)
      result << line_item_in_receipt(item, quantity)
    end
    receipt.discounts.each do |discount|
      product_presentation = discount.product.name
      price_presentation = '%.2f' % discount.discount_amount
      description = discount.description
      result << description
      result << "(#{product_presentation})"
      result << whitespace(@columns - 3 - product_presentation.size - description.size - price_presentation.size)
      result << '-'
      result << price_presentation
      result << "\n"
    end
    result.concat("\n")
    price_presentation = format('%.2f', receipt.total_price.to_f)
    total = 'Total: '
    whitespace = ' ' * (@columns - total.size - price_presentation.size)
    result.concat(total, whitespace, price_presentation)
    result.to_s
  end

  def self.present_quantity(item)
    Kata::ProductUnit::EACH == item.product.unit ? format('%x', item.quantity.to_i) : '%.3f' % item.quantity
  end

  def whitespace(whitespace_size)
    ' ' * whitespace_size
  end

  private

  def line_item_in_receipt(item, quantity)
    total_price = '%.2f' % item.total_price
    unit_price_text = '%.2f' % item.price
    whitespace_size = @columns - item.product.name.size - total_price.size
    whitespace = ' ' * whitespace_size
    line = "#{item.product.name}#{whitespace}#{total_price}\n"
    line += "  #{unit_price_text} * #{quantity}\n" if item.quantity != 1
    line
  end
end
