class MyList < ApplicationRecord
  belongs_to :user
  belongs_to :plan
  has_many :grocerie_lists
end
