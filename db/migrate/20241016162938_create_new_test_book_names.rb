class CreateNewTestBookNames < ActiveRecord::Migration[7.2]
  def change
    create_table :new_test_book_names do |t|
      t.text :title

      t.timestamps
    end
  end
end
