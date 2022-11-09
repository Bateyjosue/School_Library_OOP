
require './base_decorator'

class Trimmer_Decorator < Base_Decorator
  def correct_name
    if 
      @nameable.correct_name.strip if @nameable.correct_name.size > 10
    end
  end
end 