require_relative 'task1_2'
require_relative 'task3'
#
student1 = Student.new(surname: 'Smith', first_name: 'John', patronymic: 'sda', git: 'https://github.com/ezsx', telegram: 'ezsx', mail: 'scdcor@gmail.com', phone: '380501234567')
puts student1
#
# student_string = "1,Smith,John,Alex, +7 (999) 123-45-67, @johnsmith, john.smith@example.com, https://github.com/johnsmith"
# student = Student.from_string(student_string)
#
# puts student
# student_back_string = student.to_s
# puts student_back_string
#
# student_short = Student_short.new(student: student)
# puts student_short
#
# # test read from txt file
#
# students1 = Student.read_from_txt('students.txt')
# students1.each do |student_j|
#   puts student_j.to_s
# end
# # convert students1 to students1_short
# students1_short = []
# students1.each do |student_j|
#   students1_short << Student_short.new(student: student_j)
# end
# puts "students1_short"
# # write all students from students1_short
# for i in 0..students1_short.length-1
#   puts students1_short[i]
# end
#
#
# Student.write_to_txt('students_out.txt', students1)

# Create several Student_short entities
students_main = [Student.new(id: '1', surname: 'Smith', first_name: 'John', patronymic: 'Alex',
                             git: 'https://github.com/ezsx', telegram: 'ezsx',
                             mail: 'scdcor@gmail.com', phone: '380501234567'),

                 Student.new(id: '2', surname: 'Smith', first_name: 'John', patronymic: 'sda',
                             git: 'https://github.com/ezsx', telegram: 'ezsx', mail: 'scdcor@gmail.com',
                             phone: '380501234567'),

                 Student.new(id: '3', surname: 'Smithd', first_name: 'John', patronymic: 'sda',
                             git: 'https://github.com/ezsx', telegram: 'ezsx', mail: 'scdcor@gmail.com',
                             phone: '380501234567'),
]
students = [
  # Student_short.new(string: "1 Smith J. jsmith email@example.com"),
  # Student_short.new(string: "2 Johnson K. kjohnson another_email@example.com"),
  # Student_short.new(string: "3 Brown L. lbrown third_email@example.com")
  Student_short.new(student: students_main[0]),
  Student_short.new(student: students_main[1]),
  Student_short.new(student: students_main[2])
]

# Create a DataListStudentShort object from the created entities
students_list = DataListStudentShort.new(column_names: %w[id surname initials git contact], data: students)

# Get the number of columns in the table
puts "Number of columns in the table: #{students_list.get_column_count}"

# Get the number of rows in the table
puts "Number of rows in the table: #{students_list.get_row_count}"

# Get the names of the attributes of the entities
puts "Attribute names: #{students_list.get_names}"

# Get an element by number
puts "Selected element: #{students_list.select(2)}"

# Get an array of ids of selected elements
puts "Selected elements ids: #{students_list.get_selected}"

# Get the data
puts "Data: "
students_list.get_data.each do |row|
  puts row.inspect
end

