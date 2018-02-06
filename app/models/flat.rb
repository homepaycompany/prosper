class Flat < ApplicationRecord

  belongs_to :city

  def return_rate
    @selling_price = (self.size.to_f * self.average_price.to_f)
    @notarial_costs = (0.025 * @selling_price)
    @interests = (self.size.to_f * 0.025 * 1)
    @margin = @selling_price - self.price - @notarial_costs - @interests
    return (@margin.to_f / self.price)
  end
end
