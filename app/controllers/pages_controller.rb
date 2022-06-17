class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def show
    authorize @user
  end

  def profile
    @plans = current_user.plans
    @recipes = current_user.recipes
    @intolerances = Intolerance.new
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:id, :email, :name)
  end

end
