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

ActiveRecord::Schema[7.0].define(version: 2023_12_11_224044) do
  create_table "employees", force: :cascade do |t|
    t.string "employee_code", null: false
    t.string "first_name"
    t.string "last_name"
    t.integer "phone_number"
    t.integer "alternate_number"
    t.string "email", null: false
    t.datetime "date_of_joining"
    t.float "salary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tax_deductions", force: :cascade do |t|
    t.integer "employee_id", null: false
    t.float "salary"
    t.float "tax_amount"
    t.float "cess_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_tax_deductions_on_employee_id"
  end

  add_foreign_key "tax_deductions", "employees"
end
