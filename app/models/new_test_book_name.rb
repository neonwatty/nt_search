class NewTestBookName < ApplicationRecord
    has_many :new_test_verses, dependent: :destroy  # A book has many verses
    has_many :new_test_words, dependent: :destroy  # A book has many verses
end
