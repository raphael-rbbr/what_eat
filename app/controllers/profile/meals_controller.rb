class Profile::MealsController < ApplicationController
  before_action :set_user

  def index
    @user.meals
  end

  def show
    set_recipe
    @meal = @recipe.meals
    # authorize @meal
  end

  def new
    @meal = Meal.new
    authorize @meal
  end

  def create
    permitted_params = params.permit(:recipe_id, :position, :plan_id, :meal)
    recipe = Recipe.find(permitted_params[:recipe_id])
    plan = Plan.find(permitted_params[:plan_id])
    position = permitted_params[:position]
    @meal = Meal.new(plan: plan, recipe: recipe, position: position)
    @meal.save
    # authorize @meal
  end

  def move
    @meal.insert_at(params[:position].to_i)
    head :ok
  end

  def destroy
    set_meal
    @plan = @meal.plan
    @meal.destroy
    redirect_to "/profile/plans/#{@plan.id}"
  end

  private

  def set_user
    @user = current_user
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def set_meal
    @meal = Meal.find(params[:id])
    authorize @meal
  end

  def recipe_params
    params.require(:recipe).permit(:id, :title, :instructions, :prep_time, :servings, :recipe_photo, :position)
  end
end
