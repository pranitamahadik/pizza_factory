class PizzasController < ApplicationController

	def index
		pizzas = Pizza.all
		render json: pizzas, status: :ok
	end

	def create
		pizza = Pizza.new(pizza_params)
		if pizza.save
      render json: pizza, status: :created
    else
      render json: { error: pizza.errors.full_messages }, status: :unprocessable_entity
    end
	end

	private
	def pizza_params
		params.require(:pizza).permit(:name, :category, :price_regular, :price_medium, :price_large)	
	end
end
