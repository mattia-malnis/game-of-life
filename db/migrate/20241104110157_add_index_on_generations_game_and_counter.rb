class AddIndexOnGenerationsGameAndCounter < ActiveRecord::Migration[7.2]
  def change
    add_index :generations, [:game_id, :counter]
  end
end
