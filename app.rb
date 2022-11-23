require_relative './student'
require_relative './teacher'
require_relative './book'
require_relative './rental'

require 'json'

class App
  attr_accessor :persons, :books, :rentals

  def initialize()
    
    @persons = [JSON.parse(File.read('persons.json'))]
    @books = [JSON.parse(File.read('books.json'))]
    @rentals = [JSON.parse(File.read('rentals.json'))]
    binding.pry
  end

  def list_books
    if @books.size.zero?
      puts "\t\t++++++++++++++++++++++++++++++++++++++++"
      puts "\t\t+    No Book found, please Add a book  +"
      puts "\t\t++++++++++++++++++++++++++++++++++++++++\n"
    end
    @books.each do |book|
      puts "Title: \"#{book['title']}, Author: #{book['author']}"
    end
  end

  def list_person
    if @persons.size.zero?
      puts "\t\t++++++++++++++++++++++++++++++++++++++++"
      puts "\t\t+    No Person found, please Add a book  +"
      puts "\t\t++++++++++++++++++++++++++++++++++++++++\n"
    end
    @persons.each do |person|
      puts "[#{person.class}] Name: #{person['name']}, ID: #{person['id']}, Age: #{person['age']}"
    end
  end

  def create_student()
    puts '+++++++++ Add Student +++++++++'
    print('Age: ')
    age = gets.chomp
    print('Name: ')
    name = gets.chomp
    # print('Has parent permission? [Y/N]: ')
    # parent_permission = gets.chomp
    person = Student.new(name, age)
    @persons.push(person)
    puts "Student created successfully\n"
  end

  def create_teacher()
    puts '+++++++++ Add Teacher +++++++++'
    print('Age: ')
    age = gets.chomp
    print('Name: ')
    name = gets.chomp
    print('Specialization: ')
    specialization = gets.chomp
    teacher = Teacher.new(name, age, specialization)
    @persons.push(teacher)
    puts "Teacher created successfully\n"
  end

  def add_book
    puts '+++++++++ Add Book +++++++++'
    print('Title: ')
    title = gets.chomp
    print('Author: ')
    author = gets.chomp
    book = Book.new(title, author)
    @books.push(book)
    puts "Book created successfully\n"
  end

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
    rental = Rental.new(date, @books[book_index], @persons[person_index])
    @rentals.push(rental)

    puts "Rental created successfully\n"
  end

  def list_rental
    print 'ID of person: '
    @persons.each_with_index do |person, index|
      puts "#{index}) [#{person.class}] Name: #{person['name']}, ID: #{person['id']}, Age: #{person['age']}"
    end
    id = gets.chomp.to_i
    person = @persons.find { |p| p.id == id }
    puts 'Rentals: '
    person.rentals.map { |rental| puts "Date: #{rental['date']}, Book: #{rental['book_title']} by #{rental['book_author']}" }
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

  
  def make_file(filename, ob)
    if File.exists?("#{filename}.json")
      File.open("#{filename}.json", 'a') { |file| file.write( ob)}
    else
      File.open("#{filename}.json", 'w') { |file| file.write( ob)}
    end
  end
end