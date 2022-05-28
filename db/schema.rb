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

ActiveRecord::Schema.define(version: 2022_05_28_145519) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "diets", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_diets_on_user_id"
  end

  create_table "groceries_lists", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "plan_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["plan_id"], name: "index_groceries_lists_on_plan_id"
    t.index ["user_id"], name: "index_groceries_lists_on_user_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.bigint "meal_id", null: false
    t.bigint "groceries_list_id", null: false
    t.string "name"
    t.string "quantity"
    t.text "description"
    t.string "unit"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["groceries_list_id"], name: "index_ingredients_on_groceries_list_id"
    t.index ["meal_id"], name: "index_ingredients_on_meal_id"
  end

  create_table "intolerances", force: :cascade do |t|
    t.integer "type"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_intolerances_on_user_id"
  end

  create_table "meals", force: :cascade do |t|
    t.bigint "plan_id", null: false
    t.bigint "recipe_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["plan_id"], name: "index_meals_on_plan_id"
    t.index ["recipe_id"], name: "index_meals_on_recipe_id"
  end

  create_table "plans", force: :cascade do |t|
    t.datetime "start_date"
    t.datetime "final_date"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_plans_on_user_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "title"
    t.text "instructions"
    t.string "prep_time"
    t.integer "servings"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_recipes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "role"
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "diets", "users"
  add_foreign_key "groceries_lists", "plans"
  add_foreign_key "groceries_lists", "users"
  add_foreign_key "ingredients", "groceries_lists"
  add_foreign_key "ingredients", "meals"
  add_foreign_key "intolerances", "users"
  add_foreign_key "meals", "plans"
  add_foreign_key "meals", "recipes"
  add_foreign_key "plans", "users"
  add_foreign_key "recipes", "users"
end
