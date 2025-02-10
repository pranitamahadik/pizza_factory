class CreateOrderPizzaToppings < ActiveRecord::Migration[7.2]
  def change
    create_table :order_pizza_toppings do |t|
      t.references :order_pizza, null: false, foreign_key: true
      t.references :topping, null: false, foreign_key: true

      t.timestamps
    end
  end
end
