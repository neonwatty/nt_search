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

ActiveRecord::Schema[7.2].define(version: 2024_10_16_162940) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "new_test_book_names", force: :cascade do |t|
    t.text "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "new_test_verses", force: :cascade do |t|
    t.bigint "new_test_book_name_id", null: false
    t.integer "chapter_number"
    t.integer "verse_number"
    t.string "verse_content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["new_test_book_name_id", "chapter_number", "verse_number"], name: "index_new_test_verses_on_book_and_chapter_and_verse", unique: true
    t.index ["new_test_book_name_id"], name: "index_new_test_verses_on_new_test_book_name_id"
  end

  add_foreign_key "new_test_verses", "new_test_book_names"
end
