class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :omniauthable and :registerable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :invitable, :invite_for => 2.weeks

  has_many :wishes, dependent: :destroy
  has_many :city_accesses
  has_many :cities, through: :city_accesses

  def city
    CityAccess.where(user_id: self).last.city
  end
end
