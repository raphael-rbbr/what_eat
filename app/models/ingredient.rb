class Ingredient < ApplicationRecord
  belongs_to :meal
  belongs_to :groceries_list
end
