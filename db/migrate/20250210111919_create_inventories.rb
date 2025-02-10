class CreateInventories < ActiveRecord::Migration[7.2]
  def change
    create_table :inventories do |t|
      t.string :ingredient
      t.integer :quantity

      t.timestamps
    end
  end
end
