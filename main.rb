
require_relative './student.rb'
require_relative './teacher.rb'
require_relative './book.rb'
require_relative './rental.rb'

p "======  Welcome to Our School Library Apps  ======"
p "=================================================="
persons = []
books = []
book = []
rentals = []

@rep = 0
begin
  puts "Please choose an option by entering a number:"
  puts "1 - List all books\n2 - List all people\n3 - Create a person\n4 - Create a book\n5 - Create a rental\n6 - List all rentals for a given person id\n7 - Exit\n"
  @rep = gets.chomp()
  case(@rep.to_i)
  when 1
    if books.size == 0
      puts "\t\t++++++++++++++++++++++++++++++++++++++++"
      puts "\t\t+    No Book found, please Add a book  +"
      puts "\t\t++++++++++++++++++++++++++++++++++++++++\n"
    end
    books.each do |book|
      puts "Title: \"#{book.title}\", Author: #{book.author}"
    end
    # unless book.nil? puts "Not Book Found"
  when 2
    if persons.size == 0
      puts "\t\t++++++++++++++++++++++++++++++++++++++++"
      puts "\t\t+    No Person found, please Add a book  +"
      puts "\t\t++++++++++++++++++++++++++++++++++++++++\n"
    end
    persons.each do |person|
      puts "[#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
  when 3
    begin
      print "Do you want to create a student (1) or a teacher (2)? [Input the number] :"
      choose = gets.chomp
      case(choose.to_i)
      when 1
        puts "+++++++++ Add Student +++++++++"
        print("Age: ")
        age = gets.chomp
        print("Name: ")
        name = gets.chomp
        print("Has parent permission? [Y/N]: ")
        parent_permission = gets.chomp
        person = Student.new(name, age, parent_permission.upcase)
        # persons.push(['Student', person.name, person.id, person.age])
        persons.push(person)
        puts "Person created successfully\n"
        break
      when 2
        puts "+++++++++ Add Teacher +++++++++"
        print("Age: ")
        age = gets.chomp
        print("Name: ")
        name = gets.chomp
        print("Specialization: ")
        specialization = gets.chomp
        teacher = Teacher.new(name, age, specialization)
        # persons.push(['Teacher', teacher.name, teacher.id, teacher.age])
        persons.push(teacher)

        break
      end
    end while choose.to_i == 1  || choose.to_i == 2
  when 4
    puts "+++++++++ Add Book +++++++++"
    print("Title: ")
    title = gets.chomp
    print("Author: ")
    author = gets.chomp
    book = Book.new(title, author)
    # books.push([book.title, book.author])
    books.push(book)
    puts "Book created successfully\n"
  when 5
    puts "Select a book from the following list by number "
    if books.size == 0
      puts "\t\t+    No Book found, please Add a book  +"
    end
    books.each_with_index do |book, index|
      puts "#{index}) Title: \"#{book.title}\", Author: #{book.author}"
    end
    book_index = gets.chomp.to_i

    puts "Select a person from the following list by number (not id)"
    if persons.size == 0
      puts "\t\t+    No Person found, please Add a book  +"
    end
    persons.each_with_index do |person, index|
      puts "#{index}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    person_index = gets.chomp.to_i

    puts "Date [YYYY-MM-DD] :"
    date = gets.chomp

    rentals.push(Rental.new(date, persons[person_index], books[book_index]))

    puts "Rental created successfully\n"
    
  when 6
    puts "ID of Person: "
    person_ID = gets.chomp.to_i
    persons.each do |p|
      if p.id == person_ID
        puts "Rentals: "
        p.rentals.each do |rental|
          puts "Date: #{rental.date}, Book: #{rental.book.title} by #{rental.book.author}"
        end
      end
    end
    

  else
    puts "Thanks for using This App!!!"
  end
end while @rep.to_i != 7