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

ActiveRecord::Schema.define(version: 2021_08_29_013027) do

  create_table "credit_card_statements", force: :cascade do |t|
    t.text "content", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "credit_card_statement_id", null: false
    t.date "date", null: false
    t.string "description", null: false
    t.decimal "debit"
    t.decimal "credit"
    t.decimal "balance", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "vendor_id"
    t.index ["credit_card_statement_id"], name: "index_transactions_on_credit_card_statement_id"
    t.index ["vendor_id"], name: "index_transactions_on_vendor_id"
  end

  create_table "vendors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "transactions", "credit_card_statements"
  add_foreign_key "transactions", "vendors"
end
