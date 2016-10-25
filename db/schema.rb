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

ActiveRecord::Schema.define(version: 20141204191311) do

  create_table "accounts", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.decimal  "amount"
    t.string   "currency"
    t.boolean  "is_disabled"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "movements", force: :cascade do |t|
    t.integer  "account_id"
    t.integer  "mtype_id"
    t.string   "name"
    t.text     "description"
    t.decimal  "amount",         default: "0.0"
    t.datetime "mdate"
    t.decimal  "account_amount"
    t.boolean  "is_transfer"
    t.integer  "movement_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["account_id"], name: "index_movements_on_account_id"
    t.index ["mtype_id"], name: "index_movements_on_mtype_id"
  end

  create_table "mtypes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
