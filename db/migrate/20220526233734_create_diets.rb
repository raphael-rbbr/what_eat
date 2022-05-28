class CreateDiets < ActiveRecord::Migration[6.1]
  def change
    create_table :diets do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :diet_type

      t.timestamps
    end
  end
end
