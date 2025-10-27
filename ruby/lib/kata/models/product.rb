Kata::Product = Data.define(:name, :unit) do

  def self.each(name:)
    new(name: name, unit: Kata::ProductUnit::EACH)
  end

  def self.kilo_of(name:)
    new(name: name, unit: Kata::ProductUnit::KILO)
  end
end
