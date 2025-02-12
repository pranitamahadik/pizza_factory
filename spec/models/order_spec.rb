require 'rails_helper'
RSpec.describe Order, type: :model do

  describe 'validation on business rules' do
    before do
      inventory1 = FactoryBot.create(:dough_inventory)
      inventory2 = FactoryBot.create(:cheese_inventory)
      @veg_pizza = FactoryBot.create(:pizza, name: 'Deluxe Veggie', category: 'veg', price_regular: 150,price_medium: 200, price_large: 325)
      @non_veg_pizza = FactoryBot.create(:pizza, :non_veg, name: 'Non-Veg Supreme', price_regular: 190, price_medium: 325, price_large: 425)
      @crust = FactoryBot.create(:crust)
      @veg_topping = FactoryBot.create(:topping, name: 'Black Olive', category: 'veg', price: 20)
      @non_veg_topping = FactoryBot.create(:topping, :non_veg, name: 'Chicken Tikka', price: 35)
      @paneer_topping = FactoryBot.create(:topping, :paneer)
      @extra_cheese = FactoryBot.create(:topping, :extra_cheese)
      @side = FactoryBot.create(:side, name: 'Cold drink', price: 55)
    end
    

    it 'is valid with a valid veg pizza order' do
      order = Order.new(status: "pending")
      order.order_pizzas.build(
        pizza: @veg_pizza,
        crust: @crust,
        size: 'regular',
        order_pizza_toppings_attributes: [{ topping_id: @veg_topping.id }]
      )
      order.order_sides.build(side: @side)
      expect(order).to be_valid
    end

    it 'is invalid when a veg pizza has a non-veg topping' do
      order = Order.new(status: "pending")
      order.order_pizzas.build(
        pizza: @veg_pizza,
        crust: @crust,
        size: 'regular',
        order_pizza_toppings_attributes: [{ topping_id: @non_veg_topping.id }]
      )
      expect(order).to_not be_valid
      expect(order.errors.full_messages).to include('Vegetarian pizza cannot have non-vegetarian toppings')
    end

    it 'is invalid when a non-veg pizza includes paneer topping' do
      order = Order.new(status: "pending")
      order.order_pizzas.build(
        pizza: @non_veg_pizza,
        crust: @crust,
        size: 'regular',
        order_pizza_toppings_attributes: [{ topping_id: @paneer_topping.id }]
      )
      expect(order).to_not be_valid
      expect(order.errors.full_messages).to include('Non-vegetarian pizza cannot have paneer topping')
    end

    it 'is invalid when a non-veg pizza has more than one non-veg topping' do
      order = Order.new(status: "pending")
      order.order_pizzas.build(
        pizza: @non_veg_pizza,
        crust: @crust,
        size: 'regular',
        order_pizza_toppings_attributes: [
          { topping_id: @non_veg_topping.id },
          { topping_id: @non_veg_topping.id } # Duplicate non-veg topping
        ]
      )
      expect(order).to_not be_valid
      expect(order.errors.full_messages).to include('Only one non-veg topping can be selected per non-veg pizza')
    end
  end

  describe '#total_amount' do
    it 'should return total amount value of order pizza' do
      inventory1 = FactoryBot.create(:dough_inventory)
      inventory2 = FactoryBot.create(:cheese_inventory)
      veg_pizza = FactoryBot.create(:pizza, name: 'Deluxe Veggie', category: 'veg', price_regular: 150,price_medium: 200, price_large: 325)
      crust = FactoryBot.create(:crust)
      veg_topping = FactoryBot.create(:topping, name: 'Black Olive', category: 'veg', price: 20)
    
      order = Order.new(status: "pending")
      order.order_pizzas.build(
        pizza: veg_pizza,
        crust: crust,
        size: 'regular',
        order_pizza_toppings_attributes: [{ topping_id: veg_topping.id }]
      )
      order.save!

      expect(order.total_amount).to eq(170)
    end
  end
end
