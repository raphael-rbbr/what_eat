class Profile::GroceriesListsController < ApplicationController
  before_action :set_user

  def show
    # @groceries_lists = @user.groceries_lists
    # authorize @user
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:id, :email, :name)
  end

  def set_meals
    @meals = @user.meals
  end

  def set_recipes
    @recipes = @meals.each do |meal|
      meal.recipes
    end
  end

  def set_ingredients
    @ingredients = @recipes.each do |recipe|
      recipe.ingredients
    end
  end

end
