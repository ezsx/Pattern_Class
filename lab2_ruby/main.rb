require_relative 'task4/2/Student_and_Student_short'
# require_relative 'task3'
require_relative 'task4/Txt_Json_Yaml'

students = [
  Student.new(id: '1', surname: 'Surn', first_name: 'Firstn', patronymic: 'Sufu', phone:'79996340632', telegram: 'ezsx', mail:'scdcor@gmail.com', git: 'https://github.com/ezsx'),
  Student.new(id: '2', surname: 'Surn2', first_name: 'Firstn2', patronymic: 'Sufu2', phone:'79996340632', telegram: 'ezsx', mail:'scdcor@gmail.com', git: 'https://github.com/ezsx'),
  Student.new(id: '3', surname: 'Surn3', first_name: 'Firstn3', patronymic: 'Sufu3', phone:'79996340632', telegram: 'ezsx', mail:'scdcor@gmail.com', git: 'https://github.com/ezsx'),
  Student.new(id: '4', surname: 'Surn4', first_name: 'Firstn4', patronymic: 'Sufu4', phone:'79996340632', telegram: 'ezsx', mail:'scdcor@gmail.com', git: 'https://github.com/ezsx'),
  Student.new(id: '5', surname: 'Surn5', first_name: 'Firstn5', patronymic: 'Sufu5', phone:'79996340632', telegram: 'ezsx', mail:'scdcor@gmail.com', git: 'https://github.com/ezsx')
]

students_list = StudentList.new(students)
# print students
# puts students_list.get_student('3')

student_db = StudentListTXT.new('students.txt')
# add students to db
for student in students
  student_db.add_student(student)
end
# print sudents number
puts student_db.get_student_short_count
# print students
puts student_db.get_k_n_student_short_list(0, 5, students_list).data

