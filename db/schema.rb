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

ActiveRecord::Schema.define(version: 2018_11_22_075516) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "deals", force: :cascade do |t|
    t.date "depart_date"
    t.date "return_date"
    t.string "origin"
    t.string "destination"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "unique_deal", default: ""
    t.integer "discount_abs"
    t.integer "discount_perc"
    t.string "wday_duration"
    t.jsonb "historical", default: "[]"
  end

  create_table "preferences", force: :cascade do |t|
    t.string "destination"
    t.integer "discount_perc"
    t.integer "duration"
    t.boolean "monday", default: true
    t.boolean "tuesday", default: true
    t.boolean "wednesday", default: true
    t.boolean "thursday", default: true
    t.boolean "friday", default: true
    t.boolean "saturday", default: true
    t.boolean "sunday", default: true
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_preferences_on_user_id"
  end

  create_table "quotes", force: :cascade do |t|
    t.date "depart_date"
    t.string "origin"
    t.string "destination"
    t.integer "min_price"
    t.boolean "direct"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "unique_flight", default: ""
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "preferences", "users"
end
