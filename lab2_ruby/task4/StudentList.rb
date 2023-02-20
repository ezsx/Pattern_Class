# frozen_string_literal: true

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

  def get_student_count
    @students.size
  end

  def get_k_n_student_short_list_(n, k, data_getter = @students)
    Students_short_getter.new(data_getter).get_k_n_student_short_list(n, k)
  end

  def get_k_n_student_short(k, n, sort_field = :id)
    sorted_students = @students.sort_by { |s| s.send(sort_field) }
    sorted_students.take(k * n).each_slice(n).map { |group| Student_list.new(group) }
  end

  def get_student_short_count(data_getter = @students)
    Students_short_getter.new(data_getter).get_student_short_count
  end

  def filter(&block)
    Student_list.new(@students.select(&block))
  end
end
