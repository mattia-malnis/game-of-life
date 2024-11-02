class CreateGenerations < ActiveRecord::Migration[7.2]
  def change
    create_table :generations, id: :uuid do |t|
      t.integer :counter
      t.integer :columns
      t.integer :rows
      t.text :matrix
      t.references :game, type: :uuid

      t.timestamps
    end
  end
end
