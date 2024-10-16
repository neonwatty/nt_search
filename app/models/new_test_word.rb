class NewTestWord < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search_any_word,
                  against: [:original_word, :stemmed_word],
                  using: {
                    tsearch: { any_word: true }
                  }

  belongs_to :new_test_book_name
  validates :chapter_number, :verse_number, :original_word, :stemmed_word, :word_number, presence: true

  def book_from
    new_test_book_name.title 
  end

  def verse_from
    NewTestVerse.find_by(new_test_book_name: new_test_book_name, chapter_number: chapter_number, verse_number: verse_number).verse_content
  end
end
