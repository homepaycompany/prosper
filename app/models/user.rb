class User < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :invitable, :invite_for => 2.weeks

  has_many :wishes, dependent: :delete_all
  has_many :city_accesses, dependent: :delete_all
  has_many :cities, through: :city_accesses
  has_many :visits, dependent: :delete_all

  def city
    CityAccess.where(user_id: self).last.city
  end
end
