class Rental
  attr_accessor :date

  def initialize(_date, person, book)
    @date = _date

    @person = person
    person.rentals << self

    @book = book
    book.rentals << self
  end
end
