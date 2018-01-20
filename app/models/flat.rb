class Flat < ApplicationRecord
  has_many :wishes, dependent: :destroy
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  def in_wishlist?(user)
    Wish.all.where(flat: self, user: user).count >= 1
  end

  def photo
    if self.image_url.nil?
      ActionController::Base.new.view_context.asset_path("default_flat.png")
    else
      self.image_url
    end
  end

  def price_per_squared_meter
    self.price / self.size
  end

  def return_rate
    @selling_price = (self.size.to_f * self.average_price.to_f)
    @notarial_costs = (0.025 * @selling_price)
    @interests = (self.size.to_f * 0.025 * 1)
    @margin = @selling_price - self.price - @notarial_costs - @interests
    return (@margin.to_f / self.price)
  end
end
