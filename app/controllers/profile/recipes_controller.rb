class Profile::RecipesController < ApplicationController
  before_action :set_user
  # before_action :verify_authorized, except: :create_recipes
  skip_after_action :verify_authorized

  def index
    @recipes = @user.recipes
    # authorize @user
    @recipes = policy_scope(Recipe).order(created_at: :desc)
    authorize @recipes
  end

  def show
    set_recipe

    respond_to do |format|
      format.html
      format.text { render partial: 'profile/recipes/recipe', locals: { recipe: @recipe }, formats: [:html] }
    end
    authorize @recipe
  end

  def new
    @recipe = Recipe.new
    authorize @recipe
  end

  # def create
  #   @recipes = Recipe.create_user_recipes(current_user)
  #   authorize @recipes
  #   authorize current_user

  #   redirect_to profile_plans_path(Plan.last)
  # end

  def create_recipes
    @recipes = Recipe.create_user_recipes(current_user)
    skip_authorization
    # @recipes.save
    # authorize @recipes

    redirect_to profile_plan_path(Plan.last)
  end

  private

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
    params.require(:recipe).permit(:id, :title, :instructions, :prep_time, :servings, :recipe_photo, :position)
  end

end
