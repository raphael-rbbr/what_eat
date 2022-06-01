class Profile::MealsController < ApplicationController
  before_action :set_recipe

  def new

  end

  def create

  end

  # change this later from recipes to meals
  def index
    @recipes = @user.recipes
  end

  private

  def set_plan
    # @user = current_user
  end

  def plan_params
    # params.require(:user).permit(:id, :email, :name)
  end

  def set_recipe
    @user = current_user
  end

  def recipe_params
    params.require(:user).permit(:id, :email, :name, :meal_photo)
  end
end
