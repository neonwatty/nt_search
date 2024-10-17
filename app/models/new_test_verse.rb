class NewTestVerse < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search_any_word,
                  against: [:verse_content],
                  using: {
                    tsearch: { any_word: true }
                  }

  belongs_to :new_test_book_name
  validates :chapter_number, :verse_number, :verse_content, presence: true

  def book_from
    new_test_book_name.title 
  end
end
