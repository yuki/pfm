# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_04_000730) do

  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.decimal "amount"
    t.string "currency"
    t.boolean "is_disabled", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "movements", force: :cascade do |t|
    t.integer "account_id"
    t.integer "mtype_id"
    t.string "name"
    t.text "description"
    t.decimal "amount", default: "0.0"
    t.datetime "mdate"
    t.decimal "account_amount"
    t.boolean "is_transfer"
    t.integer "movement_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["account_id"], name: "index_movements_on_account_id"
    t.index ["mtype_id"], name: "index_movements_on_mtype_id"
  end

  create_table "mtypes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
