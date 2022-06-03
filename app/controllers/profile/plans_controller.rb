class Profile::PlansController < ApplicationController
  efore_action :set_user
  # before_action :set_recipe

  def index
    @plan = Plan.where(:start_date < Date.now < :final_date)
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

  # change this later from recipes to meals
  # def index
  #   @recipes = @user.recipes
  # end

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

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:id, :title, :instructions, :prep_time, :servings, :meal_photo)
  end
end
