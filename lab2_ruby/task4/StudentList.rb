# frozen_string_literal: true
require_relative '../../lab3_ruby/task3/Student_short_getter'
# == File: This is a Ruby class called Student_list. It represents a list of students and provides various methods to manipulate the list, filter the list, and perform some operations on the list.
#
# The class has an instance variable @students, which is initialized to an empty array in the constructor initialize, and can be set and retrieved using the attr_accessor method.
#
# The add_student method adds a new student to the list and assigns a unique ID to the student if it's not already set. The get_student method retrieves a student with a specified ID from the list. The update_student method updates an existing student with the specified ID with the provided student object. The delete_student method deletes a student with the specified ID from the list. The student_count method returns the number of students in the list.
#
# The get_k_n_student_short_list_ method takes an optional data_getter argument that can be used to filter the list of students, and then calls the get_k_n_student_short_list method on a new Students_Filtered object with the specified n and k arguments.
#
# The get_k_n_student_short method returns a short list of students, with each group containing n students and a total of k groups. It first sorts the list of students by a specified field (defaulting to :id), then takes the first k * n students, groups them into arrays of n students each using each_slice, and creates a new Student_list object for each group.
#
# The get_student_short_count method returns a count of students in the list after applying some filters using a Students_Filtered object.
#
# Finally, the filter method takes a block as an argument and returns a new Student_list object containing only the students for which the block returns true.
class Student_list
  attr_accessor :students

  # @param [Array] students
  def initialize(students = [])
    @students = students
  end

  def add_student(student)
    student.id = @students.length + 1 if student.id.nil?
    @students << student
  end

  def get_student(id)
    @students.find { |student| student.id == id }
  end

  def update_student(id, student)
    index = @students.index { |s| s.id == id }
    return unless index

    @students[index] = student
  end

  def delete_student(id)
    @students.delete_if { |student| student.id == id }
  end

  def student_count
    @students.size
  end

  def get_k_n_student_short_list_(n, k, data_getter = @students)
    Students_Filtered.new(data_getter).get_k_n_student_short_list(n, k)
  end

  def get_k_n_student_short(k, n, sort_field = :id)
    sorted_students = @students.sort_by { |s| s.send(sort_field) }
    sorted_students.take(k * n).each_slice(n).map { |group| Student_list.new(group) }
  end

  def get_student_short_count(data_getter = @students)
    Students_Filtered.new(data_getter).get_student_short_count
  end

  def filter(&block)
    Student_list.new(@students.select(&block))
  end

end
