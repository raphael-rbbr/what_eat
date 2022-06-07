class Profile::GroceriesListsController < ApplicationController
  before_action :set_user

  def show
    @ingredients_all = []
    @ingredients = {}
    @meals = @user.meals
    @meals.each do |meal|
      @ingredients_all << meal.ingredients
    end
    @ingredients_all.each do |ingredients|
      ingredients.each do |ingredient|
        @ingredients.store(ingredient.name, ingredient.quantity)
      end
    end
    @ingredient_sum = Hash[@ingredients.sort]
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
