class UsersController < ApplicationController
  before_action :set_user

  def show
    @my_meals = @user.meals
    @groceries_lists = @user.groceries_lists
    authorize @user
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:id, :email, :name)
  end
end
