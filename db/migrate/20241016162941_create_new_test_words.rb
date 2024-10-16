class CreateNewTestWords < ActiveRecord::Migration[7.2]
  def change
    create_table :new_test_words do |t|
      t.references :new_test_book_name, foreign_key: true, null: false
      t.integer :verse_number
      t.integer :chapter_number
      t.string :original_word
      t.string :stemmed_word
      t.integer :word_number

      t.timestamps
    end
  end
end
