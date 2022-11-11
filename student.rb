require './person'
require './classroom'

class Student < Person
  attr_reader :classroom

  def initialize(name, age, parent_permission)
    super(age, name, parent_permission)
    @classroom = ''
  end

  def classroom=(classroom)
    @classroom = classroom
    classroom.students.push(self) unless classroom.students.include?(self)
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end
end
