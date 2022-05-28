class Intolerance < ApplicationRecord
  belongs_to :user

  enum type: {
    dairy: 0,
    egg: 1,
    gluten: 2,
    peanut: 3,
    sesame: 4,
    seafood: 5,
    shellfish: 6,
    soy: 7,
    sulfite: 8,
    tree_nut: 9,
    wheat: 10
  }
end
