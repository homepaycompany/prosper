class Wish < ApplicationRecord
  belongs_to :user

  def flat(flats)
    flats.select { |flat| flat["url"] == self.flat_url }.first
  end
end
