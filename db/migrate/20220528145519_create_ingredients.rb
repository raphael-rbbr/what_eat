class CreateIngredients < ActiveRecord::Migration[6.1]
  def change
    create_table :ingredients do |t|
      t.references :meal, null: false, foreign_key: true
      t.references :groceries_list, null: false, foreign_key: true
      t.string :name
      t.string :quantity
      t.text :description
      t.string :unit

      t.timestamps
    end
  end
end
