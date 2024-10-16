class NewTestWord < ApplicationRecord
   belongs_to :new_test_book_name
  validates :chapter_number, :verse_number, :original_word, :stemmed_word, :word_number, presence: true
end
