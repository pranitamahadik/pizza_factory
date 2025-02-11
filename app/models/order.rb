class Order < ApplicationRecord
  has_many :order_pizzas, dependent: :destroy
  has_many :order_sides, dependent: :destroy

  accepts_nested_attributes_for :order_pizzas, :order_sides

  validates :status, inclusion: { in: %w[pending confirmed completed] }

  validate :validate_order_business_rules
  validate :check_inventory_availability, on: :create

  before_create :decrement_inventory
  before_update :prevent_order_cancellation
  before_destroy :prevent_order_cancellation

  def validate_order_business_rules
    order_pizzas.each do |op|
      if op.crust.nil?
        errors.add(:base, 'Each pizza must have one crust selected')
      end

      #Vegetarian pizza cannot have non-vegetarian toppings.
      if op.pizza.category == 'veg'
        op.order_pizza_toppings.each do |tpt|
          if tpt.topping.category == 'non-veg'
            errors.add(:base, 'Vegetarian pizza cannot have non-vegetarian toppings')
          end
        end
      end

      #Non-vegetarian pizza cannot have paneer topping and only one non-veg topping is allowed.
      if op.pizza.category == 'non-veg'
        non_veg_toppings = op.order_pizza_toppings.select { |tpt| tpt.topping.category == 'non-veg' }
        if non_veg_toppings.size > 1
          errors.add(:base, 'Only one non-veg topping can be selected per non-veg pizza')
        end
        op.order_pizza_toppings.each do |tpt|
          if tpt.topping.name.downcase == 'paneer'
            errors.add(:base, 'Non-vegetarian pizza cannot have paneer topping')
          end
        end
      end

      #Large size pizzas come with any 2 toppings of customer's choice free.
      if op.size == 'large' && op.order_pizza_toppings.size < 2
        errors.add(:base, 'Large pizzas should include at least 2 toppings (which are free of charge)')
      end
    end
  end

  def total_amount
    total = 0
    order_pizzas.each do |op|
      price = case op.size
              when 'regular'
                op.pizza.price_regular
              when 'medium'
                op.pizza.price_medium
              when 'large'
                op.pizza.price_large
              else
                0
              end
      # For large pizzas, the first 2 toppings are free.
      topping_cost = 0
      if op.size == 'large'
        free_toppings = 2
        op.order_pizza_toppings.each do |tpt|
          if free_toppings.positive?
            free_toppings -= 1
          else
            topping_cost += tpt.topping.price
          end
        end
      else
        op.order_pizza_toppings.each do |tpt|
          topping_cost += tpt.topping.price
        end
      end

      total += price + topping_cost
    end

    order_sides.each do |os|
      total += os.side.price.to_i
    end

    total
  end

  def check_inventory_availability
    total_pizzas = order_pizzas.size
    required_dough = total_pizzas
    required_cheese = total_pizzas

    extra_cheese_count = 0
    order_pizzas.each do |op|
      op.order_pizza_toppings.each do |tpt|
        extra_cheese_count += 1 if tpt.topping.name.downcase == 'extra cheese'
      end
    end
    required_cheese += extra_cheese_count

    dough_inventory = Inventory.find_by(ingredient: 'Dough')
    cheese_inventory = Inventory.find_by(ingredient: 'Cheese')

    if dough_inventory.nil? || dough_inventory.quantity < required_dough
      errors.add(:base, 'Not enough Dough in inventory')
    end

    if cheese_inventory.nil? || cheese_inventory.quantity < required_cheese
      errors.add(:base, 'Not enough Cheese in inventory')
    end
  end

  def decrement_inventory
    total_pizzas = order_pizzas.size
    dough_inventory = Inventory.find_by(ingredient: 'Dough')
    cheese_inventory = Inventory.find_by(ingredient: 'Cheese')
    extra_cheese_count = 0

    order_pizzas.each do |op|
      op.order_pizza_toppings.each do |tpt|
        extra_cheese_count += 1 if tpt.topping.name.downcase == 'extra cheese'
      end
    end

    dough_inventory.update(quantity: dough_inventory.quantity - total_pizzas) if dough_inventory
    cheese_inventory.update(quantity: cheese_inventory.quantity - (total_pizzas + extra_cheese_count)) if cheese_inventory
  end

  def prevent_order_cancellation
    # Allow updates only if the only changed attribute is the status
    # and if it is transitioning from 'pending' to 'confirmed'.
    if persisted? && changed?
      if changed_attributes.keys == ["status", "updated_at"]
        old_status = changed_attributes['status']
        new_status = self.status
        # Allow transition from pending to confirmed or completed
        return if old_status == 'pending' && %w[confirmed completed].include?(new_status)
      end
      errors.add(:base, 'Order cannot be cancelled or modified once placed')
      throw(:abort)
    end
  end
end
