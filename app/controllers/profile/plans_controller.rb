class Profile::PlansController < ApplicationController
  before_action :set_user
  # before_action :set_recipe

  def index
    @user.plans
    # @plan = Plan.where(:start_date < Date.now < :final_date)
  end

  def new
    @meal = Meal.new
    authorize @meal
  end

  def show
    set_plan
    @plan_id = params[:id]
    @recipes = current_user.recipes
  end

  def create
    set_recipe
    @meal = Meal.new(meal_params)
    @meal.recipe = @recipe
    @meal.save
    authorize @meal
  end

  # def current_plan
  #   @user = current_user
  #   @plan = @user.plans.where(:start_date < Date.now < :final_date)
  # end

  private

  def set_user
    @user = current_user
  end

  def set_plan
    @plan = Plan.find(params[:id])
  end

  def plan_params
    params.require(:plan).permit(:id, :email, :name)
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:id, :title, :instructions, :prep_time, :servings, :meal_photo)
  end
end
