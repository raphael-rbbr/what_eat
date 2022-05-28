class Profile::MealsController < ApplicationController
  before_action :set_user

  def index
    # @meals = @user.meals
    # authorize @user
    # @meals = policy_scope(Meal).order(created_at: :desc)
    # authorize @meals
  end

  def show
    # @meals = @user.meals
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
