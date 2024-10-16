require 'json'

# Load JSON data from the file
nt_book_file_path = Rails.root.join('db', 'seeds', 'nt_book_names.json')

begin
  json_data = File.read(nt_book_file_path)
  names = JSON.parse(json_data)

  # Create records in the database
  names.each do |name|
    book = NewTestBookName.new(title: name)
    if book.save
      puts "Imported: #{name}"
    else
      puts "Failed to import #{name}: #{book.errors.full_messages.join(', ')}"
    end
  end

  puts "Seeding complete."
rescue Errno::ENOENT
  puts "JSON file not found: #{nt_book_file_path}"
rescue JSON::ParserError
  puts "Failed to parse JSON file."
end
