class UsersController < ApplicationController
  before_action :set_user

  def show
    authorize @user
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:id, :email, :profile_photo)
  end
end
