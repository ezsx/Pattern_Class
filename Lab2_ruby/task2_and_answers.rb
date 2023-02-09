# Class representing a student
# import class Student from task1.rb
require_relative 'task1_and_answers'

# Class representing a short version of a student
class StudentShort
  attr_reader :id, :first_name, :patronymic, :git, :telegram

  def initialize(student)
    @id = student.object_id
    @first_name = student.first_name
    @patronymic = student.patronymic
    @git = student.git
    @telegram = student.telegram
  end

  def self.from_string(id, string)
    first_name, patronymic, git, telegram = string.split(',')
    # new(Student.new(first_name, first_name, git, telegram))
    new(Student.new(first_name: first_name, patronymic: patronymic, git: git, telegram: telegram))

  end

  def get_info
    "#{id}. #{first_name} #{patronymic}. (#{git}, #{telegram})"
  end
end

# Method to read students from a text file
def read_from_txt(file_path)
  students = []
  begin
    File.open(file_path, "r") do |file|
      file.each_line do |line|
        first_name, patronymic, git, telegram = line.strip.split(",")
        # students << Student.new(first_name, first_name, git, telegram)
        students << Student.new(first_name: first_name, patronymic:patronymic, git: git, telegram: telegram)
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
        file.puts("#{student.first_name},#{student.patronymic},#{student.git},#{student.telegram}")
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
#
# a.
# Опишите структуру классов языка Ruby, как в нее вписывается написанный Вами класс?
# b.
# Опишите принцип наследования, переопределение методов и
# способы вызова переопределенного метода.
# c.
# Опишите принципы работы конструкторов для наследуемых классов.
# d.
# Какие методы объекта обязательно есть у любого написанного
# Вами класса, опишите, что они делают.

# Ответы на вопросы:

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
