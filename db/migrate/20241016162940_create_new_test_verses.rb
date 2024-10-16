class CreateNewTestVerses < ActiveRecord::Migration[7.2]
  def change
    create_table :new_test_words do |t|
      t.references :new_test_book_name, foreign_key: true, null: false
      t.integer :book_number
      t.integer :chapter_number
      t.integer :verse_number
      t.string :verse_content

      t.timestamps
    end
  end
end
