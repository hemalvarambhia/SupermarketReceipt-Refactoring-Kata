Kata::ReceiptItem = Struct.new(:product, :quantity, :price, :total_price) do
  undef :product=, :quantity=, :price=, :total_price=

  def each?
    self.product.unit == Kata::ProductUnit::EACH
  end
end
