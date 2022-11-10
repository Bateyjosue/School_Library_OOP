class Rental
  attr_accessor :date
  def initialize(date, person, book)
    @date = data

    @person = person
    person.rentals << self

    @book = book
    book.rentals << self
  end

end