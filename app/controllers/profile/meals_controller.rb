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
    # set_recipe
    # @meal = Meal.new(meal_params)
    @meal = Meal.new
    @meal.recipe = @recipe
    @meal.save
    authorize @meal
  end

  def move
    @meal.insert_at(params[:position].to_i)
    head :ok
  end

  private

  def set_user
    @user = current_user
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:id, :title, :instructions, :prep_time, :servings, :recipe_photo, :position)
  end
end
