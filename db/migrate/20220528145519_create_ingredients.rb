class CreateIngredients < ActiveRecord::Migration[6.1]
  def change
    create_table :ingredients do |t|
      t.references :recipe, null: false, foreign_key: true
      t.references :groceries_list, null: false, foreign_key: true
      t.string :quantity
      t.text :description

      t.timestamps
    end
  end
end
