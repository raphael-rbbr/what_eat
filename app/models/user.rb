class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :plans, dependent: :destroy
  has_many :meals, through: :plans
  has_many :intolerances
  has_many :groceries_lists
  has_many :recipes, dependent: :destroy
  has_one :diet
  has_one_attached :profile_photo
end
