require './app'
require 'json'
require 'pry'

# rubocop:disable Metrics/CyclomaticComplexity
def main
  app = App.new
  @rep = 0
  loop do
    app.message
    @rep = gets.chomp
    case @rep.to_i
    when 1 then app.list_books
    when 2 then app.list_person
    when 3 then app.create_person
    when 4 then app.add_book
    when 5 then app.create_rental
    when 6 then app.list_rental
    when 7

      # Create Persons File
      $obj_person = {}
      $obj_book = {}
      $obj_rental = {}
      app.persons.map do |x|
        $obj_person[:id] = x.id
        $obj_person[:name] = x.name
        $obj_person[:age] = x.age
      end
      #  = app.persons.map {|x| x.name}
      ob_person = JSON.generate($obj_person)
      app.make_file('persons', ob_person)

      # Create Books FIle

      # obj_book[:title] = app.books.map {|x| x.title}
      # obj_book[:author] = app.books.map {|x| x.author}
      app.books.map do |x|
        $obj_book[:title] = x.title
        $obj_book[:author] = x.author
      end
      ob_book = JSON.generate($obj_book)
      app.make_file('books', ob_book)

      # Create Rentals File
      # binding.pry

      # obj_rental[:date] = app.rentals.map {|x| x.date}
      app.rentals.map do |x|
        $obj_rental[:date] = x.date
        $obj_rental[:person_id] = x.person.id

        $obj_rental[:person_name] = x.person.name
        $obj_rental[:person_age] = x.person.age
        $obj_rental[:book_title] = x.book.title
        $obj_rental[:book_author] = x.book.author
      end
      ob_rental = JSON.generate($obj_rental)
      app.make_file('rentals', ob_rental)
    end
    break unless @rep.to_i != 7
  end
end
# rubocop:enable Metrics/CyclomaticComplexity

main
