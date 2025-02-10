# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_02_10_111957) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "crusts", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inventories", force: :cascade do |t|
    t.string "ingredient"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_pizza_toppings", force: :cascade do |t|
    t.bigint "order_pizza_id", null: false
    t.bigint "topping_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_pizza_id"], name: "index_order_pizza_toppings_on_order_pizza_id"
    t.index ["topping_id"], name: "index_order_pizza_toppings_on_topping_id"
  end

  create_table "order_pizzas", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "pizza_id", null: false
    t.bigint "crust_id", null: false
    t.string "size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["crust_id"], name: "index_order_pizzas_on_crust_id"
    t.index ["order_id"], name: "index_order_pizzas_on_order_id"
    t.index ["pizza_id"], name: "index_order_pizzas_on_pizza_id"
  end

  create_table "order_sides", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "side_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_sides_on_order_id"
    t.index ["side_id"], name: "index_order_sides_on_side_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pizzas", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.integer "price_regular"
    t.integer "price_medium"
    t.integer "price_large"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sides", force: :cascade do |t|
    t.string "name"
    t.string "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "toppings", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "order_pizza_toppings", "order_pizzas"
  add_foreign_key "order_pizza_toppings", "toppings"
  add_foreign_key "order_pizzas", "crusts"
  add_foreign_key "order_pizzas", "orders"
  add_foreign_key "order_pizzas", "pizzas"
  add_foreign_key "order_sides", "orders"
  add_foreign_key "order_sides", "sides"
end
