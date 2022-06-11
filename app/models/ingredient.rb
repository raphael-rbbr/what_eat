class Ingredient < ApplicationRecord
  belongs_to :meal
  belongs_to :recipe
  belongs_to :groceries_list
end
