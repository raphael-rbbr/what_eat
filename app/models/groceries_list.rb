class GroceriesList < ApplicationRecord
  belongs_to :user
  belongs_to :plan
  has_many :ingredients, dependent: :destroy
end
