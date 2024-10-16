class NewTestVerse < ApplicationRecord
   belongs_to :new_test_book_name
  validates :chapter_number, :verse_number, :verse_conent, presence: true
end
