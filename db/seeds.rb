require 'json'

# load in nt book names
nt_book_file_path = Rails.root.join('db', 'seeds', 'nt_book_names.json')
begin
  json_data = File.read(nt_book_file_path)
  names = JSON.parse(json_data)

  # Create records in the database
  names.each do |name|
    book = NewTestBookName.new(title: name)
    if book.save
    else
      puts "Failed to import #{name}: #{book.errors.full_messages.join(', ')}"
    end
  end

  puts "Nt book names seeding complete."
rescue Errno::ENOENT
  puts "JSON file not found: #{nt_book_file_path}"
rescue JSON::ParserError
  puts "Failed to parse JSON file."
end


# load in nt verses
nt_verse_file_path = Rails.root.join('db', 'seeds', 'nt_verse_dict.json')

begin
  json_data = File.read(nt_verse_file_path)
  verses = JSON.parse(json_data)

  # Create records in the database
  verses.each do |datapoint|
    book = NewTestBookName.find(datapoint['book_number'])
    verse_data = NewTestVerse.new(
      new_test_book_name: book,
      chapter_number: datapoint['chapter_number'],
      verse_number: datapoint['verse_number'],
      verse_content: datapoint['verse_content'],
    )
    if verse_data.save
    else
      puts "Failed to import #{datapoint}: #{verse_data.errors.full_messages.join(', ')}"
    end
  end
  puts "Nt verse seeding complete."
rescue Errno::ENOENT
  puts "JSON file not found: #{nt_verse_file_path}"
rescue JSON::ParserError
  puts "Failed to parse JSON file."
end
