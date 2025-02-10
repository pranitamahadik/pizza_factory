class CreatePizzas < ActiveRecord::Migration[7.2]
  def change
    create_table :pizzas do |t|
      t.string :name
      t.string :category
      t.integer :price_regular
      t.integer :price_medium
      t.integer :price_large

      t.timestamps
    end
  end
end
