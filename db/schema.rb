# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160517183059) do

  create_table "favourites", force: :cascade do |t|
    t.integer  "favourited_id"
    t.string   "favourited_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favourites", ["favourited_type", "favourited_id"], name: "index_favourites_on_favourited_type_and_favourited_id"
  add_index "favourites", ["user_id"], name: "index_favourites_on_user_id"

  create_table "recipes", force: :cascade do |t|
    t.text     "name",               null: false
    t.text     "author"
    t.text     "image"
    t.text     "ingredients"
    t.text     "recipeYield"
    t.text     "recipeCuisine"
    t.text     "recipeCategory"
    t.text     "prepTime"
    t.text     "cookTime"
    t.text     "totalTime"
    t.text     "recipeInstructions"
    t.text     "url"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
