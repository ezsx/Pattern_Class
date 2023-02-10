require_relative 'task1_2'

# student1 = Student.new(surname: 'Smith', first_name: 'John',patronymic: 'sda', git: 'https://github.com/ezsx', telegram: 'ezsx', mail: 'scdcor@gmail.com', phone: '380501234567')

student_string = "1,Smith,John,Alex, +7 (999) 123-45-67, @johnsmith, john.smith@example.com, https://github.com/johnsmith"
student = Student.from_string(student_string)

puts student
student_back_string = student.to_s
puts student_back_string

student_short = Student_short.new(student: student)
puts student_short

# test read from txt file

students1 = Student.read_from_txt('students.txt')
students1.each do |student_j|
  puts student_j.to_s
end
# convert students1 to students1_short
students1_short = []
students1.each do |student_j|
  students1_short << Student_short.new(student: student_j)
end
puts "students1_short"
# write all students from students1_short
for i in 0..students1_short.length-1
  puts students1_short[i]
end


Student.write_to_txt('students_out.txt', students1)
