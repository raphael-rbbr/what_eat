class Meal < ApplicationRecord
  belongs_to :plan
  has_many :ingredients
end
