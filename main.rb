require_relative './student'
require_relative './teacher'
require_relative './book'
require_relative './rental'

@persons = []
@books = []
rentals = []

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

def list_books(books)
  if books.size.zero?
    puts "\t\t++++++++++++++++++++++++++++++++++++++++"
    puts "\t\t+    No Book found, please Add a book  +"
    puts "\t\t++++++++++++++++++++++++++++++++++++++++\n"
  end
  books.each do |book|
    puts "Title: \"#{book.title}\", Author: #{book.author}"
  end
end

def list_person(persons)
  if persons.size.zero?
    puts "\t\t++++++++++++++++++++++++++++++++++++++++"
    puts "\t\t+    No Person found, please Add a book  +"
    puts "\t\t++++++++++++++++++++++++++++++++++++++++\n"
  end
  persons.each do |person|
    puts "[#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
  end
end

def create_student()
  puts '+++++++++ Add Student +++++++++'
  print('Age: ')
  age = gets.chomp
  print('Name: ')
  name = gets.chomp
  print('Has parent permission? [Y/N]: ')
  parent_permission = gets.chomp
  person = Student.new(name, age, parent_permission.upcase)
  # @persons.push(['Student', person.name, person.id, person.age])
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
  # persons.push(['Teacher', teacher.name, teacher.id, teacher.age])
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
  # books.push([book.title, book.author])
  @books.push(book)
  puts "Book created successfully\n"
end

def create_rental(rentals)
  puts 'Select a book from the following list by number '
  puts "\t\t+    No Book found, please Add a book  +" if @books.size.zero?
  @books.each_with_index do |book, index|
    puts "#{index}) Title: \"#{book.title}\", Author: #{book.author}"
  end
  book_index = gets.chomp.to_i

  puts 'Select a person from the following list by number (not id)'
  puts "\t\t+    No Person found, please Add a book  +" if @persons.size.zero?
  @persons.each_with_index do |person, index|
    puts "#{index}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
  end
  person_index = gets.chomp.to_i

  puts 'Date [YYYY-MM-DD] :'
  date = gets.chomp

  rentals.push(Rental.new(date, @persons[person_index], @books[book_index]))

  puts "Rental created successfully\n"
end

def list_rental()
  puts 'ID of Person: '
  person_id = gets.chomp.to_i
  @persons.each do |p|
    next unless p.id == person_id

    puts 'Rentals: '
    p.rentals.each do |rental|
      puts "Date: #{rental.date}, Book: #{rental.book.title} by #{rental.book.author}"
    end
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

@rep = 0
loop do
  message
  @rep = gets.chomp
  case @rep.to_i
  when 1
    list_books(@books)
  when 2
    list_person(@persons)
  when 3
    create_person
  when 4
    add_book
  when 5
    create_rental(rentals)
  when 6
    list_rental
  else
    puts 'Thanks for using This App!!!'
  end
  break unless @rep.to_i != 7
end
