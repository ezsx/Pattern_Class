require_relative '../ruby_APP/Student_List'
# TODO: think about deletion this an add into StudentList
class Student_List_Base < Student_List
  attr_accessor :students, :file_path, :data

  def load_data
    raise "load_data method must be implemented in a subclass"
  end

  def save_data
    raise "save_data method must be implemented in a subclass"
  end

  def sort_by_surname_initials
    students.sort_by! { |s| "#{s.surname} #{s.first_name[0]}#{s.patronymic[0]}" }
  end

  private

  def generate_id
    max_id = students.map(&:id).max
    max_id ? max_id + 1 : 1
  end
end
