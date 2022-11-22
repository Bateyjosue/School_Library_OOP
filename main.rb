require './app'

def main
  app = App.new
  @rep = 0
    loop do
      app.message
      @rep = gets.chomp
      case @rep.to_i
      when 1
        app.list_books()
      when 2
        app.list_person()
      when 3
        app.create_person
      when 4
        app.add_book
      when 5
        app.create_rental
      when 6
        app.list_rental
      else
        puts 'Thanks for using This App!!!'
      end
      break unless @rep.to_i != 7
    end
end

main
