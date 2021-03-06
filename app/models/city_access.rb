class CityAccess < ApplicationRecord
  belongs_to :city
  belongs_to :user
  has_many :city_accesses, dependent: :delete_all
end
