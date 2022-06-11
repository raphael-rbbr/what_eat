class AddPositionToMeal < ActiveRecord::Migration[6.1]
  def change
    add_column :meals, :position, :integer
  #   Plan.all.each do |plan|
  #     plan.meals.order(:updated_at).each.with_index(1) do |meal, index|
  #       meal.update_column :position, index
  #     end
  #   end
  end
end
