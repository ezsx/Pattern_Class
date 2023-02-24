# frozen_string_literal: true
require_relative '../ruby_APP/Student_Filter_Search'
class Student_List
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

  def get_k_n_student(k, n, sort_field = :id)
    sorted_students = @students.sort_by { |s| s.send(sort_field) }
    sorted_students.take(k * n).each_slice(n).map { |group| Student_List.new(group) }
  end

  def get_student_count(data_getter = @students)
    Student_Filtered.new(data_getter).get_student_short_count
  end

  def filter(&block)
    Student_List.new(@students.select(&block))
  end

end
