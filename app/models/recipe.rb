class Recipe < ApplicationRecord
  belongs_to :user
  has_many :meals
  has_one_attached :recipe_photo
  has_many :ingredients
end
