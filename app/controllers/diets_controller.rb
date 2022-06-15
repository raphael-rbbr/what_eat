class DietsController < ApplicationController
  before_action :set_diet

  def edit
    @diet = Diet.find(params[:id])
    authorize @diet
  end

  def new
    @diet = Diet.new
    authorize @diet
  end

  def create
    @user_id = current_user.id
    @diet = Diet.new(user_id: @user_id)
    @diet.save
    authorize @diet
    redirect_to profile_path
  end

  def update
    @diet = Diet.find(params[:id])
    if @diet.update(diet_type: diet_params[:diet_type].to_i)
      authorize @diet
      redirect_to profile_path(current_user)
    end
  end

  private

  def set_diet
    @diet = current_user.diet
  end

  def diet_params
    params.require(:diet).permit(:diet_type)
  end
end
