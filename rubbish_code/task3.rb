require_relative '../task4/2/Student_and_Student_short'

# ONLY FOR PREVENT A TASK, IT DOESNT NEED ANYMORE

def create_student_short_data_list(column_names, students_list)
  DataListStudentShort.new(column_names: column_names, data: students_list)
end

def parse_student_short(elements)
  student = elements.map { |element| element.to_s }
  Student_short.new(id: student.id, surname: student.surname, initials: student.initials, git: student.git, contact: student.contact)
end

def parse_data(data_list)
  students_list = data_list.map { |elements| parse_student_short(elements) }
  create_student_short_data_list(data_list.column_names, students_list)
end

class Students_list_txt < Data_list
  attr_accessor :file_path

  def initialize(file_path, data_list = nil)
    @file_path = file_path
    data = []
    if File.exist?(@file_path)
      File.open(@file_path, "r") do |f|
        f.each_line do |line|
          student_data = line.strip.split(',')
          data << Student.new(id: student_data[0], surname: student_data[1], first_name: student_data[2], patronymic: student_data[3], git: student_data[4], telegram: student_data[5], mail: student_data[6], phone: student_data[7])
        end
      end
    end
    # , data_list.selected
    super(data)
  end

  def write_to_file
    File.open(@file_path, "w") do |f|
      @data.each do |student|
        f.puts "#{student.id},#{student.surname},#{student.first_name},#{student.patronymic},#{student.phone},#{student.telegram},#{student.email},#{student.git}"
      end
    end
  end

  def get_student_by_id(id)
    @data.find { |student| student.id == id }
  end

  def get_k_n_student_short_list(k, n, data_list = nil, student_f=Student)
    data = @data[k..(k + n - 1)].map { |student| Student_short.new(id: student.id, surname: student_f.surname, initials: student.initials, git: student.git, contact: student.contact) }
    if data_list.nil?
      DataListStudentShort.new(data)
    else
      data_list.data = data
      data_list
    end
  end

  def sort_by_surname_initials
    @data.sort_by! { |student| [student.surname, student.first_name, student.patronymic] }
  end

  def add_student(student)
    max_id = @data.map { |s| s.id.to_i }.max
    student.id = (max_id + 1).to_s
    @data << student
  end

  def replace_student(id, student)
    student.id = id
    @data.map! { |s| s.id == id ? student : s }
  end

  def delete_student(id)
    @data.delete_if { |student| student.id == id }
  end

  def get_student_short_count
    @data.length
  end
end


require 'json'

class Students_list_JSON
  def initialize(file_path)
    @file_path = file_path
    @students = []

    if File.exist?(file_path)
      read_from_file
    else
      write_to_file
    end
  end

  def read_from_file
    file = File.read(@file_path)
    @students = JSON.parse(file)
  end

  def write_to_file
    File.open(@file_path, 'w') do |f|
      f.write(@students.to_json)
    end
  end

  def add_student(student)
    student_id = @students.empty? ? 1 : @students.last[:id] + 1
    @students << { id: student_id, student: student }
    write_to_file
  end

  def replace_student(student_id, student)
    student_index = @students.index { |s| s[:id] == student_id }
    @students[student_index][:student] = student if student_index
    write_to_file
  end

  def delete_student(student_id)
    @students.delete_if { |s| s[:id] == student_id }
    write_to_file
  end

  def get_student(student_id)
    student = @students.find { |s| s[:id] == student_id }
    student[:student] if student
  end

  def get_k_n_student_short_list(k, n, data_list = nil)
    data = @students[k...k+n].map { |s| s[:student] }
    if data_list
      data_list.data = data
      data_list
    else
      Data_list.new(data)
    end
  end

  def sort_by_surname_initials
    @students.sort! do |a, b|
      student_a = a[:student]
      student_b = b[:student]
      if student_a.surname == student_b.surname
        student_a.first_name <=> student_b.first_name
      else
        student_a.surname <=> student_b.surname
      end
    end
    write_to_file
  end

  def get_student_short_count
    @students.count
  end
end

require 'yaml'

class Students_list_YAML < Data_list
  def initialize(file_path = "students_list.yml")
    super()
    @file_path = file_path
    @students = []
    if File.exists?(file_path)
      @students = YAML.load_file(file_path)
    end
  end

  def add(student)
    new_id = (@students.map { |s| s.id.to_i }.max || 0) + 1
    student.id = new_id.to_s
    @students << student
    write_to_file
  end

  def delete(student_id)
    student = get(student_id)
    @students.delete(student)
    write_to_file
  end

  def replace(student)
    delete(student.id)
    add(student)
  end

  def sort_by_full_name
    @students.sort_by! { |s| [s.surname, s.first_name, s.patronymic] }
    write_to_file
  end

  def get(student_id)
    @students.find { |s| s.id == student_id }
  end

  # in progress...
  #
  # def get_k_n_student_short_list(k, n, data_list = nil, student_full=nil)
  #   data_list ||= Data_list.new
  #   student_shorts = @students[k, n].map { |s| Student_short.new(id: s.id, surname: "#{s.surname} #{s.first_name[0]}.") }
  #   data_list.students = student_shorts
  #   data_list
  # end

  def get_student_short_count
    @students.count
  end

  private

  def write_to_file
    File.open(@file_path, 'w') do |file|
      file.write(@students.to_yaml)
    end
  end
end


