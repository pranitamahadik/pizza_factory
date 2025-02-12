require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  before do
    FactoryBot.create(:dough_inventory)
    FactoryBot.create(:cheese_inventory)
  end

  let!(:veg_pizza) do
    FactoryBot.create(:pizza,
                      name: 'Deluxe Veggie',
                      category: 'veg',
                      price_regular: 150,
                      price_medium: 200,
                      price_large: 325)
  end
  let!(:crust)      { FactoryBot.create(:crust) }
  let!(:veg_topping){ FactoryBot.create(:topping, name: 'Black Olive', category: 'veg', price: 20) }
  let!(:side)       { FactoryBot.create(:side, name: 'Cold drink', price: 55) }

  describe 'POST #create' do
    context 'with valid parameters' do

      let(:valid_params) do
        {
          order: {
            order_pizzas_attributes: [
              {
                pizza_id: veg_pizza.id,
                crust_id: crust.id,
                size: 'regular',
                order_pizza_toppings_attributes: [
                  { topping_id: veg_topping.id }
                ]
              }
            ],
            order_sides_attributes: [
              { side_id: side.id }
            ]
          }
        }
      end

      it 'creates a new order' do
        expect {
          post :create, params: valid_params, format: :json
        }.to change(Order, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        non_veg_topping = FactoryBot.create(:topping, :non_veg, name: 'Chicken Tikka', price: 35)
        {
          order: {
            order_pizzas_attributes: [
              {
                pizza_id: veg_pizza.id,
                crust_id: crust.id,
                size: 'regular',
                order_pizza_toppings_attributes: [
                  { topping_id: non_veg_topping.id }
                ]
              }
            ]
          }
        }
      end

      it 'does not create order and returns errors' do
        expect {
          post :create, params: invalid_params, format: :json
        }.to_not change(Order, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET #show' do
    let!(:order) do
      Order.create!(
        status: 'pending',
        order_pizzas_attributes: [
          {
            pizza_id: veg_pizza.id,
            crust_id: crust.id,
            size: 'regular',
            order_pizza_toppings_attributes: [{ topping_id: veg_topping.id }]
          }
        ]
      )
    end

    it 'returns the order details' do
      get :show, params: { id: order.id }, format: :json
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['order']['id']).to eq(order.id)
    end
  end

  describe 'PATCH #update' do
    let!(:order) do
      Order.create!(
        status: 'pending',
        order_pizzas_attributes: [
          {
            pizza_id: veg_pizza.id,
            crust_id: crust.id,
            size: 'regular',
            order_pizza_toppings_attributes: [{ topping_id: veg_topping.id }]
          }
        ]
      )
    end

    context 'with valid status update' do
      it 'updates the order status to confirmed' do
        patch :update, params: { id: order.id, order: { status: 'confirmed' } }, format: :json
        expect(response).to have_http_status(:ok)
        order.reload
        expect(order.status).to eq('confirmed')
      end
    end

    context 'with invalid status update (with extra modifications)' do
      it 'does not update the order' do
        patch :update, params: { id: order.id, order: { status: 'confirme'} }, format: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
