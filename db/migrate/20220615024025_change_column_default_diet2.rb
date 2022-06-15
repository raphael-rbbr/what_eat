class ChangeColumnDefaultDiet2 < ActiveRecord::Migration[6.1]
  def change
    change_column_default :diets, :diet_type, 0
  end
end
