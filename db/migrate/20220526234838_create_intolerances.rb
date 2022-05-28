class CreateIntolerances < ActiveRecord::Migration[6.1]
  def change
    create_table :intolerances do |t|
      t.integer :type
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
