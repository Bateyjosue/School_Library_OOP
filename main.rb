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
      ob_rental = JSON.generate(app.rentals)
      app.make_file('rentals', ob_rental)
      puts 'Thanks For using this app'
    end
    break unless @rep.to_i != 7
  end
end
# rubocop:enable Metrics/CyclomaticComplexity

main
