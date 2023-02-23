class StudentListStrategyAdapter
  attr_accessor :strategy

  def initialize(strategy)
    @strategy = strategy
  end

  def add_student(student)
    @strategy.add_student(student)
  end

  def get_student(id)
    @strategy.get_student(id)
  end

  def update_student(id, student)
    @strategy.update_student(id, student)
  end

  def delete_student(id)
    @strategy.delete_student(id)
  end

  def sort_by_surname_and_initials
    @strategy.sort_by_surname_and_initials
  end

  def load_data
    @strategy.load_data
    @students = @strategy.students
  end

  def save_data
    @strategy.students = @students
    @strategy.save_data
  end
end

# exempale of usage:
#
#     txt_strategy = StudentListTXT.new('/path/to/students.txt')
#     adapter = StudentListStrategyAdapter.new(txt_strategy)
#     students = StudentList.new(adapter)
