class Flat < ApplicationRecord
  has_many :wishes, dependent: :destroy

  def in_wishlist?
    Wish.all.where(flat: self).count >= 1
  end

  def photo
    if self.image_url.nil?
      ActionController::Base.new.view_context.asset_path("default_flat.png")
    else
      self.image_url
    end
  end
end
