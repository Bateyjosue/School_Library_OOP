require './base_decorator'

class TrimmerDecorator < BaseDecorator
  def correct_name
    @nameable.correct_name.strip if @nameable.correct_name.size > 10
  end
end
