class City < ApplicationRecord

  has_many :flats, dependent: :destroy

  validates_uniqueness_of :name

end
