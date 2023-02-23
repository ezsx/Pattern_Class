# import classes from other directories
require_relative '../task1_2/APP/Student'
require_relative '../task4/stBase'


class StudentListTXT < StudentListBase
  # @param [Object] file_path
  def initialize(file_path)
    super()
    @file_path = file_path
    @file_extension = '.txt'
  end

  def load_data
    students = []
    File.open(@file_path, 'r') do |f|
      f.each_line do |line|
        student = line.strip.split(',')
        students << Student.new(*student)
      end
    end
    @students = students
  end

  def save_data
    File.open(@file_path, 'w') do |f|
      @students.each do |student|
        f.puts("#{student.id},#{student.surname},#{student.initials},#{student.birth_date}")
      end
    end
  end
end


class StudentListJSON < StudentListBase

  def load_data
    serialized_data = File.read(@file_path)
    @data = JSON.parse(serialized_data, symbolize_names: true)
  end

  def save_data
    serialized_data = @data.to_json
    File.write(@file_path, serialized_data)
  end
end

require 'yaml'

class StudentListYAML < StudentListBase
  attr_reader :file_name

  def load_data
    @data = YAML.load_file(file_name)
  end

  def save_data
    File.open(file_name, 'w') { |f| f.write @data.to_yaml }
  end
end

