class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :omniauthable and :registerable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :invitable, :invite_for => 2.weeks

  has_many :positions, dependent: :destroy
end
