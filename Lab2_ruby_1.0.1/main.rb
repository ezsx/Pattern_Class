require_relative 'task1'

student1 = Student.new(1, 'Johnson', 'John', 'Doe')
student2 = Student.new(2, 'Smith', 'Jane', 'Doe', '555-555-5555', '@jane_smith', 'jane.smith@email.com', 'jane_smith')
student3 = Student.new(3, 'Brown', 'Jim', 'Doe', '555-555-5556', '@jim_brown', 'jim.brown@email.com', 'jim_brown')

def display_student_info(student)
  puts "ID: #{student.id}"
  puts "Surname: #{student.surname}"
  puts "First name: #{student.first_name}"
  puts "Patronymic: #{student.patronymic}"
  puts "Phone: #{student.phone}" if student.phone
  puts "Telegram: #{student.telegram}" if student.telegram
  puts "Mail: #{student.mail}" if student.mail
  puts "Git: #{student.git}" if student.git
  puts ""
end

puts "Student 1 information:"
display_student_info(student1)

puts "Student 2 information:"
display_student_info(student2)

puts "Student 3 information:"
display_student_info(student3)
