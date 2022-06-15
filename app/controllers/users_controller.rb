class UsersController < ApplicationController
  before_action :set_user

  def show
    authorize @user
  end

  private

  def set_user
    @user = current_user
    Diet.create(user_id: @user.id, diet_type: 0)
  end

  def user_params
    params.require(:user).permit(:id, :email, :profile_photo, :name, :intolerances_id, :diet_id)
  end
end
