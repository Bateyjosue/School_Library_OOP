
class Person
  def initialize(name = 'Uhnknown', age, parent_permission = true)
    @id = Random.rand(1...10000)
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  attr_accessor : id
  attr_accessor : name
  attr_accessor : age

  def is_of_age?
    if @age >= 18
      true
    else
      false
    end
  end

  def can_use_services?
    true if is_of_age? || @parent_permission
  end

end
