class Profile::GroceriesListsController < ApplicationController
  before_action :set_user

  def show
    # @groceries_lists = @user.groceries_lists
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
