class ChangeColumnDefaultDiet < ActiveRecord::Migration[6.1]
  def change
    change_column_default :diets, :diet_type, to: 0
  end
end
