class Profile::RecipesController < ApplicationController
  before_action :set_user

  def index
    # @recipes = @user.recipes
    # authorize @user
    # @recipes = policy_scope(Recipe).order(created_at: :desc)
    # authorize @recipes
  end

  def show
    # @recipes = @user.recipes
    # authorize @user
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:id, :email, :name)
  end

end
