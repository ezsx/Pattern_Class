# import classes from other directories
require_relative 'task1_2'
require_relative 'task3'

class DataList
  attr_accessor :data

  def initialize(data = [])
    @data = data
  end

  def add_data(new_data)
    @data << new_data
  end

  def get_data_by_id(id)
    @data.find { |item| item.id == id }
  end

  def replace_data_by_id(id, new_data)
    @data.each_with_index do |item, index|
      if item.id == id
        @data[index] = new_data
        break
      end
    end
  end

  def delete_data_by_id(id)
    @data.delete_if { |item| item.id == id }
  end

  def sort_by_surname_and_initials
    @data.sort_by! { |item| [item.surname, item.initials] }
  end

  def get_k_n_short_data_list(k, n, short_data_class)
    short_data = @data.map { |item| short_data_class.new(item) }
    DataList.new(short_data[k-1, n])
  end

  def get_data_count
    @data.count
  end
end

class StudentList < DataList
  attr_accessor :students

  def initialize(students = [])
    @students = students
  end

  def add_student(student)
    student.id = @students.length + 1 if student.id.nil?
    @students << student
  end

  def get_student(id)
    @students.find { |student| student.id == id }
  end

  def update_student(id, student)
    index = @students.index { |s| s.id == id }
    return unless index

    @students[index] = student
  end

  def delete_student(id)
    @students.delete_if { |student| student.id == id }
  end

  def sort_by_surname_and_initials
    @students.sort_by! { |student| [student.surname, student.initials] }
  end
end

class StudentListBase < StudentList
  attr_accessor :students, :file_path

  def initialize(file_path)
    @file_path = file_path
    @students = []
  end

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
      data_list = DataList.new(students.slice(k, n).map { |s| Student_short.new(id: s.id,surname: s.surname, initials: s.initials, git: s.git, contact: s.contact) })
    else
      data_list.data = students.slice(k, n).map { |s| Student_short.new(id: s.id,surname: s.surname, initials: s.initials, git: s.git, contact: s.contact) }
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

  def to_s
    super
  end

  private

  def generate_id
    max_id = students.map(&:id).max
    max_id ? max_id + 1 : 1
  end
end


class StudentListTXT < StudentListBase
  def initialize(file_path)
    super(file_path)
    @file_extension = '.txt'
  end

  def read_data
    students = []
    File.open(@file_path, 'r') do |f|
      f.each_line do |line|
        student = line.strip.split(',')
        students << Student.new(*student)
      end
    end
    @students = students
  end

  def write_data
    File.open(@file_path, 'w') do |f|
      @students.each do |student|
        f.puts("#{student.id},#{student.surname},#{student.initials},#{student.birth_date}")
      end
    end
  end
end

class StudentListJSON < StudentListBase
  def initialize(file_path)
    super(file_path)
  end

  def read
    serialized_data = File.read(@file_path)
    @data = JSON.parse(serialized_data, symbolize_names: true)
  end

  def write
    serialized_data = @data.to_json
    File.write(@file_path, serialized_data)
  end
end

require 'yaml'

class StudentListYAML < StudentListBase
  attr_reader :file_name

  def initialize(file_name)
    super(file_name)
  end

  def read_data
    @data = YAML.load_file(file_name)
  end

  def write_data
    File.open(file_name, 'w') {|f| f.write @data.to_yaml}
  end
end

