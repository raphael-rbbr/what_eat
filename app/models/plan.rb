class Plan < ApplicationRecord
  belongs_to :user
  has_many :meals, dependent: :destroy
  has_one :groceries_list, dependent: :destroy
end
