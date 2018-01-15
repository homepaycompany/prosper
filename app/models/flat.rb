class Flat < ApplicationRecord
  has_many :wishes, dependent: :destroy
end
