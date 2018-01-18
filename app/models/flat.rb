class Flat < ApplicationRecord
  has_many :wishes, dependent: :destroy

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
end
