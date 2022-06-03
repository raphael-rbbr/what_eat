class Profile::MealsController < ApplicationController
  before_action :set_user

  def index
    @user.meals
  end

  def new
    @meal = Meal.new
    authorize @meal
  end

  def create
    set_recipe
    @meal = Meal.new(meal_params)
    @meal.recipe = @recipe
    @meal.save
    authorize @meal
  end

  private

  def set_user
    @user = current_user
  end

  def set_plan
    # @user = current_user
  end

  def plan_params
    # params.require(:user).permit(:id, :email, :name)
  end

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:id, :email, :name)
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:id, :title, :instructions, :prep_time, :servings, :recipe_photo)
  end
end
