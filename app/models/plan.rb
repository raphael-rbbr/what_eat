class Plan < ApplicationRecord
  belongs_to :user
  has_many :meals
  has_one :groceries_list
end
