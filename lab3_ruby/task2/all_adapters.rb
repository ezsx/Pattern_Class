# TODO: Refactor Student class to fit init:
#


require_relative '../../lab2_ruby/task1_2/Student_and_Student_short'
require 'pg'

class StudentListDBAdapter < StudentListBase
  # @param [Object] dbname
  # @param [Object] user
  # @param [Object] password
  # @param [String] host
  # @param [Integer] port
  def initialize(dbname:, user:, password:, host: 'localhost', port: 5432)
    super()
    @conn = PG.connect(dbname: dbname, user: user, password: password, host: host, port: port)
  end

  def load_data
    students = []
    @conn.exec("SELECT * FROM students") do |result|
      result.each do |row|
        students << Student.new(id: row['id'], surname: row['surname'], initials: row['initials'], birth_date: Date.parse(row['birth_date']))
      end
    end
    @students = students
  end

  def save_data
    @conn.exec("DELETE FROM students")
    @students.each do |student|
      @conn.exec_params("INSERT INTO students (id, surname, initials, birth_date) VALUES ($1, $2, $3, $4)", [student.id, student.surname, student.initials, student.birth_date])
    end
  end

  def add_student(student)
    student.id = generate_id
    @conn.exec_params("INSERT INTO students (id, surname, initials, birth_date) VALUES ($1, $2, $3, $4)", [student.id, student.surname, student.initials, student.birth_date])
  end

  def replace_student(student)
    @conn.exec_params("UPDATE students SET surname = $1, initials = $2, birth_date = $3 WHERE id = $4", [student.surname, student.initials, student.birth_date, student.id])
  end

  def delete_student(id)
    @conn.exec_params("DELETE FROM students WHERE id = $1", [id])
  end

  private

  def generate_id
    max_id = @students.map(&:id).max
    max_id ? max_id + 1 : 1
  end
end

class StudentListTXTAdapter < StudentListBase
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
        f.puts("#{student.id},#{student.surname},#{student.initials},#{student.git},#{student.contact},#{student.birth_date}")
      end
    end
  end
end

class StudentListJSONAdapter < StudentListBase
  def initialize(file_path)
    super()
    @file_path = file_path
    @file_extension = '.json'
  end

  def load_data
    serialized_data = File.read(@file_path)
    @data = JSON.parse(serialized_data, symbolize_names: true)
    @data.each do |student|
      @students << Student.new(*student.values)
    end
  end

  def save_data
    serialized_data = @students.map { |student| {id: student.id, surname: student.surname, initials: student.initials, git: student.git, contact: student.contact, birth_date: student.birth_date} }.to_json
    File.write(@file_path, serialized_data)
  end
end

require 'yaml'

class StudentListYAMLAdapter < StudentListBase
  def initialize(file_path)
    super()
    @file_path = file_path
    @file_extension = '.yaml'
  end

  def load_data
    @data = YAML.load_file(@file_path)
    @data.each do |student|
      @students << Student.new(*student.values)
    end
  end

  def save_data
    File.open(@file_path, 'w') { |f| f.write @students.map { |student| {id: student.id, surname: student.surname, initials: student.initials, git: student.git, contact: student.contact, birth_date: student.birth_date} }.to_yaml }
  end
end
