class Recipe < ApplicationRecord
  belongs_to :user
  has_many :meals
  has_one_attached :meal_photo
end
