class Profile::GroceriesListsController < ApplicationController
  before_action :set_user, :set_groceries_list
  after_action :verify_authorized, except: :show

  def new
    @groceries_list = GroceriesList.new
    authorize @groceries_list
  end

  def create
    user = current_user
    plan = user.plans.first
    @groceries_list = GroceriesList.new(user: user, plan: plan)
    @groceries_list.save
    authorize @groceries_list
  end

  def show
    @ingredients_all = []
    @ingredients = {}

    @user.meals.each do |meal|
      @ingredients_all << meal.recipe.ingredients
    end

    @ingredients_all.each do |ingredients|
      ingredients.each do |ingredient|
        @ingredients.store(ingredient.name, ingredient.quantity)
      end
    end
    @ingredient_sum = Hash[@ingredients.sort]

    # @ingredients_all = []
    # @ingredients = {}
    # @meals = @user.meals
    # @meals.each do |meal|
    #   @ingredients_all << meal.ingredients
    # end


  end

  private

  def set_groceries_list
    if @user.groceries_lists == nil
      self.create
    else
      @groceries_list = @user.groceries_lists
    end
  end

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
    @recipes = []
    @recipes = @meals.each do |meal|
      @recipes << meal.recipes
    end
  end

  def set_ingredients
    @ingredients = @recipes.each do |recipe|
      recipe.ingredients
    end
  end
end
