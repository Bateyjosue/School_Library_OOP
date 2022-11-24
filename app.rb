require_relative './student'
require_relative './teacher'
require_relative './book'
require_relative './rental'

require 'json'

class App
  attr_accessor :persons, :books, :rentals

  def initialize()
    @persons = File.exist?('persons.json') ? JSON.parse(File.read('persons.json')) : []
    @books = File.exist?('books.json') ? JSON.parse(File.read('books.json')) : []
    @rentals = File.exist?('rentals.json') ? JSON.parse(File.read('rentals.json')) : []
  end

  def list_books
    if @books.size.zero?
      puts "\t\t++++++++++++++++++++++++++++++++++++++++"
      puts "\t\t+    No Book found, please Add a book  +"
      puts "\t\t++++++++++++++++++++++++++++++++++++++++\n"
    end
    @books.map do |book|
      puts "Title: \"#{book['title']}, Author: #{book['author']}"
    end
  end

  def list_person
    if @persons.size.zero?
      puts "\t\t++++++++++++++++++++++++++++++++++++++++"
      puts "\t\t+    No Person found, please Add a book  +"
      puts "\t\t++++++++++++++++++++++++++++++++++++++++\n"
    end
    @persons.map do |person|
      puts "[#{person.class}] Name: #{person['name']}, ID: #{person['id']}, Age: #{person['age']}"
    end
  end

  def create_student()
    obj_person = {}
    puts '+++++++++ Add Student +++++++++'
    print('Age: ')
    age = gets.chomp
    print('Name: ')
    name = gets.chomp

    obj_person[:id] = Random.rand(1...10_000)
    obj_person[:name] = name
    obj_person[:age] = age
    @persons.push(obj_person)
    ob_person = JSON.generate(@persons)
    make_file('persons', ob_person)
    puts "Student created successfully\n"
  end

  def create_teacher()
    obj_person = {}

    puts '+++++++++ Add Teacher +++++++++'
    print('Age: ')
    age = gets.chomp
    print('Name: ')
    name = gets.chomp
    print('Specialization: ')
    specialization = gets.chomp
    obj_person['id'] = Random.rand(1...10_000)
    obj_person['name'] = name
    obj_person['age'] = age
    obj_person['specialization'] = specialization
    @persons.push(obj_person)
    ob_person = JSON.generate(@persons)
    make_file('persons', ob_person)
    puts "Teacher created successfully\n"
  end

  def add_book
    obj_book = {}
    puts '+++++++++ Add Book +++++++++'
    print('Title: ')
    title = gets.chomp
    print('Author: ')
    author = gets.chomp

    obj_book['title'] = title
    obj_book['author'] = author
    @books.push(obj_book)
    ob_book = JSON.generate(@books)
    make_file('books', ob_book)

    puts "Book created successfully\n"
  end

  # rubocop:disable Metrics/MethodLength
  def create_rental
    puts 'Select a book from the following list by number '
    puts "\t\t+    No Book found, please Add a book  +" if @books.size.zero?
    @books.each_with_index.map do |book, index|
      puts "#{index}) Title: \"#{book['title']}\", Author: #{book['author']}"
    end
    book_index = gets.chomp.to_i

    puts 'Select a person from the following list by number (not id)'
    puts "\t\t+    No Person found, please Add a book  +" if @persons.size.zero?
    @persons.each_with_index.map do |person, index|
      puts "#{index}) [#{person['class']}] Name: #{person['name']}, ID: #{person['id']}, Age: #{person['age']}"
    end
    person_index = gets.chomp.to_i

    puts 'Date [YYYY-MM-DD] :'
    date = gets.chomp
    @rentals.push(
      { 'date' => date,
        'person_id' => @persons[person_index]['id'],
        'person_name' => @persons[person_index]['name'],
        'person_age' => @persons[person_index]['age'],
        'book_title' => @books[book_index]['title'],
        'book_author' => @books[book_index]['author'] }
    )
    puts "Rental created successfully\n"
  end
  # rubocop:enable Metrics/MethodLength

  def list_rental
    print 'ID of person: '
    @persons.each_with_index do |person, index|
      puts "#{index}) [#{person.class}] Name: #{person['name']}, ID: #{person['id']}, Age: #{person['age']}"
    end
    id = gets.chomp.to_i
    person = @persons.find { |p| p.id == id }
    puts 'Rentals: '
    person.rentals.map do |rental|
      puts "Date: #{rental['date']}, Book: #{rental['book_title']} by #{rental['book_author']}"
    end
  end

  def create_person()
    loop do
      print 'Do you want to create a student (1) or a teacher (2)? [Input the number] :'
      choose = gets.chomp
      case choose.to_i
      when 1
        create_student
        break
      when 2
        create_teacher
        break
      end
      break unless choose.to_i == 1 || choose.to_i == 2
    end
  end

  def message
    p '======  Welcome to Our School Library Apps  ======'
    p '=================================================='
    puts 'Please choose an option by entering a number:'
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person id'
    puts '7 - Exit'
  end

  def make_file(filename, obj)
    File.write("#{filename}.json", obj)
  end
end
