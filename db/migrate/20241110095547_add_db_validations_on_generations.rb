class AddDbValidationsOnGenerations < ActiveRecord::Migration[7.2]
  def change
    change_column_null :generations, :counter, false
    change_column_null :generations, :columns, false
    change_column_null :generations, :rows, false
    change_column_null :generations, :matrix, false

    add_check_constraint :generations, "counter > 0", name: "generations_counter_check"
    add_check_constraint :generations, "columns > 1", name: "generations_columns_check"
    add_check_constraint :generations, "rows > 1", name: "generations_rows_check"
  end
end
