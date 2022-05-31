class Meal < ApplicationRecord
  belongs_to :plan
  belongs_to :recipe
  has_many :ingredients
end
