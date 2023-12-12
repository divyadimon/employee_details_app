class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.string :employee_code, uniq: true, null: false
      t.string :first_name
      t.string :last_name
      t.integer :phone_number
      t.integer :alternate_number
      t.string :email, uniqe: true, null: false
      t.datetime :date_of_joining
      t.float :salary

      t.timestamps
    end
  end
end
