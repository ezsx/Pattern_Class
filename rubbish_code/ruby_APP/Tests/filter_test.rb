require_relative '../Student_Filter_Search'
require_relative '../Student_info/student'

students = [
  Student.new(
    id: 1,
    name: "John",
    surname: "Aoe",
    middle_name: "A",
    git: "https://github.com/johndoe",
    contact_info: { phone: "+1234567890", email: "john@example.com", telegram: "@johndoe" }
  ),
  Student.new(
    id: 2,
    name: "Jane",
    surname: "Doe",
    middle_name: "B",
    git: "https://github.com/janedoe",
    contact_info: { phone: "+1234567891", email: "jane@example.com", telegram: "@janedoe" }
  )
]

student_filtered = Student_Filtered.new(students)
student_search = Student_Search.new(student_filtered)
# ...
# Example 1: Filter students by surname
filtered_students = student_search.with_surname("Doe").results(2, 1)
puts "Filtered by surname 'Doe':"
puts filtered_students.inspect

# Example 2: Filter students with a specific email domain
filtered_students = student_search.reset_filters.with_mail("example.com").results(2, 1)
puts "Filtered by email domain 'example.com':"
puts filtered_students.inspect

# Example 3: Filter students with a specific phone number
filtered_students = student_search.reset_filters.with_phone("+1234567890").results(2, 1)
puts "Filtered by phone '+1234567890':"
puts filtered_students.inspect


