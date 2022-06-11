class Profile::PlansController < ApplicationController
  before_action :set_user
  # before_action :set_recipe

  def index
    @user.plans
    # @plan = Plan.where(:start_date < Date.now < :final_date)
  end

  def show
    set_plan
    @plan_id = params[:id]
    @recipes = current_user.recipes
  end

  def new
    @plan = Plan.new
    authorize @plan
  end

  def create
    @start_date = :start_date
    @final_date = :final_date
    @user_id = current_user.id
    @plan = Plan.new(start_date: @start_date, final_date: @final_date, user_id: @user_id)
    @plan.save
    redirect_to plans_path
  end

  def self.current_plan
    @plan = current_user.plans.where(Date.now > :start_date && Date.now < :final_date)
  end

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
