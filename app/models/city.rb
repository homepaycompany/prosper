class City < ApplicationRecord
  has_many :flats, dependent: :destroy
  has_many :city_accesses, dependent: :destroy

  validates_uniqueness_of :name
end
