# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Pizzas
Pizza.create(name: 'Deluxe Veggie', category: 'veg', price_regular: 150, price_medium: 200, price_large: 325)
Pizza.create(name: 'Cheese and Corn', category: 'veg', price_regular: 175, price_medium: 375, price_large: 475)
Pizza.create(name: 'Paneer Tikka', category: 'veg', price_regular: 160, price_medium: 290, price_large: 340)
Pizza.create(name: 'Non-Veg Supreme', category: 'non-veg', price_regular: 190, price_medium: 325, price_large: 425)
Pizza.create(name: 'Chicken Tikka', category: 'non-veg', price_regular: 210, price_medium: 370, price_large: 500)
Pizza.create(name: 'Pepper Barbecue Chicken', category: 'non-veg', price_regular: 220, price_medium: 380, price_large: 525)

# Toppings (Veg & Non-Veg)
Topping.create(name: 'Black Olive', category: 'veg', price: 20)
Topping.create(name: 'Capsicum', category: 'veg', price: 25)
Topping.create(name: 'Paneer', category: 'veg', price: 35)
Topping.create(name: 'Mushroom', category: 'veg', price: 30)
Topping.create(name: 'Fresh Tomato', category: 'veg', price: 10)
Topping.create(name: 'Chicken Tikka', category: 'non-veg', price: 35)
Topping.create(name: 'Barbeque Chicken', category: 'non-veg', price: 45)
Topping.create(name: 'Grilled Chicken', category: 'non-veg', price: 40)
Topping.create(name: 'Extra Cheese', category: 'veg', price: 35)

# Crust types
Crust.create(name: 'New hand tossed')
Crust.create(name: 'Wheat thin crust')
Crust.create(name: 'Cheese Burst')
Crust.create(name: 'Fresh pan pizza')

# Sides
Side.create(name: 'Cold drink', price: 55)
Side.create(name: 'Mousse cake', price: 90)

# Inventory (ingredients)
Inventory.create(ingredient: 'Cheese', quantity: 100)
Inventory.create(ingredient: 'Dough', quantity: 200)