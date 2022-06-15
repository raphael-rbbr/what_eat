class IntolerancesController < ApplicationController
  before_action :set_intolerances

  def edit
    @intolerances = Intolerance.find(params[:id])
    authorize @intolerances
  end

  def update
    @intolerances = Intolerance.find(params[:id])
    if @intolerances.update(intolerance_type: intolerance_params[:intolerance_type].to_i)
      authorize @intolerances
      redirect_to profile_path(current_user)
    end
  end

  private

  def set_intolerances
    @intolerances = current_user.intolerances
  end

  def intolerance_params
    params.require(:intolerances).permit(:intolerance_type)
  end
end
