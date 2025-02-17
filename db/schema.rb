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

ActiveRecord::Schema[8.0].define(version: 2024_11_13_081631) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pgcrypto"

  create_table "games", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_session_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_session_id"], name: "index_games_on_user_session_id"
  end

  create_table "generations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "counter", null: false
    t.integer "columns", null: false
    t.integer "rows", null: false
    t.text "matrix", null: false
    t.uuid "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "matrix_hash", null: false
    t.index ["game_id", "counter"], name: "index_generations_on_game_id_and_counter"
    t.index ["game_id", "matrix_hash"], name: "index_generations_on_game_id_and_matrix_hash"
    t.index ["game_id"], name: "index_generations_on_game_id"
    t.check_constraint "columns > 1", name: "generations_columns_check"
    t.check_constraint "counter > 0", name: "generations_counter_check"
    t.check_constraint "rows > 1", name: "generations_rows_check"
  end

  create_table "user_sessions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "last_login_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
