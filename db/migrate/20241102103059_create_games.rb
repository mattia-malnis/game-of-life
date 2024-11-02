class CreateGames < ActiveRecord::Migration[7.2]
  def change
    create_table :games, id: :uuid do |t|
      t.references :user_session, type: :uuid
      t.timestamps
    end
  end
end
