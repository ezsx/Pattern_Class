require_relative 'task1_2'

class DataTable
  def initialize(data)
    @data = data
  end

  def [](row, col)
    @data[row][col]
  end

  def row_count
    @data.size
  end

  def column_count
    @data[0].size
  end
end

class DataList
  attr_reader :selected

  def initialize(data)
    @data = data
    @selected = []
  end

  def [](index)
    @data[index]
  end

  def size
    @data.size
  end

  def select(number)
    @selected << number
  end

  def get_selected
    @selected
  end

  def get_names
    raise NotImplementedError, "get_names must be implemented in inheriting class"
  end

  def get_data
    raise NotImplementedError, "get_data must be implemented in inheriting class"
  end

  def each
    @data.each { |element| yield element }
  end

  private

  attr_reader :data
end

# class DataListStudentShort < DataList
#   # realisation of get_names withot using each method cant be done
#   # because of the realization of DataTabel class
#
#   def get_data
#     data = []
#     each do |student|
#       data << [student.id, student.surname, student.initials, student.git, student.contact]
#     end
#     DataTable.new(data)
#   end
#
#   def get_names
#     ['ID', 'Surname', 'Initials', 'Git', 'Contact']
#   end
# end
# class DataListStudentShort < DataList
#   attr_reader :data_table
#
#   private
#
#   def parse_student_short(student_short)
#     [student_short.id, student_short.surname, student_short.initials, student_short.git, student_short.contact]
#   end
#
#   public
#
#   def get_data
#     @data.map { |student_short| parse_student_short(student_short) }
#   end
#   def get_column_count
#     @data[0].instance_variables.count
#   end
#   def get_row_count
#     @data.count
#   end
#   def get_names
#     %w[id surname initials git contact]
#   end
# end

# the simple patern template example
#
# def parse_pattern(input)
#   case input
#   when "hello"
#     puts "You said hello!"
#   when "goodbye"
#     puts "You said goodbye!"
#   when /\A\d+\z/
#     puts "You entered a number."
#   else
#     puts "I don't understand what you said."
#   end
# end
#
# parse_pattern("hello") # outputs: You said hello!
# parse_pattern("goodbye") # outputs: You said goodbye!
# parse_pattern("123") # outputs: You entered a number.
# parse_pattern("abc") # outputs: I don't understand what you said.

class DataListStudentShort
  attr_reader :column_names
  attr_accessor :data

  def initialize(column_names: nil, data: [])
    @column_names = column_names
    @data = data
    @selected = []
  end

  def set_data(new_data)
    @data = new_data
  end

  public

  def get_column_count
    # pin
    @data[0].instance_variables.count
  end

  def get_row_count
    # pin
    @data.count
  end

  def get_names
    %w[id surname initials git contact]
  end

  def select(number)
    @selected << @data[number].id
  end

  def get_selected
    @selected
  end

  def get_data
    @data
  end

end

# Modifying the constructors

def create_student_short_data_list(column_names, students_list)
  DataListStudentShort.new(column_names: column_names, data: students_list)
end

def parse_student_short(elements)
  string = elements.map { |element| element.to_s }
  Student_short.new(string: string)
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

  def get_k_n_student_short_list(k, n, data_list = nil, student_full=nil)
    data = @data[k..(k + n - 1)].map { |student| Student_short.new(student: student_full) }
    if data_list.nil?
      Data_list_student_short.new(data)
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


