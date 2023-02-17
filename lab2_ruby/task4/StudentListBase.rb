
class StudentListBase < StudentList
  attr_accessor :students, :file_path

  def load_data
    raise "load_data method must be implemented in a subclass"
  end

  def save_data
    raise "save_data method must be implemented in a subclass"
  end

  def get_student(id)
    students.find { |s| s.id == id }
  end

  def get_k_n_student_short_list(k, n, data_list = nil)
    if data_list.nil?
      data_list = DataList.new(students.slice(k, n).map { |s| Student_short.new(id: s.id, surname: s.surname, initials: s.initials, git: s.git, contact: s.contact) })
    else
      data_list.data = students.slice(k, n).map { |s| Student_short.new(id: s.id, surname: s.surname, initials: s.initials, git: s.git, contact: s.contact) }
    end

    data_list
  end

  def sort_by_surname_initials
    students.sort_by! { |s| "#{s.surname} #{s.first_name[0]}#{s.patronymic[0]}" }
  end

  def add_student(student)
    student.id = generate_id
    students << student
  end

  def replace_student(student)
    index = students.index { |s| s.id == student.id }
    students[index] = student if index
  end

  def delete_student(id)
    students.delete_if { |s| s.id == id }
  end

  def get_student_short_count
    students.count
  end

  private

  def generate_id
    max_id = students.map(&:id).max
    max_id ? max_id + 1 : 1
  end
end
