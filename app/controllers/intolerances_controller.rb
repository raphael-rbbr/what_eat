class IntolerancesController < ApplicationController
  before_action :set_intolerances
  after_action :verify_authorized, except: :create

  def new
    # @intolerances = Intolerance.find(params[:id])
    @intolerances = Intolerance.new
    authorize @intolerances
  end

  def create
    # @intolerances = Intolerance.find(params[:id])
    current_user.intolerances&.destroy_all
    intolerances_id = params["intolerance"]["intolerances"].map do |i|
      next if i==""
      i.to_i
    end
    @intolerances = []
    intolerances_id.each do |i|
      next if i.nil?
      @intolerances << Intolerance.create!(user_id: current_user.id, intolerance_type: i)
    end
    redirect_to profile_path(current_user)
  end

  private

  def set_intolerances
    @intolerances = current_user.intolerances
  end

  def intolerance_params
    params.require(:intolerances).permit(:intolerance_type)
  end
end
