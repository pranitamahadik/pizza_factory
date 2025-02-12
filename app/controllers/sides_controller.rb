class SidesController < ApplicationController
  def create
    side = Side.new(side_params)
    if side.save
      render json: side, status: :created
    else
      render json: { error: side.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  def side_params
    params.require(:side).permit(:name, :price)  
  end
end
