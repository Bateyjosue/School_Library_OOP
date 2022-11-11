require './person'

class Teacher < Person
  def initialize(name, age, specialization)
    super(age, name)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end
