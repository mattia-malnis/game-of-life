class AddMatrixHashToGenerations < ActiveRecord::Migration[8.0]
  def change
    add_column :generations, :matrix_hash, :string
    add_index :generations, [:game_id, :matrix_hash]
    Generation.reset_column_information

    Generation.find_each { |g| g.update_column(:matrix_hash, Generation.to_hash(g.matrix)) }

    change_column_null :generations, :matrix_hash, false
  end
end
