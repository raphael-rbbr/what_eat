class MyListsController < ApplicationController
  before_action :set_user

  def index
    @user.my_lists
  end

  def show
    set_groceries_list
    @my_list = @grocerie_lists.my_lists
    # authorize @meal
  end

  def new
    @my_list = MyList.new
    authorize @my_list
  end

  def create
    set_groceries_list
    @my_list = MyList.new(my_list_params)
    @my_list.recipe = @recipe
    @my_list.save
    authorize @my_list
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:id, :email, :name)
  end

  def set_groceries_list
    @grocerie_list = GroceriesList.find(params[:id])
  end

  def groceries_list_params
    params.require(:recipe).permit(:id, :title, :instructions, :prep_time, :servings, :recipe_photo)
  end
end
