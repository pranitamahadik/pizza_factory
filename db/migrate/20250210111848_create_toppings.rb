class CreateToppings < ActiveRecord::Migration[7.2]
  def change
    create_table :toppings do |t|
      t.string :name
      t.string :category
      t.integer :price

      t.timestamps
    end
  end
end
