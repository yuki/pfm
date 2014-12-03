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

ActiveRecord::Schema.define(version: 20141201152332) do

  create_table "accounts", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "currency"
    t.boolean  "is_disabled"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "amount"
  end

  create_table "movements", force: true do |t|
    t.integer  "account_id"
    t.integer  "mtype_id"
    t.string   "name"
    t.text     "description"
    t.decimal  "amount"
    t.datetime "mdate"
    t.datetime "vdate"
    t.decimal  "account_amount"
    t.boolean  "is_transfer"
    t.integer  "movement_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "movements", ["account_id"], name: "index_movements_on_account_id"
  add_index "movements", ["mtype_id"], name: "index_movements_on_mtype_id"

  create_table "mtypes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
