class CreateNewTestVerses < ActiveRecord::Migration[7.2]
  def change
    create_table :new_test_verses do |t|
      t.references :new_test_book_name, foreign_key: true, null: false
      t.integer :chapter_number
      t.integer :verse_number
      t.string :verse_content
      t.vector :verse_embedding, limit: 384

      t.timestamps
    end
    add_index :new_test_verses, [:new_test_book_name_id, :chapter_number, :verse_number], unique: true, name: 'index_new_test_verses_on_book_and_chapter_and_verse'
  end
end
