class Diet < ApplicationRecord
  belongs_to :user

  enum type: {
    no_diet: 0,
    pescetarian: 1,
    lacto_vegetarian: 2,
    ovo_vegetarian: 3,
    vegan: 4,
    paleo: 5,
    primal: 6,
    vegetarian: 7
  }

end
