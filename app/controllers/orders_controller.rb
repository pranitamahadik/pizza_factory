class OrdersController < ApplicationController

  def create
    order = Order.new(order_params)
    order.status = 'pending'
    if order.save
      render json: { order: order, total_amount: order.total_amount }, status: :created
    else
      render json: { error: order.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    order = Order.find(params[:id])
    render json: { order: order, total_amount: order.total_amount }
  end

  def update
    order = Order.find(params[:id])
    if order.update(order_update_params)
      render json: { order: order, total_amount: order.total_amount }, status: :ok
    else
      render json: { error: order.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  def order_params
    params.require(:order).permit(
      order_pizzas_attributes: [
        :pizza_id, :crust_id, :size, 
        order_pizza_toppings_attributes: [:topping_id]
      ],
      order_sides_attributes: [
        :side_id
      ]
    )
  end

  def order_update_params
    params.require(:order).permit(:status)
  end
end
