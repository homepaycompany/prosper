class Project < ApplicationRecord
  has_many :positions, dependent: :destroy
end
