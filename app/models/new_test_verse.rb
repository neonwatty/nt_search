require 'informers'
model = 

class NewTestVerse < ApplicationRecord
  include PgSearch::Model
  attr_accessor :model

  def initialize(attributes = {})
    super
    @model = Informers.pipeline("embedding", "sentence-transformers/all-MiniLM-L6-v2")
  end

  pg_search_scope :search_any_word,
                  against: [:verse_content],
                  using: {
                    tsearch: { any_word: true }
                  }

  belongs_to :new_test_book_name
  has_neighbors :verse_embedding

  validates :chapter_number, :verse_number, :verse_content, presence: true
  
  def book_from
    new_test_book_name.title 
  end

  def get_neighbors
    self.nearest_neighbors(:verse_embedding, distance: "cosine").first(10)

  end

  def compute_embedding
    self.verse_embedding = model.(self.verse_content)
  end
end
