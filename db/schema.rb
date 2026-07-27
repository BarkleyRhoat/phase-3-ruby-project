ActiveRecord::Schema[7.2].define(version: 2026_07_27_155645) do
  create_table "courses", force: :cascade do |t|
    t.string "name", null: false
    t.integer "par", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rounds", force: :cascade do |t|
    t.integer "score", null: false
    t.string "date"
    t.integer "player_id", null: false
    t.integer "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
