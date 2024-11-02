class CreateUserSessions < ActiveRecord::Migration[7.2]
  def change
    create_table :user_sessions, id: :uuid do |t|
      t.datetime :last_login_at
      t.timestamps
    end
  end
end
