class Ingredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :groceries_list
end
