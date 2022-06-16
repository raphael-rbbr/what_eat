class CreateMyListToBuys < ActiveRecord::Migration[6.1]
  def change
    create_table :my_list_to_buys do |t|
      t.references :user, null: false, foreign_key: true
      t.references :plan, null: false, foreign_key: true
      t.references :groceries_lists, null: false, foreign_key: true

      t.timestamps
    end
  end
end
