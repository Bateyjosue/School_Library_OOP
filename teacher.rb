require './person.rb'

class Teacher < Person
  def initialize(name, age, specialization)
    super(name, age, parent_permission)
    @specialization = specialization
  end

  def can_use_services?
    true
end