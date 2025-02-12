class ToppingsController < ApplicationController
  def create
    topping = Topping.new(topping_params)
    if topping.save
      render json: topping, status: :created
    else
      render json: { error: topping.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  def topping_params
    params.require(:topping).permit(:name, :category, :price)  
  end
end
