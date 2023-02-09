# Class representing a student
class Student
  attr_accessor :last_name, :first_name, :git_username, :contact

  def initialize(last_name, first_name, git_username, contact)
    @last_name = last_name
    @first_name = first_name
    @git_username = git_username
    @contact = contact
  end

  # Constructor that accepts a string as input
  def self.from_string(string)
    last_name, first_name, git_username, contact = string.split(',')
    new(last_name, first_name, git_username, contact)
  end

  # Returns brief information about the student
  def get_info
    "#{last_name} #{first_name[0]}. (#{git_username}, #{contact})"
  end
end

# Class representing a short version of a student
class StudentShort
  attr_reader :id, :last_name, :first_name, :git_username, :contact

  def initialize(student)
    @id = student.object_id
    @last_name = student.last_name
    @first_name = student.first_name
    @git_username = student.git_username
    @contact = student.contact
  end

  def self.from_string(id, string)
    last_name, first_name, git_username, contact = string.split(',')
    new(Student.new(last_name, first_name, git_username, contact))
  end

  def get_info
    "#{id}. #{last_name} #{first_name[0]}. (#{git_username}, #{contact})"
  end
end

# Method to read students from a text file
def read_from_txt(file_path)
  students = []
  begin
    File.open(file_path, "r") do |file|
      file.each_line do |line|
        last_name, first_name, git, contact = line.strip.split(",")
        students << Student.new(last_name, first_name, git, contact)
      end
    end
    students
  rescue => exception
    puts "Error reading file: #{exception}"
    []
  end
end


# Method to write students to a text file
def write_to_txt(file_path, students)
  begin
    File.open(file_path, 'w') do |file|
      students.each do |student|
        file.puts("#{student.last_name},#{student.first_name},#{student.git_username},#{student.contact}")
      end
    end
  rescue StandardError => e
    raise "Error writing file: #{e.message}"
  end
end

# Testing the code
students = read_from_txt('students.txt')

students_short = students.map.with_index { |student, i| StudentShort.new(student) }

students_short.each do |student|
  puts student.get_info
end

write_to_txt('students_short.txt', students_short)

# Вопросы:

#   а. Структура классов языка Ruby основана на парадигме объектно-ориентированного программирования,
#   где классы определяют поведение и свойства объектов. Классы могут наследовать от других классов,
#   что позволяет им повторно использовать и расширять поведение существующих классов.
#
#   Класс, который был написан в предыдущем ответе, Student вписывается в эту структуру как базовый класс,
#   определяющий свойства и поведение объекта ученика.
#
#   б. Принцип наследования в Ruby позволяет классам наследовать свойства и поведение родительского класса.
#   Это означает, что дочерний класс может получать доступ и использовать методы и атрибуты родительского класса,
#   а также может добавлять новые методы или переопределять методы родительского класса.
#
#   Переопределение методов в Ruby можно выполнить с помощью def ключевого слова, за которым следует имя метода
#   и его реализация. Когда метод переопределяется в дочернем классе, говорят, что он «переопределен».
#
#   Чтобы вызвать переопределенный метод в дочернем классе, вы можете использовать super ключевое слово.
#   Это ключевое слово позволяет вызывать исходную реализацию метода, определенного в родительском классе.
#
#   в. В Ruby конструкторы — это именованные методы initialize, которые автоматически вызываются при создании объекта.
#   Когда класс наследуется от другого класса, дочерний класс может иметь свой собственный initialize метод,
#   который можно использовать для установки свойств объекта.
#
#   При создании объекта дочернего класса initialize сначала будет вызываться метод дочернего класса,
#   а затем метод родительского класса initialize. Это позволяет дочернему классу устанавливать свои
#   собственные свойства, а также наследовать свойства, установленные родительским классом.
#
#   д. Каждый класс в Ruby должен иметь хотя бы один метод-конструктор с именем initialize, который используется
#   для инициализации свойств объекта.
#
#   Кроме того, класс должен иметь методы, определяющие его поведение. В Student классе get_info метод
#   возвращает краткую информацию об ученике, например его фамилию и инициалы, Git и ссылку.
#
#   Методы read_from_txt и write_to_txt используются для чтения и записи данных в текстовый файл соответственно.
#   Эти методы позволяют сохранять данные и могут использоваться для хранения и извлечения данных между различными
#   экземплярами программы.
