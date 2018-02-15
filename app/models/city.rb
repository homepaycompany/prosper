class City < ApplicationRecord
  has_many :flats, dependent: :delete_all
  has_many :city_accesses, dependent: :delete_all

  validates_uniqueness_of :name
end
