require_relative 'task1_2'

# student1 = Student.new(surname: 'Smith', first_name: 'John',patronymic: 'sda', git: 'https://github.com/ezsx', telegram: 'ezsx', mail: 'scdcor@gmail.com', phone: '380501234567')

student_string = "1,Smith,John,Alex, +7 (999) 123-45-67, @johnsmith, john.smith@example.com, https://github.com/johnsmith"
student = Student.from_string(student_string)

puts student
student_back_string = student.to_s
puts student_back_string

student_short = Student_short.new(student: student)
puts student_short

#
# def display_student_info(student)
#   puts "ID: #{student.id}"
#   puts "Surname: #{student.surname}"
#   puts "First name: #{student.first_name}"
#   puts "Patronymic: #{student.patronymic}"
#   puts "Phone: #{student.phone}" if student.phone
#   puts "Telegram: #{student.telegram}" if student.telegram
#   puts "Mail: #{student.mail}" if student.mail
#   puts "Git: #{student.git}" if student.git
#   puts " "
# end
#
# display_student_info(student1)