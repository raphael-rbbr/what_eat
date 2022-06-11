class Meal < ApplicationRecord
  belongs_to :plan
  # acts_as_list scope: :plan

  belongs_to :recipe
  has_many :ingredients

end
