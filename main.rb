# Some tests

require_relative 'ruby_APP/Student_List'
require_relative 'ruby_APP/Student'
require_relative 'ruby_APP/Txt_Json_Yaml'
require_relative 'ruby_APP/Student_Filter_Search'

students_l = [
  Student.new(id: '1', surname: 'Aurn', first_name: 'Firstn', patronymic: 'Sufu', phone: '79996340632', telegram: 'ezsx', mail: 'scdcor@gmail.com', git: 'https://github.com/ezsx'),
  Student.new(id: '2', surname: 'Burn2', first_name: 'Firstn2', patronymic: 'Sufu2', phone: '79996340632', telegram: 'ezsx', mail: 'scdcor@gmail.com', git: 'https://github.com/ezsx'),
  Student.new(id: '3', surname: 'Curn3', first_name: 'Airstn3', patronymic: 'Sufu3', phone: '79996340632', telegram: 'ezsx', mail: 'scdcor@gmail.com', git: 'https://github.com/ezsx'),
  Student.new(id: '4', surname: 'Durn4', first_name: 'Firstn4', patronymic: 'Sufu4', phone: '79996340632', telegram: 'ezsx', mail: 'scdcor@gmail.com', git: 'https://github.com/ezsx'),
  Student.new(id: '5', surname: 'Eurn5', first_name: 'Airstn5', patronymic: 'Sufu5', phone: '79996340632', telegram: 'ezsx', mail: 'scdcor@gmail.com', git: 'https://github.com/ezsx')
]
Student.display(students_l)


# test classes
students_list = Student_List.new(students_l)
# students_data_list = DataList.new(students)

student_db = Student_List_TXT.new('students.txt')
# add students to db
for student in students_l
  student_db.add_student(student)
end
# print sudents number
puts student_db.get_student_count
# print students
# puts student_db.get_k_n_student_short_list(0, 5, students_list).students
puts students_list.get_k_n_student(2, 3, 'surname').to_s

getter = Student_Filtered.new(students_l)
# test filter
puts getter.get_k_n_student_list(2, 3, { surname: 'B' }).to_s #id2



# Assuming you have already created an instance of Students_short_getter called `students`
filtered_students = Student_Search.new(getter)

# Find students with the surname "Smith"
puts filtered_students.with_surname("C").results(1, 5).to_s
# results is an array of Student_list objects, each containing up to 5 students with the surname "Smith"

# Get the count of students with the initials "A" and a phone number
puts filtered_students.reset_filters
                         .with_initials("A")
                         .with_phone_present
                         .count.to_s
# count is an integer representing the number of students with the initials "JD" and a phone number

# Find students with a telegram handle and a GitHub username
Student.display(filtered_students.reset_filters
                           .with_telegram_present
                           .with_git_present
                           .results(5, 3))
# results is an array of Student_list objects, each containing up to 3 students with a telegram handle and a GitHub username



